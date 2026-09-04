import 'package:electroapp/app/providers.dart';
import 'package:electroapp/core/models/profil_firma.dart';
import 'package:electroapp/core/services/update_service.dart';
import 'package:electroapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Test de navigare: provider-ii de date sunt suprascriși cu stream-uri
/// sintetice (drift are I/O real, incompatibil cu ceasul simulat al testului);
/// repository-urile sunt acoperite în test/core/repositories_test.dart.
/// Fără rețea în teste: verificarea de la pornire nu găsește nimic.
class _FaraActualizari extends UpdateService {
  @override
  Future<UpdateInfo?> verifica() async => null;
}

void main() {
  testWidgets(
    'aplicația pornește pe registrul gol și navighează între tab-uri',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      PackageInfo.setMockInitialValues(
        appName: 'ElectroApp',
        packageName: 'ro.ccii.electroapp',
        version: '0.1.0',
        buildNumber: '1',
        buildSignature: '',
      );
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            updateServiceProvider.overrideWithValue(_FaraActualizari()),
            registruProvider.overrideWith((ref) => Stream.value(const [])),
            clientiProvider.overrideWith((ref) => Stream.value(const [])),
            profilFirmaProvider.overrideWith(
              (ref) => Stream.value(const ProfilFirma(denumire: 'Electro SRL')),
            ),
          ],
          child: const ElectroApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Registru lucrări'), findsOneWidget);
      expect(find.text('Registrul este gol'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.people_outline));
      await tester.pumpAndSettle();
      expect(find.text('Niciun client'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.calculate_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Calcule de dimensionare'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Profil firmă și electrician'), findsOneWidget);
      expect(find.text('Electro SRL'), findsOneWidget);
    },
  );
}
