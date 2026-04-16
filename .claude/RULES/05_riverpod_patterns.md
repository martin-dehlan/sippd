# Riverpod Patterns

**TL;DR:** Use code-gen (`@riverpod`) everywhere. All providers for a feature live in one `feature.provider.dart` file. Use `AsyncNotifier` for async state, `StreamNotifier` for reactive streams, `.family` for parameterized providers.

---

## Setup

```yaml
# pubspec.yaml
dependencies:
  flutter_riverpod: ^2.x.x
  riverpod_annotation: ^2.x.x

dev_dependencies:
  riverpod_generator: ^2.x.x
  build_runner: ^2.x.x
```

Every file using code-gen needs:
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'wine.provider.g.dart';  // or wine.controller.g.dart
```

---

## Provider Types

### Simple Provider (dependency / value)

```dart
// wine.provider.dart
@riverpod
WineRepository wineRepository(Ref ref) {
  return WineRepositoryImpl(
    api: ref.watch(wineApiProvider),
    dao:  ref.watch(appDatabaseProvider).wineDao,
  );
}
```

### AsyncNotifier (async state with actions)

Use for: load data once, expose mutating methods.

```dart
// wine.controller.dart
@riverpod
class WineController extends _$WineController {
  @override
  Future<List<WineEntity>> build() async {
    final userId = ref.watch(currentUserIdProvider);
    return ref.watch(wineRepositoryProvider).getWines(userId);
  }

  Future<void> addWine(WineEntity wine) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(wineRepositoryProvider).addWine(wine),
    );
    ref.invalidateSelf(); // re-trigger build()
  }

  Future<void> deleteWine(String id) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(wineRepositoryProvider).deleteWine(id);
        return ref.read(wineRepositoryProvider).getWines(
          ref.read(currentUserIdProvider),
        );
      },
    );
  }
}
```

### StreamNotifier (reactive / live data)

Use for: Drift watch streams, Supabase realtime.

```dart
// wine_list.controller.dart
@riverpod
class WineListController extends _$WineListController {
  @override
  Stream<List<WineEntity>> build() {
    final userId = ref.watch(currentUserIdProvider);
    return ref.watch(wineRepositoryProvider).watchWines(userId);
  }
}
```

### Family (parameterized)

```dart
// Single wine by ID
@riverpod
Future<WineEntity?> wineDetail(Ref ref, String wineId) {
  return ref.watch(wineRepositoryProvider).getWineById(wineId);
}

// Usage in UI
final wine = ref.watch(wineDetailProvider('wine-uuid-123'));
```

---

## Centralizing Providers

All providers for a feature go in `controller/wine.provider.dart`:

```dart
// lib/features/wine/controller/wine.provider.dart

part 'wine.provider.g.dart';

@riverpod
WineApi wineApi(Ref ref) => WineApi(ref.watch(supabaseClientProvider));

@riverpod
WineRepository wineRepository(Ref ref) => WineRepositoryImpl(
  api: ref.watch(wineApiProvider),
  dao: ref.watch(appDatabaseProvider).wineDao,
);

// Controllers live in their own .controller.dart but are imported/re-exported here
// so callers only need to import wine.provider.dart
```

---

## UI Consumption

### AsyncValue.when

```dart
class WineListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(wineListControllerProvider);

    return winesAsync.when(
      data: (wines) => WineListView(wines: wines),
      loading: () => const LoadingState(),
      error: (error, _) => ErrorState(error: error),
    );
  }
}
```

### Listening to state changes (side effects)

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  ref.listen<AsyncValue<List<WineEntity>>>(
    wineListControllerProvider,
    (_, next) {
      next.whenOrNull(
        error: (e, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        ),
      );
    },
  );

  // ... rest of build
}
```

---

## Useful Patterns

### Invalidate (force refresh)

```dart
// From a button or pull-to-refresh
ref.invalidate(wineListControllerProvider);
```

### Select (prevent unnecessary rebuilds)

```dart
// Only rebuild when wine count changes
final count = ref.watch(
  wineListControllerProvider.select((v) => v.valueOrNull?.length ?? 0),
);
```

### Debounce (search input)

```dart
@riverpod
class WineSearchController extends _$WineSearchController {
  Timer? _debounce;

  @override
  Future<List<WineEntity>> build() async => [];

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () => ref.read(wineRepositoryProvider).searchWines(query),
      );
    });
  }
}
```

### Override in tests

```dart
ProviderScope(
  overrides: [
    wineRepositoryProvider.overrideWithValue(MockWineRepository()),
  ],
  child: const MyApp(),
)
```

---

## Build Commands

```bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode
dart run build_runner watch --delete-conflicting-outputs
```

---

## Rules Checklist

- [ ] All providers use `@riverpod` annotation (no manual `Provider(...)`)
- [ ] All feature providers in one `feature.provider.dart` file
- [ ] Async operations wrapped in `AsyncValue.guard`
- [ ] Use `StreamNotifier` for Drift watch streams
- [ ] Use `.family` for ID-parameterized providers
- [ ] UI uses `.when()` — never access `.value` directly without null check
