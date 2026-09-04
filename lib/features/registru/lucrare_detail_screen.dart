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
          const SectiunePlanificata(
            titlu: 'Releveu tehnic de șantier',
            icon: Icons.roofing_outlined,
            etapa: 'E2',
          ),
          const SectiunePlanificata(
            titlu: 'Măsurători instrumentale',
            icon: Icons.speed_outlined,
            etapa: 'E2',
          ),
          const SectiunePlanificata(
            titlu: 'Soluția tehnică adoptată',
            icon: Icons.solar_power_outlined,
            etapa: 'E1',
          ),
          const SectiunePlanificata(
            titlu: 'Racordare și avize',
            icon: Icons.fact_check_outlined,
            etapa: 'E4',
          ),
          const SectiunePlanificata(
            titlu: 'Documente emise',
            icon: Icons.picture_as_pdf_outlined,
            etapa: 'E3',
          ),
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
