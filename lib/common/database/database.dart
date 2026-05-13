import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/wines.table.dart';
import 'tables/wine_memories.table.dart';
import 'tables/wine_memory_photos.table.dart';
import 'tables/wine_aliases.table.dart';
import 'tables/notification_prefs.table.dart';
import 'tables/canonical_grape.table.dart';
import 'tables/profiles.table.dart';
import 'tables/pending_image_uploads.table.dart';
import 'tables/rating_summary_cache.table.dart';
import 'daos/wines.dao.dart';
import 'daos/wine_memories.dao.dart';
import 'daos/wine_memory_photos.dao.dart';
import 'daos/wine_aliases.dao.dart';
import 'daos/notification_prefs.dao.dart';
import 'daos/canonical_grape.dao.dart';
import 'daos/profiles.dao.dart';
import 'daos/pending_image_uploads.dao.dart';
import 'daos/rating_summary_cache.dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    WinesTable,
    WineMemoriesTable,
    WineMemoryPhotosTable,
    WineAliasesTable,
    NotificationPrefsTable,
    CanonicalGrapeTable,
    ProfilesTable,
    PendingImageUploadsTable,
    RatingSummaryCacheTable,
  ],
  daos: [
    WinesDao,
    WineMemoriesDao,
    WineMemoryPhotosDao,
    WineAliasesDao,
    NotificationPrefsDao,
    CanonicalGrapeDao,
    ProfilesDao,
    PendingImageUploadsDao,
    RatingSummaryCacheDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-only constructor. Tests pass `NativeDatabase.memory()` so
  /// they get an isolated, schema-fresh DB without touching disk.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(ratingSummaryCacheTable);
      }
      if (from < 3) {
        // Wine Moments phase 1 — extend wine_memories with moment
        // context fields and add wine_memory_photos sibling table.
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.occurredAt);
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.occasion);
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.placeName);
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.placeLat);
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.placeLng);
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.foodPaired);
        await m.addColumn(
          wineMemoriesTable,
          wineMemoriesTable.companionUserIds,
        );
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.note);
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.visibility);
        await m.addColumn(wineMemoriesTable, wineMemoriesTable.updatedAt);
        await m.createTable(wineMemoryPhotosTable);
      }
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
