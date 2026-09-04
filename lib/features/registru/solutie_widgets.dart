import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../core/calc/verdict.dart';
import '../../core/models/solutie.dart';
import '../../core/utils/format.dart';
import '../../widgets/common_widgets.dart';

/// Afișarea unui rezultat de estimare — folosită atât în ecranul de calcul
/// (înainte de salvare), cât și la deschiderea unei revizii salvate.
class RezultatSolutieView extends StatelessWidget {
  final SolutieSnapshot s;
  const RezultatSolutieView({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    final r = s.rezultat;
    final i = s.intrari;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectiuneCard(
          titlu: 'Sistemul propus',
          icon: Icons.solar_power_outlined,
          children: [
            _Cifra(
              valoare: '${r.kWp.toStringAsFixed(2)} kWp',
              eticheta:
                  '${r.nrModule} × ${r.modul} · ${r.nrStringuri} string × ${r.ns}',
              culoare: context.accentBlue,
            ),
            const SizedBox(height: 6),
            CampInfo(
              'Invertor',
              '${r.invertor} · ${r.pAcKw} kW ${r.faze == 1 ? 'mono' : 'tri'} · ${r.tipInvertor}',
            ),
            CampInfo(
              'Stocare',
              r.nrBaterii > 0
                  ? '${r.nrBaterii} × ${r.baterie} = ${r.stocareKwh.toStringAsFixed(1)} kWh'
                  : 'fără',
            ),
            CampInfo(
              'Tensiuni string',
              'Voc(${i.tMinC.toStringAsFixed(0)} °C) ${r.vocTmin.toStringAsFixed(0)} V · Vmp(70 °C) ${r.vmpTmax.toStringAsFixed(0)} V',
            ),
            CampInfo(
              'Protecții AC',
              'disjunctor ${r.disjunctorAcA} A B · DDR tip ${r.tipDdr} · cablu ${formatNumar(r.sectiuneAcMm2)} mm²',
            ),
            CampInfo('Regim', r.regimProsumator),
            if (r.limitari.isNotEmpty) ...[
              const SizedBox(height: 6),
              for (final l in r.limitari)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.warningSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.warningBorder),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: context.warningText,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.warningText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        SectiuneCard(
          titlu: 'Verificări de dimensionare',
          icon: Icons.rule,
          children: [for (final v in r.verdicte) _VerdictRand(v)],
        ),
        const SizedBox(height: 12),
        SectiuneCard(
          titlu: 'Producție și economie',
          icon: Icons.wb_sunny_outlined,
          children: [
            Row(
              children: [
                Expanded(
                  child: _Cifra(
                    valoare:
                        '${formatNumar(r.productieAnualaKwh, zecimale: 0)} kWh/an',
                    eticheta:
                        '${r.productieSpecifica.toStringAsFixed(0)} kWh/kWp · ${(r.productieAnualaKwh / (i.consumAnualKwh == 0 ? 1 : i.consumAnualKwh) * 100).toStringAsFixed(0)} % din consum',
                    culoare: context.accentAmber,
                  ),
                ),
                Expanded(
                  child: _Cifra(
                    valoare:
                        '${formatNumar(r.economieAnualaRon, zecimale: 0)} RON/an',
                    eticheta:
                        'autoconsum ${(r.fractieAutoconsum * 100).toStringAsFixed(0)} % · amortizare ${r.paybackAni.isFinite ? '${r.paybackAni.toStringAsFixed(1)} ani' : '—'}',
                    culoare: context.accentGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _BareLunare(valori: r.productieLunaraKwh),
          ],
        ),
        const SizedBox(height: 12),
        SectiuneCard(
          titlu: 'Necesar de materiale',
          icon: Icons.inventory_2_outlined,
          actiune: Text(
            '${formatNumar(r.totalMaterialeRon, zecimale: 0)} RON',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: context.accentBlue,
            ),
          ),
          children: [_ListaLinii(linii: r.materiale, grupata: true)],
        ),
        const SizedBox(height: 12),
        SectiuneCard(
          titlu: 'Manoperă și servicii',
          icon: Icons.engineering_outlined,
          actiune: Text(
            '${formatNumar(r.totalManoperaRon, zecimale: 0)} RON',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: context.accentBlue,
            ),
          ),
          children: [_ListaLinii(linii: r.manopera, grupata: false)],
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total estimat (fără TVA)',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${formatNumar(r.totalRon, zecimale: 0)} RON',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: context.financialColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Cifra extends StatelessWidget {
  final String valoare;
  final String eticheta;
  final Color culoare;
  const _Cifra({
    required this.valoare,
    required this.eticheta,
    required this.culoare,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        valoare,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: culoare,
        ),
      ),
      Text(
        eticheta,
        style: TextStyle(fontSize: 12, color: context.subtitleColor),
      ),
    ],
  );
}

class _VerdictRand extends StatelessWidget {
  final VerdictSnapshot v;
  const _VerdictRand(this.v);

  @override
  Widget build(BuildContext context) {
    final (icon, culoare) = switch (v.nivelEnum) {
      NivelVerdict.conform => (Icons.check_circle, context.accentGreen),
      NivelVerdict.atentie => (
        Icons.warning_amber_rounded,
        context.accentOrange,
      ),
      NivelVerdict.neconform => (Icons.cancel, context.accentRed),
      NivelVerdict.informativ => (Icons.info, context.accentBlueGrey),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: culoare),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  v.titlu,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(v.detaliu, style: const TextStyle(fontSize: 12)),
                Text(
                  v.referinta,
                  style: TextStyle(fontSize: 11, color: context.hintColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BareLunare extends StatelessWidget {
  final List<double> valori;
  const _BareLunare({required this.valori});
  static const _luni = [
    'I',
    'F',
    'M',
    'A',
    'M',
    'I',
    'I',
    'A',
    'S',
    'O',
    'N',
    'D',
  ];

  @override
  Widget build(BuildContext context) {
    final max = valori.fold<double>(1, (m, v) => v > m ? v : m);
    return SizedBox(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < valori.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 50 * valori[i] / max,
                      decoration: BoxDecoration(
                        color: context.accentAmber,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _luni[i],
                      style: TextStyle(fontSize: 10, color: context.hintColor),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ListaLinii extends StatelessWidget {
  final List<LinieSnapshot> linii;
  final bool grupata;
  const _ListaLinii({required this.linii, required this.grupata});

  @override
  Widget build(BuildContext context) {
    String? categorie;
    final copii = <Widget>[];
    for (final l in linii) {
      if (grupata && l.categorie != categorie) {
        categorie = l.categorie;
        copii.add(
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 2),
            child: Text(
              categorie.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: context.subtitleColor,
              ),
            ),
          ),
        );
      }
      copii.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.denumire, style: const TextStyle(fontSize: 13)),
                    if (l.nota != null)
                      Text(
                        l.nota!,
                        style: TextStyle(
                          fontSize: 11,
                          color: context.hintColor,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${formatNumar(l.cantitate)} ${l.um}',
                style: TextStyle(fontSize: 12, color: context.subtitleColor),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 70,
                child: Text(
                  formatNumar(l.valoareRon, zecimale: 0),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: copii,
    );
  }
}
