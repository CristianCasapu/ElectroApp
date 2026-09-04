import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../models/enums.dart';
import '../models/profil_firma.dart';
import '../services/log_service.dart';
import 'database.dart';

const _uuid = Uuid();

/// `version` crește la orice scriere — baza sincronizării optimiste (E5).
Future<void> _incrementeazaVersiunea(
  AppDatabase db,
  TableInfo tabela,
  String id, {
  String coloanaId = 'id',
}) => db.customUpdate(
  'UPDATE ${tabela.actualTableName} SET version = version + 1 '
  'WHERE $coloanaId = ?',
  variables: [Variable.withString(id)],
  updates: {tabela},
);

/// O fișă de lucrare împreună cu beneficiarul și locul de consum — forma în
/// care registrul afișează și deschide o înregistrare.
class FisaLucrare {
  final LucrariData lucrare;
  final ClientiData? client;
  final LocuriConsumData? locConsum;

  const FisaLucrare({
    required this.lucrare,
    required this.client,
    required this.locConsum,
  });

  StareLucrare get stare => StareLucrare.dinCod(lucrare.stare);
  TipLucrare get tipLucrare => TipLucrare.dinCod(lucrare.tipLucrare);

  String get titluAfisat =>
      lucrare.titlu.isNotEmpty ? lucrare.titlu : tipLucrare.eticheta;

  String get amplasament {
    final lc = locConsum;
    if (lc == null) return '';
    return [lc.localitate, lc.judet].where((s) => s.isNotEmpty).join(', ');
  }
}

class ClientiRepository {
  ClientiRepository(this.db);
  final AppDatabase db;

  Stream<List<ClientiData>> watchToti() =>
      (db.select(db.clienti)
            ..where((c) => c.deletedAt.isNull())
            ..orderBy([(c) => OrderingTerm.asc(c.denumire)]))
          .watch();

  Future<ClientiData?> gaseste(String id) =>
      (db.select(db.clienti)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<String> creeaza(ClientiCompanion date) async {
    final acum = DateTime.now();
    final id = _uuid.v4();
    await db
        .into(db.clienti)
        .insert(
          date.copyWith(
            id: Value(id),
            createdAt: Value(acum),
            updatedAt: Value(acum),
          ),
        );
    log.info('clienti', 'Client creat', '${date.denumire.value} · $id');
    return id;
  }

  Future<void> actualizeaza(String id, ClientiCompanion date) =>
      db.transaction(() async {
        await (db.update(db.clienti)..where((c) => c.id.equals(id))).write(
          date.copyWith(
            updatedAt: Value(DateTime.now()),
            version: const Value.absent(),
          ),
        );
        await _incrementeazaVersiunea(db, db.clienti, id);
        log.info('clienti', 'Client actualizat', id);
      });

  Future<int> numarLucrari(String clientId) async {
    final numar = db.lucrari.id.count();
    final q = db.selectOnly(db.lucrari)
      ..addColumns([numar])
      ..where(
        db.lucrari.clientId.equals(clientId) & db.lucrari.deletedAt.isNull(),
      );
    return (await q.getSingle()).read(numar) ?? 0;
  }

  /// Ștergere logică; refuzată dacă există fișe de lucrare asociate.
  Future<bool> sterge(String id) async {
    if (await numarLucrari(id) > 0) {
      log.warn('clienti', 'Ștergere refuzată — clientul are fișe', id);
      return false;
    }
    await db.transaction(() async {
      await (db.update(db.clienti)..where((c) => c.id.equals(id))).write(
        ClientiCompanion(deletedAt: Value(DateTime.now())),
      );
      await _incrementeazaVersiunea(db, db.clienti, id);
    });
    log.info('clienti', 'Client șters', id);
    return true;
  }
}

class LucrariRepository {
  LucrariRepository(this.db);
  final AppDatabase db;

  JoinedSelectStatement<HasResultSet, dynamic> _interogare() =>
      db.select(db.lucrari).join([
        leftOuterJoin(db.clienti, db.clienti.id.equalsExp(db.lucrari.clientId)),
        leftOuterJoin(
          db.locuriConsum,
          db.locuriConsum.lucrareId.equalsExp(db.lucrari.id),
        ),
      ]);

  FisaLucrare _mapeaza(TypedResult r) => FisaLucrare(
    lucrare: r.readTable(db.lucrari),
    client: r.readTableOrNull(db.clienti),
    locConsum: r.readTableOrNull(db.locuriConsum),
  );

