import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Clienti, Lucrari, LucrariStari, LocuriConsum, Setari])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _deschide());

  /// Bază de date izolată în memorie — pentru teste.
  AppDatabase.inMemory(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _deschide() =>
      driftDatabase(name: 'electroapp', native: const DriftNativeOptions());
}
