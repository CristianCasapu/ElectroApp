import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/calc/echipamente.dart';
import '../../core/calc/masuratori.dart';
import '../../core/calc/verdict.dart';
import '../../core/db/database.dart';
import '../../core/db/masuratori_repository.dart';
import '../../core/db/solutii_repository.dart';
import '../../core/models/solutie.dart';
import '../../core/services/log_service.dart';
import '../registru/solutie_detail_screen.dart' show deschideDocument;
import '../../core/utils/format.dart';
import '../../widgets/calc_widgets.dart';
import '../../widgets/common_widgets.dart';

/// Măsurătorile instrumentale ale unei fișe: la releveu, la punerea în
/// funcțiune (IEC 62446-1) și la service. Valorile sunt append-only —
/// o corectură înlocuiește vechea măsurătoare, dar o păstrează în istoric.
class MasuratoriScreen extends ConsumerStatefulWidget {
  final String lucrareId;
  const MasuratoriScreen({super.key, required this.lucrareId});

  @override
  ConsumerState<MasuratoriScreen> createState() => _MasuratoriScreenState();
}

class _MasuratoriScreenState extends ConsumerState<MasuratoriScreen> {
  FazaMasuratoare _faza = FazaMasuratoare.pif;

  /// Valorile de referință ale sistemului, din ultima revizie a soluției.
  RezultatSolutie? _solutie;
  SolutieSnapshot? _snapshot;
  String? _solutieId;
  bool _incarcat = false;

  @override
  void initState() {
    super.initState();
    _incarcaSolutia();
  }

  Future<void> _incarcaSolutia() async {
    final lista = await ref
        .read(solutiiRepositoryProvider)
        .watchPentruLucrare(widget.lucrareId)
        .first;
    if (!mounted) return;
    final snap = lista.isEmpty
        ? null
        : SolutiiRepository.decodeaza(lista.first);
    setState(() {
      _snapshot = snap;
      _solutieId = lista.isEmpty ? null : lista.first.id;
      _solutie = snap?.rezultat;
      _incarcat = true;
    });
  }

  ModulPV? get _modul {
    final s = _solutie;
    if (s == null) return null;
    return CatalogImplicit.module
            .where((m) => s.modul.contains(m.model))
            .firstOrNull ??
        CatalogImplicit.module.first;
  }

  Verdict _evalueaza(MasuratoriData m) => EvaluatorMasuratori.evalueaza(
    MasuratoareIntrare(
      tip: TipMasuratoare.dinCod(m.tip),
      valoare: m.valoare,
      iradiantaWM2: m.iradiantaWM2,
      temperaturaModulC: m.temperaturaModulC,
      tensiuneTestV: m.tensiuneTestV,
      tinta: m.tinta,
    ),
    vocAsteptatV: _vocStc,
    iscAsteptatA: _iscStc,
    tensiuneSistemV: _solutie?.vocTmin ?? 600,
    modul: _modul,
  );

  double? get _vocStc {
    final s = _solutie;
    final m = _modul;
    if (s == null || m == null) return null;
    return s.ns * m.vocV;
  }

  double? get _iscStc => _modul?.iscA;

