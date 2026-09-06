import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/calc/echipamente.dart';
import '../../core/calc/releveu.dart';
import '../../core/db/database.dart';
import '../../core/db/releveu_repository.dart';
import '../../core/models/enums.dart';
import '../../core/services/senzori_service.dart';
import '../../core/utils/format.dart';
import '../../widgets/calc_widgets.dart';
import '../../widgets/common_widgets.dart';

/// Releveul de șantier al unei fișe: planele de montaj cu capacitatea lor,
/// tabloul electric existent și traseele de cablu măsurate.
class ReleveuScreen extends ConsumerStatefulWidget {
  final String lucrareId;
  const ReleveuScreen({super.key, required this.lucrareId});

  @override
  ConsumerState<ReleveuScreen> createState() => _ReleveuScreenState();
}

class _ReleveuScreenState extends ConsumerState<ReleveuScreen> {
  ReleveeData? _releveu;

  @override
  void initState() {
    super.initState();
    _asigura();
  }

  Future<void> _asigura() async {
    final profil = ref.read(profilFirmaProvider).value;
    final r = await ref
        .read(releveuRepositoryProvider)
        .asigura(widget.lucrareId, operator: profil?.electricianNume ?? '');
    if (mounted) setState(() => _releveu = r);
  }

  @override
  Widget build(BuildContext context) {
    final fisa = ref.watch(fisaProvider(widget.lucrareId)).value;
    final complet = ref.watch(releveuProvider(widget.lucrareId)).value;
    final judet = fisa?.locConsum?.judet ?? '';
    final r = complet?.releveu ?? _releveu;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          fisa == null ? 'Releveu' : 'Releveu · ${fisa.lucrare.nrInregistrare}',
        ),
      ),
      floatingActionButton: r == null
          ? null
          : FloatingActionButton.extended(
              heroTag: 'fab-plan',
              onPressed: () => context.push(
                '/registru/${widget.lucrareId}/releveu/plan',
                extra: {'releveuId': r.id, 'judet': judet},
              ),
              icon: const Icon(Icons.add),
              label: const Text('Plan de montaj'),
            ),
      body: r == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
              children: [
                _Rezumat(complet: complet, judet: judet),
                const SizedBox(height: 12),
                SectiuneCard(
                  titlu: 'Plane de montaj',
                  icon: Icons.roofing_outlined,
                  children: [
                    if (complet == null || complet.plane.isEmpty)
                      Text(
                        'Niciun plan. Adaugă versanții sau terasa pe care intră modulele.',
                        style: TextStyle(
                          fontSize: 13,
                          color: context.subtitleColor,
                        ),
                      ),
                    for (final p in complet?.plane ?? const <PlanCuObstacole>[])
                      _RandPlan(
                        p: p,
                        judet: judet,
                        onDeschide: () => context.push(
                          '/registru/${widget.lucrareId}/releveu/plan',
                          extra: {
                            'releveuId': r.id,
                            'judet': judet,
                            'planId': p.plan.id,
                          },
                        ),
                        onSterge: () async {
                          await ref
                              .read(releveuRepositoryProvider)
                              .stergePlan(p.plan.id);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                _CardTablou(releveuId: r.id, tablou: complet?.tablou),
                const SizedBox(height: 12),
                _CardTrasee(
                  releveuId: r.id,
                  trasee: complet?.trasee ?? const [],
                ),
                const SizedBox(height: 12),
                _CardClimatic(releveu: r),
              ],
            ),
    );
  }
}

class _Rezumat extends StatelessWidget {
  final ReleveuComplet? complet;
  final String judet;
  const _Rezumat({required this.complet, required this.judet});

