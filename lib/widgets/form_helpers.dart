import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/app_colors.dart';
import '../app/providers.dart';
import '../core/db/tables.dart' show furnizorOffGrid;
import '../core/services/contact_picker_service.dart';
import '../core/services/osm_service.dart';

/// Câmpuri refolosite de formularele de client și de fișă de lucrare:
/// adresă cu detectare din locație, selector de furnizor, buton de agendă.

/// Adresă cu buton „din locația curentă" (OpenStreetMap). [onAdresa] primește
/// adresa completă, cu localitate/județ/coordonate, ca formularul să le
/// distribuie în câmpurile lui.
class AdresaField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String label;
  final void Function(AdresaOsm adresa)? onAdresa;

  const AdresaField({
    super.key,
    required this.controller,
    this.label = 'Adresă (stradă, număr)',
    this.onAdresa,
  });

  @override
  ConsumerState<AdresaField> createState() => _AdresaFieldState();
}

class _AdresaFieldState extends ConsumerState<AdresaField> {
  bool _cauta = false;

  Future<void> _dinLocatie() async {
    setState(() => _cauta = true);
    final osm = ref.read(osmServiceProvider);
    final a = await osm.adresaCurenta();
    if (!mounted) return;
    setState(() => _cauta = false);
    if (a == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(osm.motivEsec ?? 'Adresa nu a fost găsită.')),
      );
      return;
    }
    widget.controller.text = a.strada.isNotEmpty ? a.strada : a.scurta;
    widget.onAdresa?.call(a);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: _cauta
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : IconButton(
                tooltip: 'Adresa din locația curentă (OpenStreetMap)',
                icon: Icon(Icons.my_location, color: context.accentBlue),
                onPressed: _dinLocatie,
              ),
      ),
    );
  }
}

/// Furnizorul de energie: lista predefinită + cei adăugați de utilizator,
/// opțiunea off-grid și „Alt furnizor…" care salvează unul nou.
class FurnizorField extends ConsumerWidget {
  final String valoare;
  final ValueChanged<String> onChanged;
  final String label;

  const FurnizorField({
    super.key,
    required this.valoare,
    required this.onChanged,
    this.label = 'Furnizor de energie',
  });

  static const _altul = '__altul__';
  static const _niciunul = '';

  Future<void> _adauga(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController();
    final nume = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Furnizor nou'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(labelText: 'Denumire furnizor'),
          onSubmitted: (v) => Navigator.pop(ctx, v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Renunță'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text),
            child: const Text('Salvează'),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (nume == null || nume.trim().isEmpty) return;
    final salvat = await ref.read(furnizoriRepositoryProvider).adauga(nume);
    onChanged(salvat);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final furnizori = ref.watch(furnizoriProvider).value ?? const [];
    final nume = furnizori.map((f) => f.denumire).toList();
    // valoarea curentă poate fi un furnizor șters între timp — rămâne vizibilă
    if (valoare.isNotEmpty &&
        valoare != furnizorOffGrid &&
        !nume.contains(valoare)) {
      nume.add(valoare);
    }
    return DropdownButtonFormField<String>(
      // cheia forțează reconstrucția când lista sau valoarea se schimbă
      key: ValueKey('$valoare|${nume.length}'),
      initialValue: valoare,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        const DropdownMenuItem(value: _niciunul, child: Text('— neprecizat —')),
        for (final n in nume)
          DropdownMenuItem(
            value: n,
            child: Text(n, overflow: TextOverflow.ellipsis),
          ),
        DropdownMenuItem(
          value: furnizorOffGrid,
          child: Row(
            children: [
              Icon(Icons.power_off, size: 18, color: context.accentOrange),
              const SizedBox(width: 6),
              const Text('Off-grid (fără racord)'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: _altul,
          child: Row(
            children: [
              Icon(Icons.add, size: 18, color: context.accentBlue),
              const SizedBox(width: 6),
              const Text('Alt furnizor…'),
            ],
          ),
        ),
      ],
      onChanged: (v) {
        if (v == null) return;
        if (v == _altul) {
          _adauga(context, ref);
        } else {
          onChanged(v);
        }
      },
    );
  }
}

/// Buton „din agendă": deschide selectorul de contacte al sistemului și
/// livrează contactul ales (nume, telefoane, e-mailuri, adrese).
class ContactButton extends ConsumerWidget {
  final void Function(ContactAles contact) onAles;
  const ContactButton({super.key, required this.onAles});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () async {
        final c = await ref.read(contactPickerProvider).alege();
        if (c == null || !context.mounted) return;
        onAles(c);
      },
      icon: const Icon(Icons.contacts_outlined),
      label: const Text('Din agendă'),
    );
  }
}

/// Când contactul are mai multe valori (telefoane, adrese), lasă utilizatorul
/// să aleagă una; cu una singură o întoarce direct.
Future<String?> alegeDinLista(
  BuildContext context, {
  required String titlu,
  required List<String> optiuni,
}) async {
  if (optiuni.isEmpty) return null;
  if (optiuni.length == 1) return optiuni.first;
  return showDialog<String>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: Text(titlu),
      children: [
        for (final o in optiuni)
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, o),
            child: Text(o),
          ),
      ],
    ),
  );
}
