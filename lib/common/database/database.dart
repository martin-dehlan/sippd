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
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1) {
        // Additive: keep existing wines, add canonical grape columns +
        // new catalog table. Backfill grape_freetext from the legacy
        // free-text column so old rows show up the same way until the
        // user re-edits and picks a canonical variety.
        await m.addColumn(winesTable, winesTable.canonicalGrapeId);
        await m.addColumn(winesTable, winesTable.grapeFreetext);
        await m.createTable(canonicalGrapeTable);
        await customStatement(
          "UPDATE wines SET grape_freetext = grape "
          "WHERE grape IS NOT NULL AND grape != '' AND grape_freetext IS NULL",
        );
      }
      if (from <= 2) {
        // Adds the canonical_wine_id FK column. The actual canonical
        // catalog stays server-side — only the FK lives locally so
        // wines round-trip cleanly to and from Supabase.
        await m.addColumn(winesTable, winesTable.canonicalWineId);
      }
      if (from <= 3) {
        // Local mirror of the Supabase profile so the router and profile
        // screens render immediately on cold-start, including offline.
        await m.createTable(profilesTable);
      }
      if (from <= 4) {
        // Outbox for image uploads. Without it, an upload that fails
        // (offline, transient 5xx) silently leaves the wine row with
        // imageUrl = null forever. The OutboxFlusher reads this on
        // launch + connectivity flips and retries with backoff.
        await m.createTable(pendingImageUploadsTable);
      }
      if (from <= 5) {
        // Heal: PendingImageUploadsDao.recordFailure used to write
        // ISO-8601 strings into a DateTime column (Drift expects int).
        // Existing rows from v5 with corrupted last_error_at would
        // crash the next due() read. Cheaper to drop the in-flight
        // queue (max ~5 retries per wine) than to pick through every
        // row defensively. Fresh users are unaffected.
        await customStatement('DROP TABLE IF EXISTS pending_image_uploads');
        await m.createTable(pendingImageUploadsTable);
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
