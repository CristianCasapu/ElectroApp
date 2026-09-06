import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:electroapp/core/calc/echipamente.dart';
import 'package:electroapp/core/calc/masuratori.dart';
import 'package:electroapp/core/calc/verdict.dart';
import 'package:electroapp/core/db/database.dart';
import 'package:electroapp/core/db/masuratori_repository.dart';
import 'package:electroapp/core/db/repositories.dart';
import 'package:electroapp/core/models/enums.dart';
import 'package:flutter_test/flutter_test.dart';

const modul = ModulPV(
  producator: 'Test',
  model: 'TOPCon 450',
  pmaxW: 450,
  vocV: 39.0,
  iscA: 14.0,
  vmpV: 32.5,
  impA: 13.8,
  betaVocPctK: -0.26,
  alfaIscPctK: 0.045,
);

Verdict eval(
  TipMasuratoare tip, {
  double? valoare,
  double? voc,
  double? isc,
  double? iradianta,
  double? temperatura,
  double? tensiuneTest,
  double tensiuneSistem = 600,
}) => EvaluatorMasuratori.evalueaza(
  MasuratoareIntrare(
    tip: tip,
    valoare: valoare,
    iradiantaWM2: iradianta,
    temperaturaModulC: temperatura,
    tensiuneTestV: tensiuneTest,
  ),
  vocAsteptatV: voc,
  iscAsteptatA: isc,
  tensiuneSistemV: tensiuneSistem,
  modul: modul,
);

