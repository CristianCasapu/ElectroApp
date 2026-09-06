import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/db/database.dart';
import '../../core/db/repositories.dart';
import '../../core/models/enums.dart';
import '../../core/utils/format.dart';
import '../../widgets/common_widgets.dart';
import '../../core/db/solutii_repository.dart';
import '../../core/models/solutie.dart';
import '../../core/services/raport_pdf_service.dart';
import '../../core/calc/echipamente.dart';
import '../../core/calc/masuratori.dart';
import '../../core/calc/releveu.dart';
import '../../core/db/masuratori_repository.dart';
import '../../core/db/releveu_repository.dart';
import 'solutie_detail_screen.dart';

class LucrareDetailScreen extends ConsumerWidget {
  final String id;
  const LucrareDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fisa = ref.watch(fisaProvider(id));
    return fisa.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Eroare: $e')),
      ),
      data: (f) {
        if (f == null || f.lucrare.deletedAt != null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Fișă de lucrare')),
            body: const StareGoala(
              icon: Icons.folder_off_outlined,
              titlu: 'Fișa nu există',
              descriere: 'A fost ștearsă sau nu a putut fi încărcată.',
            ),
          );
        }
        return _Continut(fisa: f);
      },
    );
  }
}

class _Continut extends ConsumerWidget {
  final FisaLucrare fisa;
  const _Continut({required this.fisa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = fisa.lucrare;
    final c = fisa.client;
    final lc = fisa.locConsum;
    final istoric = ref.watch(istoricStariProvider(l.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.nrInregistrare),
        actions: [
          IconButton(
            tooltip: 'Editează',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/registru/${l.id}/editare'),
          ),
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'sterge') await _confirmaStergere(context, ref);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'sterge',
                child: ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Șterge fișa'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          _Antet(fisa: fisa),
          const SizedBox(height: 12),
          SectiuneCard(
            titlu: 'Beneficiar',
            icon: Icons.person_outline,
            actiune: c == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.open_in_new, size: 18),
                    tooltip: 'Deschide clientul',
                    onPressed: () => context.push('/clienti/${c.id}'),
                  ),
            children: [
              if (c == null)
                const Text('Fără beneficiar asociat')
              else ...[
                CampInfo('Denumire', c.denumire),
                CampInfo('Tip', TipClient.dinCod(c.tip).eticheta),
                CampInfo('Calitate', RolClient.dinCod(l.rolClient).eticheta),
                CampInfo('Telefon', c.telefon),
                CampInfo('E-mail', c.email),
                CampInfo('CUI', c.cui),
                CampInfo('Reprezentant', c.reprezentantLegal),
                CampInfo('Furnizor energie', c.furnizorEnergie),
                CampInfo('Cod client furnizor', c.codClientFurnizor),
                CampInfo('POD client', c.codPod),
              ],
            ],
          ),
          const SizedBox(height: 12),
          SectiuneCard(
            titlu: 'Loc de consum și amplasament',
            icon: Icons.electrical_services_outlined,
            children: [
              if (lc == null)
                const Text('Necompletat')
              else ...[
                CampInfo('Adresă', lc.adresa),
                CampInfo('Localitate', fisa.amplasament),
                if (lc.lat != null && lc.lon != null)
                  CampInfo(
                    'Coordonate',
                    '${lc.lat!.toStringAsFixed(5)}, ${lc.lon!.toStringAsFixed(5)}',
                  ),
                CampInfo(
                  'Operator distribuție',
                  OperatorDistributie.dinCod(lc.operatorDistributie).eticheta,
                ),
                CampInfo('Cod POD', lc.codPod),
                CampInfo('Furnizor energie', lc.furnizorEnergie),
                CampInfo('Cod client furnizor', lc.codClientFurnizor),
                CampInfo(
                  'Nivel tensiune',
                  NivelTensiune.dinCod(lc.nivelTensiune).eticheta,
                ),
                CampInfo(
                  'Branșament',
                  TipBransament.dinCod(lc.bransament).eticheta,
                ),
                CampInfo(
                  'Putere aprobată',
                  lc.putereAprobataKva == null
                      ? ''
                      : '${formatNumar(lc.putereAprobataKva)} kVA',
                ),
                CampInfo(
                  'Putere contractată',
                  lc.putereContractataKw == null
                      ? ''
                      : '${formatNumar(lc.putereContractataKw)} kW',
                ),
                CampInfo(
                  'Disjunctor general',
                  lc.disjunctorGeneralA == null
                      ? ''
                      : '${lc.disjunctorGeneralA} A',
                ),
                CampInfo(
                  'Schema legare la pământ',
                  SchemaLegarePamant.dinCod(lc.schemaLegarePamant).eticheta,
                ),
                CampInfo(
                  'Priză de pământ proprie',
                  lc.prizaPamantProprie ? 'Da' : 'Nu',
                ),
                CampInfo(
                  'Contor',
                  [
                    TipContor.dinCod(lc.contorTip).eticheta,
                    if (lc.contorSerie.isNotEmpty) 'seria ${lc.contorSerie}',
                    lc.contorBidirectional ? 'bidirecțional' : 'unidirecțional',
                  ].join(', '),
                ),
                CampInfo(
                  'Clădire',
                  [
                    DestinatieCladire.dinCod(lc.destinatieCladire).eticheta,
                    if (lc.anConstructie != null) 'an ${lc.anConstructie}',
                  ].join(', '),
                ),
                CampInfo('Observații', lc.observatii),
              ],
            ],
          ),
          const SizedBox(height: 12),
          _SectiuneReleveu(lucrareId: l.id, judet: lc?.judet ?? ''),
          _SectiuneMasuratori(lucrareId: l.id),
          _SectiuneSolutii(lucrareId: l.id),
          const SectiunePlanificata(
            titlu: 'Racordare și avize',
            icon: Icons.fact_check_outlined,
            etapa: 'E4',
          ),
          _SectiuneDocumente(lucrareId: l.id),
          const SizedBox(height: 12),
          SectiuneCard(
            titlu: 'Istoric stări',
            icon: Icons.history,
            children: [
              istoric.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('Eroare: $e'),
                data: (lista) =>
                    Column(children: [for (final s in lista) _IstoricRand(s)]),
              ),
            ],
          ),
          if (l.observatii.isNotEmpty) ...[
            const SizedBox(height: 12),
            SectiuneCard(
              titlu: 'Observații',
              icon: Icons.notes_outlined,
              children: [Text(l.observatii)],
            ),
          ],
        ],
      ),
      bottomNavigationBar: fisa.stare.urmatoare.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: FilledButton.icon(
                  onPressed: () => _schimbaStarea(context, ref),
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Schimbă starea'),
                ),
              ),
            ),
    );
  }

  Future<void> _schimbaStarea(BuildContext context, WidgetRef ref) async {
    final rezultat = await showModalBottomSheet<(StareLucrare, String)>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _StareSheet(curenta: fisa.stare),
    );
    if (rezultat == null) return;
    final profil = ref.read(profilFirmaProvider).value;
    final ok = await ref
        .read(lucrariRepositoryProvider)
        .schimbaStarea(
          id: fisa.lucrare.id,
          stareNoua: rezultat.$1,
          observatie: rezultat.$2,
          deCatre: profil?.electricianNume ?? '',
        );
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tranziție nepermisă din starea curentă')),
      );
    }
  }

  Future<void> _confirmaStergere(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ștergi fișa de lucrare?'),
        content: Text(
          'Fișa ${fisa.lucrare.nrInregistrare} va fi ștearsă din registru. '
          'Numărul de înregistrare nu va fi refolosit.',
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
    if (ok != true) return;
    await ref.read(lucrariRepositoryProvider).sterge(fisa.lucrare.id);
    if (context.mounted) context.go('/registru');
  }
}

