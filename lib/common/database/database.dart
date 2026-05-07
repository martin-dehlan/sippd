import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/wines.table.dart';
import 'tables/wine_memories.table.dart';
import 'tables/wine_aliases.table.dart';
import 'tables/notification_prefs.table.dart';
import 'tables/canonical_grape.table.dart';
import 'tables/profiles.table.dart';
import 'tables/pending_image_uploads.table.dart';
import 'daos/wines.dao.dart';
import 'daos/wine_memories.dao.dart';
import 'daos/wine_aliases.dao.dart';
import 'daos/notification_prefs.dao.dart';
import 'daos/canonical_grape.dao.dart';
import 'daos/profiles.dao.dart';
import 'daos/pending_image_uploads.dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    WinesTable,
    WineMemoriesTable,
    WineAliasesTable,
    NotificationPrefsTable,
    CanonicalGrapeTable,
    ProfilesTable,
    PendingImageUploadsTable,
  ],
  daos: [
    WinesDao,
    WineMemoriesDao,
    WineAliasesDao,
    NotificationPrefsDao,
    CanonicalGrapeDao,
    ProfilesDao,
    PendingImageUploadsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-only constructor. Tests pass `NativeDatabase.memory()` so
  /// they get an isolated, schema-fresh DB without touching disk.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
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
