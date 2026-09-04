import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

/// Catalogul calculatoarelor de dimensionare (docs/CERCETARE.md §3.2).
/// În E0 sunt doar anunțate; motorul de calcul vine în E1.
class CalculeScreen extends StatelessWidget {
  const CalculeScreen({super.key});

  static const _calculatoare = [
    (
      'Dimensionare string-uri',
      'Voc la Tmin, Vmp la Tcell max, fereastră MPPT, Isc × 1,25, raport DC/AC',
      Icons.view_column_outlined,
      'IEC 62548',
    ),
    (
      'Randament energetic',
      'PVGIS 5.3 + model lunar offline, lanț de pierderi, PR',
      Icons.wb_sunny_outlined,
      'IEC 61724-1',
    ),
    (
      'Circuit AC invertor',
      'Curent, secțiune cablu, cădere de tensiune, disjunctor, DDR',
      Icons.cable_outlined,
      'I7-2011 / IEC 60364-5-52',
    ),
    (
      'Cablu DC și protecții',
      'Secțiune H1Z2Z2-K, ΔU ≤ 1 %, siguranțe gPV, SPD, separator',
      Icons.electric_bolt_outlined,
      'IEC 62548 / EN 61643-31',
    ),
    (
      'Stocare',
      'Capacitate pentru autoconsum / backup, C-rate, invertor hibrid',
      Icons.battery_charging_full_outlined,
      'Ord. ANRE 3/2023',
    ),
    (
      'Racordare și regim prosumator',
      'Praguri 27/200/400 kW, 16 A între faze, ≤ 30 kVA, RfG A–D',
      Icons.fact_check_outlined,
      'Ord. 228/2018 · Legea 160/2026',
    ),
    (
      'Transformator și MT',
      'S_tr, uk %, cablu 20 kV, protecții 27/59/81/67N',
      Icons.transform_outlined,
      'SR EN 50549-2',
    ),
    (
      'Economie',
      'Economii anuale, payback, NPV, LCOE',
      Icons.savings_outlined,
      '—',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calcule de dimensionare')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _calculatoare.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          if (i == 0) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.infoSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.infoBorder),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: context.infoText),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Motorul de calcul se livrează în etapa E1. '
                      'Fiecare rezultat va purta ipotezele și referința normativă.',
                      style: TextStyle(fontSize: 13, color: context.infoText),
                    ),
                  ),
                ],
              ),
            );
          }
          final c = _calculatoare[i - 1];
          return Card(
            child: ListTile(
              enabled: false,
              leading: Icon(c.$3, color: context.hintColor),
              title: Text(c.$1),
              subtitle: Text(
                '${c.$2}\n${c.$4}',
                style: const TextStyle(fontSize: 12),
              ),
              isThreeLine: true,
              trailing: Icon(
                Icons.lock_outline,
                size: 18,
                color: context.hintColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
