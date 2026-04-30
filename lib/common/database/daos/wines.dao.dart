import 'package:drift/drift.dart';
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
    return (select(winesTable)..where((w) => w.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertWine(WineTableData wine) {
    return into(winesTable).insertOnConflictUpdate(wine);
  }

  /// Insert/update with is_synced explicitly false. Used for local writes
  /// before the remote upload completes.
  Future<void> insertWineUnsynced(WineTableData wine) {
    final companion = wine.toCompanion(true).copyWith(
      isSynced: const Value(false),
    );
    return into(winesTable).insertOnConflictUpdate(companion);
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

  Future<List<WineTableData>> getUnsynced() {
    return (select(winesTable)..where((w) => w.isSynced.equals(false))).get();
  }

  Future<int> countUnsynced() async {
    final rows = await getUnsynced();
    return rows.length;
  }

  Future<void> markSynced(String id) {
    return (update(winesTable)..where((w) => w.id.equals(id))).write(
      const WinesTableCompanion(isSynced: Value(true)),
    );
  }

  Stream<List<WineTableData>> watchAllWines() => select(winesTable).watch();

  Stream<List<WineTableData>> watchWinesByUser(String userId) {
    return (select(winesTable)..where((w) => w.userId.equals(userId))).watch();
  }

  Stream<WineTableData?> watchWineById(String id) {
    return (select(winesTable)..where((w) => w.id.equals(id)))
        .watchSingleOrNull();
  }
}
