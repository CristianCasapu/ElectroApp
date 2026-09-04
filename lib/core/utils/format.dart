import 'package:intl/intl.dart';

final _data = DateFormat('dd.MM.yyyy');
final _dataOra = DateFormat('dd.MM.yyyy HH:mm');

String formatData(DateTime? d) => d == null ? '—' : _data.format(d);
String formatDataOra(DateTime? d) => d == null ? '—' : _dataOra.format(d);

/// Număr cu virgulă zecimală și fără zerouri inutile: 5 → "5", 5.5 → "5,5".
String formatNumar(num? n, {int zecimale = 2}) {
  if (n == null) return '—';
  var s = n.toStringAsFixed(zecimale);
  if (s.contains('.')) {
    s = s.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }
  return s.replaceFirst('.', ',');
}

double? parseNumar(String? s) {
  if (s == null) return null;
  final t = s.trim().replaceAll(',', '.');
  if (t.isEmpty) return null;
  return double.tryParse(t);
}

int? parseIntreg(String? s) {
  if (s == null) return null;
  final t = s.trim();
  if (t.isEmpty) return null;
  return int.tryParse(t);
}