  @override
  Widget build(BuildContext context) {
    final plane = complet?.plane ?? const <PlanCuObstacole>[];
    var module = 0;
    var kWp = 0.0;
    var blocaje = 0;
    for (final p in plane) {
      final cap = CalculReleveu.capacitate(
        tip: TipPlanMontaj.dinCod(p.plan.tip),
        lungimeM: p.plan.lungimeM,
        latimeM: p.plan.latimeM,
        inclinareGrade: p.plan.inclinareGrade,
        modul: CatalogImplicit.module.first,
        latitudine: CalculReleveu.latitudineJudet(judet),
        stare: StarePlan.dinCod(p.plan.stare),
        obstacole: [
          for (final o in p.obstacole)
            (inaltimeM: o.inaltimeM, distantaM: o.distantaM),
        ],
      );
      module += cap.nrModule;
      kWp += cap.kWp;
      if (StarePlan.dinCod(p.plan.stare).blocheazaMontajul) blocaje++;
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plane.isEmpty
                  ? 'Releveu în lucru'
                  : '${formatNumar(kWp)} kWp posibili · $module module',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: context.accentBlue,
              ),
            ),
            Text(
              plane.isEmpty
                  ? 'Adaugă planele de montaj, tabloul și traseele'
                  : '${plane.length} plane · ${formatNumar(complet?.suprafataTotalaM2 ?? 0, zecimale: 0)} m² măsurați'
                        '${judet.isEmpty ? '' : ' · județul $judet'}',
              style: TextStyle(fontSize: 12, color: context.subtitleColor),
            ),
            if (blocaje > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.report_problem_outlined,
                      size: 16,
                      color: context.errorText,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '$blocaje plan(e) marcate neconforme — nu intră în ofertă până la reparații',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.errorText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RandPlan extends StatelessWidget {
  final PlanCuObstacole p;
  final String judet;
  final VoidCallback onDeschide;
  final Future<void> Function() onSterge;

  const _RandPlan({
    required this.p,
    required this.judet,
    required this.onDeschide,
    required this.onSterge,
  });

  @override
  Widget build(BuildContext context) {
    final d = p.plan;
    final stare = StarePlan.dinCod(d.stare);
    final cap = CalculReleveu.capacitate(
      tip: TipPlanMontaj.dinCod(d.tip),
      lungimeM: d.lungimeM,
      latimeM: d.latimeM,
      inclinareGrade: d.inclinareGrade,
      modul: CatalogImplicit.module.first,
      latitudine: CalculReleveu.latitudineJudet(judet),
      stare: stare,
      obstacole: [
        for (final o in p.obstacole)
          (inaltimeM: o.inaltimeM, distantaM: o.distantaM),
      ],
    );
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onDeschide,
      leading: CircleAvatar(
        backgroundColor: context.tintedSurface(
          stare.blocheazaMontajul ? context.accentRed : context.accentBlue,
        ),
        child: Icon(
          TipPlanMontaj.dinCod(d.tip).esteOrizontal
              ? Icons.crop_landscape
              : Icons.roofing,
          color: stare.blocheazaMontajul
              ? context.accentRed
              : context.accentBlue,
        ),
      ),
      title: Text(d.denumire),
      subtitle: Text(
        '${formatNumar(d.lungimeM)}×${formatNumar(d.latimeM)} m · '
        '${d.inclinareGrade.toStringAsFixed(0)}° · '
        '${SenzoriService.directie(d.azimutGrade)} · '
        '${cap.nrModule} module (${formatNumar(cap.kWp)} kWp)'
        '${p.obstacole.isEmpty ? '' : ' · ${p.obstacole.length} obstacole'}'
        '${stare == StarePlan.buna ? '' : ' · ${stare.eticheta}'}',
      ),
      isThreeLine: true,
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () async {
          final ok = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Ștergi „${d.denumire}"?'),
              content: const Text(
                'Planul și obstacolele lui vor fi eliminate.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Renunță'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Șterge'),
                ),
              ],
            ),
          );
          if (ok == true) await onSterge();
        },
      ),
    );
  }
}

class _CardTablou extends ConsumerStatefulWidget {
  final String releveuId;
  final TablouriExistenteData? tablou;
  const _CardTablou({required this.releveuId, required this.tablou});

  @override
  ConsumerState<_CardTablou> createState() => _CardTablouState();
}

class _CardTablouState extends ConsumerState<_CardTablou> {
  final _pozitii = TextEditingController();
  final _disjunctor = TextEditingController();
  final _icu = TextEditingController();
  final _idn = TextEditingController();
  final _sectiune = TextEditingController();
  TipDdr _ddr = TipDdr.necunoscut;
  bool _spd = false;
  bool _bara = false;
  bool _initializat = false;

  void _initializeaza() {
    final t = widget.tablou;
    if (_initializat || t == null) return;
    _initializat = true;
    _pozitii.text = t.pozitiiLibere?.toString() ?? '';
    _disjunctor.text = t.disjunctorGeneralA?.toString() ?? '';
    _icu.text = t.icuKa == null ? '' : formatNumar(t.icuKa);
    _idn.text = t.ddrIdnMa?.toString() ?? '';
    _sectiune.text = t.sectiuneColoanaMm2 == null
        ? ''
        : formatNumar(t.sectiuneColoanaMm2);
    _ddr = TipDdr.dinCod(t.ddrExistent);
    _spd = t.spdExistent;
    _bara = t.baraPeSeparata;
  }

