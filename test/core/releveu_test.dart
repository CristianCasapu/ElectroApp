import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:electroapp/core/calc/echipamente.dart';
import 'package:electroapp/core/calc/releveu.dart';
import 'package:electroapp/core/calc/verdict.dart';
import 'package:electroapp/core/db/database.dart';
import 'package:electroapp/core/db/releveu_repository.dart';
import 'package:electroapp/core/db/repositories.dart';
import 'package:electroapp/core/models/enums.dart';
import 'package:electroapp/core/services/senzori_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final modul = CatalogImplicit.module.first; // 1762 × 1134 mm, 440 W

  group('geometrie', () {
    test('unghiul solar de iarnă scade spre nord', () {
      final craiova = CalculReleveu.unghiSolarIarna(44.3);
      final suceava = CalculReleveu.unghiSolarIarna(47.6);
      expect(craiova, greaterThan(suceava));
      // amiaza la Craiova: 90 − 44,3 − 23,45 = 22,25° ; × 0,62 ≈ 13,8°
      expect(craiova, closeTo(13.8, 0.2));
      expect(CalculReleveu.unghiSolarIarna(80), 6, reason: 'plafon minim');
    });

    test('distanța între rânduri crește cu înclinarea', () {
      final d15 = CalculReleveu.distantaRanduri(
        lungimeModulM: 1.762,
        inclinareGrade: 15,
        latitudine: 44.3,
      );
      final d30 = CalculReleveu.distantaRanduri(
        lungimeModulM: 1.762,
        inclinareGrade: 30,
        latitudine: 44.3,
      );
      expect(d30, greaterThan(d15));
      expect(d15, greaterThan(1.762));
      // pe orizontală modulele stau lipite
      expect(
        CalculReleveu.distantaRanduri(
          lungimeModulM: 1.762,
          inclinareGrade: 0,
          latitudine: 44.3,
        ),
        1.762,
      );
    });

    test('umbrirea depinde de înălțime și distanță', () {
      double f(double h, double d) => CalculReleveu.factorUmbrire(
        obstacole: [(inaltimeM: h, distantaM: d)],
        suprafataM2: 60,
        latitudine: 44.3,
      );
      expect(f(0, 5), 1.0);
      expect(f(2, 30), 1.0, reason: 'obstacol prea departe');
      expect(f(3, 1), lessThan(0.9));
      expect(f(3, 1), greaterThanOrEqualTo(0.5), reason: 'plafonat la 50 %');
      expect(f(1, 2), greaterThan(f(3, 2)));
      expect(
        CalculReleveu.factorUmbrire(
          obstacole: const [],
          suprafataM2: 60,
          latitudine: 44.3,
        ),
        1.0,
      );
    });
  });

  group('capacitate', () {
    test('acoperiș înclinat: retrageri de 1 m pe fiecare latură', () {
      final cap = CalculReleveu.capacitate(
        tip: TipPlanMontaj.acoperisInclinat,
        lungimeM: 10,
        latimeM: 6,
        inclinareGrade: 30,
        modul: modul,
        latitudine: 44.3,
      );
      expect(cap.suprafataBrutaM2, 60);
      expect(cap.suprafataUtilaM2, closeTo(32, 0.01), reason: '8 × 4 m');
      // (8 + rost) / (1,134 + rost) → 6 coloane; (4 + rost) / (1,762 + rost) → 2 rânduri
      expect(cap.moduleOrizontal, 6);
      expect(cap.moduleVertical, 2);
      expect(cap.nrModule, 12);
      expect(cap.kWp, closeTo(5.28, 0.001));
      expect(cap.verdicte.any((v) => v.cod == 'retrageri'), isTrue);
    });

    test('terasa ține cont de distanța între rânduri', () {
      final terasa = CalculReleveu.capacitate(
        tip: TipPlanMontaj.terasa,
        lungimeM: 12,
        latimeM: 12,
        inclinareGrade: 15,
        modul: modul,
        latitudine: 44.3,
      );
      final inclinat = CalculReleveu.capacitate(
        tip: TipPlanMontaj.acoperisInclinat,
        lungimeM: 12,
        latimeM: 12,
        inclinareGrade: 15,
        modul: modul,
        latitudine: 44.3,
      );
      expect(terasa.nrModule, lessThan(inclinat.nrModule));
      expect(terasa.distantaRanduriM, greaterThan(1.762));
      expect(terasa.verdicte.any((v) => v.cod == 'distanta_randuri'), isTrue);
    });

    test('planul neconform dă verdict de blocare', () {
      final cap = CalculReleveu.capacitate(
        tip: TipPlanMontaj.acoperisInclinat,
        lungimeM: 10,
        latimeM: 6,
        inclinareGrade: 30,
        modul: modul,
        latitudine: 44.3,
        stare: StarePlan.neconforma,
      );
      final v = cap.verdicte.firstWhere((x) => x.cod == 'stare_plan');
      expect(v.nivel, NivelVerdict.neconform);
    });

    test('suprafață prea mică: niciun modul, cu avertisment', () {
      final cap = CalculReleveu.capacitate(
        tip: TipPlanMontaj.acoperisInclinat,
        lungimeM: 2.5,
        latimeM: 2.5,
        inclinareGrade: 30,
        modul: modul,
        latitudine: 44.3,
      );
      expect(cap.nrModule, 0);
      expect(cap.verdicte.any((v) => v.cod == 'capacitate'), isTrue);
    });

    test('obstacolele reduc factorul de umbrire al planului', () {
      final cap = CalculReleveu.capacitate(
        tip: TipPlanMontaj.acoperisInclinat,
        lungimeM: 10,
        latimeM: 6,
        inclinareGrade: 30,
        modul: modul,
        latitudine: 44.3,
        obstacole: const [(inaltimeM: 2.5, distantaM: 1)],
      );
      expect(cap.factorUmbrire, lessThan(1));
      expect(cap.verdicte.any((v) => v.cod == 'umbrire'), isTrue);
    });
  });

  group('încărcări', () {
    test('zăpada scade cu panta (CR 1-1-3)', () {
      expect(
        CalculReleveu.incarcareZapada(skKnM2: 2.0, inclinareGrade: 20),
        closeTo(1.6, 0.001),
      );
      expect(
        CalculReleveu.incarcareZapada(skKnM2: 2.0, inclinareGrade: 45),
        closeTo(0.8, 0.001),
      );
      expect(CalculReleveu.incarcareZapada(skKnM2: 2.0, inclinareGrade: 65), 0);
    });

    test('forța de vânt crește cu presiunea de referință', () {
      final f = CalculReleveu.fortaVant(qbKpa: 0.5, suprafataModulM2: 2.0);
      expect(f, greaterThan(0));
      expect(
        CalculReleveu.fortaVant(qbKpa: 0.7, suprafataModulM2: 2.0),
        greaterThan(f),
      );
    });

    test('latitudinea județului, cu valoare implicită pentru necunoscut', () {
      expect(CalculReleveu.latitudineJudet('Constanța'), 44.2);
      expect(CalculReleveu.latitudineJudet('Suceava'), 47.6);
      expect(CalculReleveu.latitudineJudet('Necunoscut'), 45.9);
    });
  });

  group('senzori', () {
    test('telefon așezat orizontal: înclinare zero', () {
      final c = SenzoriService.calculeaza(
        ax: 0,
        ay: 0,
        az: 9.81,
        mx: 20,
        my: 0,
        mz: -40,
        areMagnetometru: true,
      );
      expect(c.inclinareGrade, closeTo(0, 0.5));
      expect(c.busolaDisponibila, isTrue);
    });

    test('telefon la 30°: inclinometrul citește panta', () {
      // g proiectat pe axele telefonului înclinat cu 30°
      final c = SenzoriService.calculeaza(
        ax: 0,
        ay: 9.81 * 0.5,
        az: 9.81 * 0.866,
        mx: 20,
        my: 0,
        mz: -40,
        areMagnetometru: true,
      );
      expect(c.inclinareGrade, closeTo(30, 1));
    });

    test('fără magnetometru: doar înclinarea', () {
      final c = SenzoriService.calculeaza(
        ax: 0,
        ay: 0,
        az: 9.81,
        mx: 0,
        my: 0,
        mz: 0,
        areMagnetometru: false,
      );
      expect(c.busolaDisponibila, isFalse);
      expect(c.azimutFataDeSud, 0);
      expect(c.inclinareGrade, closeTo(0, 0.5));
    });

    test('denumirea direcției din azimut', () {
      expect(SenzoriService.directie(0), 'sud');
      expect(SenzoriService.directie(-90), 'est');
      expect(SenzoriService.directie(90), 'vest');
      expect(SenzoriService.directie(180), 'nord');
      expect(SenzoriService.directie(-45), 'sud-est');
      expect(SenzoriService.directie(45), 'sud-vest');
    });
  });

  group('ReleveuRepository', () {
    late AppDatabase db;
    late ReleveuRepository repo;
    late String lucrareId;

    setUp(() async {
      db = AppDatabase.inMemory(NativeDatabase.memory());
      repo = ReleveuRepository(db);
      final c = await ClientiRepository(db).creeaza(
        const ClientiCompanion(tip: Value('pf'), denumire: Value('Ion')),
      );
      lucrareId = await LucrariRepository(db).creeaza(
        lucrare: LucrariCompanion(
          clientId: Value(c),
          rolClient: Value(RolClient.proprietar.cod),
          tipLucrare: Value(TipLucrare.instalareNoua.cod),
        ),
        locConsum: LocuriConsumCompanion(
          operatorDistributie: Value(OperatorDistributie.ppc.cod),
          nivelTensiune: Value(NivelTensiune.jt.cod),
          bransament: Value(TipBransament.trifazat.cod),
          schemaLegarePamant: Value(SchemaLegarePamant.tnCS.cod),
          contorTip: Value(TipContor.smart.cod),
          destinatieCladire: Value(DestinatieCladire.rezidential.cod),
          judet: const Value('Dolj'),
        ),
      );
    });

    tearDown(() => db.close());

    test('releveul se creează o singură dată pentru o fișă', () async {
      final r1 = await repo.asigura(lucrareId, operator: 'Ion');
      final r2 = await repo.asigura(lucrareId);
      expect(r1.id, r2.id);
      expect(r1.operator, 'Ion');
    });

    test('planele și obstacolele se salvează și se citesc împreună', () async {
      final r = await repo.asigura(lucrareId);
      final planId = await repo.adaugaPlan(
        PlaneMontajCompanion(
          releveuId: Value(r.id),
          denumire: const Value('Versant sud'),
          tip: Value(TipPlanMontaj.acoperisInclinat.cod),
          invelitoare: Value(TipInvelitoare.tiglaCeramica.cod),
          inclinareGrade: const Value(35),
          azimutGrade: const Value(-10),
          lungimeM: const Value(10),
          latimeM: const Value(6),
          stare: Value(StarePlan.buna.cod),
        ),
      );
      await repo.adaugaObstacol(
        ObstacoleCompanion(
          planId: Value(planId),
          tip: Value(TipObstacol.cos.cod),
          inaltimeM: const Value(1.5),
          distantaM: const Value(2),
        ),
      );
      final complet = await repo.watchPentruLucrare(lucrareId).first;
      expect(complet, isNotNull);
      expect(complet!.plane.length, 1);
      expect(complet.plane.first.plan.denumire, 'Versant sud');
      expect(complet.plane.first.obstacole.length, 1);
      expect(complet.suprafataTotalaM2, 60);
    });

    test('ștergerea planului îi ascunde și obstacolele', () async {
      final r = await repo.asigura(lucrareId);
      final planId = await repo.adaugaPlan(
        PlaneMontajCompanion(
          releveuId: Value(r.id),
          denumire: const Value('Versant'),
          tip: Value(TipPlanMontaj.acoperisInclinat.cod),
          invelitoare: Value(TipInvelitoare.tiglaCeramica.cod),
          stare: Value(StarePlan.buna.cod),
        ),
      );
      await repo.adaugaObstacol(
        ObstacoleCompanion(
          planId: Value(planId),
          tip: Value(TipObstacol.antena.cod),
        ),
      );
      await repo.stergePlan(planId);
      final complet = await repo.watchPentruLucrare(lucrareId).first;
      expect(complet!.plane, isEmpty);
    });

    test('tabloul se creează o dată și apoi se actualizează', () async {
      final r = await repo.asigura(lucrareId);
      await repo.salveazaTablou(
        r.id,
        TablouriExistenteCompanion(
          pozitiiLibere: const Value(4),
          ddrExistent: Value(TipDdr.tipA.cod),
        ),
      );
      await repo.salveazaTablou(
        r.id,
        TablouriExistenteCompanion(
          pozitiiLibere: const Value(6),
          ddrExistent: Value(TipDdr.tipB.cod),
        ),
      );
      final complet = await repo.watchPentruLucrare(lucrareId).first;
      expect(complet!.tablou!.pozitiiLibere, 6);
      expect(complet.tablou!.ddrExistent, 'b');
    });

    test('traseele se actualizează pe segment, fără duplicate', () async {
      final r = await repo.asigura(lucrareId);
      await repo.salveazaTrasee(r.id, {'dc': 20, 'ac': 10});
      await repo.salveazaTrasee(r.id, {'dc': 25, 'contor': 5});
      final complet = await repo.watchPentruLucrare(lucrareId).first;
      final dupaSegment = {
        for (final t in complet!.trasee) t.segment: t.lungimeM,
      };
      expect(dupaSegment, {'dc': 25.0, 'ac': 10.0, 'contor': 5.0});
      expect(complet.trasee.length, 3);
    });
  });
}
