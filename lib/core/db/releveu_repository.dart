import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../services/log_service.dart';
import 'database.dart';

const _uuid = Uuid();

/// Releveul unei fișe, cu tot ce ține de el: plane de montaj, obstacole,
/// tabloul existent și traseele măsurate.
class ReleveuComplet {
  final ReleveeData releveu;
  final List<PlanCuObstacole> plane;
  final TablouriExistenteData? tablou;
  final List<TraseeData> trasee;

  const ReleveuComplet({
    required this.releveu,
    required this.plane,
    required this.tablou,
    required this.trasee,
  });

  double get suprafataTotalaM2 =>
      plane.fold(0, (s, p) => s + p.plan.lungimeM * p.plan.latimeM);
}

class PlanCuObstacole {
  final PlaneMontajData plan;
  final List<ObstacoleData> obstacole;
  const PlanCuObstacole({required this.plan, required this.obstacole});
}

class ReleveuRepository {
  ReleveuRepository(this.db);
  final AppDatabase db;

  Stream<ReleveuComplet?> watchPentruLucrare(String lucrareId) {
    final q = db.select(db.relevee)
      ..where((r) => r.lucrareId.equals(lucrareId));
    return q.watchSingleOrNull().asyncMap((r) async {
      if (r == null) return null;
      return incarca(r);
    });
  }

  Future<ReleveuComplet> incarca(ReleveeData r) async {
    final plane =
        await (db.select(db.planeMontaj)
              ..where((p) => p.releveuId.equals(r.id) & p.deletedAt.isNull())
              ..orderBy([(p) => OrderingTerm.asc(p.ordine)]))
            .get();
    final obstacole = await (db.select(
      db.obstacole,
    )..where((o) => o.deletedAt.isNull())).get();
    final tablou = await (db.select(
      db.tablouriExistente,
    )..where((t) => t.releveuId.equals(r.id))).getSingleOrNull();
    final trasee = await (db.select(
      db.trasee,
    )..where((t) => t.releveuId.equals(r.id) & t.deletedAt.isNull())).get();
    return ReleveuComplet(
      releveu: r,
      plane: [
        for (final p in plane)
          PlanCuObstacole(
            plan: p,
            obstacole: obstacole.where((o) => o.planId == p.id).toList(),
          ),
      ],
      tablou: tablou,
      trasee: trasee,
    );
  }

  /// Releveul existent sau unul nou, gol — deschis la prima intrare în ecran.
  Future<ReleveeData> asigura(String lucrareId, {String operator = ''}) async {
    final existent = await (db.select(
      db.relevee,
    )..where((r) => r.lucrareId.equals(lucrareId))).getSingleOrNull();
    if (existent != null) return existent;
    final acum = DateTime.now();
    final rand = await db
        .into(db.relevee)
        .insertReturning(
          ReleveeCompanion.insert(
            id: _uuid.v4(),
            createdAt: acum,
            updatedAt: acum,
            lucrareId: lucrareId,
            data: acum,
            operator: Value(operator),
          ),
        );
    log.info('releveu', 'Releveu deschis', lucrareId);
    return rand;
  }

  Future<void> actualizeaza(String id, ReleveeCompanion date) =>
      db.transaction(() async {
        await (db.update(db.relevee)..where((r) => r.id.equals(id))).write(
          date.copyWith(
            updatedAt: Value(DateTime.now()),
            version: const Value.absent(),
          ),
        );
        await db.customUpdate(
          'UPDATE relevee SET version = version + 1 WHERE id = ?',
          variables: [Variable.withString(id)],
          updates: {db.relevee},
        );
        log.info('releveu', 'Releveu actualizat', id);
      });

  // ── Plane de montaj ───────────────────────────────────────────────────────

  Future<String> adaugaPlan(PlaneMontajCompanion date) async {
    final acum = DateTime.now();
    final id = _uuid.v4();
    await db
        .into(db.planeMontaj)
        .insert(
          date.copyWith(
            id: Value(id),
            createdAt: Value(acum),
            updatedAt: Value(acum),
          ),
        );
    log.info('releveu', 'Plan de montaj adăugat', date.denumire.value);
    return id;
  }

