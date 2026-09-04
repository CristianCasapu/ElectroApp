import 'dart:math';
import '../data/i7_tables.dart';

// ── Rezultat calcul secțiune cablu
class CableResult {
  final double curentCalc; // A
  final double sectiuneRecomandata; // mm²
  final double curentAdmisibil; // A (după corecții)
  final double curentAdmisibilBrut; // A (fără corecții)
  final double factorTemp;
  final double factorGrupare;
  final double cadereTensiuneV; // V
  final double cadereTensiunePct; // %
  final bool conformCadereTensiune;
  final bool conformCurentAdmisibil;
  final String modPozare;
  final String izolatie;
  final String material;
  final List<String> avertismente;

  const CableResult({
    required this.curentCalc,
    required this.sectiuneRecomandata,
    required this.curentAdmisibil,
    required this.curentAdmisibilBrut,
    required this.factorTemp,
    required this.factorGrupare,
    required this.cadereTensiuneV,
    required this.cadereTensiunePct,
    required this.conformCadereTensiune,
    required this.conformCurentAdmisibil,
    required this.modPozare,
    required this.izolatie,
    required this.material,
    this.avertismente = const [],
  });
}

class CableCalculator {
  // ── Calcul curent de sarcină
  static double calcCurentSarcina({
    required double putereW,
    required double tensiuneV,
    required bool trifazat,
    double cosPhi = 0.85,
  }) {
    if (trifazat) {
      return putereW / (sqrt(3) * tensiuneV * cosPhi);
    } else {
      return putereW / (tensiuneV * cosPhi);
    }
  }

  // ── Factor corecție temperatură
  static double factorCorrTemp(int tempAmbiantaC, String izolatie) {
    final key = izolatie == 'XLPE' ? 'XLPE' : 'PVC';
    // Găsim temperatura cea mai apropiată
    int tempKey = 30;
    int minDif = 999;
    for (final t in factoriCorrTemp.keys) {
      final dif = (t - tempAmbiantaC).abs();
      if (dif < minDif) {
        minDif = dif;
        tempKey = t;
      }
    }
    return factoriCorrTemp[tempKey]?[key] ?? 1.0;
  }

  // ── Factor corecție grupare
  static double factorCorrGrupare(int nrCircuite, String modPozare) {
    final isD = modPozare == 'D';
    final isAB = modPozare.startsWith('A') || modPozare.startsWith('B');
    String key;
    if (isD) {
      key = 'D';
    } else if (isAB) {
      key = 'A_B';
    } else {
      key = 'C';
    }

    int closestKey = 1;
    for (final k in factoriCorrGrupare.keys) {
      if (k <= nrCircuite) closestKey = k;
    }
    return factoriCorrGrupare[closestKey]?[key] ?? 1.0;
  }

