import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../core/models/enums.dart';

extension StareLucrareCuloare on BuildContext {
  Color culoareStare(StareLucrare s) => switch (s) {
    StareLucrare.lead => accentBlueGrey,
    StareLucrare.releveu => accentLightBlue,
    StareLucrare.dimensionare => accentBlue,
    StareLucrare.oferta => accentAmber,
    StareLucrare.atr => accentOrange,
    StareLucrare.executie => accentPurple,
    StareLucrare.pif => accentCyan,
    StareLucrare.certificat => accentGreen,
    StareLucrare.exploatare => accentTeal,
    StareLucrare.arhivat => hintColor,
    StareLucrare.anulat => accentRed,
  };
}

class StareChip extends StatelessWidget {
  final StareLucrare stare;
  final bool compact;

  const StareChip(this.stare, {super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final c = context.culoareStare(stare);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: context.tintedSurface(c),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withValues(alpha: 0.5)),
      ),
      child: Text(
        stare.eticheta,
        style: TextStyle(
          color: c,
          fontSize: compact ? 11 : 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Card de secțiune cu titlu și conținut — structura de bază a fișei.
class SectiuneCard extends StatelessWidget {
  final String titlu;
  final IconData icon;
  final List<Widget> children;
  final Widget? actiune;

  const SectiuneCard({
    super.key,
    required this.titlu,
    required this.icon,
    required this.children,
    this.actiune,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titlu,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ?actiune,
              ],
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// Rând etichetă → valoare, folosit în fișă.
class CampInfo extends StatelessWidget {
  final String eticheta;
  final String valoare;

  const CampInfo(this.eticheta, this.valoare, {super.key});

  @override
  Widget build(BuildContext context) {
    if (valoare.isEmpty || valoare == '—') return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              eticheta,
              style: TextStyle(fontSize: 13, color: context.subtitleColor),
            ),
          ),
          Expanded(
            child: Text(
              valoare,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

/// Secțiune planificată într-o etapă viitoare — vizibilă, dar inactivă.
class SectiunePlanificata extends StatelessWidget {
  final String titlu;
  final IconData icon;
  final String etapa;

  const SectiunePlanificata({
    super.key,
    required this.titlu,
    required this.icon,
    required this.etapa,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: context.hintColor),
        title: Text(titlu, style: TextStyle(color: context.hintColor)),
        subtitle: Text(
          'Disponibil în etapa $etapa',
          style: TextStyle(fontSize: 12, color: context.hintColor),
        ),
        trailing: Icon(Icons.lock_outline, size: 18, color: context.hintColor),
      ),
    );
  }
}

/// Stare goală standard pentru liste.
class StareGoala extends StatelessWidget {
  final IconData icon;
  final String titlu;
  final String descriere;

  const StareGoala({
    super.key,
    required this.icon,
    required this.titlu,
    required this.descriere,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: context.hintColor),
            const SizedBox(height: 12),
            Text(
              titlu,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              descriere,
              style: TextStyle(fontSize: 13, color: context.subtitleColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Dropdown generic peste un enum cu `cod` și `eticheta`.
class EnumDropdown<T extends Enum> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> values;
  final String Function(T) eticheta;
  final ValueChanged<T> onChanged;

  const EnumDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.values,
    required this.eticheta,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      isExpanded: true,
      items: values
          .map(
            (v) => DropdownMenuItem(
              value: v,
              child: Text(eticheta(v), overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}