  Future<void> _adauga([TipMasuratoare? tip]) async {
    final rezultat = await showModalBottomSheet<MasuratoriCompanion>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _MasuratoareSheet(
        lucrareId: widget.lucrareId,
        faza: _faza,
        tipInitial: tip,
        vocAsteptat: _vocStc,
        iscAsteptat: _iscStc,
        tensiuneSistem: _solutie?.vocTmin ?? 600,
        modul: _modul,
        nrStringuri: _solutie?.nrStringuri ?? 0,
        instrumente: ref.read(instrumenteProvider).value ?? const [],
        operator: ref.read(profilFirmaProvider).value?.electricianNume ?? '',
      ),
    );
    if (rezultat == null) return;
    await ref.read(masuratoriRepositoryProvider).adauga(rezultat);
  }

  bool _emite = false;

  /// Buletinul de verificări la punerea în funcțiune: consemnează măsurătorile
  /// în vigoare din faza PIF, cu aparatura folosită și concluzia.
  Future<void> _emiteBuletin(List<MasuratoriData> active) async {
    final fisa = ref.read(fisaProvider(widget.lucrareId)).value;
    final profil = ref.read(profilFirmaProvider).value;
    if (fisa == null || profil == null) return;
    setState(() => _emite = true);
    log.info(
      'documente',
      'Generez buletinul de PIF',
      '${active.length} măsurători',
    );
    try {
      final instrumente = ref.read(instrumenteProvider).value ?? const [];
      final folosite = active
          .map((m) => m.instrumentId)
          .whereType<String>()
          .toSet();
      final poze = ref.read(pozeProvider(widget.lucrareId)).value ?? const [];
      final pdf = ref.read(raportPdfProvider);
      final bytes = await pdf.buletinPif(
        profil: profil,
        fisa: fisa,
        masuratori: [for (final m in active) (m, _evalueaza(m))],
        instrumente: instrumente.where((i) => folosite.contains(i.id)).toList(),
        solutie: _snapshot,
        lipsuri: EvaluatorMasuratori.lipsuriPif(
          active.map((m) => TipMasuratoare.dinCod(m.tip)),
        ),
        nrFotografii: poze.length,
      );
      final repo = ref.read(solutiiRepositoryProvider);
      final existente = await repo.watchDocumente(widget.lucrareId).first;
      final versiune =
          existente
              .where((d) => d.tip == TipDocument.buletinPif.cod)
              .fold<int>(0, (m, d) => d.versiune > m ? d.versiune : m) +
          1;
      final f = await pdf.salveaza(
        bytes: bytes,
        nrInregistrare: fisa.lucrare.nrInregistrare,
        tip: TipDocument.buletinPif,
        versiune: versiune,
      );
      final doc = await repo.adaugaDocument(
        lucrareId: widget.lucrareId,
        solutieId: _solutieId,
        tip: TipDocument.buletinPif,
        cale: f.cale,
        sha256: f.sha256,
        marimeBytes: f.marime,
      );
      if (!mounted) return;
      await deschideDocument(context, doc);
    } on Object catch (e, st) {
      log.error('documente', 'Generarea buletinului a eșuat', e, st);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Generarea a eșuat: $e')));
      }
    } finally {
      if (mounted) setState(() => _emite = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fisa = ref.watch(fisaProvider(widget.lucrareId)).value;
    final toate =
        ref
            .watch(
              masuratoriProvider((lucrareId: widget.lucrareId, faza: _faza)),
            )
            .value ??
        const <MasuratoriData>[];
    final active = MasuratoriRepository.inVigoare(toate);
    final lipsuri = _faza == FazaMasuratoare.pif
        ? EvaluatorMasuratori.lipsuriPif(
            active.map((m) => TipMasuratoare.dinCod(m.tip)),
          )
        : const <TipMasuratoare>[];
    final neconforme = active
        .where((m) => _evalueaza(m).nivel == NivelVerdict.neconform)
        .length;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          fisa == null
              ? 'Măsurători'
              : 'Măsurători · ${fisa.lucrare.nrInregistrare}',
        ),
        actions: [
          if (_faza == FazaMasuratoare.pif)
            IconButton(
              tooltip: 'Emite buletinul de verificări',
              icon: const Icon(Icons.picture_as_pdf_outlined),
              onPressed: active.isEmpty || _emite
                  ? null
                  : () => _emiteBuletin(active),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-masuratoare',
        onPressed: () => _adauga(),
        icon: const Icon(Icons.add),
        label: const Text('Măsurătoare'),
      ),
      body: !_incarcat
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: CalcSegmented<FazaMasuratoare>(
                    selected: _faza,
                    options: const {
                      FazaMasuratoare.releveu: 'Releveu',
                      FazaMasuratoare.pif: 'PIF',
                      FazaMasuratoare.service: 'Service',
                    },
                    onChanged: (f) => setState(() => _faza = f),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                    children: [
                      _CardStare(
                        total: active.length,
                        neconforme: neconforme,
                        lipsuri: lipsuri,
                        faza: _faza,
                        voc: _vocStc,
                        isc: _iscStc,
                        onAdauga: _adauga,
                      ),
                      const SizedBox(height: 12),
                      if (active.isEmpty)
                        const StareGoala(
                          icon: Icons.speed_outlined,
                          titlu: 'Nicio măsurătoare',
                          descriere:
                              'Adaugă valorile citite pe teren; fiecare primește verdict și referință normativă.',
                        ),
                      for (final m in active)
                        _RandMasuratoare(
                          m: m,
                          verdict: _evalueaza(m),
                          onCorecteaza: () =>
                              _adauga(TipMasuratoare.dinCod(m.tip)),
                        ),
                      if (toate.length > active.length) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Corecturi în istoric: ${toate.length - active.length}',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.subtitleColor,
                          ),
                        ),
                        for (final m in toate.where(
                          (x) => x.inlocuitaDe != null,
                        ))
                          Opacity(
                            opacity: 0.55,
                            child: _RandMasuratoare(
                              m: m,
                              verdict: _evalueaza(m),
                              inlocuita: true,
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _CardStare extends StatelessWidget {
  final int total;
  final int neconforme;
  final List<TipMasuratoare> lipsuri;
  final FazaMasuratoare faza;
  final double? voc;
  final double? isc;
  final void Function(TipMasuratoare) onAdauga;

  const _CardStare({
    required this.total,
    required this.neconforme,
    required this.lipsuri,
    required this.faza,
    required this.voc,
    required this.isc,
    required this.onAdauga,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$total măsurători'
              '${neconforme > 0 ? ' · $neconforme neconforme' : ''}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: neconforme > 0 ? context.accentRed : context.accentGreen,
              ),
            ),
            if (voc != null && isc != null)
              Text(
                'Referință din soluție: Voc ${voc!.toStringAsFixed(0)} V · Isc ${isc!.toStringAsFixed(1)} A la STC',
                style: TextStyle(fontSize: 12, color: context.subtitleColor),
              )
            else
              Text(
                'Fără soluție salvată — valorile de string nu pot fi comparate cu fișa tehnică',
                style: TextStyle(fontSize: 12, color: context.subtitleColor),
              ),
            if (faza == FazaMasuratoare.pif && lipsuri.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'Lipsesc din categoria 1 (IEC 62446-1):',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: context.warningText,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final t in lipsuri)
                    ActionChip(
                      label: Text(
                        t.eticheta,
                        style: const TextStyle(fontSize: 11),
                      ),
                      avatar: const Icon(Icons.add, size: 16),
                      onPressed: () => onAdauga(t),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RandMasuratoare extends StatelessWidget {
  final MasuratoriData m;
  final Verdict verdict;
  final bool inlocuita;
  final VoidCallback? onCorecteaza;

  const _RandMasuratoare({
    required this.m,
    required this.verdict,
    this.inlocuita = false,
    this.onCorecteaza,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, culoare) = switch (verdict.nivel) {
      NivelVerdict.conform => (Icons.check_circle, context.accentGreen),
      NivelVerdict.atentie => (
        Icons.warning_amber_rounded,
        context.accentOrange,
      ),
      NivelVerdict.neconform => (Icons.cancel, context.accentRed),
      NivelVerdict.informativ => (Icons.info, context.accentBlueGrey),
    };
    return Card(
      child: ListTile(
        leading: Icon(icon, color: culoare),
        title: Text(verdict.titlu, style: const TextStyle(fontSize: 14)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(verdict.detaliu, style: const TextStyle(fontSize: 12)),
            Text(
              '${formatDataOra(m.la)}'
              '${m.operator.isEmpty ? '' : ' · ${m.operator}'} · ${verdict.referinta}'
              '${inlocuita ? ' · înlocuită' : ''}',
              style: TextStyle(fontSize: 11, color: context.hintColor),
            ),
            if (m.observatii.isNotEmpty)
              Text(
                m.observatii,
                style: TextStyle(fontSize: 11, color: context.subtitleColor),
              ),
          ],
        ),
        isThreeLine: true,
        trailing: inlocuita
            ? null
            : IconButton(
                tooltip: 'Corectează (măsurătoare nouă)',
                icon: const Icon(Icons.refresh),
                onPressed: onCorecteaza,
              ),
      ),
    );
  }
}

class _MasuratoareSheet extends StatefulWidget {
  final String lucrareId;
  final FazaMasuratoare faza;
  final TipMasuratoare? tipInitial;
  final double? vocAsteptat;
  final double? iscAsteptat;
  final double tensiuneSistem;
  final ModulPV? modul;
  final int nrStringuri;
  final List<InstrumenteData> instrumente;
  final String operator;

  const _MasuratoareSheet({
    required this.lucrareId,
    required this.faza,
    required this.tipInitial,
    required this.vocAsteptat,
    required this.iscAsteptat,
    required this.tensiuneSistem,
    required this.modul,
    required this.nrStringuri,
    required this.instrumente,
    required this.operator,
  });

  @override
  State<_MasuratoareSheet> createState() => _MasuratoareSheetState();
}

class _MasuratoareSheetState extends State<_MasuratoareSheet> {
  late TipMasuratoare _tip =
      widget.tipInitial ?? TipMasuratoare.pentruFaza(widget.faza).first;
  final _valoare = TextEditingController();
  final _tinta = TextEditingController();
  final _iradianta = TextEditingController();
  final _temperatura = TextEditingController();
  final _observatii = TextEditingController();
  String? _instrumentId;
  bool _bifaOk = true;

  @override
  void dispose() {
    for (final c in [_valoare, _tinta, _iradianta, _temperatura, _observatii]) {
      c.dispose();
    }
    super.dispose();
  }

  Verdict get _previzualizare => EvaluatorMasuratori.evalueaza(
    MasuratoareIntrare(
      tip: _tip,
      valoare: _tip.esteBifa ? (_bifaOk ? 1 : 0) : parseNumar(_valoare.text),
      iradiantaWM2: parseNumar(_iradianta.text),
      temperaturaModulC: parseNumar(_temperatura.text),
      tinta: _tinta.text.trim(),
    ),
    vocAsteptatV: widget.vocAsteptat,
    iscAsteptatA: widget.iscAsteptat,
    tensiuneSistemV: widget.tensiuneSistem,
    modul: widget.modul,
  );

  @override
  Widget build(BuildContext context) {
    final v = _previzualizare;
    final culoare = switch (v.nivel) {
      NivelVerdict.conform => context.accentGreen,
      NivelVerdict.atentie => context.accentOrange,
      NivelVerdict.neconform => context.accentRed,
      NivelVerdict.informativ => context.accentBlueGrey,
    };
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder: (context, scroll) => ListView(
        controller: scroll,
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        children: [
          Text(
            'Măsurătoare nouă · ${widget.faza.eticheta}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<TipMasuratoare>(
            initialValue: _tip,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Ce se măsoară'),
            items: [
              for (final t in TipMasuratoare.pentruFaza(widget.faza))
                DropdownMenuItem(
                  value: t,
                  child: Text(t.eticheta, overflow: TextOverflow.ellipsis),
                ),
            ],
            onChanged: (t) => setState(() => _tip = t ?? _tip),
          ),
          const SizedBox(height: 12),
          if (_tip.esteDeString && widget.nrStringuri > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Wrap(
                spacing: 8,
                children: [
                  for (var i = 1; i <= widget.nrStringuri; i++)
                    ChoiceChip(
                      label: Text('String $i'),
                      selected: _tinta.text == 'String $i',
                      onSelected: (_) =>
                          setState(() => _tinta.text = 'String $i'),
                    ),
                ],
              ),
            ),
          TextField(
            controller: _tinta,
            decoration: InputDecoration(
              labelText: 'Țintă',
              hintText: _tip.esteDeString
                  ? 'String 1'
                  : 'ex. circuit invertor, priză de pământ',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          if (_tip.esteBifa)
            CalcSegmented<bool>(
              label: 'Rezultat',
              selected: _bifaOk,
              options: const {true: 'Funcționează', false: 'Nu funcționează'},
              onChanged: (b) => setState(() => _bifaOk = b),
            )
          else
            CalcNumberField(
              controller: _valoare,
              label: 'Valoare măsurată',
              suffix: _tip.unitate,
              onChanged: (_) => setState(() {}),
            ),
          if (_tip == TipMasuratoare.vocString ||
              _tip == TipMasuratoare.iscString) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CalcNumberField(
                    controller: _iradianta,
                    label: 'Iradianță',
                    suffix: 'W/m²',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CalcNumberField(
                    controller: _temperatura,
                    label: 'Temp. modul',
                    suffix: '°C',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          DropdownButtonFormField<String?>(
            initialValue: _instrumentId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Instrument'),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('— neprecizat —'),
              ),
              for (final i in widget.instrumente)
                DropdownMenuItem(
                  value: i.id,
                  child: Text(
                    '${i.denumire}${i.serie.isEmpty ? '' : ' · ${i.serie}'}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
            onChanged: (v) => setState(() => _instrumentId = v),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _observatii,
            decoration: const InputDecoration(labelText: 'Observații'),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.tintedSurface(culoare),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: culoare.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  v.nivel.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: culoare,
                  ),
                ),
                Text(v.detaliu, style: const TextStyle(fontSize: 13)),
                Text(
                  v.referinta,
                  style: TextStyle(fontSize: 11, color: context.hintColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              final valoare = _tip.esteBifa
                  ? (_bifaOk ? 1.0 : 0.0)
                  : parseNumar(_valoare.text);
              if (!_tip.esteBifa && valoare == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Introdu valoarea măsurată')),
                );
                return;
              }
              Navigator.pop(
                context,
                MasuratoriCompanion(
                  lucrareId: Value(widget.lucrareId),
                  faza: Value(widget.faza.cod),
                  tip: Value(_tip.cod),
                  tinta: Value(_tinta.text.trim()),
                  valoare: Value(valoare),
                  unitate: Value(_tip.unitate),
                  iradiantaWM2: Value(parseNumar(_iradianta.text)),
                  temperaturaModulC: Value(parseNumar(_temperatura.text)),
                  tensiuneTestV: Value(
                    _tip == TipMasuratoare.izolatieDc
                        ? EvaluatorMasuratori.tensiuneTestRiso(
                            widget.tensiuneSistem,
                          )
                        : null,
                  ),
                  instrumentId: Value(_instrumentId),
                  verdict: Value(switch (v.nivel) {
                    NivelVerdict.neconform => VerdictMasuratoare.neconform.cod,
                    NivelVerdict.informativ =>
                      VerdictMasuratoare.informativ.cod,
                    _ => VerdictMasuratoare.conform.cod,
                  }),
                  referinta: Value(v.referinta),
                  observatii: Value(_observatii.text.trim()),
                  operator: Value(widget.operator),
                  la: Value(DateTime.now()),
                ),
              );
            },
            icon: const Icon(Icons.save_outlined),
            label: const Text('Înregistrează'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Măsurătorile nu se editează. O corectură se face printr-o valoare '
              'nouă pe aceeași țintă; cea veche rămâne în istoric.',
              style: TextStyle(fontSize: 11, color: context.subtitleColor),
            ),
          ),
        ],
      ),
    );
  }
}
