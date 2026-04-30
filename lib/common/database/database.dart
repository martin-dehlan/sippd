import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/wines.table.dart';
import 'tables/wine_memories.table.dart';
import 'tables/wine_aliases.table.dart';
import 'tables/notification_prefs.table.dart';
import 'daos/wines.dao.dart';
import 'daos/wine_memories.dao.dart';
import 'daos/wine_aliases.dao.dart';
import 'daos/notification_prefs.dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    WinesTable,
    WineMemoriesTable,
    WineAliasesTable,
    NotificationPrefsTable,
  ],
  daos: [WinesDao, WineMemoriesDao, WineAliasesDao, NotificationPrefsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1 && to == 2) {
        // Additive: add is_synced column on wines. Mark every existing row
        // as unsynced so the next flush sweep re-uploads them — Supabase
        // upsert is idempotent so this is safe and protects users who had
        // unsynced wines on the device before this column existed.
        await m.addColumn(winesTable, winesTable.isSynced);
        await customStatement('UPDATE wines SET is_synced = 0');
        return;
      }
      // Beta wipe-and-recreate fallback for any other path.
      for (final table in allTables) {
        await m.deleteTable(table.actualTableName);
      }
      await m.createAll();
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'sippd_database');
  }

  /// Wipes all rows across every table. Used on sign-out to prevent the next
  /// user on this device from seeing the previous session's cached data.
  Future<void> clearAll() async {
    await transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}
