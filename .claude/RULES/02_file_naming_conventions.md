# File & Class Naming Conventions

**TL;DR:** Use `name.type.dart` for files, `NameType` for classes. One widget per file. Match folder structure to feature/layer.

---

## File Naming Pattern

```
name.type.dart
```

### Recognized Type Suffixes

| Suffix | Example | Purpose |
|---|---|---|
| `.entity.dart` | `wine.entity.dart` | Domain model (Freezed, no JSON) |
| `.model.dart` | `wine.model.dart` | Data/API model (Freezed + JSON) |
| `.repository.dart` | `wine.repository.dart` | Abstract repository interface |
| `.repository.impl.dart` | `wine.repository.impl.dart` | Concrete repository implementation |
| `.api.dart` | `wine.api.dart` | Supabase/REST API calls |
| `.dao.dart` | `wine.dao.dart` | Drift database access object |
| `.provider.dart` | `wine.provider.dart` | All Riverpod providers for a feature |
| `.controller.dart` | `wine.controller.dart` | AsyncNotifier / StateNotifier |
| `.screen.dart` | `wine_list.screen.dart` | Full-screen routable widget |
| `.widget.dart` | `wine_card.widget.dart` | Reusable sub-widget |
| `.routes.dart` | `wine.routes.dart` | Feature route definitions |
| `.usecase.dart` | `add_wine.usecase.dart` | Single-purpose domain use case |
| `.service.dart` | `auth.service.dart` | Cross-feature service |

---

## Class Naming

File suffix maps directly to class name suffix:

```dart
// wine.entity.dart
class WineEntity { ... }

// wine.model.dart
class WineModel { ... }

// wine.repository.dart
abstract class WineRepository { ... }

// wine.repository.impl.dart
class WineRepositoryImpl implements WineRepository { ... }

// wine.dao.dart
class WineDao extends DatabaseAccessor<AppDatabase> { ... }

// wine.provider.dart  ← all providers for this feature live here
final wineListProvider = ...
final wineDetailProvider = ...

// wine.controller.dart
class WineController extends AsyncNotifier<List<WineEntity>> { ... }
```

### Use Case Naming

Pattern: `ActionEntityUseCase`

```dart
// add_wine.usecase.dart
class AddWineUseCase { ... }

// delete_wine.usecase.dart
class DeleteWineUseCase { ... }

// rank_wine.usecase.dart
class RankWineUseCase { ... }
```

### Provider Naming

Pattern: `entityTypeProvider` (camelCase)

```dart
final wineListProvider = ...         // list of wines
final wineDetailProvider = ...       // single wine by id
final wineControllerProvider = ...   // notifier
final authStateProvider = ...        // auth state
```

---

## Folder Structure

```
lib/
  features/
    wine/
      data/
        wine.model.dart
        wine.api.dart
        wine.repository.impl.dart
      domain/
        wine.entity.dart
        wine.repository.dart
        add_wine.usecase.dart
        rank_wine.usecase.dart
      controller/
        wine.controller.dart
        wine.provider.dart          ← ALL providers for this feature
      presentation/
        screens/
          wine_list.screen.dart
          wine_detail.screen.dart
        widgets/
          wine_card.widget.dart
          wine_rating_bar.widget.dart
        wine.routes.dart
    groups/
      ...
    profile/
      ...
  common/
    database/
      tables/
        wine.table.dart
        group.table.dart
      daos/
        wine.dao.dart
        group.dao.dart
      app_database.dart
    utils/
      responsive.dart
    errors/
      app_error.dart
    widgets/
      error_state.widget.dart
      loading_state.widget.dart
```

---

## Rules

- **One widget per file.** `WineCard` lives in `wine_card.widget.dart`, not alongside `WineList`.
- **One class per file** for entities, models, repositories, DAOs.
- **One provider file per feature** — `wine.provider.dart` contains all `wineXxxProvider` declarations for that feature.
- **Sub-folders only when 5+ related files** exist in the same layer. Don't pre-create empty folders.
- Screen files always end in `.screen.dart`, never just `wine_list.dart`.
- Never put providers in the same file as a controller — always separate `.provider.dart`.
