# Drift Database Rules (Local-First)

**TL;DR:** Drift is the single source of truth. Supabase is a sync backend only. All UI reads come from Drift. Never return Supabase data directly to the UI.

---

## Architecture: Local-First Flow

```
UI
 ↓ triggers action
Repository
 ↓ 1. fetch from Supabase
 ↓ 2. save to Drift
 ↓ 3. return/watch from Drift
UI ← stream/future from Drift
```

On network failure → fall back to local Drift data.  
Never expose raw Supabase responses to the controller or UI layer.

---

## Folder Structure

```
lib/
  common/
    database/
      tables/
        wine.table.dart
        group.table.dart
        wine_group.table.dart        ← join tables follow same pattern
      daos/
        wine.dao.dart
        group.dao.dart
      app_database.dart              ← single AppDatabase class
```

---

## Table Definition Pattern

File: `lib/common/database/tables/wine.table.dart`

```dart
import 'package:drift/drift.dart';

@DataClassName('WineTableData')
class WineTable extends Table {
  @override
  String get tableName => 'wines';

  TextColumn get id       => text()();
  TextColumn get name     => text()();
  TextColumn get winery   => text()();
  TextColumn get region   => text()();
  IntColumn  get vintage  => integer().nullable()();
  RealColumn get rating   => real().nullable()();
  TextColumn get notes    => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get userId => text()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}
```

Rules:
- Class name: `EntityTable` (e.g. `WineTable`, `GroupTable`)
- Always add `@DataClassName('EntityTableData')` — generated row class becomes `WineTableData`
- Add `isSynced` flag for optimistic local writes
- Use `text()` for IDs — UUIDs from Supabase
- Add `createdAt` / `updatedAt` on every table

---

## AppDatabase

File: `lib/common/database/app_database.dart`

```dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/wine.table.dart';
import 'tables/group.table.dart';
import 'daos/wine.dao.dart';
import 'daos/group.dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [WineTable, GroupTable],
  daos: [WineDao, GroupDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'sippd_db');
  }
}
```

---

## DAO Pattern

File: `lib/common/database/daos/wine.dao.dart`

```dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/wine.table.dart';

part 'wine.dao.g.dart';

@DriftAccessor(tables: [WineTable])
class WineDao extends DatabaseAccessor<AppDatabase> with _$WineDaoMixin {
  WineDao(super.db);

  // Watch all wines for current user (reactive stream)
  Stream<List<WineTableData>> watchWinesByUser(String userId) {
    return (select(wineTable)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch();
  }

  // Single wine by ID
  Future<WineTableData?> getWineById(String id) {
    return (select(wineTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  // Insert or replace
  Future<void> upsertWine(WineTableCompanion wine) {
    return into(wineTable).insertOnConflictUpdate(wine);
  }

  // Upsert many (from Supabase sync)
  Future<void> upsertWines(List<WineTableCompanion> wines) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(wineTable, wines);
    });
  }

  // Delete
  Future<int> deleteWine(String id) {
    return (delete(wineTable)..where((t) => t.id.equals(id))).go();
  }

  // Mark as synced
  Future<void> markSynced(String id) {
    return (update(wineTable)..where((t) => t.id.equals(id))).write(
      const WineTableCompanion(isSynced: Value(true)),
    );
  }
}
```

---

## Repository Pattern

File: `lib/features/wine/data/wine.repository.impl.dart`

```dart
class WineRepositoryImpl implements WineRepository {
  const WineRepositoryImpl({
    required WineApi api,
    required WineDao dao,
  });

  @override
  Stream<List<WineEntity>> watchWines(String userId) {
    // 1. Trigger background sync (fire and forget)
    _syncFromSupabase(userId);
    // 2. Return local stream immediately
    return dao.watchWinesByUser(userId).map(
      (rows) => rows.map((r) => r.toEntity()).toList(),
    );
  }

  @override
  Future<void> addWine(WineEntity wine) async {
    // Optimistic local write first
    await dao.upsertWine(wine.toCompanion(isSynced: false));
    // Then sync to Supabase
    try {
      await api.createWine(wine.toModel());
      await dao.markSynced(wine.id);
    } catch (e) {
      // Local write stays; will retry on next sync
    }
  }

  Future<void> _syncFromSupabase(String userId) async {
    try {
      final models = await api.fetchWines(userId);
      final companions = models.map((m) => m.toCompanion()).toList();
      await dao.upsertWines(companions);
    } catch (_) {
      // Silently fall back to local data already in stream
    }
  }
}
```

---

## Conversion Helpers

Define `toEntity()` on `WineTableData` and `toCompanion()` on `WineEntity` as extensions:

```dart
// In wine.entity.dart or a separate wine.mapper.dart
extension WineTableDataX on WineTableData {
  WineEntity toEntity() => WineEntity(
    id: id,
    name: name,
    winery: winery,
    region: region,
    vintage: vintage,
    rating: rating,
    notes: notes,
    imageUrl: imageUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension WineEntityX on WineEntity {
  WineTableCompanion toCompanion({bool isSynced = true}) =>
    WineTableCompanion(
      id:        Value(id),
      name:      Value(name),
      winery:    Value(winery),
      region:    Value(region),
      vintage:   Value(vintage),
      rating:    Value(rating),
      notes:     Value(notes),
      imageUrl:  Value(imageUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced:  Value(isSynced),
    );
}
```

---

## Build Commands

```bash
# Generate Drift code (run after changing tables or DAOs)
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs
```

---

## Rules Checklist

- [ ] UI never reads from Supabase directly
- [ ] Every table has `isSynced`, `createdAt`, `updatedAt`
- [ ] DAOs have both `watch*` (Stream) and `get*` (Future) variants
- [ ] Repositories do optimistic local write before Supabase call
- [ ] Network failures are caught silently; local data serves as fallback
- [ ] Migrations increment `schemaVersion` and use `MigrationStrategy`
