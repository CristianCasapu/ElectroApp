import 'package:flutter/services.dart';

import 'log_service.dart';

/// Contact ales din agenda telefonului (vezi MainActivity.kt): fără permisiunea
/// READ_CONTACTS, Android acordă acces doar la contactul ales de utilizator.
class ContactAles {
  final String nume;
  final List<String> telefoane;
  final List<String> emailuri;
  final List<String> adrese;

  const ContactAles({
    required this.nume,
    required this.telefoane,
    required this.emailuri,
    required this.adrese,
  });

  factory ContactAles.fromMap(Map<Object?, Object?> m) {
    List<String> lista(Object? v) =>
        (v as List<Object?>? ?? const []).map((e) => '$e').toList();
    return ContactAles(
      nume: (m['nume'] as String?) ?? '',
      telefoane: lista(m['telefoane']),
      emailuri: lista(m['emailuri']),
      adrese: lista(m['adrese']),
    );
  }
}

class ContactPickerService {
  static const _canal = MethodChannel('ro.ccii.electroapp/contacte');

  /// `null` dacă utilizatorul a renunțat sau agenda nu e disponibilă.
  Future<ContactAles?> alege() async {
    try {
      final r = await _canal.invokeMethod<Map<Object?, Object?>>(
        'alegeContact',
      );
      if (r == null) {
        log.debug('contacte', 'Selectare anulată');
        return null;
      }
      final c = ContactAles.fromMap(r);
      log.info(
        'contacte',
        'Contact ales',
        '${c.telefoane.length} telefoane · ${c.emailuri.length} e-mailuri · ${c.adrese.length} adrese',
      );
      return c;
    } on PlatformException catch (e) {
      log.warn('contacte', 'Agenda indisponibilă', e.message);
      return null;
    } on MissingPluginException {
      log.warn('contacte', 'Canal nativ indisponibil');
      return null;
    }
  }
}
