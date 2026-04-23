import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/wine_aliases.table.dart';

part 'wine_aliases.dao.g.dart';

@DriftAccessor(tables: [WineAliasesTable])
class WineAliasesDao extends DatabaseAccessor<AppDatabase>
    with _$WineAliasesDaoMixin {
  WineAliasesDao(super.db);

  Future<WineAliasTableData?> getAlias({
    required String userId,
    required String localWineId,
  }) {
    return (select(wineAliasesTable)
          ..where((t) =>
              t.userId.equals(userId) & t.localWineId.equals(localWineId)))
        .getSingleOrNull();
  }

  Future<void> upsert(WineAliasesTableCompanion alias) {
    return into(wineAliasesTable).insertOnConflictUpdate(alias);
  }

  Future<void> upsertAll(List<WineAliasesTableCompanion> aliases) async {
    await batch((b) => b.insertAllOnConflictUpdate(wineAliasesTable, aliases));
  }

  Future<void> deleteAlias({
    required String userId,
    required String localWineId,
  }) {
    return (delete(wineAliasesTable)
          ..where((t) =>
              t.userId.equals(userId) & t.localWineId.equals(localWineId)))
        .go();
  }
}