  Stream<List<FisaLucrare>> watchRegistru() {
    final q = _interogare()
      ..where(db.lucrari.deletedAt.isNull())
      ..orderBy([OrderingTerm.desc(db.lucrari.deschisaLa)]);
    return q.watch().map((rows) => rows.map(_mapeaza).toList());
  }

  Stream<FisaLucrare?> watchFisa(String id) {
    final q = _interogare()..where(db.lucrari.id.equals(id));
    return q.watchSingleOrNull().map((r) => r == null ? null : _mapeaza(r));
  }

  Stream<List<LucrariStariData>> watchIstoricStari(String lucrareId) =>
      (db.select(db.lucrariStari)
            ..where((s) => s.lucrareId.equals(lucrareId))
            ..orderBy([
              (s) => OrderingTerm.desc(s.la),
              (s) => OrderingTerm.desc(s.rowId),
            ]))
          .watch();

  /// Numărul de înregistrare `FL-<an>-<secvență>`, unic pe an. Include și
  /// fișele șterse logic — un număr nu se refolosește niciodată.
  Future<String> urmatorulNumar([DateTime? data]) async {
    final an = (data ?? DateTime.now()).year;
    final prefix = 'FL-$an-';
    final rows = await (db.select(
      db.lucrari,
    )..where((l) => l.nrInregistrare.like('$prefix%'))).get();
    var max = 0;
    for (final r in rows) {
      final n = int.tryParse(r.nrInregistrare.substring(prefix.length)) ?? 0;
      if (n > max) max = n;
    }
    return '$prefix${(max + 1).toString().padLeft(4, '0')}';
  }

  Future<String> creeaza({
    required LucrariCompanion lucrare,
    required LocuriConsumCompanion locConsum,
  }) {
    return db.transaction(() async {
      final acum = DateTime.now();
      final id = _uuid.v4();
      final nr = await urmatorulNumar(acum);
      await db
          .into(db.lucrari)
          .insert(
            lucrare.copyWith(
              id: Value(id),
              nrInregistrare: Value(nr),
              stare: Value(StareLucrare.lead.cod),
              deschisaLa: Value(acum),
              createdAt: Value(acum),
              updatedAt: Value(acum),
            ),
          );
      await db
          .into(db.locuriConsum)
          .insert(
            locConsum.copyWith(
              id: Value(_uuid.v4()),
              lucrareId: Value(id),
              createdAt: Value(acum),
              updatedAt: Value(acum),
            ),
          );
      await db
          .into(db.lucrariStari)
          .insert(
            LucrariStariCompanion.insert(
              id: _uuid.v4(),
              lucrareId: id,
              stareIn: StareLucrare.lead.cod,
              la: acum,
              observatie: const Value('Fișă deschisă'),
            ),
          );
      log.info('registru', 'Fișă de lucrare creată', '$nr · $id');
      return id;
    });
  }

  Future<void> actualizeaza({
    required String id,
    required LucrariCompanion lucrare,
    required LocuriConsumCompanion locConsum,
  }) {
    return db.transaction(() async {
      final acum = DateTime.now();
      await (db.update(db.lucrari)..where((l) => l.id.equals(id))).write(
        lucrare.copyWith(updatedAt: Value(acum), version: const Value.absent()),
      );
      await (db.update(
        db.locuriConsum,
      )..where((l) => l.lucrareId.equals(id))).write(
        locConsum.copyWith(
          updatedAt: Value(acum),
          version: const Value.absent(),
        ),
      );
      await _incrementeazaVersiunea(db, db.lucrari, id);
      await _incrementeazaVersiunea(
        db,
        db.locuriConsum,
        id,
        coloanaId: 'lucrare_id',
      );
      log.info('registru', 'Fișă actualizată', id);
    });
  }