void main() {
  group('Tensiunea de test si limita Riso (IEC 62446-1)', () {
    test('sub 120 V se testeaza cu 250 V si limita e 0,5 MOhm', () {
      expect(EvaluatorMasuratori.tensiuneTestRiso(100), 250);
      expect(EvaluatorMasuratori.limitaRisoMOhm(100), 0.5);
    });

    test('intre 120 si 500 V se testeaza cu 500 V', () {
      expect(EvaluatorMasuratori.tensiuneTestRiso(120), 500);
      expect(EvaluatorMasuratori.tensiuneTestRiso(500), 500);
      expect(EvaluatorMasuratori.limitaRisoMOhm(400), 1.0);
    });

    test('peste 500 V se testeaza cu 1000 V', () {
      expect(EvaluatorMasuratori.tensiuneTestRiso(800), 1000);
      expect(EvaluatorMasuratori.tensiuneTestRiso(1500), 1000);
    });

    test('izolatia DC sub limita este neconforma', () {
      expect(
        eval(TipMasuratoare.izolatieDc, valoare: 0.8).nivel,
        NivelVerdict.neconform,
      );
      expect(
        eval(TipMasuratoare.izolatieDc, valoare: 1.0).nivel,
        NivelVerdict.conform,
      );
    });

    test('la sub 120 V sistem, 0,6 MOhm trece', () {
      final v = eval(
        TipMasuratoare.izolatieDc,
        valoare: 0.6,
        tensiuneTest: 100,
      );
      expect(v.nivel, NivelVerdict.conform);
      expect(v.detaliu, contains('250 V DC'));
    });
  });

  group('Corectia la STC', () {
    test('Voc masurat la modul cald urca dupa corectie', () {
      final stc = EvaluatorMasuratori.vocLaStc(
        vocMasurat: 500,
        temperaturaModulC: 55,
        betaPctK: -0.26,
      );
      expect(stc, greaterThan(500));
      expect(stc, closeTo(500 / (1 - 0.0026 * 30), 0.01));
    });

    test('Voc la 25 grade ramane neschimbat', () {
      expect(
        EvaluatorMasuratori.vocLaStc(
          vocMasurat: 500,
          temperaturaModulC: 25,
          betaPctK: -0.26,
        ),
        closeTo(500, 1e-9),
      );
    });

    test('Isc masurat la 700 W/m2 se raporteaza la 1000 W/m2', () {
      final stc = EvaluatorMasuratori.iscLaStc(
        iscMasurat: 9.8,
        iradiantaWM2: 700,
        temperaturaModulC: 25,
        alfaPctK: 0.045,
      );
      expect(stc, closeTo(14.0, 0.01));
    });

    test('iradianta zero lasa valoarea nemodificata', () {
      expect(
        EvaluatorMasuratori.iscLaStc(
          iscMasurat: 9.8,
          iradiantaWM2: 0,
          temperaturaModulC: 25,
          alfaPctK: 0.045,
        ),
        9.8,
      );
    });
  });

  group('Verdictele pe string', () {
    test('Voc in toleranta de 5 la suta este conform', () {
      expect(
        eval(TipMasuratoare.vocString, valoare: 585, voc: 585).nivel,
        NivelVerdict.conform,
      );
    });

    test('Voc cu 30 la suta sub asteptat semnaleaza string incomplet', () {
      final v = eval(TipMasuratoare.vocString, valoare: 410, voc: 585);
      expect(v.nivel, NivelVerdict.neconform);
      expect(v.referinta, 'IEC 62446-1');
    });

    test('fara valoare de referinta verdictul e informativ', () {
      expect(
        eval(TipMasuratoare.vocString, valoare: 585).nivel,
        NivelVerdict.informativ,
      );
    });

    test('Isc masurat pe cer acoperit devine conform dupa corectie', () {
      final v = eval(
        TipMasuratoare.iscString,
        valoare: 9.8,
        isc: 14.0,
        iradianta: 700,
        temperatura: 25,
      );
      expect(v.nivel, NivelVerdict.conform);
      expect(v.detaliu, contains('la STC'));
    });

    test('Isc necorectat la 700 W/m2 ar fi iesit neconform', () {
      expect(
        eval(TipMasuratoare.iscString, valoare: 9.8, isc: 14.0).nivel,
        NivelVerdict.neconform,
      );
    });
  });

  group('Verdictele pe instalatia de joasa tensiune', () {
    test('priza de pamant: 4 conform, 8 atentie, 15 neconform', () {
      expect(
        eval(TipMasuratoare.rezistentaPriza, valoare: 4).nivel,
        NivelVerdict.conform,
      );
      expect(
        eval(TipMasuratoare.rezistentaPriza, valoare: 8).nivel,
        NivelVerdict.atentie,
      );
      expect(
        eval(TipMasuratoare.rezistentaPriza, valoare: 15).nivel,
        NivelVerdict.neconform,
      );
    });

    test('continuitatea peste 1 Ohm este neconforma', () {
      expect(
        eval(TipMasuratoare.continuitateEchipotential, valoare: 1.4).nivel,
        NivelVerdict.neconform,
      );
    });

    test('dezechilibrul peste 16 A incalca Ord. ANRE 228/2018', () {
      final v = eval(TipMasuratoare.dezechilibruFaze, valoare: 18);
      expect(v.nivel, NivelVerdict.neconform);
      expect(v.referinta, contains('228/2018'));
    });

    test('tensiunea de 253 V este la limita admisa', () {
      expect(
        eval(TipMasuratoare.tensiuneFazaNul, valoare: 253).nivel,
        NivelVerdict.conform,
      );
      expect(
        eval(TipMasuratoare.tensiuneFazaNul, valoare: 258).nivel,
        NivelVerdict.atentie,
      );
    });

    test('DDR peste 300 ms este neconform', () {
      expect(
        eval(TipMasuratoare.timpDeclansareDdr, valoare: 320).nivel,
        NivelVerdict.neconform,
      );
      expect(
        eval(TipMasuratoare.timpDeclansareDdr, valoare: 28).nivel,
        NivelVerdict.conform,
      );
    });

    test('impedanta buclei da curentul de scurtcircuit prezumat', () {
      final v = eval(TipMasuratoare.impedantaBucla, valoare: 0.46);
      expect(v.nivel, NivelVerdict.informativ);
      expect(v.detaliu, contains('Ik'));
    });
  });

  group('Bifele fara valoare numerica', () {
    test('bifa nesetata conteaza ca verificata', () {
      expect(TipMasuratoare.polaritate.esteBifa, isTrue);
      expect(eval(TipMasuratoare.polaritate).nivel, NivelVerdict.conform);
    });

    test('bifa pe zero inseamna nefunctional', () {
      expect(
        eval(TipMasuratoare.antiInsularizare, valoare: 0).nivel,
        NivelVerdict.neconform,
      );
    });
  });

  group('Setul obligatoriu la punerea in functiune', () {
    test('lista goala cere toate cele sase categorii', () {
      expect(
        EvaluatorMasuratori.lipsuriPif(const []),
        EvaluatorMasuratori.obligatoriiPif,
      );
    });

    test('setul complet nu mai are lipsuri', () {
      expect(
        EvaluatorMasuratori.lipsuriPif(EvaluatorMasuratori.obligatoriiPif),
        isEmpty,
      );
    });

    test('lipseste exact ce nu s-a masurat', () {
      final lipsuri = EvaluatorMasuratori.lipsuriPif([
        TipMasuratoare.vocString,
        TipMasuratoare.iscString,
      ]);
      expect(lipsuri, contains(TipMasuratoare.izolatieDc));
      expect(lipsuri, isNot(contains(TipMasuratoare.vocString)));
    });

    test('tipurile de string cer o tinta', () {
      expect(TipMasuratoare.vocString.esteDeString, isTrue);
      expect(TipMasuratoare.rezistentaPriza.esteDeString, isFalse);
    });

    test('codurile se decodeaza, iar cele necunoscute cad pe implicit', () {
      expect(TipMasuratoare.dinCod('riso_dc'), TipMasuratoare.izolatieDc);
      expect(
        TipMasuratoare.dinCod('inexistent'),
        TipMasuratoare.tensiuneFazaNul,
      );
      expect(FazaMasuratoare.dinCod('pif'), FazaMasuratoare.pif);
      expect(FazaMasuratoare.dinCod(null), FazaMasuratoare.releveu);
      expect(
        VerdictMasuratoare.dinCod('neconform'),
        VerdictMasuratoare.neconform,
      );
    });

    test('fiecare faza propune doar tipurile ei', () {
      final pif = TipMasuratoare.pentruFaza(FazaMasuratoare.pif);
      expect(pif, contains(TipMasuratoare.vocString));
      expect(pif, isNot(contains(TipMasuratoare.thdTensiune)));
      expect(
        TipMasuratoare.pentruFaza(FazaMasuratoare.service).length,
        TipMasuratoare.values.length,
      );
    });
  });

  group('Registrul de masuratori', () {
    late AppDatabase db;
    late MasuratoriRepository repo;
    late String lucrareId;

    setUp(() async {
      db = AppDatabase.inMemory(NativeDatabase.memory());
      repo = MasuratoriRepository(db);
      final clientId = await ClientiRepository(db).creeaza(
        ClientiCompanion(
          tip: Value(TipClient.persoanaFizica.cod),
          denumire: const Value('Ion Popescu'),
        ),
      );
      lucrareId = await LucrariRepository(db).creeaza(
        lucrare: LucrariCompanion(
          clientId: Value(clientId),
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
        ),
      );
    });

    tearDown(() => db.close());

    Future<String> adauga(
      TipMasuratoare tip,
      double valoare, {
      String tinta = '',
      FazaMasuratoare faza = FazaMasuratoare.pif,
    }) => repo.adauga(
      MasuratoriCompanion(
        lucrareId: Value(lucrareId),
        tip: Value(tip.cod),
        faza: Value(faza.cod),
        tinta: Value(tinta),
        valoare: Value(valoare),
        unitate: Value(tip.unitate),
        verdict: Value(VerdictMasuratoare.conform.cod),
      ),
    );

    test('o corectura inlocuieste valoarea veche, dar o pastreaza', () async {
      await adauga(TipMasuratoare.vocString, 410, tinta: 'S1');
      await adauga(TipMasuratoare.vocString, 585, tinta: 'S1');

      final toate = await repo.watchPentruLucrare(lucrareId).first;
      expect(toate, hasLength(2));

      final active = MasuratoriRepository.inVigoare(toate);
      expect(active, hasLength(1));
      expect(active.single.valoare, 585);

      final inlocuita = toate.firstWhere((m) => m.inlocuitaDe != null);
      expect(inlocuita.valoare, 410);
      expect(inlocuita.inlocuitaDe, active.single.id);
    });

    test('string-urile diferite nu se inlocuiesc intre ele', () async {
      await adauga(TipMasuratoare.vocString, 585, tinta: 'S1');
      await adauga(TipMasuratoare.vocString, 580, tinta: 'S2');
      final active = MasuratoriRepository.inVigoare(
        await repo.watchPentruLucrare(lucrareId).first,
      );
      expect(active, hasLength(2));
    });

    test('fazele diferite nu se inlocuiesc intre ele', () async {
      await adauga(
        TipMasuratoare.rezistentaPriza,
        3.2,
        faza: FazaMasuratoare.releveu,
      );
      await adauga(TipMasuratoare.rezistentaPriza, 2.8);
      final active = MasuratoriRepository.inVigoare(
        await repo.watchPentruLucrare(lucrareId).first,
      );
      expect(active, hasLength(2));
    });

    test('filtrarea pe faza intoarce doar masuratorile fazei', () async {
      await adauga(
        TipMasuratoare.rezistentaPriza,
        3.2,
        faza: FazaMasuratoare.releveu,
      );
      await adauga(TipMasuratoare.vocString, 585, tinta: 'S1');
      final pif = await repo
          .watchPentruLucrare(lucrareId, faza: FazaMasuratoare.pif)
          .first;
      expect(pif, hasLength(1));
      expect(pif.single.tip, TipMasuratoare.vocString.cod);
    });

    test('istoricul unei tinte pastreaza ambele valori', () async {
      await adauga(TipMasuratoare.vocString, 410, tinta: 'S1');
      await adauga(TipMasuratoare.vocString, 585, tinta: 'S1');
      final istoric = await repo.istoric(
        lucrareId,
        TipMasuratoare.vocString,
        'S1',
      );
      expect(istoric, hasLength(2));
      expect(istoric.map((m) => m.valoare), containsAll([410.0, 585.0]));
    });

    test('etalonarea expirata se depisteaza la data data', () async {
      await repo.adaugaInstrument(
        InstrumenteCompanion(
          denumire: const Value('Metrel MI 3115'),
          serie: const Value('20123456'),
          etalonareExpira: Value(DateTime(2026, 1, 1)),
        ),
      );
      await repo.adaugaInstrument(
        InstrumenteCompanion(
          denumire: const Value('Fluke SMFT-1000'),
          serie: const Value('77001'),
          etalonareExpira: Value(DateTime(2027, 12, 31)),
        ),
      );
      final toate = await repo.watchInstrumente().first;
      expect(toate, hasLength(2));
      final expirate = MasuratoriRepository.cuEtalonareExpirata(
        toate,
        DateTime(2026, 9, 6),
      );
      expect(expirate, hasLength(1));
      expect(expirate.single.denumire, 'Metrel MI 3115');
    });

    test('instrumentul sters iese din lista', () async {
      final id = await repo.adaugaInstrument(
        InstrumenteCompanion(denumire: const Value('Cleste CA')),
      );
      await repo.stergeInstrument(id);
      expect(await repo.watchInstrumente().first, isEmpty);
    });

    test('fotografia stearsa iese din lista', () async {
      final id = await repo.adaugaPoza(
        PozeCompanion(
          lucrareId: Value(lucrareId),
          sectiune: Value(SectiunePoza.tablou.cod),
          cale: const Value('/tmp/tablou.jpg'),
          facutaLa: Value(DateTime.now()),
        ),
      );
      expect(await repo.watchPoze(lucrareId).first, hasLength(1));
      await repo.stergePoza(id);
      expect(await repo.watchPoze(lucrareId).first, isEmpty);
    });
  });
}
