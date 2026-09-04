import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final String titlu;
  final Color culoare;
  final IconData icon;
  final List<ResultRow> continut;

  const ResultCard({
    super.key,
    required this.titlu,
    required this.culoare,
    required this.icon,
    required this.continut,
  });

  @override
  Widget build(BuildContext context) {
    // Antetul rămâne saturat (text alb), dar pe suprafața întunecată
    // valorile bold au nevoie de o variantă mai deschisă a accentului.
    final accentText = Theme.of(context).brightness == Brightness.dark
        ? Color.lerp(culoare, Colors.white, 0.45)!
        : culoare;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: culoare.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: culoare,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  titlu,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: continut
                  .map(
                    (row) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              row.label,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            row.value,
                            style: TextStyle(
                              fontWeight: row.bold
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: row.bold ? 16 : 13,
                              color: row.bold
                                  ? accentText
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultRow {
  final String label;
  final String value;
  final bool bold;

  const ResultRow(this.label, this.value, {this.bold = false});
}
