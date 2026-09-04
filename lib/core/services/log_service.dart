import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Nivelurile jurnalului, în ordinea severității.
enum NivelLog {
  debug('debug', 'Debug', 'D'),
  info('info', 'Info', 'I'),
  warn('warn', 'Warn', 'W'),
  error('error', 'Error', 'E');

  const NivelLog(this.cod, this.eticheta, this.litera);
  final String cod;
  final String eticheta;
  final String litera;

  static NivelLog dinCod(String? cod) =>
      values.firstWhere((n) => n.cod == cod, orElse: () => info);

  bool operator >=(NivelLog alt) => index >= alt.index;
}

/// O intrare din jurnal, așa cum se vede în aplicație și în fișierul exportat.
class IntrareLog {
  final DateTime la;
  final NivelLog nivel;
  final String zona;
  final String mesaj;
  final String? detaliu;

  const IntrareLog({
    required this.la,
    required this.nivel,
    required this.zona,
    required this.mesaj,
    this.detaliu,
  });

  String get ora =>
      '${la.hour.toString().padLeft(2, '0')}:${la.minute.toString().padLeft(2, '0')}:'
      '${la.second.toString().padLeft(2, '0')}.${la.millisecond.toString().padLeft(3, '0')}';

  String get data =>
      '${la.year}-${la.month.toString().padLeft(2, '0')}-${la.day.toString().padLeft(2, '0')}';

  /// Linia din fișier: `2026-09-04 20:11:03.412 I [registru] mesaj | detaliu`
  String get linie {
    final b = StringBuffer('$data $ora ${nivel.litera} [$zona] $mesaj');
    if (detaliu != null && detaliu!.isNotEmpty) {
      b.write(' | ${detaliu!.replaceAll('\n', ' ⏎ ')}');
    }
    return b.toString();
  }
}

/// Jurnalul de activitate al aplicației: fiecare operație importantă lasă o
/// urmă cu oră, zonă și detalii, iar utilizatorul poate trimite fișierul când
/// raportează o problemă. Nimic nu părăsește telefonul fără acțiunea lui.
///
/// Fișierul este rotativ (max ~512 KB, se păstrează coada); scrierea se face
/// grupat, ca jurnalizarea să nu încetinească interfața.
class LogService {
  LogService._();
  static final LogService instance = LogService._();

  static const cheieActiv = 'log_activ';
  static const cheieNivel = 'log_nivel';
  static const numeFisier = 'electroapp.log';
  static const dimensiuneMaxima = 512 * 1024;
  static const _maxInMemorie = 500;

  SharedPreferences? _prefs;
  File? _fisier;
  bool _activ = true;
  NivelLog _nivel = NivelLog.info;
  final _recente = Queue<IntrareLog>();
  final _deScris = <IntrareLog>[];
  Timer? _flush;

  /// Notifică ecranul de jurnal când apar intrări noi.
  final ValueNotifier<int> revizie = ValueNotifier(0);

  bool get activ => _activ;
  NivelLog get nivel => _nivel;
  List<IntrareLog> get recente => _recente.toList();
  File? get fisier => _fisier;

  Future<void> initializeaza({Directory? director}) async {
    _prefs = await SharedPreferences.getInstance();
    _activ = _prefs!.getBool(cheieActiv) ?? true;
    _nivel = NivelLog.dinCod(_prefs!.getString(cheieNivel));
    final dir = director ?? await getApplicationSupportDirectory();
    _fisier = File('${dir.path}${Platform.pathSeparator}$numeFisier');
    if (!await _fisier!.parent.exists()) {
      await _fisier!.parent.create(recursive: true);
    }
  }

  Future<void> seteazaActiv(bool v) async {
    _activ = v;
    await _prefs?.setBool(cheieActiv, v);
    info('setari', v ? 'Jurnal pornit' : 'Jurnal oprit');
  }

  Future<void> seteazaNivel(NivelLog n) async {
    _nivel = n;
    await _prefs?.setString(cheieNivel, n.cod);
    info('setari', 'Nivel jurnal: ${n.eticheta}');
  }

  void debug(String zona, String mesaj, [String? detaliu]) =>
      _scrie(NivelLog.debug, zona, mesaj, detaliu);
  void info(String zona, String mesaj, [String? detaliu]) =>
      _scrie(NivelLog.info, zona, mesaj, detaliu);
  void warn(String zona, String mesaj, [String? detaliu]) =>
      _scrie(NivelLog.warn, zona, mesaj, detaliu);
  void error(String zona, String mesaj, [Object? eroare, StackTrace? stiva]) =>
      _scrie(
        NivelLog.error,
        zona,
        mesaj,
        [
          if (eroare != null) '$eroare',
          if (stiva != null) _stivaScurta(stiva),
        ].join('\n'),
      );

  /// Cronometrează o operație și o jurnalizează cu durata și rezultatul ei.
  Future<T> masoara<T>(
    String zona,
    String mesaj,
    Future<T> Function() operatie, {
    String Function(T)? rezultat,
  }) async {
    final start = DateTime.now();
    try {
      final r = await operatie();
      final ms = DateTime.now().difference(start).inMilliseconds;
      info(
        zona,
        mesaj,
        ['${ms}ms', if (rezultat != null) rezultat(r)].join(' · '),
      );
      return r;
    } on Object catch (e, s) {
      final ms = DateTime.now().difference(start).inMilliseconds;
      error(zona, '$mesaj — eșuat după ${ms}ms', e, s);
      rethrow;
    }
  }

