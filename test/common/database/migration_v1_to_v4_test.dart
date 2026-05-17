import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/database/database.dart';

/// Regression test for the v1→v3 migration outage that left existing
/// store users (0.1.11+12) unable to load wines, pick grapes, or save
/// new wines. The original v3 migration called `addColumn(occurredAt)`
/// whose `currentDateAndTime` default compiles to a non-constant SQL
/// expression — SQLite rejects that in ALTER TABLE ADD COLUMN and the
/// whole upgrade aborted, leaving DAOs in error state on every open.
///
/// The v4 migration replaces that path with PRAGMA-guarded ALTERs and
/// constant defaults + backfills. These tests prove the recovery path.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('v1 → v4 migration backfills timestamps on pre-existing memories',
      () async {
    final db = AppDatabase.forTesting(
      NativeDatabase.memory(setup: (raw) {
        _seedV1Schema(raw);
        raw.execute(
          "INSERT INTO wine_memories (id, wine_id, user_id, caption, created_at) "
          "VALUES ('m1', 'w1', 'u1', 'old', "
          "CAST(strftime('%s','now') AS INTEGER) * 1000)",
        );
        raw.execute('PRAGMA user_version = 1');
      }),
    );
    addTearDown(db.close);

    // Trigger onUpgrade(1, 4) by hitting any DAO.
    final memories = await db.wineMemoriesDao.getByWine('w1');
    expect(memories, hasLength(1));
    expect(memories.first.id, 'm1');

    // Backfilled timestamps land within the last minute.
    final now = DateTime.now();
    expect(
      now.difference(memories.first.occurredAt).inMinutes,
      lessThan(1),
      reason: 'occurred_at must be backfilled to now() during migration',
    );
    expect(
      now.difference(memories.first.updatedAt).inMinutes,
      lessThan(1),
      reason: 'updated_at must be backfilled to now() during migration',
    );
    // Constant-default columns get their declared default.
    expect(memories.first.visibility, 'friends');
    expect(memories.first.companionUserIds, '[]');
  });

  test('partial-v3 stuck state recovers to v4', () async {
    // Simulates a device that hit the original v3 migration mid-way:
    // rating_summary_cache was created before addColumn(occurredAt)
    // threw, so the table exists but user_version was never bumped.
    final db = AppDatabase.forTesting(
      NativeDatabase.memory(setup: (raw) {
        _seedV1Schema(raw);
        raw.execute(
          'CREATE TABLE rating_summary_cache ('
          'user_id TEXT NOT NULL PRIMARY KEY, '
          'payload TEXT NOT NULL, '
          'fetched_at INTEGER NOT NULL)',
        );
        raw.execute('PRAGMA user_version = 1');
      }),
    );
    addTearDown(db.close);

    // No exception on the first DAO read = migration recovered.
    expect(await db.canonicalGrapeDao.getAll(), isEmpty);
    expect(await db.wineMemoryPhotosDao.getByMemory('any-id'), isEmpty);
  });

  test('fresh install (v4 onCreate) works without onUpgrade', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    expect(await db.canonicalGrapeDao.getAll(), isEmpty);
    expect(await db.wineMemoriesDao.getByWine('any'), isEmpty);
    expect(await db.wineMemoryPhotosDao.getByMemory('any'), isEmpty);
  });
}

/// Mirrors the table set as it shipped in store build 0.1.11+12
/// (schemaVersion 1). Only the columns relevant to the migration
/// regression are accurate; unrelated tables are minimal stubs so
/// post-migration DAO calls find their tables present.
void _seedV1Schema(dynamic db) {
  db.execute(
    'CREATE TABLE wine_memories ('
    'id TEXT NOT NULL PRIMARY KEY, '
    'wine_id TEXT NOT NULL, '
    'user_id TEXT NOT NULL, '
    'image_url TEXT, '
    'local_image_path TEXT, '
    'caption TEXT, '
    'created_at INTEGER NOT NULL)',
  );
  db.execute(
    'CREATE TABLE canonical_grape ('
    'id TEXT NOT NULL PRIMARY KEY, '
    'name TEXT NOT NULL, '
    'color TEXT NOT NULL, '
    "aliases TEXT NOT NULL DEFAULT '')",
  );
  db.execute(
    'CREATE TABLE wines ('
    'id TEXT NOT NULL PRIMARY KEY, '
    'name TEXT NOT NULL, '
    'rating REAL NOT NULL, '
    'type TEXT NOT NULL, '
    'user_id TEXT NOT NULL, '
    'created_at INTEGER NOT NULL)',
  );
  db.execute(
    'CREATE TABLE wine_aliases ('
    'id TEXT NOT NULL PRIMARY KEY, '
    'wine_id TEXT NOT NULL, '
    'alias TEXT NOT NULL)',
  );
  db.execute(
    'CREATE TABLE notification_prefs ('
    'user_id TEXT NOT NULL PRIMARY KEY, '
    "payload TEXT NOT NULL DEFAULT '{}')",
  );
  db.execute(
    'CREATE TABLE profiles ('
    'id TEXT NOT NULL PRIMARY KEY, '
    'username TEXT)',
  );
  db.execute(
    'CREATE TABLE pending_image_uploads ('
    'wine_id TEXT NOT NULL PRIMARY KEY, '
    'local_path TEXT NOT NULL)',
  );
}
