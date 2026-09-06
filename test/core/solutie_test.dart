import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:electroapp/core/calc/materiale.dart';
import 'package:electroapp/core/calc/pv_estimare.dart';
import 'package:electroapp/core/calc/masuratori.dart';
import 'package:electroapp/core/db/database.dart';
import 'package:electroapp/core/db/repositories.dart';
import 'package:electroapp/core/db/solutii_repository.dart';
import 'package:electroapp/core/models/enums.dart';
import 'package:electroapp/core/models/profil_firma.dart';
import 'package:electroapp/core/models/solutie.dart';
import 'package:electroapp/core/services/raport_pdf_service.dart';
import 'package:flutter_test/flutter_test.dart';

SolutieSnapshot _snapshotExemplu() {
  const intrari = IntrariSolutie(
    consumAnualKwh: 6000,
    profil: 'casnic',
    faze: 3,
    putereAprobataKva: 10,
    judet: 'Dolj',
    azimutGrade: -20,
    inclinareGrade: 35,
    suprafataUtilaM2: 40,
    acoperire: 1.0,
    stocare: 'autoconsum',
    autonomieBackupOre: 8,
    pAcMaxDoritaKw: 0,
    modulModel: 'Tiger Neo 440 W (N-type, 108 cel.)',
    tMinC: -25,
    pretCumparareKwh: 1.3,
    pretInjectareKwh: 0.65,
    lungimeDcM: 20,
    lungimeAcM: 12,
    lungimeTeg2ContorM: 5,
    prizaPamantNoua: true,
    acoperisTabla: false,
    terasa: false,
    distantaKm: 15,
  );
  final e = EstimatorPV.estimeaza(intrari.laEstimare());
  final n = NecesarMateriale.din(
    e,
    lungimeDcM: intrari.lungimeDcM,
    lungimeAcM: intrari.lungimeAcM,
    prizaPamantNoua: true,
    distantaKm: 15,
  );
  return SolutieSnapshot(intrari: intrari, rezultat: RezultatSolutie.din(e, n));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('snapshot-ul se serializează și se reconstruiește identic', () {
    final s = _snapshotExemplu();
    final i2 = IntrariSolutie.decode(s.intrari.encode());
    final r2 = RezultatSolutie.decode(s.rezultat.encode());
    expect(i2.toJson(), s.intrari.toJson());
    expect(r2.toJson(), s.rezultat.toJson());
    expect(r2.materiale.length, s.rezultat.materiale.length);
    expect(r2.totalRon, closeTo(s.rezultat.totalRon, 0.001));
    expect(r2.verdicte.first.nivelEnum, s.rezultat.verdicte.first.nivelEnum);
    expect(i2.modul.model, s.intrari.modulModel);
    expect(s.titluScurt, contains('kWp'));
  });

  group('SolutiiRepository', () {
    late AppDatabase db;
    late String lucrareId;

    setUp(() async {
      db = AppDatabase.inMemory(NativeDatabase.memory());
      final clienti = ClientiRepository(db);
      final lucrari = LucrariRepository(db);
      final c = await clienti.creeaza(
        const ClientiCompanion(tip: Value('pf'), denumire: Value('Ion')),
      );
      lucrareId = await lucrari.creeaza(
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
        ),
      );
    });

    tearDown(() => db.close());

    test('reviziile cresc și se recitesc', () async {
      final repo = SolutiiRepository(db);
      final s = _snapshotExemplu();
      final id1 = await repo.adaugaRevizie(
        lucrareId: lucrareId,
        snapshot: s,
        observatii: 'prima',
      );
      final id2 = await repo.adaugaRevizie(lucrareId: lucrareId, snapshot: s);
      final lista = await repo.watchPentruLucrare(lucrareId).first;
      expect(lista.map((x) => x.revizie), [2, 1]);
      expect(lista.last.id, id1);
      expect(lista.first.id, id2);
      final citit = SolutiiRepository.decodeaza(lista.last);
      expect(citit.rezultat.kWp, s.rezultat.kWp);
      expect(lista.last.observatii, 'prima');
    });

    test('documentele primesc versiuni per tip', () async {
      final repo = SolutiiRepository(db);
      final sid = await repo.adaugaRevizie(
        lucrareId: lucrareId,
        snapshot: _snapshotExemplu(),
      );
      final d1 = await repo.adaugaDocument(
        lucrareId: lucrareId,
        solutieId: sid,
        tip: TipDocument.ofertaCompleta,
        cale: '/a.pdf',
        sha256: 'x',
        marimeBytes: 10,
      );
      final d2 = await repo.adaugaDocument(
        lucrareId: lucrareId,
        solutieId: sid,
        tip: TipDocument.ofertaCompleta,
        cale: '/b.pdf',
        sha256: 'y',
        marimeBytes: 10,
      );
      final d3 = await repo.adaugaDocument(
        lucrareId: lucrareId,
        solutieId: sid,
        tip: TipDocument.fisaSistem,
        cale: '/c.pdf',
        sha256: 'z',
        marimeBytes: 10,
      );
      expect(d1.versiune, 1);
      expect(d2.versiune, 2);
      expect(d3.versiune, 1);
      expect((await repo.watchDocumente(lucrareId).first).length, 3);
    });
  });

  group('RaportPdfService', () {
    final fisa = FisaLucrare(
      lucrare: LucrariData(
        id: 'l1',
        createdAt: DateTime(2026, 9, 4),
        updatedAt: DateTime(2026, 9, 4),
        version: 1,
        nrInregistrare: 'FL-2026-0007',
        clientId: 'c1',
        rolClient: 'proprietar',
        tipLucrare: 'instalare_noua',
        stare: 'dimensionare',
        titlu: 'Hibrid 10 kWp',
        observatii: '',
        deschisaLa: DateTime(2026, 9, 4),
      ),
      client: ClientiData(
        id: 'c1',
        createdAt: DateTime(2026, 9, 4),
        updatedAt: DateTime(2026, 9, 4),
        version: 1,
        tip: 'pj',
        denumire: 'Ferma Solar SRL',
        telefon: '0722',
        email: 'a@b.ro',
        adresaCorespondenta: 'Str. Soarelui 7, Craiova',
        cui: 'RO123',
        regCom: 'J16/1/2020',
        reprezentantLegal: 'Ion',
        furnizorEnergie: 'Hidroelectrica',
        codClientFurnizor: '123',
        codPod: 'RO002E1',
        observatii: '',
      ),
      locConsum: LocuriConsumData(
        id: 'lc1',
        createdAt: DateTime(2026, 9, 4),
        updatedAt: DateTime(2026, 9, 4),
        version: 1,
        lucrareId: 'l1',
        adresa: 'Str. Soarelui 7',
        judet: 'Dolj',
        localitate: 'Craiova',
        operatorDistributie: 'oltenia',
        codPod: 'RO002E1',
        furnizorEnergie: 'Hidroelectrica',
        codClientFurnizor: '123',
        nivelTensiune: 'jt',
        bransament: 'tri',
        putereAprobataKva: 10,
        schemaLegarePamant: 'tn_c_s',
        prizaPamantProprie: false,
        contorTip: 'smart',
        contorSerie: '',
        contorBidirectional: true,
        destinatieCladire: 'rezidential',
        observatii: '',
      ),
    );
    const profil = ProfilFirma(
      denumire: 'Electro Test SRL',
      cui: 'RO999',
      atestatTip: 'B',
      atestatNr: '1234',
      electricianNume: 'Ion Electricianu',
      electricianGrad: 'IIB',
    );

    test('fișa sistemului și ofertele produc PDF-uri valide', () async {
      final pdf = RaportPdfService();
      final s = _snapshotExemplu();
      final fisaBytes = await pdf.fisaSistem(
        profil: profil,
        fisa: fisa,
        s: s,
        revizie: 1,
      );
      expect(fisaBytes.length, greaterThan(5000));
      expect(String.fromCharCodes(fisaBytes.take(5)), '%PDF-');
      for (final t in [
        TipDocument.ofertaMateriale,
        TipDocument.ofertaManopera,
        TipDocument.ofertaCompleta,
      ]) {
        final b = await pdf.oferta(
          profil: profil,
          fisa: fisa,
          s: s,
          revizie: 1,
          tip: t,
          tvaProcent: 21,
          observatii: 'Termen 3 săptămâni',
        );
        expect(b.length, greaterThan(5000));
        expect(String.fromCharCodes(b.take(5)), '%PDF-');
      }
      expect(RaportPdfService.hashPentru([1, 2, 3]).length, 64);
    });

    test('buletinul de PIF se emite si cand instalatia e neconforma', () async {
      final pdf = RaportPdfService();
      MasuratoriData masuratoare(
        TipMasuratoare tip,
        double valoare, {
        String tinta = '',
      }) => MasuratoriData(
        id: tip.cod,
        lucrareId: 'l1',
        faza: FazaMasuratoare.pif.cod,
        tip: tip.cod,
        tinta: tinta,
        valoare: valoare,
        unitate: tip.unitate,
        metoda: '',
        instrumentId: 'i1',
        verdict: VerdictMasuratoare.conform.cod,
        referinta: tip.referinta,
        observatii: '',
        operator: 'Ion',
        la: DateTime(2026, 9, 6),
      );
      final randuri = [
        for (final m in [
          masuratoare(TipMasuratoare.vocString, 585, tinta: 'S1'),
          masuratoare(TipMasuratoare.iscString, 13.9, tinta: 'S1'),
          masuratoare(TipMasuratoare.izolatieDc, 0.4, tinta: 'S1'),
          masuratoare(TipMasuratoare.rezistentaPriza, 3.1),
          masuratoare(TipMasuratoare.timpDeclansareDdr, 42),
        ])
          (
            m,
            EvaluatorMasuratori.evalueaza(
              MasuratoareIntrare(
                tip: TipMasuratoare.dinCod(m.tip),
                valoare: m.valoare,
                tinta: m.tinta,
              ),
              vocAsteptatV: 585,
              iscAsteptatA: 14,
            ),
          ),
      ];
      final bytes = await pdf.buletinPif(
        profil: profil,
        fisa: fisa,
        masuratori: randuri,
        instrumente: [
          InstrumenteData(
            id: 'i1',
            createdAt: DateTime(2026, 1, 1),
            updatedAt: DateTime(2026, 1, 1),
            version: 1,
            denumire: 'MI 3115',
            producator: 'Metrel',
            serie: '20123456',
            etalonareExpira: DateTime(2027, 5, 1),
            observatii: '',
          ),
        ],
        solutie: _snapshotExemplu(),
        lipsuri: EvaluatorMasuratori.lipsuriPif(
          randuri.map((r) => TipMasuratoare.dinCod(r.$1.tip)),
        ),
        nrFotografii: 4,
      );
      expect(bytes.length, greaterThan(5000));
      expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    });
  });
}
