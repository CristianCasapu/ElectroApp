import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/db/database.dart';
import '../../core/models/enums.dart';

/// Selector de beneficiar cu căutare și creare rapidă.
Future<ClientiData?> showClientPickerSheet(BuildContext context) {
  return showModalBottomSheet<ClientiData>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _ClientPicker(),
  );
}

class _ClientPicker extends ConsumerStatefulWidget {
  const _ClientPicker();

  @override
  ConsumerState<_ClientPicker> createState() => _ClientPickerState();
}

class _ClientPickerState extends ConsumerState<_ClientPicker> {
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
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (context, scroll) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cautare,
                    autofocus: true,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      hintText: 'Caută client',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: 'Client nou',
                  icon: const Icon(Icons.person_add_alt_1),
                  onPressed: () async {
                    final id = await context.push<String>('/clienti/nou');
                    if (id == null || !context.mounted) return;
                    final nou = await ref
                        .read(clientiRepositoryProvider)
                        .gaseste(id);
                    if (context.mounted) Navigator.pop(context, nou);
                  },
                ),
              ],
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
                if (filtrata.isEmpty) {
                  return Center(
                    child: Text(
                      lista.isEmpty
                          ? 'Niciun client — adaugă unul cu butonul de mai sus'
                          : 'Niciun rezultat',
                      style: TextStyle(color: context.subtitleColor),
                    ),
                  );
                }
                return ListView.builder(
                  controller: scroll,
                  itemCount: filtrata.length,
                  itemBuilder: (context, i) {
                    final c = filtrata[i];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          c.denumire.isEmpty ? '?' : c.denumire[0].toUpperCase(),
                        ),
                      ),
                      title: Text(c.denumire),
                      subtitle: Text(
                        [
                          TipClient.dinCod(c.tip).eticheta,
                          if (c.telefon.isNotEmpty) c.telefon,
                        ].join(' · '),
                      ),
                      onTap: () => Navigator.pop(context, c),
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
