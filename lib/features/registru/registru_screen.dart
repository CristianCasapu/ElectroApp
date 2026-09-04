import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/db/repositories.dart';
import '../../core/models/enums.dart';
import '../../core/utils/format.dart';
import '../setari/update_dialog.dart';
import '../../widgets/common_widgets.dart';

enum _Filtru { active, toate, arhivate }

class RegistruScreen extends ConsumerStatefulWidget {
  const RegistruScreen({super.key});

  @override
  ConsumerState<RegistruScreen> createState() => _RegistruScreenState();
}

class _RegistruScreenState extends ConsumerState<RegistruScreen> {
  final _cautare = TextEditingController();
  _Filtru _filtru = _Filtru.active;
  StareLucrare? _stare;

  static bool _verificatInSesiune = false;

  @override
  void initState() {
    super.initState();
    if (!_verificatInSesiune) {
      _verificatInSesiune = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          verificaActualizari(
            context,
            service: ref.read(updateServiceProvider),
            silentios: true,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _cautare.dispose();
    super.dispose();
  }

  bool _potrivire(FisaLucrare f) {
    switch (_filtru) {
      case _Filtru.active:
        if (!f.stare.esteActiva) return false;
      case _Filtru.arhivate:
        if (f.stare.esteActiva) return false;
      case _Filtru.toate:
        break;
    }
    if (_stare != null && f.stare != _stare) return false;
    final q = _cautare.text.trim().toLowerCase();
    if (q.isEmpty) return true;
    final text = [
      f.lucrare.nrInregistrare,
      f.lucrare.titlu,
      f.client?.denumire ?? '',
      f.locConsum?.adresa ?? '',
      f.locConsum?.localitate ?? '',
      f.locConsum?.codPod ?? '',
    ].join(' ').toLowerCase();
    return text.contains(q);
  }

  @override
  Widget build(BuildContext context) {
    final registru = ref.watch(registruProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Registru lucrări')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/registru/noua'),
        icon: const Icon(Icons.add),
        label: const Text('Fișă nouă'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: _cautare,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Caută după client, adresă, POD, nr. fișă',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _cautare.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(_cautare.clear),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final f in _Filtru.values) ...[
                  ChoiceChip(
                    label: Text(switch (f) {
                      _Filtru.active => 'Active',
                      _Filtru.toate => 'Toate',
                      _Filtru.arhivate => 'Arhivate',
                    }),
                    selected: _filtru == f,
                    onSelected: (_) => setState(() => _filtru = f),
                  ),
                  const SizedBox(width: 8),
                ],
                const VerticalDivider(width: 16, indent: 12, endIndent: 12),
                for (final s in StareLucrare.values.where((s) => s.esteActiva))
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(s.eticheta),
                      selected: _stare == s,
                      onSelected: (v) => setState(() => _stare = v ? s : null),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: registru.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Eroare: $e')),
              data: (fise) {
                final filtrate = fise.where(_potrivire).toList();
                if (fise.isEmpty) {
                  return const StareGoala(
                    icon: Icons.folder_open_outlined,
                    titlu: 'Registrul este gol',
                    descriere:
                        'Deschide prima fișă de lucrare cu butonul „Fișă nouă".',
                  );
                }
                if (filtrate.isEmpty) {
                  return const StareGoala(
                    icon: Icons.search_off,
                    titlu: 'Nicio fișă nu corespunde',
                    descriere: 'Schimbă filtrul sau textul căutat.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                  itemCount: filtrate.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, i) => _FisaCard(fisa: filtrate[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FisaCard extends StatelessWidget {
  final FisaLucrare fisa;
  const _FisaCard({required this.fisa});

  @override
  Widget build(BuildContext context) {
    final lc = fisa.locConsum;
    final detalii = <String>[
      if (lc != null) TipBransament.dinCod(lc.bransament).eticheta,
      if (lc != null && lc.putereAprobataKva != null)
        '${formatNumar(lc.putereAprobataKva)} kVA',
      if (lc != null && lc.codPod.isNotEmpty) 'POD ${lc.codPod}',
    ];
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/registru/${fisa.lucrare.id}'),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    fisa.lucrare.nrInregistrare,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: context.accentBlue,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const Spacer(),
                  StareChip(fisa.stare, compact: true),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                fisa.client?.denumire ?? 'Fără beneficiar',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                fisa.titluAfisat,
                style: TextStyle(fontSize: 13, color: context.subtitleColor),
              ),
              if (fisa.amplasament.isNotEmpty || detalii.isNotEmpty) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 14,
                      color: context.hintColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        [
                          if (fisa.amplasament.isNotEmpty) fisa.amplasament,
                          ...detalii,
                        ].join(' · '),
                        style: TextStyle(
                          fontSize: 12,
                          color: context.hintColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      formatData(fisa.lucrare.deschisaLa),
                      style: TextStyle(fontSize: 12, color: context.hintColor),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
