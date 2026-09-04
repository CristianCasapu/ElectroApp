import 'package:flutter/material.dart';

/// Selector segmentat cu etichetă — înlocuiește rândurile de ChoiceChip.
class CalcSegmented<T> extends StatelessWidget {
  final String? label;
  final T selected;
  final Map<T, String> options;
  final ValueChanged<T> onChanged;

  const CalcSegmented({
    super.key,
    this.label,
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
        ],
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<T>(
            segments: options.entries
                .map(
                  (e) => ButtonSegment<T>(
                    value: e.key,
                    label: Text(e.value, textAlign: TextAlign.center),
                  ),
                )
                .toList(),
            selected: {selected},
            onSelectionChanged: (s) => onChanged(s.first),
            showSelectedIcon: false,
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],
    );
  }
}

/// Câmp numeric standardizat pentru calculatoare: tastatură zecimală,
/// sufix unitate, preseturi opționale sub câmp.
class CalcNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? suffix;
  final String? helper;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Map<String, String>? presets;

  const CalcNumberField({
    super.key,
    required this.controller,
    required this.label,
    this.suffix,
    this.helper,
    this.validator,
    this.onChanged,
    this.presets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: label,
            suffixText: suffix,
            helperText: helper,
          ),
          validator: validator,
          onChanged: onChanged,
        ),
        if (presets != null) ...[
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: presets!.entries
                .map(
                  (e) => ActionChip(
                    label: Text(e.key, style: const TextStyle(fontSize: 12)),
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      controller.text = e.value;
                      onChanged?.call(e.value);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}

/// Card pliabil cu formula și referința normativă — colapsat implicit,
/// nu mai ocupă ecranul înainte de datele de intrare.
class FormulaInfoTile extends StatelessWidget {
  final String titlu;
  final List<String> formule;
  final String? nota;

  const FormulaInfoTile({
    super.key,
    required this.titlu,
    required this.formule,
    this.nota,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(Icons.functions, color: cs.primary, size: 20),
          title: Text(
            titlu,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...formule.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  f,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ),
            if (nota != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  nota!,
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Titlu de secțiune pentru gruparea vizuală a datelor de intrare.
class CalcSectionTitle extends StatelessWidget {
  final String text;
  final IconData? icon;

  const CalcSectionTitle(this.text, {super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 10),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: cs.primary),
            const SizedBox(width: 6),
          ],
          Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Divider(color: cs.outlineVariant)),
        ],
      ),
    );
  }
}

/// Buton mare de calcul — stil unic pentru toate calculatoarele.
class CalcButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color culoare;
  final VoidCallback onPressed;

  const CalcButton({
    super.key,
    required this.label,
    required this.icon,
    required this.culoare,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: culoare,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}
