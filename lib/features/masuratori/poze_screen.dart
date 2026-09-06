import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/db/database.dart';
import '../../core/models/enums.dart';
import '../../core/services/log_service.dart';
import '../../core/utils/format.dart';
import '../../widgets/common_widgets.dart';

/// Fotografiile de șantier ale unei fișe, organizate pe secțiuni. Rămân pe
/// telefon, în directorul aplicației, și se pot trimite la nevoie.
class PozeScreen extends ConsumerStatefulWidget {
  final String lucrareId;
  const PozeScreen({super.key, required this.lucrareId});

  @override
  ConsumerState<PozeScreen> createState() => _PozeScreenState();
}

class _PozeScreenState extends ConsumerState<PozeScreen> {
  SectiunePoza? _filtru;
  bool _lucreaza = false;

  Future<void> _adauga(ImageSource sursa) async {
    setState(() => _lucreaza = true);
    try {
      final x = await ImagePicker().pickImage(
        source: sursa,
        maxWidth: 2000,
        imageQuality: 80,
      );
      if (x == null || !mounted) return;
      final sectiune = await showModalBottomSheet<({SectiunePoza s, String d})>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => const _DetaliiPozaSheet(),
      );
      if (sectiune == null) return;

      final baza = await getApplicationDocumentsDirectory();
      final dir = Directory(
        '${baza.path}${Platform.pathSeparator}poze${Platform.pathSeparator}${widget.lucrareId}',
      );
      await dir.create(recursive: true);
      final nume =
          '${sectiune.s.cod}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final fisier = await File(
        x.path,
      ).copy('${dir.path}${Platform.pathSeparator}$nume');
      final marime = await fisier.length();

      // coordonatele se cer doar dacă locația e deja permisă
      double? lat, lon;
      final osm = ref.read(osmServiceProvider);
      final poz = await osm.pozitiaCurenta();
      if (poz != null) {
        lat = poz.lat;
        lon = poz.lon;
      }

      await ref
          .read(masuratoriRepositoryProvider)
          .adaugaPoza(
            PozeCompanion(
              lucrareId: Value(widget.lucrareId),
              sectiune: Value(sectiune.s.cod),
              cale: Value(fisier.path),
              descriere: Value(sectiune.d),
              lat: Value(lat),
              lon: Value(lon),
              marimeBytes: Value(marime),
              facutaLa: Value(DateTime.now()),
            ),
          );
    } on Object catch (e, s) {
      log.error('poze', 'Adăugarea fotografiei a eșuat', e, s);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fotografia nu a putut fi salvată: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _lucreaza = false);
    }
  }

  Future<void> _deschide(PozeData p) async {
    final actiune = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(SectiunePoza.dinCod(p.sectiune).eticheta),
              subtitle: Text(
                '${formatDataOra(p.facutaLa)} · ${(p.marimeBytes / 1024).toStringAsFixed(0)} KB'
                '${p.lat == null ? '' : ' · ${p.lat!.toStringAsFixed(4)}, ${p.lon!.toStringAsFixed(4)}'}',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Trimite'),
              onTap: () => Navigator.pop(ctx, 'share'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Șterge'),
              onTap: () => Navigator.pop(ctx, 'delete'),
            ),
          ],
        ),
      ),
    );
    if (actiune == 'share') {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(p.cale, mimeType: 'image/jpeg')],
          subject: SectiunePoza.dinCod(p.sectiune).eticheta,
        ),
      );
    } else if (actiune == 'delete') {
      await ref.read(masuratoriRepositoryProvider).stergePoza(p.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fisa = ref.watch(fisaProvider(widget.lucrareId)).value;
    final poze = ref.watch(pozeProvider(widget.lucrareId)).value ?? const [];
    final filtrate = _filtru == null
        ? poze
        : poze.where((p) => p.sectiune == _filtru!.cod).toList();
    final sectiuniAcoperite = poze.map((p) => p.sectiune).toSet();
    final lipsuri = SectiunePoza.obligatoriiReleveu
        .where((s) => !sectiuniAcoperite.contains(s.cod))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          fisa == null
              ? 'Fotografii'
              : 'Fotografii · ${fisa.lucrare.nrInregistrare}',
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'fab-galerie',
            onPressed: _lucreaza ? null : () => _adauga(ImageSource.gallery),
            child: const Icon(Icons.photo_library_outlined),
          ),
          const SizedBox(width: 12),
          FloatingActionButton.extended(
            heroTag: 'fab-camera',
            onPressed: _lucreaza ? null : () => _adauga(ImageSource.camera),
            icon: const Icon(Icons.photo_camera_outlined),
            label: const Text('Fotografiază'),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_lucreaza) const LinearProgressIndicator(),
          if (lipsuri.isNotEmpty)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.warningSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.warningBorder),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_camera_back_outlined,
                    size: 18,
                    color: context.warningText,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Lipsesc fotografii: ${lipsuri.map((s) => s.eticheta.toLowerCase()).join(', ')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.warningText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text('Toate (${poze.length})'),
                    selected: _filtru == null,
                    onSelected: (_) => setState(() => _filtru = null),
                  ),
                ),
                for (final s in SectiunePoza.values)
                  if (poze.any((p) => p.sectiune == s.cod))
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(s.eticheta),
                        selected: _filtru == s,
                        onSelected: (v) =>
                            setState(() => _filtru = v ? s : null),
                      ),
                    ),
              ],
            ),
          ),
          Expanded(
            child: filtrate.isEmpty
                ? const StareGoala(
                    icon: Icons.photo_camera_outlined,
                    titlu: 'Nicio fotografie',
                    descriere:
                        'Fotografiază planele, tabloul, contorul și traseele — rămân pe telefon.',
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: filtrate.length,
                    itemBuilder: (context, i) => _Miniatura(
                      p: filtrate[i],
                      onTap: () => _deschide(filtrate[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _Miniatura extends StatelessWidget {
  final PozeData p;
  final VoidCallback onTap;
  const _Miniatura({required this.p, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final f = File(p.cale);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: f.existsSync()
                  ? Image.file(f, fit: BoxFit.cover)
                  : Container(
                      color: context.neutralSurface,
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: context.hintColor,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SectiunePoza.dinCod(p.sectiune).eticheta,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    p.descriere.isEmpty ? formatData(p.facutaLa) : p.descriere,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.subtitleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

class _DetaliiPozaSheet extends StatefulWidget {
  const _DetaliiPozaSheet();

  @override
  State<_DetaliiPozaSheet> createState() => _DetaliiPozaSheetState();
}

class _DetaliiPozaSheetState extends State<_DetaliiPozaSheet> {
  SectiunePoza _sectiune = SectiunePoza.plan;
  final _descriere = TextEditingController();

  @override
  void dispose() {
    _descriere.dispose();
    super.dispose();
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Unde încadrăm fotografia?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final s in SectiunePoza.values)
                ChoiceChip(
                  label: Text(s.eticheta),
                  selected: _sectiune == s,
                  onSelected: (_) => setState(() => _sectiune = s),
                ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriere,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Descriere (opțional)',
              hintText: 'ex. versant sud, coș la 2 m de margine',
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => Navigator.pop(context, (
              s: _sectiune,
              d: _descriere.text.trim(),
            )),
            child: const Text('Salvează fotografia'),
          ),
        ],
      ),
    );
  }
}
