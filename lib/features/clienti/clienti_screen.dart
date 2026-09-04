import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/models/enums.dart';
import '../../widgets/common_widgets.dart';

class ClientiScreen extends ConsumerStatefulWidget {
  const ClientiScreen({super.key});

  @override
  ConsumerState<ClientiScreen> createState() => _ClientiScreenState();
}

class _ClientiScreenState extends ConsumerState<ClientiScreen> {
  final _cautare = TextEditingController();

  @override
  void dispose() {
    _cautare.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clienti = ref.watch(clientiProvider);
    final q = _cautare.text.trim().toLowerCase();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Clienți')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/clienti/nou'),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Client nou'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _cautare,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Caută după nume, telefon, CUI',
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
          Expanded(
            child: clienti.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Eroare: $e')),
              data: (lista) {
                final filtrata = lista
                    .where(
                      (c) =>
                          q.isEmpty ||
                          c.denumire.toLowerCase().contains(q) ||
                          c.telefon.contains(q) ||
                          c.cui.toLowerCase().contains(q),
                    )
                    .toList();
                if (lista.isEmpty) {
                  return const StareGoala(
                    icon: Icons.people_outline,
                    titlu: 'Niciun client',
                    descriere: 'Adaugă beneficiarii lucrărilor cu „Client nou".',
                  );
                }
                if (filtrata.isEmpty) {
                  return const StareGoala(
                    icon: Icons.search_off,
                    titlu: 'Niciun rezultat',
                    descriere: 'Schimbă textul căutat.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                  itemCount: filtrata.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final c = filtrata[i];
                    final tip = TipClient.dinCod(c.tip);
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        onTap: () => context.push('/clienti/${c.id}'),
                        leading: CircleAvatar(
                          backgroundColor: context.tintedSurface(
                            tip == TipClient.persoanaFizica
                                ? context.accentBlue
                                : context.accentTeal,
                          ),
                          child: Icon(
                            tip == TipClient.persoanaFizica
                                ? Icons.person
                                : Icons.business,
                            color: tip == TipClient.persoanaFizica
                                ? context.accentBlue
                                : context.accentTeal,
                          ),
                        ),
                        title: Text(c.denumire),
                        subtitle: Text(
                          [
                            tip.eticheta,
                            if (c.telefon.isNotEmpty) c.telefon,
                            if (c.cui.isNotEmpty) 'CUI ${c.cui}',
                          ].join(' · '),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