  void _scrie(NivelLog n, String zona, String mesaj, String? detaliu) {
    if (!_activ || !(n >= _nivel)) return;
    final intrare = IntrareLog(
      la: DateTime.now(),
      nivel: n,
      zona: zona,
      mesaj: mesaj,
      detaliu: detaliu,
    );
    _recente.addLast(intrare);
    while (_recente.length > _maxInMemorie) {
      _recente.removeFirst();
    }
    _deScris.add(intrare);
    revizie.value++;
    if (kDebugMode) debugPrint(intrare.linie);
    _flush ??= Timer(const Duration(seconds: 2), () {
      _flush = null;
      unawaited(descarcaPeDisc());
    });
  }

  /// Scrie pe disc intrările acumulate și rotește fișierul dacă a crescut.
  Future<void> descarcaPeDisc() async {
    final f = _fisier;
    if (f == null || _deScris.isEmpty) return;
    final linii = _deScris.map((e) => e.linie).join('\n');
    _deScris.clear();
    try {
      await f.writeAsString('$linii\n', mode: FileMode.append, flush: true);
      if (await f.length() > dimensiuneMaxima) await _roteste(f);
    } on Object {
      // jurnalul nu are voie să dărâme aplicația
    }
  }

  Future<void> _roteste(File f) async {
    final tot = await f.readAsString();
    final pastrat = tot.substring(tot.length ~/ 2);
    final start = pastrat.indexOf('\n');
    await f.writeAsString(
      '--- jurnal rotit ${DateTime.now()} ---\n'
      '${start >= 0 ? pastrat.substring(start + 1) : pastrat}',
      flush: true,
    );
  }

  Future<String> continut() async {
    await descarcaPeDisc();
    final f = _fisier;
    if (f == null || !await f.exists()) return '';
    return f.readAsString();
  }

  Future<void> goleste() async {
    _recente.clear();
    _deScris.clear();
    final f = _fisier;
    try {
      if (f != null && await f.exists()) await f.delete();
    } on FileSystemException {
      // fișier blocat de sistem: îl golim în loc să-l ștergem
      try {
        await f!.writeAsString('', flush: true);
      } on FileSystemException {
        // nici asta nu a mers — jurnalul rămâne, dar aplicația merge înainte
      }
    }
    revizie.value++;
    info('setari', 'Jurnal șters');
  }

  /// Antetul de diagnostic pus în fața jurnalului exportat.
  Future<String> antetDiagnostic() async {
    final b = StringBuffer('=== ElectroApp — jurnal de depanare ===\n');
    b.writeln('Generat: ${DateTime.now()}');
    try {
      final p = await PackageInfo.fromPlatform();
      b.writeln(
        'Aplicație: ${p.version} (build ${p.buildNumber}) · ${p.packageName}',
      );
    } on Object {
      b.writeln('Aplicație: versiune indisponibilă');
    }
    try {
      const canal = MethodChannel('ro.ccii.electroapp/contacte');
      final d = await canal.invokeMapMethod<String, Object?>('infoDispozitiv');
      if (d != null) {
        b.writeln('Telefon: ${d['marca']} ${d['model']}');
        b.writeln('Android: ${d['android']} (API ${d['api']})');
      }
    } on Object {
      b.writeln(
        'Sistem: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
      );
    }
    b.writeln(
      'Nivel jurnal: ${_nivel.eticheta} · activ: ${_activ ? 'da' : 'nu'}',
    );
    b.writeln('=======================================');
    return b.toString();
  }

  /// Fișierul complet (antet + jurnal), pregătit pentru trimitere.
  /// [director] înlocuiește directorul temporar în teste.
  Future<File?> pregatestePentruTrimitere({Directory? director}) async {
    final text = await continut();
    if (text.isEmpty) return null;
    final dir = director ?? await getTemporaryDirectory();
    final acum = DateTime.now();
    final nume =
        'electroapp-log-${acum.year}${acum.month.toString().padLeft(2, '0')}'
        '${acum.day.toString().padLeft(2, '0')}-${acum.hour.toString().padLeft(2, '0')}'
        '${acum.minute.toString().padLeft(2, '0')}.txt';
    final f = File('${dir.path}${Platform.pathSeparator}$nume');
    await f.writeAsString('${await antetDiagnostic()}\n$text', flush: true);
    return f;
  }

  /// Prinde erorile Flutter, cele din zonă și cele de platformă. Se apelează
  /// o singură dată, din `main()`.
  void prindeErorile() {
    final anterior = FlutterError.onError;
    FlutterError.onError = (details) {
      error(
        'flutter',
        details.exceptionAsString(),
        details.exception,
        details.stack,
      );
      unawaited(descarcaPeDisc());
      anterior?.call(details);
    };
    PlatformDispatcher.instance.onError = (e, s) {
      error('platforma', 'Eroare neprinsă', e, s);
      unawaited(descarcaPeDisc());
      return false;
    };
  }

  static String _stivaScurta(StackTrace s, {int linii = 12}) =>
      s.toString().split('\n').take(linii).join('\n');
}

/// Prescurtare pentru apelurile din cod: `log.info('registru', '…')`.
LogService get log => LogService.instance;
