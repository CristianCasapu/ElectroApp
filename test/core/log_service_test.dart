import 'dart:io';

import 'package:electroapp/core/services/log_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory dir;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    dir = await Directory.systemTemp.createTemp('electroapp-log');
    await log.initializeaza(director: dir);
    await log.goleste();
    await log.seteazaActiv(true);
    await log.seteazaNivel(NivelLog.debug);
  });

  tearDown(() async {
    await log.goleste();
    // pe Windows fișierul poate fi încă blocat de scrierea anterioară
    try {
      await dir.delete(recursive: true);
    } on FileSystemException {
      // directorul temporar se curăță de sistem
    }
  });

  group('IntrareLog', () {
    test('linia conține data, ora, nivelul, zona și detaliul', () {
      final e = IntrareLog(
        la: DateTime(2026, 9, 4, 20, 11, 3, 412),
        nivel: NivelLog.warn,
        zona: 'registru',
        mesaj: 'Tranziție refuzată',
        detaliu: 'lead → oferta',
      );
      expect(
        e.linie,
        '2026-09-04 20:11:03.412 W [registru] Tranziție refuzată | lead → oferta',
      );
      expect(e.ora, '20:11:03.412');
    });

    test('detaliul pe mai multe linii rămâne pe o singură linie în fișier', () {
      final e = IntrareLog(
        la: DateTime(2026, 1, 2, 3, 4, 5, 6),
        nivel: NivelLog.error,
        zona: 'pdf',
        mesaj: 'Eroare',
        detaliu: 'prima\na doua',
      );
      expect(e.linie.contains('\n'), isFalse);
      expect(e.linie, contains('prima ⏎ a doua'));
    });
  });

  group('niveluri', () {
    test('ordinea severității', () {
      expect(NivelLog.error >= NivelLog.warn, isTrue);
      expect(NivelLog.debug >= NivelLog.info, isFalse);
      expect(NivelLog.dinCod('warn'), NivelLog.warn);
      expect(NivelLog.dinCod('inexistent'), NivelLog.info);
    });

    test('nivelul filtrează ce se înregistrează', () async {
      await log.seteazaNivel(NivelLog.warn);
      log.debug('t', 'invizibil');
      log.info('t', 'invizibil');
      log.warn('t', 'vizibil');
      log.error('t', 'și asta');
      final mesaje = log.recente.map((e) => e.mesaj).toList();
      expect(mesaje, isNot(contains('invizibil')));
      expect(mesaje, contains('vizibil'));
      expect(mesaje, contains('și asta'));
    });

    test('jurnalul oprit nu înregistrează nimic', () async {
      await log.seteazaActiv(false);
      final inainte = log.recente.length;
      log.error('t', 'ignorat');
      expect(log.recente.length, inainte);
      await log.seteazaActiv(true);
    });
  });

  group('persistență', () {
    test('intrările ajung în fișier și se citesc înapoi', () async {
      log.info('registru', 'Fișă creată', 'FL-2026-0001');
      log.error('pdf', 'A picat', StateError('x'), StackTrace.current);
      final text = await log.continut();
      expect(text, contains('[registru] Fișă creată | FL-2026-0001'));
      expect(text, contains('E [pdf] A picat'));
      expect(text, contains('Bad state: x'));
    });

    test('ștergerea golește fișierul și memoria', () async {
      log.info('t', 'ceva');
      await log.continut();
      await log.goleste();
      expect(log.recente.where((e) => e.mesaj == 'ceva'), isEmpty);
      // rămâne doar urma ștergerii, ca să se vadă în jurnal ce s-a întâmplat
      expect(await log.continut(), contains('Jurnal șters'));
      expect(await log.continut(), isNot(contains('ceva')));
    });

    test('fișierul se rotește peste limită și păstrează coada', () async {
      final f = File(
        '${dir.path}${Platform.pathSeparator}${LogService.numeFisier}',
      );
      await f.writeAsString('x' * (LogService.dimensiuneMaxima + 2000));
      log.info('t', 'declanșează rotirea');
      await log.descarcaPeDisc();
      final dupa = await f.length();
      expect(dupa, lessThan(LogService.dimensiuneMaxima));
      expect(await f.readAsString(), contains('jurnal rotit'));
    });
  });

  group('export', () {
    test('antetul conține versiunea și starea jurnalului', () async {
      final antet = await log.antetDiagnostic();
      expect(antet, contains('ElectroApp — jurnal de depanare'));
      expect(antet, contains('Nivel jurnal:'));
      expect(antet, contains('activ: da'));
    });

    test('fișierul de trimis conține antetul și intrările', () async {
      log.info('t', 'de trimis');
      final f = await log.pregatestePentruTrimitere(director: dir);
      expect(f, isNotNull);
      final text = await f!.readAsString();
      expect(text, contains('jurnal de depanare'));
      expect(text, contains('de trimis'));
      await f.delete();
    });

    test('jurnalul gol nu produce fișier', () async {
      await log.seteazaActiv(false);
      await log.goleste();
      expect(await log.pregatestePentruTrimitere(director: dir), isNull);
      await log.seteazaActiv(true);
    });
  });

  group('masoara', () {
    test('înregistrează durata și rezultatul', () async {
      final v = await log.masoara(
        'test',
        'Operație',
        () async => 42,
        rezultat: (r) => 'rezultat $r',
      );
      expect(v, 42);
      final ultima = log.recente.last;
      expect(ultima.mesaj, 'Operație');
      expect(ultima.detaliu, contains('rezultat 42'));
      expect(ultima.detaliu, contains('ms'));
    });

    test('propagă excepția și o înregistrează ca eroare', () async {
      await expectLater(
        log.masoara('test', 'Cade', () async => throw StateError('gata')),
        throwsStateError,
      );
      final ultima = log.recente.last;
      expect(ultima.nivel, NivelLog.error);
      expect(ultima.mesaj, contains('Cade — eșuat după'));
      expect(ultima.detaliu, contains('gata'));
    });
  });

  test('erorile Flutter ajung în jurnal', () async {
    // Fără handler anterior, ca eroarea de probă să nu fie raportată și ca
    // eșec al testului: verificăm exact ce face handler-ul nostru.
    final original = FlutterError.onError;
    FlutterError.onError = null;
    log.prindeErorile();
    FlutterError.onError!(
      FlutterErrorDetails(
        exception: StateError('din widget'),
        stack: StackTrace.current,
        library: 'test',
      ),
    );
    FlutterError.onError = original;
    final erori = log.recente.where((e) => e.zona == 'flutter').toList();
    expect(erori, isNotEmpty);
    expect(erori.last.detaliu, contains('din widget'));
  });
}