  @override
  void dispose() {
    for (final c in [_pozitii, _disjunctor, _icu, _idn, _sectiune]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _salveaza() async {
    await ref
        .read(releveuRepositoryProvider)
        .salveazaTablou(
          widget.releveuId,
          TablouriExistenteCompanion(
            pozitiiLibere: Value(parseIntreg(_pozitii.text)),
            disjunctorGeneralA: Value(parseIntreg(_disjunctor.text)),
            icuKa: Value(parseNumar(_icu.text)),
            ddrExistent: Value(_ddr.cod),
            ddrIdnMa: Value(parseIntreg(_idn.text)),
            spdExistent: Value(_spd),
            baraPeSeparata: Value(_bara),
            sectiuneColoanaMm2: Value(parseNumar(_sectiune.text)),
          ),
        );
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tabloul a fost salvat')));
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeaza();
    return SectiuneCard(
      titlu: 'Tablou electric general',
      icon: Icons.dashboard_outlined,
      actiune: TextButton(onPressed: _salveaza, child: const Text('Salvează')),
      children: [
        Row(
          children: [
            Expanded(
              child: CalcNumberField(
                controller: _pozitii,
                label: 'Poziții DIN libere',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CalcNumberField(
                controller: _disjunctor,
                label: 'Disjunctor general',
                suffix: 'A',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CalcNumberField(
                controller: _icu,
                label: 'Icu',
                suffix: 'kA',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CalcNumberField(
                controller: _sectiune,
                label: 'Secțiune coloană',
                suffix: 'mm²',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: EnumDropdown<TipDdr>(
                label: 'DDR existent',
                value: _ddr,
                values: TipDdr.values,
                eticheta: (v) => v.eticheta,
                onChanged: (v) => setState(() => _ddr = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CalcNumberField(
                controller: _idn,
                label: 'IΔn',
                suffix: 'mA',
              ),
            ),
          ],
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: const Text('SPD existent'),
          value: _spd,
          onChanged: (v) => setState(() => _spd = v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: const Text('Bară PE separată de N'),
          value: _bara,
          onChanged: (v) => setState(() => _bara = v),
        ),
      ],
    );
  }
}

class _CardTrasee extends ConsumerStatefulWidget {
  final String releveuId;
  final List<TraseeData> trasee;
  const _CardTrasee({required this.releveuId, required this.trasee});

  @override
  ConsumerState<_CardTrasee> createState() => _CardTraseeState();
}

class _CardTraseeState extends ConsumerState<_CardTrasee> {
  final _campuri = {
    for (final s in SegmentTraseu.values) s: TextEditingController(),
  };
  bool _initializat = false;

  void _initializeaza() {
    if (_initializat || widget.trasee.isEmpty) return;
    _initializat = true;
    for (final t in widget.trasee) {
      final s = SegmentTraseu.dinCod(t.segment);
      _campuri[s]?.text = formatNumar(t.lungimeM);
    }
  }

  @override
  void dispose() {
    for (final c in _campuri.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _salveaza() async {
    final lungimi = <String, double>{};
    for (final e in _campuri.entries) {
      final v = parseNumar(e.value.text);
      if (v != null && v > 0) lungimi[e.key.cod] = v;
    }
    if (lungimi.isEmpty) return;
    await ref
        .read(releveuRepositoryProvider)
        .salveazaTrasee(widget.releveuId, lungimi);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Traseele au fost salvate')));
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeaza();
    return SectiuneCard(
      titlu: 'Trasee de cablu',
      icon: Icons.cable_outlined,
      actiune: TextButton(onPressed: _salveaza, child: const Text('Salvează')),
      children: [
        for (final s in SegmentTraseu.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CalcNumberField(
              controller: _campuri[s]!,
              label: s.eticheta,
              suffix: 'm',
            ),
          ),
        Text(
          'Lungimile intră direct în dimensionarea cablurilor și în necesarul de materiale.',
          style: TextStyle(fontSize: 12, color: context.subtitleColor),
        ),
      ],
    );
  }
}

class _CardClimatic extends ConsumerStatefulWidget {
  final ReleveeData releveu;
  const _CardClimatic({required this.releveu});

  @override
  ConsumerState<_CardClimatic> createState() => _CardClimaticState();
}

class _CardClimaticState extends ConsumerState<_CardClimatic> {
  late final _zapada = TextEditingController(
    text: widget.releveu.zapadaSkKnM2 == null
        ? ''
        : formatNumar(widget.releveu.zapadaSkKnM2),
  );
  late final _vant = TextEditingController(
    text: widget.releveu.vantQbKpa == null
        ? ''
        : formatNumar(widget.releveu.vantQbKpa),
  );
  late final _observatii = TextEditingController(
    text: widget.releveu.observatii,
  );

  @override
  void dispose() {
    _zapada.dispose();
    _vant.dispose();
    _observatii.dispose();
    super.dispose();
  }

  Future<void> _salveaza() async {
    await ref
        .read(releveuRepositoryProvider)
        .actualizeaza(
          widget.releveu.id,
          ReleveeCompanion(
            zapadaSkKnM2: Value(parseNumar(_zapada.text)),
            vantQbKpa: Value(parseNumar(_vant.text)),
            observatii: Value(_observatii.text.trim()),
          ),
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datele releveului au fost salvate')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SectiuneCard(
      titlu: 'Încărcări climatice și observații',
      icon: Icons.ac_unit_outlined,
      actiune: TextButton(onPressed: _salveaza, child: const Text('Salvează')),
      children: [
        Row(
          children: [
            Expanded(
              child: CalcNumberField(
                controller: _zapada,
                label: 'Zăpadă sk (CR 1-1-3)',
                suffix: 'kN/m²',
                presets: const {'1,5': '1,5', '2,0': '2,0', '2,5': '2,5'},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CalcNumberField(
                controller: _vant,
                label: 'Vânt qb (CR 1-1-4)',
                suffix: 'kPa',
                presets: const {
                  '0,4': '0,4',
                  '0,5': '0,5',
                  '0,6': '0,6',
                  '0,7': '0,7',
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _observatii,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Observații de șantier',
            hintText: 'acces, distanțe, particularități',
          ),
        ),
      ],
    );
  }
}
