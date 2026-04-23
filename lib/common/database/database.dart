import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/wines.table.dart';
import 'tables/wine_memories.table.dart';
import 'tables/wine_aliases.table.dart';
import 'daos/wines.dao.dart';
import 'daos/wine_memories.dao.dart';
import 'daos/wine_aliases.dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [WinesTable, WineMemoriesTable, WineAliasesTable],
  daos: [WinesDao, WineMemoriesDao, WineAliasesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Beta wipe-and-recreate: schema evolves quickly while pre-launch.
          // Existing local data is discarded; Supabase re-sync repopulates.
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
