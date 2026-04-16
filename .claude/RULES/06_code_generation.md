# Code Generation Rules

**TL;DR:** Three code-gen systems in play — Freezed (entities + models), Riverpod Generator (providers), Drift (tables + DAOs). Each requires its own `part` directive. Run `build_runner` after any change to annotated files.

---

## Overview

| Tool | Annotation | Output |
|---|---|---|
| Freezed | `@freezed` | `.freezed.dart` |
| json_serializable | `@JsonSerializable` | `.g.dart` (via Freezed) |
| Riverpod Generator | `@riverpod` | `.g.dart` |
| Drift | `@DriftDatabase`, `@DriftAccessor` | `.g.dart` |

---

## Freezed: Entities (no JSON)

Domain entities have no JSON serialization — they never touch the network directly.

```dart
// lib/features/wine/domain/wine.entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wine.entity.freezed.dart';

@freezed
class WineEntity with _$WineEntity {
  const factory WineEntity({
    required String id,
    required String name,
    required String winery,
    required String region,
    int?    vintage,
    double? rating,
    String? notes,
    String? imageUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WineEntity;
}
```

Rules:
- No `@JsonKey`, no `fromJson`, no `toJson`
- No `part 'wine.entity.g.dart'` — only `.freezed.dart`
- No JSON serialization on entities — that lives in models

---

## Freezed: Models (with JSON)

Models are the data/API layer. They map to Supabase column names.

```dart
// lib/features/wine/data/wine.model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wine.model.freezed.dart';
part 'wine.model.g.dart';

@freezed
class WineModel with _$WineModel {
  const factory WineModel({
    required String id,
    required String name,
    required String winery,
    required String region,
    int?    vintage,
    double? rating,
    String? notes,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'user_id')    required String userId,
  }) = _WineModel;

  factory WineModel.fromJson(Map<String, dynamic> json) =>
      _$WineModelFromJson(json);
}
```

Rules:
- Two `part` directives: `.freezed.dart` AND `.g.dart`
- Use `@JsonKey(name: 'snake_case')` to map Supabase column names
- Always include `fromJson` factory
- `toJson()` is auto-generated

---

## Model → Entity Conversion

Define as an extension on the model:

```dart
// lib/features/wine/data/wine.model.dart (bottom of file)
// or in a separate wine.mapper.dart

extension WineModelX on WineModel {
  WineEntity toEntity() => WineEntity(
    id:        id,
    name:      name,
    winery:    winery,
    region:    region,
    vintage:   vintage,
    rating:    rating,
    notes:     notes,
    imageUrl:  imageUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension WineEntityX on WineEntity {
  WineModel toModel() => WineModel(
    id:        id,
    name:      name,
    winery:    winery,
    region:    region,
    vintage:   vintage,
    rating:    rating,
    notes:     notes,
    imageUrl:  imageUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    userId:    '', // injected by repository
  );
}
```

---

## TableData → Entity Conversion

Extension on the Drift-generated row type:

```dart
// lib/common/database/tables/wine.table.dart (bottom of file)

extension WineTableDataX on WineTableData {
  WineEntity toEntity() => WineEntity(
    id:        id,
    name:      name,
    winery:    winery,
    region:    region,
    vintage:   vintage,
    rating:    rating,
    notes:     notes,
    imageUrl:  imageUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
```

---

## Riverpod Generator

```dart
// lib/features/wine/controller/wine.provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wine.provider.g.dart';  // ← required

@riverpod
WineRepository wineRepository(Ref ref) { ... }

@riverpod
class WineController extends _$WineController {
  @override
  Future<List<WineEntity>> build() async { ... }
}
```

---

## Drift

```dart
// lib/common/database/app_database.dart
part 'app_database.g.dart';  // ← required

@DriftDatabase(tables: [...], daos: [...])
class AppDatabase extends _$AppDatabase { ... }

// lib/common/database/daos/wine.dao.dart
part 'wine.dao.g.dart';  // ← required

@DriftAccessor(tables: [WineTable])
class WineDao extends DatabaseAccessor<AppDatabase> with _$WineDaoMixin { ... }
```

---

## Build Runner Commands

```bash
# Full build (clean + regenerate everything)
dart run build_runner build --delete-conflicting-outputs

# Incremental (fast, for daily use)
dart run build_runner build

# Watch mode (auto-rebuild on save)
dart run build_runner watch --delete-conflicting-outputs

# Clean generated files
dart run build_runner clean
```

---

## Common Errors & Fixes

| Error | Cause | Fix |
|---|---|---|
| `Missing 'part' directive` | Forgot `part 'file.g.dart'` | Add the correct `part` line |
| `_$ClassName not found` | Build not run yet | Run `build_runner build` |
| `Duplicate output` | Stale `.g.dart` files | Run with `--delete-conflicting-outputs` |
| `fromJson not generated` | Missing `fromJson` factory on `@freezed` class | Add `factory X.fromJson(Map<String,dynamic> json) => _$XFromJson(json);` |
| `@riverpod on non-class` | Using class syntax for simple provider | Use function form for simple providers |
| Drift `mixin not found` | Wrong mixin name | Check generated file — mixin is `_$ClassNameMixin` |
| Drift schema version error | Changed table without migration | Increment `schemaVersion` and add `MigrationStrategy` |

---

## Rules Checklist

- [ ] Entities: only `.freezed.dart` part, no JSON
- [ ] Models: both `.freezed.dart` and `.g.dart` parts, have `fromJson`
- [ ] Use `@JsonKey(name: ...)` for snake_case Supabase columns
- [ ] Conversion extensions defined (Model↔Entity, TableData→Entity)
- [ ] Run `build_runner` after every annotation change before testing
- [ ] Never hand-edit `.g.dart` or `.freezed.dart` files
