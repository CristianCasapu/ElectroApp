import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/db/database.dart';
import '../../core/db/masuratori_repository.dart';
import '../../core/services/log_service.dart';
import '../../core/utils/format.dart';
import '../../widgets/common_widgets.dart';

/// Aparatura de măsură a electricianului: denumire, serie și termenul de
/// etalonare. Un aparat cu etalonarea expirată nu poate semna un buletin, așa
/// că apare marcat în listă și în formularul de măsurătoare.
class InstrumenteScreen extends ConsumerWidget {
  const InstrumenteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final instrumente = ref.watch(instrumenteProvider).value ?? const [];
    final expirate = MasuratoriRepository.cuEtalonareExpirata(
      instrumente,
    ).map((i) => i.id).toSet();

    return Scaffold(
      appBar: AppBar(title: const Text('Aparatura de măsură')),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-instrument',
        onPressed: () => adaugaInstrument(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Aparat'),
      ),
      body: instrumente.isEmpty
          ? const StareGoala(
              icon: Icons.straighten_outlined,
              titlu: 'Niciun aparat',
              descriere:
                  'Adaugă aparatele cu care măsori; seria și etalonarea intră în buletinul de verificări.',
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
              itemCount: instrumente.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final it = instrumente[i];
                final expirat = expirate.contains(it.id);
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.straighten_outlined,
                    color: expirat ? context.accentRed : context.accentTeal,
                  ),
                  title: Text(
                    [
                      it.producator,
                      it.denumire,
                    ].where((x) => x.isNotEmpty).join(' '),
                  ),
                  subtitle: Text(
                    [
                      if (it.serie.isNotEmpty) 'seria ${it.serie}',
                      if (it.etalonareExpira != null)
                        '${expirat ? 'etalonare expirată la' : 'etalonat până la'} '
                            '${formatData(it.etalonareExpira!)}',
                    ].join(' · '),
                    style: TextStyle(color: expirat ? context.accentRed : null),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Șterge',
                    onPressed: () async {
                      await ref
                          .read(masuratoriRepositoryProvider)
                          .stergeInstrument(it.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}

/// Formularul de aparat, folosit și din ecranul de măsurători.
Future<String?> adaugaInstrument(BuildContext context, WidgetRef ref) async {
  final date = await showModalBottomSheet<InstrumenteCompanion>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _InstrumentSheet(),
  );
  if (date == null) return null;
  final id = await ref
      .read(masuratoriRepositoryProvider)
      .adaugaInstrument(date);
  log.info('masuratori', 'Aparat salvat', date.denumire.value);
  return id;
}

class _InstrumentSheet extends StatefulWidget {
  const _InstrumentSheet();

  @override
  State<_InstrumentSheet> createState() => _InstrumentSheetState();
}

class _InstrumentSheetState extends State<_InstrumentSheet> {
  final _denumire = TextEditingController();
  final _producator = TextEditingController();
  final _serie = TextEditingController();
  final _observatii = TextEditingController();
  DateTime? _expira;

  @override
  void dispose() {
    _denumire.dispose();
    _producator.dispose();
    _serie.dispose();
    _observatii.dispose();
    super.dispose();
  }

  Future<void> _alegeData() async {
    final acum = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _expira ?? DateTime(acum.year + 1, acum.month, acum.day),
      firstDate: DateTime(acum.year - 10),
      lastDate: DateTime(acum.year + 10),
    );
    if (d != null) setState(() => _expira = d);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aparat de măsură',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _denumire,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Denumire / model',
                hintText: 'ex. MI 3115',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _producator,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Producător',
                hintText: 'ex. Metrel',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _serie,
              decoration: const InputDecoration(labelText: 'Serie'),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_outlined),
              title: const Text('Etalonare valabilă până la'),
              subtitle: Text(
                _expira == null ? 'Nesetat' : formatData(_expira!),
              ),
              trailing: TextButton(
                onPressed: _alegeData,
                child: const Text('Alege'),
              ),
            ),
            TextField(
              controller: _observatii,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Observații'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                if (_denumire.text.trim().isEmpty) return;
                Navigator.pop(
                  context,
                  InstrumenteCompanion(
                    denumire: Value(_denumire.text.trim()),
                    producator: Value(_producator.text.trim()),
                    serie: Value(_serie.text.trim()),
                    etalonareExpira: Value(_expira),
                    observatii: Value(_observatii.text.trim()),
                  ),
                );
              },
              child: const Text('Salvează aparatul'),
            ),
          ],
        ),
      ),
    );
  }
}
