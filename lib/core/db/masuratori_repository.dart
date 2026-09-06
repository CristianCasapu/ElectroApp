import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../calc/masuratori.dart';
import '../services/log_service.dart';
import 'database.dart';

const _uuid = Uuid();

/// Măsurătorile (append-only) și instrumentele cu care s-au făcut.
class MasuratoriRepository {
  MasuratoriRepository(this.db);
  final AppDatabase db;

  Stream<List<MasuratoriData>> watchPentruLucrare(
    String lucrareId, {
    FazaMasuratoare? faza,
  }) {
    final q = db.select(db.masuratori)
      ..where((m) => m.lucrareId.equals(lucrareId))
      ..orderBy([
        (m) => OrderingTerm.desc(m.la),
        (m) => OrderingTerm.desc(m.rowId),
      ]);
    if (faza != null) {
      q.where((m) => m.faza.equals(faza.cod));
    }
    return q.watch();
  }

  /// Doar măsurătorile în vigoare: cele înlocuite de o corectură ies din listă.
  static List<MasuratoriData> inVigoare(List<MasuratoriData> toate) =>
      toate.where((m) => m.inlocuitaDe == null).toList();

  /// Adaugă o măsurătoare. Nimic nu se editează: o corectură pe aceeași țintă
  /// marchează măsurătoarea veche ca înlocuită și o păstrează în istoric.
  Future<String> adauga(
    MasuratoriCompanion date, {
    bool inlocuiestePeTinta = true,
  }) {
    return db.transaction(() async {
      final id = _uuid.v4();
      final acum = date.la.present ? date.la.value : DateTime.now();
      if (inlocuiestePeTinta) {
        final vechi =
            await (db.select(db.masuratori)..where(
                  (m) =>
                      m.lucrareId.equals(date.lucrareId.value) &
                      m.tip.equals(date.tip.value) &
                      m.faza.equals(date.faza.value) &
                      m.tinta.equals(date.tinta.value) &
                      m.inlocuitaDe.isNull(),
                ))
                .get();
        for (final v in vechi) {
          await (db.update(db.masuratori)..where((m) => m.id.equals(v.id)))
              .write(MasuratoriCompanion(inlocuitaDe: Value(id)));
        }
        if (vechi.isNotEmpty) {
          log.info(
            'masuratori',
            'Măsurătoare corectată',
            '${date.tip.value} · ${date.tinta.value} · ${vechi.length} înlocuite',
          );
        }
      }
      await db
          .into(db.masuratori)
          .insert(date.copyWith(id: Value(id), la: Value(acum)));
      log.info(
        'masuratori',
        'Măsurătoare înregistrată',
        '${date.tip.value}${date.tinta.value.isEmpty ? '' : ' · ${date.tinta.value}'} '
            '= ${date.valoare.present ? date.valoare.value : '—'} · ${date.verdict.value}',
      );
      return id;
    });
  }

  /// Istoricul unei ținte, inclusiv valorile înlocuite.
  Future<List<MasuratoriData>> istoric(
    String lucrareId,
    TipMasuratoare tip,
    String tinta,
  ) =>
      (db.select(db.masuratori)
            ..where(
              (m) =>
                  m.lucrareId.equals(lucrareId) &
                  m.tip.equals(tip.cod) &
                  m.tinta.equals(tinta),
            )
            ..orderBy([(m) => OrderingTerm.desc(m.la)]))
          .get();

  // ── Instrumente ───────────────────────────────────────────────────────────

  Stream<List<InstrumenteData>> watchInstrumente() =>
      (db.select(db.instrumente)
            ..where((i) => i.deletedAt.isNull())
            ..orderBy([(i) => OrderingTerm.asc(i.denumire)]))
          .watch();

  Future<String> adaugaInstrument(InstrumenteCompanion date) async {
    final acum = DateTime.now();
    final id = _uuid.v4();
    await db
        .into(db.instrumente)
        .insert(
          date.copyWith(
            id: Value(id),
            createdAt: Value(acum),
            updatedAt: Value(acum),
          ),
        );
    log.info('masuratori', 'Instrument adăugat', date.denumire.value);
    return id;
  }

  Future<void> stergeInstrument(String id) =>
      (db.update(db.instrumente)..where((i) => i.id.equals(id))).write(
        InstrumenteCompanion(deletedAt: Value(DateTime.now())),
      );

  /// Instrumentele cu etalonarea expirată la data dată — nu pot semna buletine.
  static List<InstrumenteData> cuEtalonareExpirata(
    List<InstrumenteData> toate, [
    DateTime? la,
  ]) {
    final data = la ?? DateTime.now();
    return toate
        .where(
          (i) => i.etalonareExpira != null && i.etalonareExpira!.isBefore(data),
        )
        .toList();
  }

  // ── Fotografii ────────────────────────────────────────────────────────────

  Stream<List<PozeData>> watchPoze(String lucrareId) =>
      (db.select(db.poze)
            ..where((p) => p.lucrareId.equals(lucrareId) & p.deletedAt.isNull())
            ..orderBy([(p) => OrderingTerm.desc(p.facutaLa)]))
          .watch();

  Future<String> adaugaPoza(PozeCompanion date) async {
    final acum = DateTime.now();
    final id = _uuid.v4();
    await db
        .into(db.poze)
        .insert(
          date.copyWith(
            id: Value(id),
            createdAt: Value(acum),
            updatedAt: Value(acum),
          ),
        );
    log.info(
      'poze',
      'Fotografie adăugată',
      '${date.sectiune.value} · ${date.marimeBytes.present ? date.marimeBytes.value : 0} octeți',
    );
    return id;
  }

  Future<void> stergePoza(String id) =>
      (db.update(db.poze)..where((p) => p.id.equals(id))).write(
        PozeCompanion(deletedAt: Value(DateTime.now())),
      );
}