  // ── Alegere secțiune optimă
  static CableResult calcSectiune({
    required double putereW,
    required double tensiuneV,
    required bool trifazat,
    required double lungimeM,
    required String modPozare,
    required String izolatie, // 'PVC' sau 'XLPE'
    required String material, // 'Cu' sau 'Al'
    double cosPhi = 0.92,
    int tempAmbiantaC = 30,
    int nrCircuite = 1,
    String tipCircuit = 'forta', // 'forta' sau 'iluminat'
  }) {
    final curentCalc = calcCurentSarcina(
      putereW: putereW,
      tensiuneV: tensiuneV,
      trifazat: trifazat,
      cosPhi: cosPhi,
    );

    final k1 = factorCorrTemp(tempAmbiantaC, izolatie);
    final k2 = factorCorrGrupare(nrCircuite, modPozare);
    final kTotal = k1 * k2;

    // Curentul de dimensionare (majorat cu inversul factorilor)
    final curentDimensionare = kTotal > 0 ? curentCalc / kTotal : curentCalc;

    // Tabele curenți admisibili
    final tabela = material == 'Al'
        ? (izolatie == 'XLPE'
              ? curentAdmisibilXlpeCu
              : curentAdmisibilPvcCu) // Al nu are tabel separat în versiunea simplificată
        : (izolatie == 'XLPE' ? curentAdmisibilXlpeCu : curentAdmisibilPvcCu);

    // Găsim secțiunea minimă
    double sectiuneAleasa = sectiuniStandard.last;
    double curentAdmisibilBrut = 0;

    for (final sectiune in sectiuniStandard) {
      final iz = tabela[sectiune]?[modPozare] ?? tabela[sectiune]?['C'] ?? 0;
      if (iz >= curentDimensionare) {
        sectiuneAleasa = sectiune;
        curentAdmisibilBrut = iz;
        break;
      }
    }

    final curentAdmisibilCorectat = curentAdmisibilBrut * kTotal;

    // Secțiunea minimă conform I7 (1.5mm² pentru iluminat, 2.5mm² pentru prize)
    if (tipCircuit == 'iluminat' && sectiuneAleasa < 1.5) sectiuneAleasa = 1.5;
    if (tipCircuit == 'forta' && sectiuneAleasa < 2.5) sectiuneAleasa = 2.5;

    // Calcul cădere de tensiune
    final rezistivitateM = material == 'Al'
        ? rezistivitate['Al']!
        : rezistivitate['Cu']!;
    final rezistentaOhm = rezistivitateM * lungimeM / sectiuneAleasa;
    final sinPhi = sqrt(1 - cosPhi * cosPhi);

    double cadereTensiuneV;
    if (trifazat) {
      cadereTensiuneV =
          sqrt(3) *
          curentCalc *
          (rezistentaOhm * cosPhi + reactantaCircuit * lungimeM * sinPhi);
    } else {
      cadereTensiuneV =
          2 *
          curentCalc *
          (rezistentaOhm * cosPhi + reactantaCircuit * lungimeM * sinPhi);
    }

    final cadereTensiunePct = cadereTensiuneV / tensiuneV * 100;
    final limitaAdmisa = cadereTensiuneMaxima[tipCircuit] ?? 5.0;

    final avertismente = <String>[];
    if (material == 'Al' && sectiuneAleasa < 16) {
      avertismente.add('I7: Secțiunea minimă pentru Al este 16mm²');
    }
    if (kTotal < 0.5) {
      avertismente.add(
        'Factor corecție total mic (${kTotal.toStringAsFixed(2)}) — verificați condițiile de instalare',
      );
    }
    if (cadereTensiunePct > limitaAdmisa) {
      avertismente.add(
        'Căderea de tensiune depășește limita de $limitaAdmisa% (${cadereTensiunePct.toStringAsFixed(2)}%)',
      );
    }

    return CableResult(
      curentCalc: curentCalc,
      sectiuneRecomandata: sectiuneAleasa,
      curentAdmisibil: curentAdmisibilCorectat,
      curentAdmisibilBrut: curentAdmisibilBrut,
      factorTemp: k1,
      factorGrupare: k2,
      cadereTensiuneV: cadereTensiuneV,
      cadereTensiunePct: cadereTensiunePct,
      conformCadereTensiune: cadereTensiunePct <= limitaAdmisa,
      conformCurentAdmisibil: curentAdmisibilCorectat >= curentCalc,
      modPozare: modPozare,
      izolatie: izolatie,
      material: material,
      avertismente: avertismente,
    );
  }
}

// ── Rezultat calcul cădere de tensiune
class VoltageDrop {
  final double cadereTensiuneV;
  final double cadereTensiunePct;
  final bool conform;
  final double limitaAdmisaPct;

  const VoltageDrop({
    required this.cadereTensiuneV,
    required this.cadereTensiunePct,
    required this.conform,
    required this.limitaAdmisaPct,
  });
}

