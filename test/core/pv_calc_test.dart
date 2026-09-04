import 'package:electroapp/core/calc/echipamente.dart';
import 'package:electroapp/core/calc/materiale.dart';
import 'package:electroapp/core/calc/pv_estimare.dart';
import 'package:electroapp/core/calc/pv_randament.dart';
import 'package:electroapp/core/calc/pv_string.dart';
import 'package:electroapp/core/calc/verdict.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final modul = CatalogImplicit.module.first; // Jinko 440 W, Voc 39,6 V
  final huawei10 = CatalogImplicit.invertoare.firstWhere(
    (i) => i.model.startsWith('SUN2000-10KTL'),
  );
  final deye5 = CatalogImplicit.invertoare.firstWhere(
    (i) => i.model.startsWith('SUN-5K'),
  );

  group('ConfigString', () {
    test('Voc la −25 °C și Vmp la 70 °C după coeficienți', () {
      final c = ConfigString(
        modul: modul,
        invertor: huawei10,
        ns: 20,
        nrStringuri: 2,
      );
      // 20 × 39,6 × (1 + (−0,25/100)(−50)) = 20 × 39,6 × 1,125 = 891 V
      expect(c.vocLaTmin, closeTo(891, 0.5));
      // 20 × 33,2 × (1 + (−0,29/100)(45)) = 20 × 33,2 × 0,8695 = 577,3 V
      expect(c.vmpLaTmax, closeTo(577.3, 0.5));
      expect(c.iscMaxString, closeTo(17.5, 0.01));
      expect(c.nrModule, 40);
      expect(c.kWp, closeTo(17.6, 0.001));
    });

    test('nsMax / nsMin din limitele invertorului', () {
      // 1100 V / (39,6 × 1,125 = 44,55) = 24,69 → 24
      expect(ConfigString.nsMax(modul, huawei10), 24);
      // 160 V / (33,2 × 0,8695 = 28,87) = 5,54 → 6
      expect(ConfigString.nsMin(modul, huawei10), 6);
      // Deye 5K: 500 V / 44,55 = 11,2 → 11 ; 125 / 28,87 = 4,3 → 5
      expect(ConfigString.nsMax(modul, deye5), 11);
      expect(ConfigString.nsMin(modul, deye5), 5);
    });

    test('verdictele semnalează Voc peste V DC max', () {
      final c = ConfigString(
        modul: modul,
        invertor: deye5,
        ns: 12,
        nrStringuri: 1,
      );
      final v = c.verifica().firstWhere((x) => x.cod == 'voc_tmin');
      expect(v.nivel, NivelVerdict.neconform);
      expect(c.esteConforma, isFalse);
    });

    test('propune o configurație conformă pentru ~12 module pe Deye 5K', () {
      final c = ConfigString.propune(
        modul: modul,
        invertor: deye5,
        nrModuleDorit: 12,
      )!;
      expect(c.esteConforma, isTrue);
      expect(c.nrModule, inInclusiveRange(11, 13));
      expect(c.ns, inInclusiveRange(5, 11));
      expect(c.nrStringuri, lessThanOrEqualTo(deye5.stringuriMax));
    });

    test('siguranțe de string doar peste 2 string-uri paralel pe MPPT', () {
      final doua = ConfigString(
        modul: modul,
        invertor: huawei10,
        ns: 12,
        nrStringuri: 2,
      );
      expect(doua.necesitaSigurante, isFalse);
      final sungrow = CatalogImplicit.invertoare.last;
      final multe = ConfigString(
        modul: modul,
        invertor: sungrow,
        ns: 20,
        nrStringuri: 10,
      );
      // 10 string-uri pe 5 MPPT → 2 per MPPT: (2−1)×17,5 = 17,5 < 25 → nu
      expect(multe.necesitaSigurante, isFalse);
      // SPD: 1,2 × Voc(Tmin) = 1,2 × 891 = 1069 → clasa 1500 V
      expect(multe.spdUcMinV, 1500);
    });
  });

  group('RandamentPV', () {
    test('factorul de orientare: sud 30° = 1, nord vertical minim', () {
      expect(
        RandamentPV.factorOrientare(azimutGrade: 0, inclinareGrade: 30),
        1.0,
      );
      expect(
        RandamentPV.factorOrientare(azimutGrade: 180, inclinareGrade: 90),
        0.35,
      );
      expect(
        RandamentPV.factorOrientare(azimutGrade: -90, inclinareGrade: 15),
        0.90,
      );
      // interpolare: sud 22,5° între 0,96 și 1,00
      expect(
        RandamentPV.factorOrientare(azimutGrade: 0, inclinareGrade: 22.5),
        closeTo(0.98, 0.001),
      );
    });

    test('producția anuală pe județ și distribuția lunară', () {
      final e = RandamentPV.productieAnuala(
        kWp: 5,
        judet: 'Dolj',
        azimutGrade: 0,
        inclinareGrade: 30,
      );
      expect(e, 6500);
      final luni = RandamentPV.productieLunara(e);
      expect(luni.length, 12);
      expect(luni.reduce((a, b) => a + b), closeTo(e, 0.01));
      expect(RandamentPV.productieSpecifica('Necunoscut'), 1250);
    });

    test('autoconsumul crește cu stocarea și cu profilul diurn', () {
      final fara = RandamentPV.autoconsum(raport: 1, profilDiurn: false);
      final cu = RandamentPV.autoconsum(
        raport: 1,
        profilDiurn: false,
        stocareKwh: 5,
        consumZilnicKwh: 10,
      );
      final firma = RandamentPV.autoconsum(raport: 1, profilDiurn: true);
      expect(fara, closeTo(0.35, 0.001));
      expect(cu, closeTo(0.60, 0.001));
      expect(firma, closeTo(0.65, 0.001));
      expect(
        RandamentPV.autoconsum(raport: 4, profilDiurn: false),
        closeTo(0.175, 0.001),
      );
    });
  });

  group('EstimatorPV', () {
    test(
      'casă monofazată, 4 000 kWh/an → sistem ~4–5 kWp, invertor ≤ 5 kW',
      () {
        final e = EstimatorPV.estimeaza(
          const IntrariEstimare(
            consumAnualKwh: 4000,
            profil: ProfilConsum.casnic,
            faze: 1,
            judet: 'Dolj',
          ),
        );
        expect(e.invertor.faze, 1);
        expect(e.invertor.pAcNomKw, lessThanOrEqualTo(5));
        expect(e.kWp, inInclusiveRange(2.5, 6.5));
        expect(e.productieAnualaKwh, closeTo(e.kWp * 1300, 0.01));
        expect(e.gradAcoperire, greaterThan(0.8));
        expect(e.nrBaterii, 0);
        expect(e.config.esteConforma, isTrue);
        expect(e.regimProsumator, contains('≤ 27 kW'));
      },
    );

    test(
      'firmă trifazată cu 15 000 kWh/an și stocare → hibrid trifazat cu baterii',
      () {
        final e = EstimatorPV.estimeaza(
          const IntrariEstimare(
            consumAnualKwh: 15000,
            profil: ProfilConsum.diurn,
            faze: 3,
            judet: 'Cluj',
            putereAprobataKva: 15,
            stocare: ModStocare.autoconsum,
          ),
        );
        expect(e.invertor.faze, 3);
        expect(e.invertor.esteHibrid, isTrue);
        expect(e.nrBaterii, greaterThan(0));
        expect(e.baterie!.hv, e.invertor.baterieHv);
        expect(e.stocareKwh, greaterThanOrEqualTo(15000 / 365 * 0.5 - 5.2));
        expect(e.fractieAutoconsum, greaterThan(0.6));
      },
    );

    test('limitarea de acoperiș reduce sistemul', () {
      final e = EstimatorPV.estimeaza(
        const IntrariEstimare(
          consumAnualKwh: 12000,
          profil: ProfilConsum.casnic,
          faze: 1,
          judet: 'Iași',
          suprafataUtilaM2: 15,
        ),
      );
      expect(e.limitari.any((l) => l.contains('Suprafața')), isTrue);
      expect(e.kWp, lessThanOrEqualTo(4.0));
    });

    test('limitările de fază și putere aprobată sunt raportate', () {
      final e = EstimatorPV.estimeaza(
        const IntrariEstimare(
          consumAnualKwh: 12000,
          profil: ProfilConsum.casnic,
          faze: 1,
          judet: 'Iași',
          putereAprobataKva: 3,
        ),
      );
      expect(e.limitari.any((l) => l.contains('monofazat')), isTrue);
      expect(e.limitari.any((l) => l.contains('aprobată')), isTrue);
      expect(e.invertor.pAcNomKw, lessThanOrEqualTo(3));
      expect(e.verdicte.any((v) => v.cod == 'monofazat'), isTrue);
    });
  });

  group('NecesarMateriale', () {
    test('BOM coerent cu estimarea: module, string-uri, cablu, protecții', () {
      final e = EstimatorPV.estimeaza(
        const IntrariEstimare(
          consumAnualKwh: 10000,
          profil: ProfilConsum.casnic,
          faze: 3,
          judet: 'Timiș',
          putereAprobataKva: 12,
        ),
      );
      final n = NecesarMateriale.din(
        e,
        lungimeDcM: 20,
        lungimeAcM: 10,
        prizaPamantNoua: true,
      );
      final module = n.materiale.firstWhere(
        (l) => l.denumire.startsWith('Modul'),
      );
      expect(module.cantitate, e.nrModule);
      final cabluDc = n.materiale.firstWhere(
        (l) => l.denumire.startsWith('Cablu solar'),
      );
      expect(
        cabluDc.cantitate,
        greaterThanOrEqualTo(2 * 20 * e.config.nrStringuri),
      );
      expect(
        n.materiale.any((l) => l.denumire.startsWith('Disjunctor 4P')),
        isTrue,
      );
      expect(n.materiale.any((l) => l.denumire.startsWith('Electrod')), isTrue);
      expect(n.sectiuneAcMm2, greaterThanOrEqualTo(2.5));
      expect(n.disjunctorAcA, greaterThanOrEqualTo(16));
      expect(n.totalMaterialeRon, greaterThan(0));
      expect(n.totalManoperaRon, greaterThan(0));
      expect(n.totalRon, n.totalMaterialeRon + n.totalManoperaRon);
      expect(n.manopera.any((l) => l.denumire.contains('PIF')), isTrue);
    });

    test('disjunctorul standard imediat superior', () {
      expect(NecesarMateriale.curentDisjunctor(27.2), 32);
      expect(NecesarMateriale.curentDisjunctor(16), 16);
      expect(NecesarMateriale.curentDisjunctor(300), 125);
    });
  });
}
