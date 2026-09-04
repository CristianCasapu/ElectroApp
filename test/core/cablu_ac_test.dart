import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:electroapp/core/calc/cablu_ac.dart';

void main() {
  // ── CableCalculator.calcCurentSarcina ──────────────────────────────────────

  group('CableCalculator.calcCurentSarcina', () {
    test('monofazic cosPhi=1 → P/U', () {
      final i = CableCalculator.calcCurentSarcina(
        putereW: 2300,
        tensiuneV: 230,
        trifazat: false,
        cosPhi: 1.0,
      );
      expect(i, closeTo(10.0, 0.01));
    });

    test('monofazic cosPhi=0.85', () {
      final i = CableCalculator.calcCurentSarcina(
        putereW: 2300,
        tensiuneV: 230,
        trifazat: false,
        cosPhi: 0.85,
      );
      // 2300 / (230 * 0.85) ≈ 11.76
      expect(i, closeTo(2300 / (230 * 0.85), 0.01));
    });

    test('trifazat cosPhi=1 → P/(√3·U)', () {
      final putere = sqrt(3) * 400 * 10; // exact 10 A
      final i = CableCalculator.calcCurentSarcina(
        putereW: putere,
        tensiuneV: 400,
        trifazat: true,
        cosPhi: 1.0,
      );
      expect(i, closeTo(10.0, 0.01));
    });

    test('trifazat cosPhi=0.85', () {
      final i = CableCalculator.calcCurentSarcina(
        putereW: 10000,
        tensiuneV: 400,
        trifazat: true,
        cosPhi: 0.85,
      );
      expect(i, closeTo(10000 / (sqrt(3) * 400 * 0.85), 0.01));
    });
  });

  // ── CableCalculator.factorCorrTemp ─────────────────────────────────────────

  group('CableCalculator.factorCorrTemp', () {
    test('30°C PVC → 1.00 (referință)', () {
      expect(CableCalculator.factorCorrTemp(30, 'PVC'), closeTo(1.00, 0.001));
    });

    test('30°C XLPE → 1.00 (referință)', () {
      expect(CableCalculator.factorCorrTemp(30, 'XLPE'), closeTo(1.00, 0.001));
    });

    test('40°C PVC → 0.87', () {
      expect(CableCalculator.factorCorrTemp(40, 'PVC'), closeTo(0.87, 0.001));
    });

    test('40°C XLPE → 0.91', () {
      expect(CableCalculator.factorCorrTemp(40, 'XLPE'), closeTo(0.91, 0.001));
    });

    test('10°C PVC → 1.22', () {
      expect(CableCalculator.factorCorrTemp(10, 'PVC'), closeTo(1.22, 0.001));
    });

    test('interpolează la cea mai apropiată tabelă — 27°C → tempKey=25', () {
      // |25-27|=2 < |30-27|=3 → nearest=25, PVC=1.06
      expect(CableCalculator.factorCorrTemp(27, 'PVC'), closeTo(1.06, 0.001));
    });

    test('interpolează la cea mai apropiată tabelă — 28°C → tempKey=30', () {
      // |30-28|=2 < |25-28|=3 → nearest=30, PVC=1.00
      expect(CableCalculator.factorCorrTemp(28, 'PVC'), closeTo(1.00, 0.001));
    });

    test('izolatie necunoscuta → tratata ca PVC', () {
      expect(
        CableCalculator.factorCorrTemp(30, 'PVC'),
        CableCalculator.factorCorrTemp(30, 'EPR'),
      );
    });
  });

  // ── CableCalculator.factorCorrGrupare ──────────────────────────────────────

  group('CableCalculator.factorCorrGrupare', () {
    test('1 circuit, mod C → 1.00', () {
      expect(CableCalculator.factorCorrGrupare(1, 'C'), closeTo(1.00, 0.001));
    });

    test('1 circuit, mod A → 1.00', () {
      expect(CableCalculator.factorCorrGrupare(1, 'A'), closeTo(1.00, 0.001));
    });

    test('3 circuite, mod C → 0.79', () {
      expect(CableCalculator.factorCorrGrupare(3, 'C'), closeTo(0.79, 0.001));
    });

    test('3 circuite, mod A → 0.70', () {
      expect(CableCalculator.factorCorrGrupare(3, 'A'), closeTo(0.70, 0.001));
    });

    test('5 circuite, mod D → 0.60', () {
      expect(CableCalculator.factorCorrGrupare(5, 'D'), closeTo(0.60, 0.001));
    });

    test('11 circuite → se foloseste cheia 10 (≤11)', () {
      // Chei disponibile ≤11: 1..10 → closestKey=10, C=0.70
      expect(CableCalculator.factorCorrGrupare(11, 'C'), closeTo(0.70, 0.001));
    });

    test('12 circuite → cheia exacta 12, C=0.69', () {
      expect(CableCalculator.factorCorrGrupare(12, 'C'), closeTo(0.69, 0.001));
    });

    test('mod B1 → mapat pe A_B', () {
      expect(CableCalculator.factorCorrGrupare(2, 'B1'), closeTo(0.80, 0.001));
    });
  });

  // ── CableCalculator.calcSectiune ───────────────────────────────────────────

  group('CableCalculator.calcSectiune', () {
    test('25kW trifazat 400V/30m — sectiune 10mm², conform curent', () {
      final r = CableCalculator.calcSectiune(
        putereW: 25000,
        tensiuneV: 400,
        trifazat: true,
        lungimeM: 30,
        modPozare: 'C',
        izolatie: 'PVC',
        material: 'Cu',
        cosPhi: 0.85,
        tempAmbiantaC: 30,
        nrCircuite: 1,
        tipCircuit: 'forta',
      );

      expect(r.sectiuneRecomandata, closeTo(10.0, 0.001));
      expect(r.curentAdmisibil, closeTo(57.0, 0.1));
      expect(r.conformCurentAdmisibil, isTrue);
      expect(r.conformCadereTensiune, isTrue);
      expect(r.material, 'Cu');
      expect(r.izolatie, 'PVC');
    });

    test('sectiune minima forta = 2.5mm² indiferent de curent mic', () {
      final r = CableCalculator.calcSectiune(
        putereW: 500,
        tensiuneV: 230,
        trifazat: false,
        lungimeM: 5,
        modPozare: 'C',
        izolatie: 'PVC',
        material: 'Cu',
        cosPhi: 1.0,
        tempAmbiantaC: 30,
        nrCircuite: 1,
        tipCircuit: 'forta',
      );
      expect(r.sectiuneRecomandata, greaterThanOrEqualTo(2.5));
    });

    test('sectiune minima iluminat = 1.5mm²', () {
      final r = CableCalculator.calcSectiune(
        putereW: 200,
        tensiuneV: 230,
        trifazat: false,
        lungimeM: 5,
        modPozare: 'C',
        izolatie: 'PVC',
        material: 'Cu',
        cosPhi: 1.0,
        tempAmbiantaC: 30,
        nrCircuite: 1,
        tipCircuit: 'iluminat',
      );
      expect(r.sectiuneRecomandata, greaterThanOrEqualTo(1.5));
    });

    test('avertisment Al sub 16mm²', () {
      // Sarcina mica → sectiune aleasa < 16mm², dar Al → avertisment
      final r = CableCalculator.calcSectiune(
        putereW: 2000,
        tensiuneV: 230,
        trifazat: false,
        lungimeM: 10,
        modPozare: 'C',
        izolatie: 'PVC',
        material: 'Al',
        cosPhi: 0.9,
        tempAmbiantaC: 30,
        nrCircuite: 1,
        tipCircuit: 'forta',
      );
      expect(r.sectiuneRecomandata, lessThan(16.0));
      expect(r.avertismente.any((a) => a.contains('16mm')), isTrue);
    });

    test('avertisment cadere tensiune depasita', () {
      // Cablu lung, sarcina mare → cadere tensiune > 5%
      final r = CableCalculator.calcSectiune(
        putereW: 20000,
        tensiuneV: 230,
        trifazat: false,
        lungimeM: 200,
        modPozare: 'C',
        izolatie: 'PVC',
        material: 'Cu',
        cosPhi: 0.85,
        tempAmbiantaC: 30,
        nrCircuite: 1,
        tipCircuit: 'forta',
      );
      expect(r.conformCadereTensiune, isFalse);
      expect(r.avertismente.any((a) => a.contains('tensiune')), isTrue);
    });

    test('factori de corectie se aplica corect la temp 40°C', () {
      final rRef = CableCalculator.calcSectiune(
        putereW: 15000,
        tensiuneV: 400,
        trifazat: true,
        lungimeM: 20,
        modPozare: 'C',
        izolatie: 'PVC',
        material: 'Cu',
        cosPhi: 0.85,
        tempAmbiantaC: 30,
        nrCircuite: 1,
        tipCircuit: 'forta',
      );
      final rHot = CableCalculator.calcSectiune(
        putereW: 15000,
        tensiuneV: 400,
        trifazat: true,
        lungimeM: 20,
        modPozare: 'C',
        izolatie: 'PVC',
        material: 'Cu',
        cosPhi: 0.85,
        tempAmbiantaC: 40,
        nrCircuite: 1,
        tipCircuit: 'forta',
      );
      // La temperatură mai mare factorul scade → curentul admisibil scade → sectiune mai mare sau egala
      expect(
        rHot.sectiuneRecomandata,
        greaterThanOrEqualTo(rRef.sectiuneRecomandata),
      );
      expect(rHot.factorTemp, closeTo(0.87, 0.001));
    });
  });

  // ── VoltageDropCalculator ──────────────────────────────────────────────────

  group('VoltageDropCalculator.calcCadereTensiune', () {
    test('monofazic 30A/50m/10mm²/Cu — conform (< 5%)', () {
      final r = VoltageDropCalculator.calcCadereTensiune(
        curentA: 30,
        lungimeM: 50,
        sectiuneMm2: 10,
        tensiuneV: 230,
        trifazat: false,
        material: 'Cu',
        cosPhi: 0.85,
        tipCircuit: 'forta',
      );
      // ΔU = 2 * 30 * (0.0225*50/10 * 0.85 + 0.00008*50 * sin(acos(0.85)))
      final sinPhi = sqrt(1 - 0.85 * 0.85);
      final rez = 0.0225 * 50 / 10;
      final expected = 2 * 30 * (rez * 0.85 + 0.00008 * 50 * sinPhi);
      expect(r.cadereTensiuneV, closeTo(expected, 0.01));
      expect(r.cadereTensiunePct, closeTo(expected / 230 * 100, 0.01));
      expect(r.conform, isTrue);
      expect(r.limitaAdmisaPct, closeTo(5.0, 0.001));
    });

    test('monofazic sarcina mare pe cablu lung — neconform (> 5%)', () {
      final r = VoltageDropCalculator.calcCadereTensiune(
        curentA: 80,
        lungimeM: 100,
        sectiuneMm2: 10,
        tensiuneV: 230,
        trifazat: false,
        material: 'Cu',
        cosPhi: 0.85,
        tipCircuit: 'forta',
      );
      expect(r.conform, isFalse);
      expect(r.cadereTensiunePct, greaterThan(5.0));
    });

    test('trifazat 400V — formula cu √3', () {
      final r = VoltageDropCalculator.calcCadereTensiune(
        curentA: 50,
        lungimeM: 30,
        sectiuneMm2: 16,
        tensiuneV: 400,
        trifazat: true,
        material: 'Cu',
        cosPhi: 0.9,
        tipCircuit: 'forta',
      );
      final sinPhi = sqrt(1 - 0.9 * 0.9);
      final rez = 0.0225 * 30 / 16;
      final expected = sqrt(3) * 50 * (rez * 0.9 + 0.00008 * 30 * sinPhi);
      expect(r.cadereTensiuneV, closeTo(expected, 0.01));
    });

    test('aluminiu are rezistivitate mai mare decat cuprul', () {
      const params = (curentA: 30.0, lungimeM: 50.0, sectiuneMm2: 16.0);
      final rCu = VoltageDropCalculator.calcCadereTensiune(
        curentA: params.curentA,
        lungimeM: params.lungimeM,
        sectiuneMm2: params.sectiuneMm2,
        tensiuneV: 230,
        trifazat: false,
        material: 'Cu',
        cosPhi: 0.85,
      );
      final rAl = VoltageDropCalculator.calcCadereTensiune(
        curentA: params.curentA,
        lungimeM: params.lungimeM,
        sectiuneMm2: params.sectiuneMm2,
        tensiuneV: 230,
        trifazat: false,
        material: 'Al',
        cosPhi: 0.85,
      );
      expect(rAl.cadereTensiuneV, greaterThan(rCu.cadereTensiuneV));
    });

    test('limita iluminat 3%, forta 5%', () {
      final rI = VoltageDropCalculator.calcCadereTensiune(
        curentA: 5,
        lungimeM: 10,
        sectiuneMm2: 1.5,
        tensiuneV: 230,
        trifazat: false,
        material: 'Cu',
        cosPhi: 0.9,
        tipCircuit: 'iluminat',
      );
      final rF = VoltageDropCalculator.calcCadereTensiune(
        curentA: 5,
        lungimeM: 10,
        sectiuneMm2: 1.5,
        tensiuneV: 230,
        trifazat: false,
        material: 'Cu',
        cosPhi: 0.9,
        tipCircuit: 'forta',
      );
      expect(rI.limitaAdmisaPct, closeTo(3.0, 0.001));
      expect(rF.limitaAdmisaPct, closeTo(5.0, 0.001));
    });
  });

  // ── FuseCalculator ─────────────────────────────────────────────────────────

  group('FuseCalculator.alegereSiguranta', () {
    test('alege primul disjunctor >= curent sarcina', () {
      final r = FuseCalculator.alegereSiguranta(
        curentCalcA: 20,
        curentAdmisibilCabluA: 24,
        caracteristica: 'C',
        tipCircuit: 'forta',
      );
      expect(r.curentNominal, 20);
      expect(r.conditieIz, isTrue);
      expect(r.caracteristica, 'C');
    });

    test('curent exact pe limita → urmatoarea treapta', () {
      // 10.5A → primul In ≥ 10.5 = 13A
      final r = FuseCalculator.alegereSiguranta(
        curentCalcA: 10.5,
        curentAdmisibilCabluA: 17.5,
        caracteristica: 'B',
        tipCircuit: 'iluminat',
      );
      expect(r.curentNominal, 13);
      expect(r.conditieIz, isTrue);
    });

    test('conditieIz false cand In > Iz', () {
      // 16A disjunctor, cablu admite 13.5A
      final r = FuseCalculator.alegereSiguranta(
        curentCalcA: 15,
        curentAdmisibilCabluA: 13.5,
        caracteristica: 'B',
        tipCircuit: 'iluminat',
      );
      expect(r.curentNominal, 16);
      expect(r.conditieIz, isFalse);
      expect(r.explicatie, contains('mărire secțiune'));
    });

    test('sarcina mica → 6A (primul din lista)', () {
      final r = FuseCalculator.alegereSiguranta(
        curentCalcA: 3,
        curentAdmisibilCabluA: 24,
        caracteristica: 'B',
        tipCircuit: 'iluminat',
      );
      expect(r.curentNominal, 6);
      expect(r.conditieIz, isTrue);
    });

    test('explicatie contine curba B/C/D', () {
      final rB = FuseCalculator.alegereSiguranta(
        curentCalcA: 10,
        curentAdmisibilCabluA: 24,
        caracteristica: 'B',
        tipCircuit: 'iluminat',
      );
      final rD = FuseCalculator.alegereSiguranta(
        curentCalcA: 10,
        curentAdmisibilCabluA: 24,
        caracteristica: 'D',
        tipCircuit: 'forta',
      );
      expect(rB.explicatie, contains('Curbă B'));
      expect(rD.explicatie, contains('Curbă D'));
    });
  });
}