class VoltageDropCalculator {
  static VoltageDrop calcCadereTensiune({
    required double curentA,
    required double lungimeM,
    required double sectiuneMm2,
    required double tensiuneV,
    required bool trifazat,
    required String material,
    double cosPhi = 0.85,
    String tipCircuit = 'forta',
  }) {
    final rezistivitateM = material == 'Al'
        ? rezistivitate['Al']!
        : rezistivitate['Cu']!;
    final rezistentaOhm = rezistivitateM * lungimeM / sectiuneMm2;
    final sinPhi = sqrt(1 - cosPhi * cosPhi);

    double cadereTensiuneV;
    if (trifazat) {
      cadereTensiuneV =
          sqrt(3) *
          curentA *
          (rezistentaOhm * cosPhi + reactantaCircuit * lungimeM * sinPhi);
    } else {
      cadereTensiuneV =
          2 *
          curentA *
          (rezistentaOhm * cosPhi + reactantaCircuit * lungimeM * sinPhi);
    }

    final caderePct = cadereTensiuneV / tensiuneV * 100;
    final limita = cadereTensiuneMaxima[tipCircuit] ?? 5.0;

    return VoltageDrop(
      cadereTensiuneV: cadereTensiuneV,
      cadereTensiunePct: caderePct,
      conform: caderePct <= limita,
      limitaAdmisaPct: limita,
    );
  }
}

// ── Calcul siguranță/disjunctor
class FuseResult {
  final int curentNominal;
  final bool conditieIz; // In ≤ Iz
  final bool conditieIcc; // verificare scurtcircuit
  final String caracteristica; // B, C, D
  final String explicatie;

  const FuseResult({
    required this.curentNominal,
    required this.conditieIz,
    required this.conditieIcc,
    required this.caracteristica,
    required this.explicatie,
  });
}

class FuseCalculator {
  static FuseResult alegereSiguranta({
    required double curentCalcA,
    required double curentAdmisibilCabluA,
    required String caracteristica, // 'B', 'C', 'D'
    required String tipCircuit,
  }) {
    // Condiția 1: In >= Ib (curent nominal ≥ curent de sarcină)
    // Condiția 2: In ≤ Iz (curent nominal ≤ curent admisibil cablu)
    int curentNominal = curentNominalDisjunctor.first;
    for (final in_ in curentNominalDisjunctor) {
      if (in_ >= curentCalcA) {
        curentNominal = in_;
        break;
      }
    }

    final conditieIz = curentNominal <= curentAdmisibilCabluA;

    String explicatie = 'Disjunctor $caracteristica $curentNominal A\n';
    explicatie += 'Curent sarcină: ${curentCalcA.toStringAsFixed(1)} A\n';
    explicatie +=
        'Curent admisibil cablu: ${curentAdmisibilCabluA.toStringAsFixed(1)} A\n';
    if (!conditieIz) {
      explicatie +=
          '⚠ In (${curentNominal}A) > Iz (${curentAdmisibilCabluA.toStringAsFixed(1)}A) — mărire secțiune!';
    } else {
      explicatie += '✓ Condiție I7: Ib ≤ In ≤ Iz satisfăcută';
    }

    // Caracteristici curbe
    switch (caracteristica) {
      case 'B':
        explicatie +=
            '\nCurbă B: declanșare la 3-5×In — pentru circuite rezistive, iluminat';
        break;
      case 'C':
        explicatie +=
            '\nCurbă C: declanșare la 5-10×In — pentru prize, motoare mici';
        break;
      case 'D':
        explicatie +=
            '\nCurbă D: declanșare la 10-20×In — pentru motoare, transformatoare';
        break;
    }

    return FuseResult(
      curentNominal: curentNominal,
      conditieIz: conditieIz,
      conditieIcc: true,
      caracteristica: caracteristica,
      explicatie: explicatie,
    );
  }
}

// ── Calcul putere absorbită
class PowerResult {
  final double putereInstalataW;
  final double putereAbsorbitaW;
  final double curentTotal;
  final double coefSimultaneitate;

  const PowerResult({
    required this.putereInstalataW,
    required this.putereAbsorbitaW,
    required this.curentTotal,
    required this.coefSimultaneitate,
  });
}
