import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/wine_memories.table.dart';

part 'wine_memories.dao.g.dart';

@DriftAccessor(tables: [WineMemoriesTable])
class WineMemoriesDao extends DatabaseAccessor<AppDatabase>
    with _$WineMemoriesDaoMixin {
  WineMemoriesDao(super.db);

  Future<List<WineMemoryTableData>> getByWine(String wineId) {
    return (select(wineMemoriesTable)
          ..where((m) => m.wineId.equals(wineId))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
        .get();
  }

  Stream<List<WineMemoryTableData>> watchByWine(String wineId) {
    return (select(wineMemoriesTable)
          ..where((m) => m.wineId.equals(wineId))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
        .watch();
  }

  Future<void> insertMemory(WineMemoryTableData memory) {
    return into(wineMemoriesTable).insertOnConflictUpdate(memory);
  }

  Future<void> insertMemories(List<WineMemoryTableData> memories) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(wineMemoriesTable, memories);
    });
  }

  Future<void> deleteMemory(String id) {
    return (delete(wineMemoriesTable)..where((m) => m.id.equals(id))).go();
  }

  Future<void> deleteByWine(String wineId) {
    return (delete(
      wineMemoriesTable,
    )..where((m) => m.wineId.equals(wineId))).go();
  }
}
