import 'dart:convert';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

/// Actualizare din aplicație prin GitHub Releases (repo public, fără token).
/// Tag-ul release-ului este `vMAJOR.MINOR.BUILD`; local comparăm
/// `MAJOR.MINOR` din versiune cu BUILD-ul din `buildNumber` (vezi CLAUDE.md).
class UpdateService {
  static const owner = 'CristianCasapu';
  static const repo = 'ElectroApp';
  static const fileProviderAuthority = 'ro.ccii.electroapp.fileProvider';
  static const _apiLatest =
      'https://api.github.com/repos/$owner/$repo/releases/latest';

  final http.Client _client;
  UpdateService({http.Client? client}) : _client = client ?? http.Client();

  /// Motivul ultimului eșec de verificare (rețea, lipsă APK), afișabil în UI.
  String? ultimaEroare;

  Future<UpdateInfo?> verifica() async {
    ultimaEroare = null;
    try {
      final resp = await _client
          .get(
            Uri.parse(_apiLatest),
            headers: const {
              'Accept': 'application/vnd.github+json',
              'X-GitHub-Api-Version': '2022-11-28',
              'User-Agent': 'ElectroApp',
            },
          )
          .timeout(const Duration(seconds: 12));
      if (resp.statusCode == 404) {
        ultimaEroare = 'Nu există încă niciun release publicat.';
        return null;
      }
      if (resp.statusCode != 200) {
        ultimaEroare = 'GitHub a răspuns cu HTTP ${resp.statusCode}.';
        return null;
      }
      final info = await PackageInfo.fromPlatform();
      return parseRelease(
        jsonDecode(resp.body) as Map<String, dynamic>,
        versiuneLocala: versiuneLocalaDin(info.version, info.buildNumber),
      );
    } on Object catch (e) {
      ultimaEroare = 'Nu s-a putut verifica: $e';
      return null;
    }
  }

  /// Extrage din răspunsul GitHub o actualizare mai nouă decât [versiuneLocala]
  /// sau `null`. Separată de rețea pentru a fi testabilă.
  UpdateInfo? parseRelease(
    Map<String, dynamic> json, {
    required String versiuneLocala,
  }) {
    final tag = json['tag_name'] as String?;
    if (tag == null) return null;
    final remote = tag.startsWith('v') ? tag.substring(1) : tag;
    if (!esteMaiNoua(remote, versiuneLocala)) return null;

    final assets = (json['assets'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    final apk = assets.where((a) => (a['name'] as String).endsWith('.apk'));
    if (apk.isEmpty) {
      ultimaEroare = 'Release-ul $tag nu are fișier APK atașat.';
      return null;
    }
    final a = apk.first;
    return UpdateInfo(
      versiune: remote,
      tag: tag,
      note: (json['body'] as String?)?.trim() ?? '',
      numeFisier: a['name'] as String,
      url: a['browser_download_url'] as String,
      dimensiuneBytes: (a['size'] as int?) ?? 0,
    );
  }

  /// Descarcă APK-ul în cache și raportează progresul 0..1.
  Future<File?> descarca(
    UpdateInfo info,
    void Function(double progres) onProgres,
  ) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${info.numeFisier}');
      final req = http.Request('GET', Uri.parse(info.url))
        ..headers['User-Agent'] = 'ElectroApp';
      final resp = await _client.send(req);
      if (resp.statusCode != 200) return null;
      final total = resp.contentLength ?? info.dimensiuneBytes;
      var primit = 0;
      final sink = file.openWrite();
      await for (final chunk in resp.stream) {
        sink.add(chunk);
        primit += chunk.length;
        if (total > 0) onProgres(primit / total);
      }
      await sink.flush();
      await sink.close();
      return file;
    } on Object {
      return null;
    }
  }

  /// Lansează instalatorul Android pentru fișierul din cache (FileProvider
  /// declarat în AndroidManifest.xml, căi în res/xml/file_paths.xml).
  Future<bool> instaleaza(File apk) async {
    try {
      final nume = apk.path.split(Platform.pathSeparator).last;
      final intent = AndroidIntent(
        action: 'action_view',
        data: 'content://$fileProviderAuthority/cache/$nume',
        type: 'application/vnd.android.package-archive',
        flags: <int>[
          Flag.FLAG_GRANT_READ_URI_PERMISSION,
          Flag.FLAG_ACTIVITY_NEW_TASK,
        ],
      );
      await intent.launch();
      return true;
    } on Object {
      return false;
    }
  }
}

class UpdateInfo {
  final String versiune;
  final String tag;
  final String note;
  final String numeFisier;
  final String url;
  final int dimensiuneBytes;

  const UpdateInfo({
    required this.versiune,
    required this.tag,
    required this.note,
    required this.numeFisier,
    required this.url,
    required this.dimensiuneBytes,
  });

  String get dimensiune => dimensiuneBytes <= 0
      ? ''
      : '${(dimensiuneBytes / 1048576).toStringAsFixed(1)} MB';
}

/// `version` din pubspec este `MAJOR.MINOR.PATCH`, iar tag-ul GitHub este
/// `vMAJOR.MINOR.BUILD` — versiunea comparabilă local este `MAJOR.MINOR.BUILD`.
String versiuneLocalaDin(String version, String buildNumber) {
  final p = version.split('.');
  final major = p.isNotEmpty ? p[0] : '0';
  final minor = p.length > 1 ? p[1] : '0';
  return '$major.$minor.$buildNumber';
}

bool esteMaiNoua(String remote, String local) {
  List<int> parse(String v) =>
      v.split('.').map((x) => int.tryParse(x) ?? 0).toList();
  final r = parse(remote);
  final l = parse(local);
  for (var i = 0; i < 3; i++) {
    final rv = i < r.length ? r[i] : 0;
    final lv = i < l.length ? l[i] : 0;
    if (rv != lv) return rv > lv;
  }
  return false;
}
