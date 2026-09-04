import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/db/database.dart';
import '../core/db/repositories.dart';
import '../core/models/profil_firma.dart';
import '../core/services/update_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final clientiRepositoryProvider = Provider(
  (ref) => ClientiRepository(ref.watch(databaseProvider)),
);
final lucrariRepositoryProvider = Provider(
  (ref) => LucrariRepository(ref.watch(databaseProvider)),
);
final setariRepositoryProvider = Provider(
  (ref) => SetariRepository(ref.watch(databaseProvider)),
);

final updateServiceProvider = Provider((ref) => UpdateService());

final registruProvider = StreamProvider<List<FisaLucrare>>(
  (ref) => ref.watch(lucrariRepositoryProvider).watchRegistru(),
);

final fisaProvider = StreamProvider.family<FisaLucrare?, String>(
  (ref, id) => ref.watch(lucrariRepositoryProvider).watchFisa(id),
);

final istoricStariProvider =
    StreamProvider.family<List<LucrariStariData>, String>(
      (ref, id) => ref.watch(lucrariRepositoryProvider).watchIstoricStari(id),
    );

final clientiProvider = StreamProvider<List<ClientiData>>(
  (ref) => ref.watch(clientiRepositoryProvider).watchToti(),
);

final profilFirmaProvider = StreamProvider<ProfilFirma>(
  (ref) => ref.watch(setariRepositoryProvider).watchProfil(),
);

/// Preferințele de afișare (tema), persistate în SharedPreferences.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Se suprascrie în main()'),
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _cheie = 'theme_mode';

  @override
  ThemeMode build() {
    final salvat = ref.watch(sharedPreferencesProvider).getString(_cheie);
    return ThemeMode.values.firstWhere(
      (m) => m.name == salvat,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> seteaza(ThemeMode mod) async {
    state = mod;
    await ref.read(sharedPreferencesProvider).setString(_cheie, mod.name);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
