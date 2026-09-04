import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'log_service.dart';

/// Adresă poștală rezultată din geocodare inversă (OpenStreetMap Nominatim).
class AdresaOsm {
  final String strada; // „Strada Teiului 5" (stradă + număr, dacă există)
  final String localitate;
  final String judet;
  final String codPostal;
  final double lat;
  final double lon;

  const AdresaOsm({
    required this.strada,
    required this.localitate,
    required this.judet,
    required this.codPostal,
    required this.lat,
    required this.lon,
  });

  /// „Strada Teiului 5, Craiova" — forma scurtă pentru câmpul de adresă.
  String get scurta =>
      [strada, localitate].where((s) => s.isNotEmpty).join(', ');
}

/// Geocodare directă/inversă prin Nominatim (politica cere User-Agent
/// identificabil și maximum o cerere pe secundă) și locația device-ului.
class OsmService {
  static const _base = 'https://nominatim.openstreetmap.org';
  static const _ua = 'ElectroApp/1.0 (casapucristian@gmail.com)';
  final http.Client _client;

  OsmService({http.Client? client}) : _client = client ?? http.Client();

  Future<({double lat, double lon})?> geocode(String adresa) async {
    try {
      final uri = Uri.parse('$_base/search').replace(
        queryParameters: {
          'q': adresa,
          'format': 'json',
          'limit': '1',
          'countrycodes': 'ro',
        },
      );
      final resp = await _client
          .get(uri, headers: const {'User-Agent': _ua})
          .timeout(const Duration(seconds: 10));
      if (resp.statusCode != 200) return null;
      final list = jsonDecode(resp.body) as List<dynamic>;
      if (list.isEmpty) return null;
      final item = list[0] as Map<String, dynamic>;
      return (
        lat: double.parse(item['lat'] as String),
        lon: double.parse(item['lon'] as String),
      );
    } on Object {
      return null;
    }
  }

  Future<AdresaOsm?> reverse(double lat, double lon) async {
    try {
      final uri = Uri.parse('$_base/reverse').replace(
        queryParameters: {
          'format': 'jsonv2',
          'lat': '$lat',
          'lon': '$lon',
          'zoom': '18',
          'addressdetails': '1',
          'accept-language': 'ro',
        },
      );
      final resp = await _client
          .get(uri, headers: const {'User-Agent': _ua})
          .timeout(const Duration(seconds: 10));
      if (resp.statusCode != 200) {
        log.warn('osm', 'Geocodare inversă eșuată', 'HTTP ${resp.statusCode}');
        return null;
      }
      final a = parseReverse(resp.body, lat: lat, lon: lon);
      log.info(
        'osm',
        'Adresă din coordonate',
        a == null ? 'fără rezultat' : '${a.scurta} (${a.judet})',
      );
      return a;
    } on Object catch (e, s) {
      log.error('osm', 'Geocodare inversă eșuată', e, s);
      return null;
    }
  }

  /// Separată de rețea pentru teste. Alege primele chei nevide din răspuns.
  static AdresaOsm? parseReverse(
    String body, {
    required double lat,
    required double lon,
  }) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    final a = json['address'] as Map<String, dynamic>?;
    if (a == null) return null;
    String prima(List<String> chei) {
      for (final k in chei) {
        final v = a[k];
        if (v is String && v.trim().isNotEmpty) return v.trim();
      }
      return '';
    }

    final drum = prima([
      'road',
      'pedestrian',
      'residential',
      'footway',
      'square',
    ]);
    final nr = prima(['house_number']);
    final strada = [drum, nr].where((s) => s.isNotEmpty).join(' ');
    final localitate = prima([
      'city',
      'town',
      'village',
      'municipality',
      'hamlet',
      'suburb',
    ]);
    final judet = prima([
      'county',
      'state',
    ]).replaceFirst(RegExp(r'^Județul '), '');
    return AdresaOsm(
      strada: strada,
      localitate: localitate,
      judet: judet,
      codPostal: prima(['postcode']),
      lat: lat,
      lon: lon,
    );
  }

  /// Poziția curentă: cere permisiunea dacă lipsește, refuză dacă serviciul
  /// de locație e oprit. Întoarce `null` cu motivul în [motivEsec].
  String? motivEsec;

  Future<({double lat, double lon})?> pozitiaCurenta() async {
    motivEsec = null;
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        motivEsec = 'Locația este oprită pe telefon.';
        log.warn('osm', 'Serviciul de locație e oprit');
        return null;
      }
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        motivEsec = 'Permisiunea de locație a fost refuzată.';
        log.warn('osm', 'Permisiune de locație refuzată', '$perm');
        return null;
      }
      Position? p;
      try {
        p = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 12),
          ),
        );
      } on Object {
        p = await Geolocator.getLastKnownPosition();
      }
      if (p == null) {
        motivEsec = 'Poziția nu a putut fi determinată.';
        log.warn('osm', 'Poziție indisponibilă');
        return null;
      }
      log.info(
        'osm',
        'Poziție obținută',
        '${p.latitude.toStringAsFixed(5)}, ${p.longitude.toStringAsFixed(5)} · ±${p.accuracy.toStringAsFixed(0)} m',
      );
      return (lat: p.latitude, lon: p.longitude);
    } on Object catch (e, s) {
      motivEsec = 'Eroare de locație: $e';
      log.error('osm', 'Locație eșuată', e, s);
      return null;
    }
  }

  /// Locație → adresă, într-un singur pas.
  Future<AdresaOsm?> adresaCurenta() async {
    final poz = await pozitiaCurenta();
    if (poz == null) return null;
    final a = await reverse(poz.lat, poz.lon);
    if (a == null) motivEsec = 'OpenStreetMap nu a găsit o adresă aici.';
    return a;
  }
}
