import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:electroapp/core/db/database.dart';
import 'package:electroapp/core/db/repositories.dart';
import 'package:electroapp/core/models/enums.dart';
import 'package:electroapp/core/models/profil_firma.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ClientiRepository clienti;
  late LucrariRepository lucrari;

  setUp(() {
    db = AppDatabase.inMemory(NativeDatabase.memory());
    clienti = ClientiRepository(db);
    lucrari = LucrariRepository(db);
  });

  tearDown(() => db.close());

  Future<String> clientNou([String nume = 'Ion Popescu']) => clienti.creeaza(
    ClientiCompanion(tip: Value(TipClient.persoanaFizica.cod), denumire: Value(nume)),
  );

  Future<String> fisaNoua(String clientId) => lucrari.creeaza(
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
      localitate: const Value('Craiova'),
      judet: const Value('Dolj'),
      putereAprobataKva: const Value(10),
    ),
  );

  group('LucrariRepository', () {
    test('creează fișa cu număr de înregistrare secvențial pe an', () async {
      final c = await clientNou();
      final an = DateTime.now().year;
      await fisaNoua(c);
      await fisaNoua(c);
      final registru = await lucrari.watchRegistru().first;
      final numere = registru.map((f) => f.lucrare.nrInregistrare).toList();
      expect(numere, containsAll(['FL-$an-0001', 'FL-$an-0002']));
      expect(await lucrari.urmatorulNumar(), 'FL-$an-0003');
    });

    test('registrul aduce beneficiarul și locul de consum', () async {
      final c = await clientNou('Maria Ionescu');
      final id = await fisaNoua(c);
      final fisa = await lucrari.watchFisa(id).first;
      expect(fisa, isNotNull);
      expect(fisa!.client?.denumire, 'Maria Ionescu');
      expect(fisa.locConsum?.putereAprobataKva, 10);
      expect(fisa.amplasament, 'Craiova, Dolj');
      expect(fisa.stare, StareLucrare.lead);
      expect(fisa.titluAfisat, 'Instalare nouă');
    });

    test('tranzițiile respectă fluxul și se jurnalizează', () async {
      final c = await clientNou();
      final id = await fisaNoua(c);
      expect(
        await lucrari.schimbaStarea(id: id, stareNoua: StareLucrare.oferta),
        isFalse,
        reason: 'din lead nu se sare direct la ofertă',
      );
      expect(
        await lucrari.schimbaStarea(
          id: id,
          stareNoua: StareLucrare.releveu,
          observatie: 'Vizită programată',
          deCatre: 'Ion',
        ),
        isTrue,
      );
      final fisa = await lucrari.watchFisa(id).first;
      expect(fisa!.stare, StareLucrare.releveu);
      final istoric = await lucrari.watchIstoricStari(id).first;
      expect(istoric.length, 2);
      expect(istoric.first.stareDin, 'lead');
      expect(istoric.first.stareIn, 'releveu');
      expect(istoric.first.observatie, 'Vizită programată');
      expect(istoric.first.deCatre, 'Ion');
    });

    test('ștergerea logică scoate fișa din registru, dar păstrează numărul', () async {
      final c = await clientNou();
      final an = DateTime.now().year;
      final id = await fisaNoua(c);
      await lucrari.sterge(id);
      expect(await lucrari.watchRegistru().first, isEmpty);
      expect(await lucrari.urmatorulNumar(), 'FL-$an-0002');
    });

    test('actualizarea modifică fișa și locul de consum împreună', () async {
      final c = await clientNou();
      final id = await fisaNoua(c);
      await lucrari.actualizeaza(
        id: id,
        lucrare: const LucrariCompanion(titlu: Value('Hibrid 10 kWp')),
        locConsum: const LocuriConsumCompanion(codPod: Value('RO001E123')),
      );
      final fisa = await lucrari.watchFisa(id).first;
      expect(fisa!.lucrare.titlu, 'Hibrid 10 kWp');
      expect(fisa.locConsum!.codPod, 'RO001E123');
      expect(fisa.stare, StareLucrare.lead);
    });
  });

  group('ClientiRepository', () {
    test('nu șterge un client cu fișe asociate', () async {
      final c = await clientNou();
      await fisaNoua(c);
      expect(await clienti.numarLucrari(c), 1);
      expect(await clienti.sterge(c), isFalse);
      expect((await clienti.watchToti().first).length, 1);
    });

    test('șterge logic un client fără fișe', () async {
      final c = await clientNou();
      expect(await clienti.sterge(c), isTrue);
      expect(await clienti.watchToti().first, isEmpty);
    });
  });

  group('SetariRepository', () {
    test('profilul firmei se salvează și se citește înapoi', () async {
      final setari = SetariRepository(db);
      await setari.salveazaProfil(
        const ProfilFirma(denumire: 'Electro SRL', electricianGrad: 'IIB'),
      );
      final p = await setari.watchProfil().first;
      expect(p.denumire, 'Electro SRL');
      expect(p.electricianGrad, 'IIB');
      await setari.salveazaProfil(p.copyWith(denumire: 'Electro Nou SRL'));
      expect((await setari.watchProfil().first).denumire, 'Electro Nou SRL');
    });
  });
}
