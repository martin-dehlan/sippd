import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/wines.table.dart';
import 'tables/wine_memories.table.dart';
import 'daos/wines.dao.dart';
import 'daos/wine_memories.dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [WinesTable, WineMemoriesTable],
  daos: [WinesDao, WineMemoriesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Beta wipe-and-recreate: schema v5 drops single memory cols on
          // wines and introduces wine_memories. Existing local data is
          // discarded.
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
          }
          await m.createAll();
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'sippd_database');
  }
}