  /// Tranziție de stare cu înregistrare în jurnal. Refuză tranzițiile care nu
  /// sunt în [StareLucrare.urmatoare].
  Future<bool> schimbaStarea({
    required String id,
    required StareLucrare stareNoua,
    String observatie = '',
    String deCatre = '',
  }) {
    return db.transaction(() async {
      final curenta = await (db.select(
        db.lucrari,
      )..where((l) => l.id.equals(id))).getSingleOrNull();
      if (curenta == null) {
        log.warn('registru', 'Tranziție pe o fișă inexistentă', id);
        return false;
      }
      final stareCurenta = StareLucrare.dinCod(curenta.stare);
      if (!stareCurenta.urmatoare.contains(stareNoua)) {
        log.warn(
          'registru',
          'Tranziție refuzată',
          '${curenta.nrInregistrare}: ${stareCurenta.cod} → ${stareNoua.cod}',
        );
        return false;
      }
      final acum = DateTime.now();
      await (db.update(db.lucrari)..where((l) => l.id.equals(id))).write(
        LucrariCompanion(stare: Value(stareNoua.cod), updatedAt: Value(acum)),
      );
      await _incrementeazaVersiunea(db, db.lucrari, id);
      await db
          .into(db.lucrariStari)
          .insert(
            LucrariStariCompanion.insert(
              id: _uuid.v4(),
              lucrareId: id,
              stareDin: Value(stareCurenta.cod),
              stareIn: stareNoua.cod,
              la: acum,
              deCatre: Value(deCatre),
              observatie: Value(observatie),
            ),
          );
      log.info(
        'registru',
        'Stare schimbată',
        '${curenta.nrInregistrare}: ${stareCurenta.cod} → ${stareNoua.cod}'
            '${observatie.isEmpty ? '' : ' · $observatie'}',
      );
      return true;
    });
  }

  /// Ștergere logică — permisă doar pentru fișe fără documente emise; în E0
  /// nu există încă documente, deci este permisă pentru orice fișă.
  Future<void> sterge(String id) => db.transaction(() async {
    await (db.update(db.lucrari)..where((l) => l.id.equals(id))).write(
      LucrariCompanion(deletedAt: Value(DateTime.now())),
    );
    await _incrementeazaVersiunea(db, db.lucrari, id);
    log.info('registru', 'Fișă ștearsă', id);
  });
}

class FurnizoriRepository {
  FurnizoriRepository(this.db);
  final AppDatabase db;

  /// Predefiniții primii, apoi cei adăugați, fiecare grup alfabetic.
  Stream<List<FurnizoriData>> watchToti() =>
      (db.select(db.furnizori)
            ..where((f) => f.deletedAt.isNull())
            ..orderBy([
              (f) => OrderingTerm.desc(f.predefinit),
              (f) => OrderingTerm.asc(f.denumire),
            ]))
          .watch();

  /// Adaugă un furnizor nou sau reactivează unul șters cu același nume.
  /// Întoarce denumirea normalizată (spații tăiate).
  Future<String> adauga(String denumire) async {
    final nume = denumire.trim();
    if (nume.isEmpty) throw ArgumentError('Denumirea furnizorului lipsește');
    final existent = await (db.select(
      db.furnizori,
    )..where((f) => f.denumire.equals(nume))).getSingleOrNull();
    if (existent != null) {
      if (existent.deletedAt != null) {
        await (db.update(db.furnizori)..where((f) => f.id.equals(existent.id)))
            .write(const FurnizoriCompanion(deletedAt: Value(null)));
      }
      return existent.denumire;
    }
    await db
        .into(db.furnizori)
        .insert(
          FurnizoriCompanion.insert(
            id: _uuid.v4(),
            denumire: nume,
            createdAt: DateTime.now(),
          ),
        );
    log.info('furnizori', 'Furnizor adăugat', nume);
    return nume;
  }

  Future<void> sterge(String id) =>
      (db.update(db.furnizori)..where((f) => f.id.equals(id))).write(
        FurnizoriCompanion(deletedAt: Value(DateTime.now())),
      );
}

class SetariRepository {
  SetariRepository(this.db);
  final AppDatabase db;

  Future<Map<String, String>> toate() async {
    final rows = await db.select(db.setari).get();
    return {for (final r in rows) r.cheie: r.valoare};
  }

  Stream<ProfilFirma> watchProfil() => db
      .select(db.setari)
      .watch()
      .map(
        (rows) =>
            ProfilFirma.fromMap({for (final r in rows) r.cheie: r.valoare}),
      );

  Future<void> salveazaProfil(ProfilFirma p) {
    log.info('setari', 'Profil firmă salvat', p.denumire);
    return db.batch((b) {
      for (final e in p.toMap().entries) {
        b.insert(
          db.setari,
          SetariCompanion.insert(cheie: e.key, valoare: e.value),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }
}
