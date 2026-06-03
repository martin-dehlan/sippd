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
import 'tables/badge_progress_cache.table.dart';
import 'daos/wines.dao.dart';
import 'daos/wine_memories.dao.dart';
import 'daos/wine_memory_photos.dao.dart';
import 'daos/wine_aliases.dao.dart';
import 'daos/notification_prefs.dao.dart';
import 'daos/canonical_grape.dao.dart';
import 'daos/profiles.dao.dart';
import 'daos/pending_image_uploads.dao.dart';
import 'daos/rating_summary_cache.dao.dart';
import 'daos/badge_progress_cache.dao.dart';

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
    BadgeProgressCacheTable,
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
    BadgeProgressCacheDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-only constructor. Tests pass `NativeDatabase.memory()` so
  /// they get an isolated, schema-fresh DB without touching disk.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // v3 (shipped in 0.1.12..0.1.18) tried `addColumn(occurredAt)` and
      // `addColumn(updatedAt)` whose default is `currentDateAndTime`.
      // SQLite forbids non-constant DEFAULTs in ALTER TABLE ADD COLUMN, so
      // the whole migration aborted mid-flight on every existing install,
      // leaving DB in a half-applied state (rating_summary_cache created,
      // user_version still 1). Subsequent opens looped on the same failure
      // → DAOs unusable → wines/grapes/add-wine all broken.
      //
      // v4 replaces the migration with an idempotent path: every step
      // PRAGMA-checks first, and the two timestamp columns use a constant
      // DEFAULT 0 plus a backfill to `now`. Runs for any from < 4 so users
      // stuck on partial-v3 recover, and fresh-but-healthy v3 users no-op.
      if (from < 4) {
        await _migrateToV4();
      }
      if (from < 5) {
        await _migrateToV5();
      }
    },
  );

  /// v5 adds the badge progress cache (JSON payload per user). Idempotent —
  /// PRAGMA-checked so a re-run on a partially-migrated DB no-ops.
  Future<void> _migrateToV5() async {
    if (!await _tableExists('badge_progress_cache')) {
      await customStatement(
        'CREATE TABLE badge_progress_cache ('
        'user_id TEXT NOT NULL PRIMARY KEY, '
        'payload TEXT NOT NULL, '
        'fetched_at INTEGER NOT NULL)',
      );
    }
  }

  Future<void> _migrateToV4() async {
    // From v1 — defensive in case the broken v3 upgrade created it already.
    if (!await _tableExists('rating_summary_cache')) {
      await customStatement(
        'CREATE TABLE rating_summary_cache ('
        'user_id TEXT NOT NULL PRIMARY KEY, '
        'payload TEXT NOT NULL, '
        'fetched_at INTEGER NOT NULL)',
      );
    }

    // wine_memories expansion — split timestamp columns (non-constant
    // default) from the rest (safe addColumn).
    await _addColumnSafe(
      'wine_memories',
      'occurred_at',
      'INTEGER NOT NULL DEFAULT 0',
    );
    await customStatement(
      "UPDATE wine_memories SET occurred_at = "
      "CAST(strftime('%s','now') AS INTEGER) WHERE occurred_at = 0",
    );
    await _addColumnSafe(
      'wine_memories',
      'updated_at',
      'INTEGER NOT NULL DEFAULT 0',
    );
    await customStatement(
      "UPDATE wine_memories SET updated_at = "
      "CAST(strftime('%s','now') AS INTEGER) WHERE updated_at = 0",
    );

    // Remaining columns are nullable or have constant defaults.
    await _addColumnSafe('wine_memories', 'occasion', 'TEXT');
    await _addColumnSafe('wine_memories', 'place_name', 'TEXT');
    await _addColumnSafe('wine_memories', 'place_lat', 'REAL');
    await _addColumnSafe('wine_memories', 'place_lng', 'REAL');
    await _addColumnSafe('wine_memories', 'food_paired', 'TEXT');
    await _addColumnSafe(
      'wine_memories',
      'companion_user_ids',
      "TEXT NOT NULL DEFAULT '[]'",
    );
    await _addColumnSafe('wine_memories', 'note', 'TEXT');
    await _addColumnSafe(
      'wine_memories',
      'visibility',
      "TEXT NOT NULL DEFAULT 'friends'",
    );

    if (!await _tableExists('wine_memory_photos')) {
      await customStatement(
        'CREATE TABLE wine_memory_photos ('
        'id TEXT NOT NULL PRIMARY KEY, '
        'memory_id TEXT NOT NULL, '
        'storage_path TEXT NOT NULL, '
        'position INTEGER NOT NULL DEFAULT 0, '
        'created_at INTEGER NOT NULL DEFAULT (CAST(strftime(\'%s\',\'now\') AS INTEGER)))',
      );
    }
  }

  Future<bool> _tableExists(String name) async {
    final rows = await customSelect(
      "SELECT name FROM sqlite_master WHERE type='table' AND name = ?",
      variables: [Variable<String>(name)],
    ).get();
    return rows.isNotEmpty;
  }

  Future<bool> _columnExists(String table, String column) async {
    final rows = await customSelect('PRAGMA table_info($table)').get();
    return rows.any((r) => r.read<String>('name') == column);
  }

  Future<void> _addColumnSafe(
    String table,
    String column,
    String typeAndConstraints,
  ) async {
    if (await _columnExists(table, column)) return;
    await customStatement(
      'ALTER TABLE $table ADD COLUMN $column $typeAndConstraints',
    );
  }

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
