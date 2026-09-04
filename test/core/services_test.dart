import 'dart:convert';
import 'dart:io';

import 'package:electroapp/core/services/anaf_service.dart';
import 'package:electroapp/core/services/osm_service.dart';
import 'package:electroapp/core/services/update_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('AnafService', () {
    test('normalizează CUI-ul cu sau fără RO', () {
      expect(AnafService.normalizeazaCui('RO 12345678'), 12345678);
      expect(AnafService.normalizeazaCui('ro12345678'), 12345678);
      expect(AnafService.normalizeazaCui('12345678'), 12345678);
      expect(AnafService.normalizeazaCui('ABC'), isNull);
      expect(AnafService.normalizeazaCui(''), isNull);
    });

    test('parsează răspunsul v9 cu sediul social structurat', () {
      final body = jsonEncode({
        'cod': 200,
        'found': [
          {
            'date_generale': {
              'cui': 12345678,
              'denumire': 'ELECTRO TEST SRL',
              'adresa': 'STR. TEIULUI NR. 5, CRAIOVA, DOLJ',
              'nrRegCom': 'J16/123/2020',
              'telefon': '0251123456',
              'codPostal': '200001',
            },
            'inregistrare_scop_Tva': {'scpTVA': true},
            'stare_inactiv': {'statusInactivi': false},
            'adresa_sediu_social': {
              'sdenumire_Strada': 'Str. Teiului',
              'snumar_Strada': '5',
              'sdenumire_Localitate': 'Mun. Craiova',
              'sdenumire_Judet': 'Dolj',
              'scod_Postal': '200001',
            },
          },
        ],
        'notFound': [],
      });
      final f = AnafService.parseRaspuns(body)!;
      expect(f.denumire, 'ELECTRO TEST SRL');
      expect(f.nrRegCom, 'J16/123/2020');
      expect(f.telefon, '0251123456');
      expect(f.adresa, 'Str. Teiului nr. 5, Craiova, Dolj');
      expect(f.localitate, 'Craiova');
      expect(f.judet, 'Dolj');
      expect(f.platitorTva, isTrue);
      expect(f.inactiva, isFalse);
    });

    test('CUI negăsit → null', () {
      expect(
        AnafService.parseRaspuns(
          jsonEncode({
            'found': [],
            'notFound': [1],
          }),
        ),
        isNull,
      );
    });

    test('cauta folosește POST cu cui numeric și raportează erorile', () async {
      late http.Request cerere;
      final s = AnafService(
        client: MockClient((req) async {
          cerere = req;
          return http.Response(jsonEncode({'found': []}), 200);
        }),
      );
      expect(await s.cauta('RO 999'), isNull);
      expect(cerere.method, 'POST');
      expect(jsonDecode(cerere.body)[0]['cui'], 999);
      expect(s.ultimaEroare, contains('nu a fost găsit'));

      final s2 = AnafService(
        client: MockClient((_) async => http.Response('', 503)),
      );
      expect(await s2.cauta('999'), isNull);
      expect(s2.ultimaEroare, contains('503'));
    });
  });

  group('OsmService.parseReverse', () {
    test('compune stradă + număr, localitate, județ', () {
      final body = jsonEncode({
        'address': {
          'road': 'Strada Teiului',
          'house_number': '5',
          'city': 'Craiova',
          'county': 'Județul Dolj',
          'postcode': '200001',
        },
      });
      final a = OsmService.parseReverse(body, lat: 44.3, lon: 23.8)!;
      expect(a.strada, 'Strada Teiului 5');
      expect(a.localitate, 'Craiova');
      expect(a.judet, 'Dolj');
      expect(a.codPostal, '200001');
      expect(a.scurta, 'Strada Teiului 5, Craiova');
    });

    test('sat fără număr → doar drum și localitate', () {
      final body = jsonEncode({
        'address': {'road': 'DJ 552', 'village': 'Bucovăț', 'county': 'Dolj'},
      });
      final a = OsmService.parseReverse(body, lat: 0, lon: 0)!;
      expect(a.strada, 'DJ 552');
      expect(a.localitate, 'Bucovăț');
      expect(a.judet, 'Dolj');
    });

    test('fără câmpul address → null', () {
      expect(OsmService.parseReverse('{"error":"x"}', lat: 0, lon: 0), isNull);
    });
  });

  group('UpdateService.descarca', () {
    final info = UpdateInfo(
      versiune: '0.1.9',
      tag: 'v0.1.9',
      note: '',
      numeFisier: 'ElectroApp-v0.1.9.apk',
      url: 'https://example.com/a.apk',
      dimensiuneBytes: 6,
    );

    test('scrie fișierul și raportează progresul', () async {
      final dir = await Directory.systemTemp.createTemp('electroapp-upd');
      addTearDown(() => dir.delete(recursive: true));
      final s = UpdateService(
        client: MockClient.streaming((req, body) async {
          expect(req.headers['User-Agent'], 'ElectroApp');
          return http.StreamedResponse(
            Stream.fromIterable([
              [1, 2, 3],
              [4, 5, 6],
            ]),
            200,
            contentLength: 6,
          );
        }),
      );
      final progres = <double>[];
      final f = await s.descarca(info, progres.add, director: dir);
      expect(f, isNotNull);
      expect(await f!.length(), 6);
      expect(progres, [0.5, 1.0]);
    });

    test('non-200 → null, fără fișier', () async {
      final dir = await Directory.systemTemp.createTemp('electroapp-upd');
      addTearDown(() => dir.delete(recursive: true));
      final s = UpdateService(
        client: MockClient.streaming(
          (req, body) async =>
              http.StreamedResponse(Stream.fromIterable([]), 404),
        ),
      );
      expect(await s.descarca(info, (_) {}, director: dir), isNull);
      expect(dir.listSync(), isEmpty);
    });

    test('anularea șterge fișierul parțial', () async {
      final dir = await Directory.systemTemp.createTemp('electroapp-upd');
      addTearDown(() => dir.delete(recursive: true));
      final s = UpdateService(
        client: MockClient.streaming(
          (req, body) async => http.StreamedResponse(
            Stream.fromIterable([
              [1, 2, 3],
              [4, 5, 6],
            ]),
            200,
            contentLength: 6,
          ),
        ),
      );
      var blocuri = 0;
      final f = await s.descarca(
        info,
        (_) => blocuri++,
        anulat: () => blocuri >= 1,
        director: dir,
      );
      expect(f, isNull);
      expect(dir.listSync(), isEmpty);
    });
  });
}