  Future<void> actualizeazaPlan(String id, PlaneMontajCompanion date) =>
      db.transaction(() async {
        await (db.update(db.planeMontaj)..where((p) => p.id.equals(id))).write(
          date.copyWith(
            updatedAt: Value(DateTime.now()),
            version: const Value.absent(),
          ),
        );
        await db.customUpdate(
          'UPDATE plane_montaj SET version = version + 1 WHERE id = ?',
          variables: [Variable.withString(id)],
          updates: {db.planeMontaj},
        );
        log.info('releveu', 'Plan actualizat', id);
      });

  Future<void> stergePlan(String id) => db.transaction(() async {
    await (db.update(db.obstacole)..where((o) => o.planId.equals(id))).write(
      ObstacoleCompanion(deletedAt: Value(DateTime.now())),
    );
    await (db.update(db.planeMontaj)..where((p) => p.id.equals(id))).write(
      PlaneMontajCompanion(deletedAt: Value(DateTime.now())),
    );
    log.info('releveu', 'Plan șters', id);
  });

  // ── Obstacole ─────────────────────────────────────────────────────────────

  Future<String> adaugaObstacol(ObstacoleCompanion date) async {
    final acum = DateTime.now();
    final id = _uuid.v4();
    await db
        .into(db.obstacole)
        .insert(
          date.copyWith(
            id: Value(id),
            createdAt: Value(acum),
            updatedAt: Value(acum),
          ),
        );
    log.info('releveu', 'Obstacol adăugat', date.tip.value);
    return id;
  }

  Future<void> stergeObstacol(String id) =>
      (db.update(db.obstacole)..where((o) => o.id.equals(id))).write(
        ObstacoleCompanion(deletedAt: Value(DateTime.now())),
      );

  // ── Tablou și trasee ──────────────────────────────────────────────────────

  Future<void> salveazaTablou(
    String releveuId,
    TablouriExistenteCompanion date,
  ) async {
    final acum = DateTime.now();
    final existent = await (db.select(
      db.tablouriExistente,
    )..where((t) => t.releveuId.equals(releveuId))).getSingleOrNull();
    if (existent == null) {
      await db
          .into(db.tablouriExistente)
          .insert(
            date.copyWith(
              id: Value(_uuid.v4()),
              releveuId: Value(releveuId),
              createdAt: Value(acum),
              updatedAt: Value(acum),
            ),
          );
    } else {
      await (db.update(
        db.tablouriExistente,
      )..where((t) => t.id.equals(existent.id))).write(
        date.copyWith(updatedAt: Value(acum), version: const Value.absent()),
      );
    }
    log.info('releveu', 'Tablou existent salvat', releveuId);
  }

  Future<void> salveazaTrasee(
    String releveuId,
    Map<String, double> lungimi,
  ) async {
    final acum = DateTime.now();
    await db.transaction(() async {
      final existente = await (db.select(
        db.trasee,
      )..where((t) => t.releveuId.equals(releveuId))).get();
      for (final e in lungimi.entries) {
        final rand = existente.where((t) => t.segment == e.key).firstOrNull;
        if (rand == null) {
          await db
              .into(db.trasee)
              .insert(
                TraseeCompanion.insert(
                  id: _uuid.v4(),
                  createdAt: acum,
                  updatedAt: acum,
                  releveuId: releveuId,
                  segment: e.key,
                  lungimeM: Value(e.value),
                ),
              );
        } else {
          await (db.update(
            db.trasee,
          )..where((t) => t.id.equals(rand.id))).write(
            TraseeCompanion(
              lungimeM: Value(e.value),
              updatedAt: Value(acum),
              deletedAt: const Value(null),
            ),
          );
        }
      }
    });
    log.info('releveu', 'Trasee salvate', '${lungimi.length} segmente');
  }
}
