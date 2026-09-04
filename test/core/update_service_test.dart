import 'package:electroapp/core/services/update_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('esteMaiNoua', () {
    test('compară major.minor.build numeric', () {
      expect(esteMaiNoua('0.1.2', '0.1.1'), isTrue);
      expect(esteMaiNoua('0.2.0', '0.1.99'), isTrue);
      expect(esteMaiNoua('1.0.0', '0.9.9'), isTrue);
      expect(esteMaiNoua('0.1.1', '0.1.1'), isFalse);
      expect(esteMaiNoua('0.1.0', '0.1.1'), isFalse);
      expect(esteMaiNoua('0.1.10', '0.1.9'), isTrue, reason: 'nu lexicografic');
    });
  });

  test('versiunea locală combină major.minor cu buildNumber', () {
    expect(versiuneLocalaDin('0.1.0', '7'), '0.1.7');
    expect(versiuneLocalaDin('2.3.9', '41'), '2.3.41');
  });

  group('parseRelease', () {
    final release = {
      'tag_name': 'v0.1.5',
      'body': 'Note de versiune',
      'assets': [
        {
          'name': 'symbols.zip',
          'browser_download_url': 'https://x/s.zip',
          'size': 10,
        },
        {
          'name': 'ElectroApp-v0.1.5.apk',
          'browser_download_url': 'https://x/ElectroApp-v0.1.5.apk',
          'size': 20 * 1048576,
        },
      ],
    };

    test('găsește APK-ul când release-ul e mai nou', () {
      final s = UpdateService();
      final info = s.parseRelease(release, versiuneLocala: '0.1.1');
      expect(info, isNotNull);
      expect(info!.versiune, '0.1.5');
      expect(info.numeFisier, 'ElectroApp-v0.1.5.apk');
      expect(info.url, endsWith('.apk'));
      expect(info.dimensiune, '20.0 MB');
      expect(info.note, 'Note de versiune');
    });

    test('returnează null când versiunea locală e la zi', () {
      expect(
        UpdateService().parseRelease(release, versiuneLocala: '0.1.5'),
        isNull,
      );
      expect(
        UpdateService().parseRelease(release, versiuneLocala: '0.2.0'),
        isNull,
      );
    });

    test('semnalează lipsa APK-ului', () {
      final s = UpdateService();
      final info = s.parseRelease({
        'tag_name': 'v9.0.0',
        'assets': <Map<String, dynamic>>[],
      }, versiuneLocala: '0.1.1');
      expect(info, isNull);
      expect(s.ultimaEroare, contains('APK'));
    });
  });
}
