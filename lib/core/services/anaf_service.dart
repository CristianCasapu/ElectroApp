import 'dart:convert';

import 'package:http/http.dart' as http;

import 'log_service.dart';

/// Datele unei persoane juridice din registrul ANAF (serviciul public
/// PlatitorTvaRest v9 — fără cheie, cu limită de o cerere pe secundă).
class FirmaAnaf {
  final String cui;
  final String denumire;
  final String adresa;
  final String nrRegCom;
  final String telefon;
  final String codPostal;
  final String localitate;
  final String judet;
  final bool platitorTva;
  final bool inactiva;

  const FirmaAnaf({
    required this.cui,
    required this.denumire,
    required this.adresa,
    required this.nrRegCom,
    required this.telefon,
    required this.codPostal,
    required this.localitate,
    required this.judet,
    required this.platitorTva,
    required this.inactiva,
  });
}

class AnafService {
  static const _url = 'https://webservicesp.anaf.ro/api/PlatitorTvaRest/v9/tva';
  final http.Client _client;
  AnafService({http.Client? client}) : _client = client ?? http.Client();

  String? ultimaEroare;

  /// CUI-ul numeric, fără prefixul „RO" și fără spații; `null` dacă nu e valid.
  static int? normalizeazaCui(String text) {
    final t = text.trim().toUpperCase().replaceFirst(RegExp(r'^RO'), '').trim();
    if (!RegExp(r'^\d{2,10}$').hasMatch(t)) return null;
    return int.parse(t);
  }

  Future<FirmaAnaf?> cauta(String cuiText) async {
    ultimaEroare = null;
    final cui = normalizeazaCui(cuiText);
    if (cui == null) {
      ultimaEroare = 'CUI invalid — introdu doar cifrele (cu sau fără RO).';
      log.warn('anaf', 'CUI invalid', cuiText);
      return null;
    }
    log.debug('anaf', 'Interogare ANAF', 'CUI $cui');
    try {
      final azi = DateTime.now();
      final data =
          '${azi.year}-${azi.month.toString().padLeft(2, '0')}-${azi.day.toString().padLeft(2, '0')}';
      final resp = await _client
          .post(
            Uri.parse(_url),
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'User-Agent': 'ElectroApp',
            },
            body: jsonEncode([
              {'cui': cui, 'data': data},
            ]),
          )
          .timeout(const Duration(seconds: 15));
      if (resp.statusCode != 200) {
        ultimaEroare = 'ANAF a răspuns cu HTTP ${resp.statusCode}.';
        log.warn('anaf', 'Răspuns neașteptat', 'HTTP ${resp.statusCode}');
        return null;
      }
      final f = parseRaspuns(resp.body);
      if (f == null) {
        ultimaEroare = 'CUI-ul nu a fost găsit la ANAF.';
        log.info('anaf', 'CUI negăsit', '$cui');
      } else {
        log.info(
          'anaf',
          'Firmă găsită',
          '${f.denumire} · TVA: ${f.platitorTva} · inactivă: ${f.inactiva}',
        );
      }
      return f;
    } on Object catch (e, s) {
      ultimaEroare = 'Nu s-a putut interoga ANAF: $e';
      log.error('anaf', 'Interogare eșuată', e, s);
      return null;
    }
  }

  /// Separată de rețea pentru teste. Acceptă forma v9 (`found[0].date_generale`
  /// + `adresa_sediu_social`) și, defensiv, forma veche plată.
  static FirmaAnaf? parseRaspuns(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    final found = json['found'] as List<dynamic>? ?? const [];
    if (found.isEmpty) return null;
    final f = found.first as Map<String, dynamic>;
    final g = (f['date_generale'] as Map<String, dynamic>?) ?? f;
    final sediu = f['adresa_sediu_social'] as Map<String, dynamic>?;
    final tva = f['inregistrare_scop_Tva'] as Map<String, dynamic>?;
    final inactiv = f['stare_inactiv'] as Map<String, dynamic>?;

    String s(Map<String, dynamic>? m, String k) {
      final v = m?[k];
      return v == null ? '' : '$v'.trim();
    }

    var localitate = s(sediu, 'sdenumire_Localitate');
    var judet = s(sediu, 'sdenumire_Judet');
    localitate = localitate.replaceFirst(
      RegExp(r'^(Mun\.|Oraș|Com\.|Sat)\s+', caseSensitive: false),
      '',
    );
    judet = judet.replaceFirst(
      RegExp(r'^Județul\s+', caseSensitive: false),
      '',
    );
    final strada = [
      s(sediu, 'sdenumire_Strada'),
      s(sediu, 'snumar_Strada').isEmpty
          ? ''
          : 'nr. ${s(sediu, 'snumar_Strada')}',
    ].where((x) => x.isNotEmpty).join(' ');

    return FirmaAnaf(
      cui: s(g, 'cui'),
      denumire: s(g, 'denumire'),
      adresa: strada.isNotEmpty
          ? [strada, localitate, judet].where((x) => x.isNotEmpty).join(', ')
          : s(g, 'adresa'),
      nrRegCom: s(g, 'nrRegCom'),
      telefon: s(g, 'telefon'),
      codPostal: s(sediu, 'scod_Postal').isNotEmpty
          ? s(sediu, 'scod_Postal')
          : s(g, 'codPostal'),
      localitate: localitate,
      judet: judet,
      platitorTva: tva?['scpTVA'] == true,
      inactiva: inactiv?['statusInactivi'] == true,
    );
  }
}
