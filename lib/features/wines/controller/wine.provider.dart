import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/database/database.dart';
import '../../auth/controller/auth.provider.dart';
import '../../onboarding/controller/onboarding.provider.dart';
import '../domain/entities/wine.entity.dart';
import '../domain/entities/wine_memory.entity.dart';
import '../domain/repositories/wine.repository.dart';
import '../domain/repositories/wine_alias.repository.dart';
import '../domain/repositories/wine_memory.repository.dart';
import '../data/data_sources/wine_alias_supabase.api.dart';
import '../data/data_sources/wine_image.service.dart';
import '../data/data_sources/wine_memory_supabase.api.dart';
import '../data/data_sources/wine_supabase.api.dart';
import '../data/repositories/wine.repository.impl.dart';
import '../data/repositories/wine_alias.repository.impl.dart';
import '../data/repositories/wine_memory.repository.impl.dart';

part 'wine.provider.g.dart';

// ========================================
// DEPENDENCIES
// ========================================

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}

@riverpod
WineSupabaseApi? wineSupabaseApi(WineSupabaseApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return WineSupabaseApi(client);
}

@riverpod
WineRepository wineRepository(WineRepositoryRef ref) {
  final db = ref.read(appDatabaseProvider);
  final api = ref.watch(wineSupabaseApiProvider);
  return WineRepositoryImpl(db.winesDao, api);
}

@riverpod
WineAliasSupabaseApi? wineAliasSupabaseApi(WineAliasSupabaseApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return WineAliasSupabaseApi(client);
}

@riverpod
WineAliasRepository wineAliasRepository(WineAliasRepositoryRef ref) {
  final db = ref.read(appDatabaseProvider);
  final api = ref.watch(wineAliasSupabaseApiProvider);
  return WineAliasRepositoryImpl(db.wineAliasesDao, api);
}

@riverpod
WineImageService? wineImageService(WineImageServiceRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return WineImageService(client);
}

@riverpod
WineMemorySupabaseApi? wineMemorySupabaseApi(WineMemorySupabaseApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return WineMemorySupabaseApi(client);
}

@riverpod
WineMemoryRepository wineMemoryRepository(WineMemoryRepositoryRef ref) {
  final db = ref.read(appDatabaseProvider);
  final api = ref.watch(wineMemorySupabaseApiProvider);
  return WineMemoryRepositoryImpl(db.wineMemoriesDao, api);
}

// ========================================
// STATE MANAGEMENT
// ========================================

@riverpod
class WineController extends _$WineController {
  @override
  Stream<List<WineEntity>> build() {
    return ref.read(wineRepositoryProvider).watchWines();
  }

  Future<void> addWine(WineEntity wine) async {
    await ref.read(wineRepositoryProvider).addWine(wine);
  }

  Future<void> updateWine(WineEntity wine) async {
    await ref.read(wineRepositoryProvider).updateWine(wine);
  }

  Future<void> deleteWine(String id) async {
    await ref.read(wineMemoryRepositoryProvider).deleteByWine(id);
    await ref.read(wineRepositoryProvider).deleteWine(id);
  }
}

// ========================================
// FAMILY PROVIDERS
// ========================================

@riverpod
Future<WineEntity?> wineDetail(WineDetailRef ref, String wineId) async {
  return ref.read(wineRepositoryProvider).getWineById(wineId);
}

@riverpod
class WineMemoriesController extends _$WineMemoriesController {
  @override
  Stream<List<WineMemoryEntity>> build(String wineId) {
    return ref.read(wineMemoryRepositoryProvider).watchByWine(wineId);
  }

  Future<void> addMemory(WineMemoryEntity memory) async {
    await ref.read(wineMemoryRepositoryProvider).addMemory(memory);
  }

  Future<void> deleteMemory(String id) async {
    await ref.read(wineMemoryRepositoryProvider).deleteMemory(id);
  }
}

// ========================================
// FILTER STATE
// ========================================

const _wineTypeFilterKey = 'wine_type_filter';

@riverpod
class WineTypeFilter extends _$WineTypeFilter {
  @override
  WineType? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final stored = prefs.getString(_wineTypeFilterKey);
    if (stored == null) return null;
    return WineType.values.firstWhere(
      (t) => t.name == stored,
      orElse: () => WineType.red,
    );
  }

  Future<void> setFilter(WineType? type) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (type == null) {
      await prefs.remove(_wineTypeFilterKey);
    } else {
      await prefs.setString(_wineTypeFilterKey, type.name);
    }
    state = type;
  }
}

// ========================================
// SORT STATE
// ========================================

enum WineSortMode { rating, recent, name }

const _wineSortModeKey = 'wine_sort_mode';

@riverpod
class WineSort extends _$WineSort {
  @override
  WineSortMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final stored = prefs.getString(_wineSortModeKey);
    return WineSortMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => WineSortMode.rating,
    );
  }

  Future<void> toggle() async {
    final next = WineSortMode
        .values[(state.index + 1) % WineSortMode.values.length];
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_wineSortModeKey, next.name);
    state = next;
  }
}
