import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Clienti,
    Lucrari,
    LucrariStari,
    LocuriConsum,
    Furnizori,
    Solutii,
    Documente,
    Setari,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _deschide());

  /// Bază de date izolată în memorie — pentru teste.
  AppDatabase.inMemory(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // v0.1.3: furnizor + POD pe client și pe locul de consum, lista de
        // furnizori. Coloane cu valoare implicită → ALTER TABLE fără pierderi.
        await m.addColumn(clienti, clienti.codPod);
        await m.addColumn(locuriConsum, locuriConsum.furnizorEnergie);
        await m.addColumn(locuriConsum, locuriConsum.codClientFurnizor);
        await m.createTable(furnizori);
      }
      if (from < 3) {
        // E1: soluții tehnice pe revizii + documente emise
        await m.createTable(solutii);
        await m.createTable(documente);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await _seedFurnizori();
    },
  );

  /// Lista predefinită intră o singură dată; rândurile existente (inclusiv
  /// cele redenumite sau șterse de utilizator) nu se ating.
  Future<void> _seedFurnizori() async {
    final existente = await select(furnizori).get();
    if (existente.isNotEmpty) return;
    const uuid = Uuid();
    final acum = DateTime.now();
    await batch((b) {
      for (final nume in furnizoriPredefiniti) {
        b.insert(
          furnizori,
          FurnizoriCompanion.insert(
            id: uuid.v4(),
            denumire: nume,
            predefinit: const Value(true),
            createdAt: acum,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }

  static QueryExecutor _deschide() =>
      driftDatabase(name: 'electroapp', native: const DriftNativeOptions());
}
