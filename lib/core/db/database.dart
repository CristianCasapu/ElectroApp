import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

import '../services/log_service.dart';
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
    Relevee,
    PlaneMontaj,
    Obstacole,
    TablouriExistente,
    Trasee,
    Instrumente,
    Masuratori,
    Poze,
    Setari,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _deschide());

  /// Bază de date izolată în memorie — pentru teste.
  AppDatabase.inMemory(super.executor);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      log.info('db', 'Bază de date nouă, schema v$schemaVersion');
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      log.info('db', 'Migrare bază de date', 'v$from → v$to');
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
      if (from < 4) {
        // E2: releveul de șantier
        await m.createTable(relevee);
        await m.createTable(planeMontaj);
        await m.createTable(obstacole);
        await m.createTable(tablouriExistente);
        await m.createTable(trasee);
      }
      if (from < 5) {
        // E2: măsurători instrumentale, instrumente și fotografii
        await m.createTable(instrumente);
        await m.createTable(masuratori);
        await m.createTable(poze);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      final noi = await _seedFurnizori();
      log.debug(
        'db',
        'Bază de date deschisă',
        'schema v${details.versionNow} · furnizori adăugați: $noi',
      );
    },
  );

  /// Lista predefinită intră o singură dată; rândurile existente (inclusiv
  /// cele redenumite sau șterse de utilizator) nu se ating.
  Future<int> _seedFurnizori() async {
    final existente = await select(furnizori).get();
    if (existente.isNotEmpty) return 0;
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
    return furnizoriPredefiniti.length;
  }

  static QueryExecutor _deschide() =>
      driftDatabase(name: 'electroapp', native: const DriftNativeOptions());
}
