import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/db/database.dart';
import '../core/db/releveu_repository.dart';
import '../core/db/repositories.dart';
import '../core/db/solutii_repository.dart';
import '../core/models/profil_firma.dart';
import '../core/services/anaf_service.dart';
import '../core/services/contact_picker_service.dart';
import '../core/services/osm_service.dart';
import '../core/services/raport_pdf_service.dart';
import '../core/services/senzori_service.dart';
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
final furnizoriRepositoryProvider = Provider(
  (ref) => FurnizoriRepository(ref.watch(databaseProvider)),
);
final releveuRepositoryProvider = Provider(
  (ref) => ReleveuRepository(ref.watch(databaseProvider)),
);
final solutiiRepositoryProvider = Provider(
  (ref) => SolutiiRepository(ref.watch(databaseProvider)),
);
final setariRepositoryProvider = Provider(
  (ref) => SetariRepository(ref.watch(databaseProvider)),
);

// Servicii externe — suprascrise în teste cu variante fără rețea.
final updateServiceProvider = Provider((ref) => UpdateService());
final osmServiceProvider = Provider((ref) => OsmService());
final anafServiceProvider = Provider((ref) => AnafService());
final contactPickerProvider = Provider((ref) => ContactPickerService());
final raportPdfProvider = Provider((ref) => RaportPdfService());
final senzoriProvider = Provider<SenzoriService>((ref) {
  final s = SenzoriService();
  ref.onDispose(s.inchide);
  return s;
});

final registruProvider = StreamProvider<List<FisaLucrare>>(
  (ref) => ref.watch(lucrariRepositoryProvider).watchRegistru(),
);

final fisaProvider = StreamProvider.autoDispose.family<FisaLucrare?, String>(
  (ref, id) => ref.watch(lucrariRepositoryProvider).watchFisa(id),
);

final istoricStariProvider = StreamProvider.autoDispose
    .family<List<LucrariStariData>, String>(
      (ref, id) => ref.watch(lucrariRepositoryProvider).watchIstoricStari(id),
    );

final clientiProvider = StreamProvider<List<ClientiData>>(
  (ref) => ref.watch(clientiRepositoryProvider).watchToti(),
);

final releveuProvider = StreamProvider.autoDispose
    .family<ReleveuComplet?, String>(
      (ref, id) => ref.watch(releveuRepositoryProvider).watchPentruLucrare(id),
    );

final solutiiProvider = StreamProvider.autoDispose
    .family<List<SolutiiData>, String>(
      (ref, id) => ref.watch(solutiiRepositoryProvider).watchPentruLucrare(id),
    );

final documenteProvider = StreamProvider.autoDispose
    .family<List<DocumenteData>, String>(
      (ref, id) => ref.watch(solutiiRepositoryProvider).watchDocumente(id),
    );

final furnizoriProvider = StreamProvider<List<FurnizoriData>>(
  (ref) => ref.watch(furnizoriRepositoryProvider).watchToti(),
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
