import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../models/solutie.dart';
import 'database.dart';

const _uuid = Uuid();

/// Soluțiile tehnice pe revizii (append-only) și documentele emise (imutabile).
class SolutiiRepository {
  SolutiiRepository(this.db);
  final AppDatabase db;

  Stream<List<SolutiiData>> watchPentruLucrare(String lucrareId) =>
      (db.select(db.solutii)
            ..where((s) => s.lucrareId.equals(lucrareId))
            ..orderBy([(s) => OrderingTerm.desc(s.revizie)]))
          .watch();

  Future<SolutiiData?> gaseste(String id) =>
      (db.select(db.solutii)..where((s) => s.id.equals(id))).getSingleOrNull();

  /// Salvează o revizie nouă (R1, R2, …) și întoarce id-ul ei.
  Future<String> adaugaRevizie({
    required String lucrareId,
    required SolutieSnapshot snapshot,
    String observatii = '',
  }) {
    return db.transaction(() async {
      final max = db.solutii.revizie.max();
      final q = db.selectOnly(db.solutii)
        ..addColumns([max])
        ..where(db.solutii.lucrareId.equals(lucrareId));
      final ultima = (await q.getSingle()).read(max) ?? 0;
      final id = _uuid.v4();
      await db
          .into(db.solutii)
          .insert(
            SolutiiCompanion.insert(
              id: id,
              lucrareId: lucrareId,
              revizie: ultima + 1,
              creataLa: DateTime.now(),
              intrariJson: snapshot.intrari.encode(),
              rezultatJson: snapshot.rezultat.encode(),
              observatii: Value(observatii),
            ),
          );
      return id;
    });
  }

  static SolutieSnapshot decodeaza(SolutiiData s) => SolutieSnapshot(
    intrari: IntrariSolutie.decode(s.intrariJson),
    rezultat: RezultatSolutie.decode(s.rezultatJson),
  );

  // ── Documente ─────────────────────────────────────────────────────────────

  Stream<List<DocumenteData>> watchDocumente(String lucrareId) =>
      (db.select(db.documente)
            ..where((d) => d.lucrareId.equals(lucrareId))
            ..orderBy([(d) => OrderingTerm.desc(d.emisLa)]))
          .watch();

  /// Înregistrează un document emis; versiunea crește per tip și fișă.
  Future<DocumenteData> adaugaDocument({
    required String lucrareId,
    required String? solutieId,
    required TipDocument tip,
    required String cale,
    required String sha256,
    required int marimeBytes,
  }) {
    return db.transaction(() async {
      final max = db.documente.versiune.max();
      final q = db.selectOnly(db.documente)
        ..addColumns([max])
        ..where(
          db.documente.lucrareId.equals(lucrareId) &
              db.documente.tip.equals(tip.cod),
        );
      final ultima = (await q.getSingle()).read(max) ?? 0;
      final rand = DocumenteCompanion.insert(
        id: _uuid.v4(),
        lucrareId: lucrareId,
        solutieId: Value(solutieId),
        tip: tip.cod,
        versiune: ultima + 1,
        emisLa: DateTime.now(),
        cale: cale,
        sha256: sha256,
        marimeBytes: Value(marimeBytes),
      );
      return db.into(db.documente).insertReturning(rand);
    });
  }
}