class _Antet extends StatelessWidget {
  final FisaLucrare fisa;
  const _Antet({required this.fisa});

  @override
  Widget build(BuildContext context) {
    final l = fisa.lucrare;
    final culoare = context.culoareStare(fisa.stare);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    fisa.titluAfisat,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                StareChip(fisa.stare),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              fisa.tipLucrare.eticheta,
              style: TextStyle(color: context.subtitleColor, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.event, size: 16, color: culoare),
                const SizedBox(width: 6),
                Text(
                  'Deschisă ${formatData(l.deschisaLa)} · actualizată ${formatData(l.updatedAt)}',
                  style: TextStyle(fontSize: 12, color: context.subtitleColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IstoricRand extends StatelessWidget {
  final LucrariStariData s;
  const _IstoricRand(this.s);

  @override
  Widget build(BuildContext context) {
    final stare = StareLucrare.dinCod(s.stareIn);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: context.culoareStare(stare),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.stareDin == null
                      ? stare.eticheta
                      : '${StareLucrare.dinCod(s.stareDin).eticheta} → ${stare.eticheta}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  [
                    formatDataOra(s.la),
                    if (s.deCatre.isNotEmpty) s.deCatre,
                    if (s.observatie.isNotEmpty) s.observatie,
                  ].join(' · '),
                  style: TextStyle(fontSize: 12, color: context.subtitleColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StareSheet extends StatefulWidget {
  final StareLucrare curenta;
  const _StareSheet({required this.curenta});

  @override
  State<_StareSheet> createState() => _StareSheetState();
}

class _StareSheetState extends State<_StareSheet> {
  StareLucrare? _aleasa;
  final _obs = TextEditingController();

  @override
  void dispose() {
    _obs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final optiuni = widget.curenta.urmatoare;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stare nouă (din „${widget.curenta.eticheta}")',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in optiuni)
                ChoiceChip(
                  label: Text(s.eticheta),
                  selected: _aleasa == s,
                  selectedColor: context.tintedSurface(context.culoareStare(s)),
                  onSelected: (_) => setState(() => _aleasa = s),
                ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _obs,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Observație (opțional)',
              hintText: 'ex. ATR nr. 123/2026 primit, putere aprobată 10 kVA',
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _aleasa == null
                ? null
                : () => Navigator.pop(context, (_aleasa!, _obs.text.trim())),
            child: const Text('Confirmă'),
          ),
        ],
      ),
    );
  }
}

class _SectiuneSolutii extends ConsumerWidget {
  final String lucrareId;
  const _SectiuneSolutii({required this.lucrareId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final solutii = ref.watch(solutiiProvider(lucrareId)).value ?? const [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SectiuneCard(
        titlu: 'Soluția tehnică adoptată',
        icon: Icons.solar_power_outlined,
        actiune: TextButton.icon(
          onPressed: () => context.push('/registru/$lucrareId/estimare'),
          icon: const Icon(Icons.calculate_outlined, size: 18),
          label: Text(solutii.isEmpty ? 'Estimare' : 'Revizie nouă'),
        ),
        children: [
          if (solutii.isEmpty)
            Text(
              'Nicio estimare încă. Calculează sistemul din consum, amplasament și racord.',
              style: TextStyle(fontSize: 13, color: context.subtitleColor),
            ),
          for (final s in solutii)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: context.tintedSurface(context.accentBlue),
                child: Text(
                  'R${s.revizie}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: context.accentBlue,
                  ),
                ),
              ),
              title: Text(SolutiiRepository.decodeaza(s).titluScurt),
              subtitle: Text(
                [
                  formatDataOra(s.creataLa),
                  if (s.observatii.isNotEmpty) s.observatii,
                ].join(' · '),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/registru/$lucrareId/solutie/${s.id}'),
            ),
        ],
      ),
    );
  }
}

class _SectiuneDocumente extends ConsumerWidget {
  final String lucrareId;
  const _SectiuneDocumente({required this.lucrareId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docs = ref.watch(documenteProvider(lucrareId)).value ?? const [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SectiuneCard(
        titlu: 'Documente emise',
        icon: Icons.picture_as_pdf_outlined,
        children: [
          if (docs.isEmpty)
            Text(
              'Niciun document. Se emit din revizia salvată a soluției tehnice, '
              'iar buletinul de verificări din ecranul de măsurători.',
              style: TextStyle(fontSize: 13, color: context.subtitleColor),
            ),
          for (final d in docs)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: Icon(switch (TipDocument.dinCod(d.tip)) {
                TipDocument.fisaSistem => Icons.description_outlined,
                TipDocument.buletinPif => Icons.fact_check_outlined,
                _ => Icons.request_quote_outlined,
              }, color: context.accentRed),
              title: Text(RaportPdfService.numeAfisat(d)),
              subtitle: Text(
                '${formatDataOra(d.emisLa)} · ${(d.marimeBytes / 1024).toStringAsFixed(0)} KB',
              ),
              trailing: const Icon(Icons.more_horiz),
              onTap: () => deschideDocument(context, d),
            ),
        ],
      ),
    );
  }
}

class _SectiuneReleveu extends ConsumerWidget {
  final String lucrareId;
  final String judet;
  const _SectiuneReleveu({required this.lucrareId, required this.judet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complet = ref.watch(releveuProvider(lucrareId)).value;
    final plane = complet?.plane ?? const <PlanCuObstacole>[];
    var module = 0;
    var kWp = 0.0;
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
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SectiuneCard(
        titlu: 'Releveu tehnic de șantier',
        icon: Icons.roofing_outlined,
        actiune: TextButton.icon(
          onPressed: () => context.push('/registru/$lucrareId/releveu'),
          icon: const Icon(Icons.straighten, size: 18),
          label: Text(plane.isEmpty ? 'Deschide' : 'Editează'),
        ),
        children: [
          if (plane.isEmpty)
            Text(
              'Fără releveu. Măsoară planele de montaj, tabloul și traseele.',
              style: TextStyle(fontSize: 13, color: context.subtitleColor),
            )
          else ...[
            CampInfo('Plane de montaj', '${plane.length}'),
            CampInfo('Capacitate', '$module module ≈ ${formatNumar(kWp)} kWp'),
            CampInfo(
              'Suprafață măsurată',
              '${formatNumar(complet?.suprafataTotalaM2 ?? 0, zecimale: 0)} m²',
            ),
            if (complet?.tablou != null)
              CampInfo(
                'Tablou existent',
                [
                  if (complet!.tablou!.pozitiiLibere != null)
                    '${complet.tablou!.pozitiiLibere} poziții libere',
                  if (complet.tablou!.disjunctorGeneralA != null)
                    'general ${complet.tablou!.disjunctorGeneralA} A',
                  'DDR ${TipDdr.dinCod(complet.tablou!.ddrExistent).eticheta}',
                ].join(' · '),
              ),
            if ((complet?.trasee ?? const []).isNotEmpty)
              CampInfo(
                'Trasee',
                complet!.trasee
                    .map(
                      (t) =>
                          '${SegmentTraseu.dinCod(t.segment).eticheta.split(' ').first} ${formatNumar(t.lungimeM)} m',
                    )
                    .join(' · '),
              ),
          ],
        ],
      ),
    );
  }
}

class _SectiuneMasuratori extends ConsumerWidget {
  final String lucrareId;
  const _SectiuneMasuratori({required this.lucrareId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toate =
        ref
            .watch(masuratoriProvider((lucrareId: lucrareId, faza: null)))
            .value ??
        const <MasuratoriData>[];
    final active = MasuratoriRepository.inVigoare(toate);
    final poze = ref.watch(pozeProvider(lucrareId)).value ?? const <PozeData>[];
    final neconforme = active
        .where(
          (m) =>
              VerdictMasuratoare.dinCod(m.verdict) ==
              VerdictMasuratoare.neconform,
        )
        .length;
    final pif = active
        .where((m) => FazaMasuratoare.dinCod(m.faza) == FazaMasuratoare.pif)
        .map((m) => TipMasuratoare.dinCod(m.tip));
    final lipsuri = EvaluatorMasuratori.lipsuriPif(pif);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SectiuneCard(
        titlu: 'Măsurători și fotografii',
        icon: Icons.speed_outlined,
        actiune: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Fotografii',
              icon: const Icon(Icons.photo_camera_outlined, size: 20),
              onPressed: () => context.push('/registru/$lucrareId/poze'),
            ),
            TextButton.icon(
              onPressed: () => context.push('/registru/$lucrareId/masuratori'),
              icon: const Icon(Icons.add_chart, size: 18),
              label: Text(active.isEmpty ? 'Măsoară' : 'Deschide'),
            ),
          ],
        ),
        children: [
          if (active.isEmpty && poze.isEmpty)
            Text(
              'Nicio măsurătoare și nicio fotografie. Valorile de pe teren și '
              'testele de punere în funcțiune se înregistrează aici.',
              style: TextStyle(fontSize: 13, color: context.subtitleColor),
            )
          else ...[
            CampInfo(
              'Măsurători',
              '${active.length} în vigoare'
                  '${neconforme > 0 ? ' · $neconforme neconforme' : ''}'
                  '${toate.length > active.length ? ' · ${toate.length - active.length} corectate' : ''}',
            ),
            CampInfo(
              'Fotografii',
              poze.isEmpty
                  ? ''
                  : '${poze.length} în ${poze.map((p) => p.sectiune).toSet().length} secțiuni',
            ),
            if (lipsuri.isNotEmpty)
              CampInfo(
                'Lipsesc la PIF',
                lipsuri.map((t) => t.eticheta).join(', '),
              ),
          ],
        ],
      ),
    );
  }
}
