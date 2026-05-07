import 'package:drift/drift.dart';
import '../../utils/name_normalizer.dart';
import '../database.dart';
import '../tables/wines.table.dart';

part 'wines.dao.g.dart';

@DriftAccessor(tables: [WinesTable])
class WinesDao extends DatabaseAccessor<AppDatabase> with _$WinesDaoMixin {
  WinesDao(super.db);

  Future<List<WineTableData>> getAllWines() => select(winesTable).get();

  Future<List<WineTableData>> getWinesByUser(String userId) {
    return (select(winesTable)..where((w) => w.userId.equals(userId))).get();
  }

  Future<List<WineTableData>> getWinesByType(String type) {
    return (select(winesTable)..where((w) => w.type.equals(type))).get();
  }

  Future<WineTableData?> getWineById(String id) {
    return (select(
      winesTable,
    )..where((w) => w.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertWine(WineTableData wine) {
    return into(winesTable).insertOnConflictUpdate(wine);
  }

  Future<void> insertWines(List<WineTableData> wines) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(winesTable, wines);
    });
  }

  Future<void> updateWine(WineTableData wine) {
    return update(winesTable).replace(wine);
  }

  Future<void> deleteWine(String id) {
    return (delete(winesTable)..where((w) => w.id.equals(id))).go();
  }

  Stream<List<WineTableData>> watchAllWines() => select(winesTable).watch();

  Stream<List<WineTableData>> watchWinesByUser(String userId) {
    return (select(winesTable)..where((w) => w.userId.equals(userId))).watch();
  }

  Stream<WineTableData?> watchWineById(String id) {
    return (select(
      winesTable,
    )..where((w) => w.id.equals(id))).watchSingleOrNull();
  }

  /// Find an existing wine for [userId] that matches the same logical
  /// bottle — same normalized name, vintage, normalized winery, and
  /// grape (canonical id when both sides have it, otherwise grape
  /// freetext / legacy `grape` column). Used by the add-wine flow to
  /// surface a "you already logged this" prompt before creating a
  /// near-identical second journal entry.
  ///
  /// Comparison is loose: nulls match nulls so users get warned about
  /// repeats even when they didn't fill optional fields.
  Future<WineTableData?> findDuplicate({
    required String userId,
    required String nameNorm,
    String? wineryNorm,
    int? vintage,
    String? canonicalGrapeId,
    String? grapeFreetext,
  }) async {
    if (nameNorm.isEmpty) return null;
    final candidates =
        await (select(winesTable)
              ..where((w) => w.userId.equals(userId))
              ..where((w) => w.nameNorm.equals(nameNorm)))
            .get();
    for (final w in candidates) {
      // Vintage must match (treat both null as a match).
      if (w.vintage != vintage) continue;
      // Winery: normalize-compare; both null counts as a match.
      final wWinery = normalizeName(w.winery);
      final inputWinery = wineryNorm ?? '';
      if (wWinery != inputWinery) continue;
      // Grape: prefer canonical id when both sides have one; otherwise
      // compare freetext/legacy strings normalized.
      if (w.canonicalGrapeId != null && canonicalGrapeId != null) {
        if (w.canonicalGrapeId != canonicalGrapeId) continue;
      } else {
        final wGrape = normalizeName(w.grapeFreetext ?? w.grape);
        final inputGrape = normalizeName(grapeFreetext);
        if (wGrape != inputGrape) continue;
      }
      return w;
    }
    return null;
  }
}
