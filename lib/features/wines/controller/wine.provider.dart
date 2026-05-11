import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/database/database.dart';
import '../../../common/services/analytics/analytics.provider.dart';
import '../../../common/services/connectivity/connectivity.provider.dart';
import '../data/services/outbox_flusher.service.dart';
import '../../auth/controller/auth.provider.dart';
import '../../onboarding/controller/onboarding.provider.dart';
import '../../taste_match/controller/taste_match.provider.dart';
import 'wine_stats.provider.dart';
import '../domain/entities/canonical_grape.entity.dart';
import '../domain/entities/canonical_merge_pair.entity.dart';
import '../domain/entities/canonical_wine_candidate.entity.dart';
import '../domain/entities/wine.entity.dart';
import '../domain/entities/wine_memory.entity.dart';
import '../domain/repositories/canonical_grape.repository.dart';
import '../domain/repositories/wine.repository.dart';
import '../domain/repositories/wine_alias.repository.dart';
import '../domain/repositories/wine_memory.repository.dart';
import '../data/data_sources/canonical_grape_supabase.api.dart';
import '../data/data_sources/canonical_wine.api.dart';
import '../data/data_sources/wine_alias_supabase.api.dart';
import '../data/data_sources/wine_image.service.dart';
import '../data/data_sources/wine_memory_supabase.api.dart';
import '../data/data_sources/wine_supabase.api.dart';
import '../data/repositories/canonical_grape.repository.impl.dart';
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
  final userId = ref.watch(currentUserIdProvider);
  // Inject the image service so the repo can retry image uploads on
  // every save when a previous upload left only a local file. Without
  // this, group members would never see photos that failed to upload
  // the first time.
  final imageService = ref.watch(wineImageServiceProvider);
  final analytics = ref.read(analyticsProvider);
  return WineRepositoryImpl(
    dao: db.winesDao,
    api: api,
    userId: userId,
    imageService: imageService,
    analytics: analytics,
    outbox: db.pendingImageUploadsDao,
  );
}

/// Background flusher for the image-upload outbox. Triggered at launch
/// and on every connectivity flip to online via [imageOutboxAutoFlush].
@riverpod
OutboxFlusher imageOutboxFlusher(ImageOutboxFlusherRef ref) {
  final db = ref.read(appDatabaseProvider);
  return OutboxFlusher(
    outbox: db.pendingImageUploadsDao,
    winesDao: db.winesDao,
    imageService: ref.watch(wineImageServiceProvider),
    api: ref.watch(wineSupabaseApiProvider),
    userId: ref.watch(currentUserIdProvider),
    analytics: ref.read(analyticsProvider),
  );
}

/// Self-arming side-effect provider: drains the image outbox whenever
/// the device is online. Riverpod tracks the dependency so a flip from
/// offline → online re-runs `build` and triggers another flush. Read
/// once at app start (e.g. in main.dart's ProviderScope) to keep it
/// alive — no UI consumes it.
@Riverpod(keepAlive: true)
Future<void> imageOutboxAutoFlush(ImageOutboxAutoFlushRef ref) async {
  if (!ref.watch(isOnlineProvider)) return;
  await ref.read(imageOutboxFlusherProvider).flush();
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
  return WineMemoryRepositoryImpl(
    db.wineMemoriesDao,
    api,
    ref.read(analyticsProvider),
  );
}

@riverpod
CanonicalGrapeSupabaseApi? canonicalGrapeSupabaseApi(
  CanonicalGrapeSupabaseApiRef ref,
) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return CanonicalGrapeSupabaseApi(client);
}

@riverpod
CanonicalGrapeRepository canonicalGrapeRepository(
  CanonicalGrapeRepositoryRef ref,
) {
  final db = ref.read(appDatabaseProvider);
  final api = ref.watch(canonicalGrapeSupabaseApiProvider);
  return CanonicalGrapeRepositoryImpl(db.canonicalGrapeDao, api);
}

/// Kicks off a remote sync of the canonical catalog the first time the
/// provider is read. Kept alive so subsequent reads return the cached
/// future instead of re-syncing on every UI rebuild.
@Riverpod(keepAlive: true)
Future<void> canonicalGrapeSync(CanonicalGrapeSyncRef ref) async {
  final repo = ref.watch(canonicalGrapeRepositoryProvider);
  await repo.syncFromRemote();
}

/// Full sorted catalog. Awaits the initial sync so newly-installed apps
/// see the catalog before the user touches the grape picker.
@riverpod
Future<List<CanonicalGrapeEntity>> canonicalGrapesAll(
  CanonicalGrapesAllRef ref,
) async {
  await ref.watch(canonicalGrapeSyncProvider.future);
  return ref.read(canonicalGrapeRepositoryProvider).getAll();
}

/// Search results for the typeahead. Empty query returns the full list.
@riverpod
Future<List<CanonicalGrapeEntity>> canonicalGrapesSearch(
  CanonicalGrapesSearchRef ref,
  String query,
) async {
  await ref.watch(canonicalGrapeSyncProvider.future);
  return ref.read(canonicalGrapeRepositoryProvider).search(query);
}

/// Single grape lookup used by wine_detail to render the resolved name.
@riverpod
Future<CanonicalGrapeEntity?> canonicalGrape(CanonicalGrapeRef ref, String id) {
  return ref.read(canonicalGrapeRepositoryProvider).getById(id);
}

@riverpod
CanonicalWineApi? canonicalWineApi(CanonicalWineApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return CanonicalWineApi(client);
}

/// Looks up Tier 1 / Tier 2 canonical candidates for a wine the user is
/// about to add or edit. Returns empty list when no API client is
/// available (signed out) or the input name is too short to match.
@riverpod
Future<List<CanonicalWineCandidate>> canonicalWineSuggestions(
  CanonicalWineSuggestionsRef ref, {
  required String wineName,
  String? winery,
  int? vintage,
}) async {
  final api = ref.read(canonicalWineApiProvider);
  if (api == null) return const [];
  if (wineName.trim().length < 2) return const [];
  return api.suggestMatch(name: wineName, winery: winery, vintage: vintage);
}

/// Pairs of canonicals the caller can merge. Drives the cleanup
/// screen in profile settings. Empty when nothing matches the
/// similarity threshold.
@riverpod
class CanonicalMergeCandidates extends _$CanonicalMergeCandidates {
  @override
  Future<List<CanonicalMergePair>> build() async {
    final api = ref.watch(canonicalWineApiProvider);
    if (api == null) return const [];
    ref.requireOnline();
    return api.findMergeCandidates().withNetTimeout();
  }

  Future<void> merge({
    required String loserId,
    required String winnerId,
  }) async {
    final api = ref.read(canonicalWineApiProvider);
    if (api == null) return;
    await api.mergeCanonicals(loserId: loserId, winnerId: winnerId);
    ref.invalidateSelf();
  }
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
    _invalidateTasteAggregates();
    ref
        .read(analyticsProvider)
        .capture(
          'wine_added',
          properties: {
            'rating': wine.rating,
            'type': wine.type.name,
            'has_notes': (wine.notes ?? '').isNotEmpty,
            'has_photo':
                (wine.imageUrl ?? wine.localImagePath ?? '').isNotEmpty,
            'has_location': wine.latitude != null && wine.longitude != null,
            'visibility': wine.visibility,
          },
        );
  }

  Future<void> updateWine(WineEntity wine) async {
    await ref.read(wineRepositoryProvider).updateWine(wine);
    _invalidateTasteAggregates();
    ref
        .read(analyticsProvider)
        .capture(
          'wine_updated',
          properties: {'rating': wine.rating, 'type': wine.type.name},
        );
  }

  // Personal-compass / DNA / top-grapes are server-aggregated and read by
  // the profile hero. ProfileScreen lives in an indexedStack shell so its
  // providers stay cached across tab switches — without manual
  // invalidation the "Curious Newcomer / rate N more" copy never updates.
  void _invalidateTasteAggregates() {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    ref.invalidate(tasteCompassProvider(userId));
    ref.invalidate(userStyleDnaProvider(userId));
    ref.invalidate(userTopGrapesProvider(userId));
    // Stats hero + breakdowns read unified rating summary; rating events
    // here change its avg and counts.
    ref.invalidate(userRatingSummaryProvider);
  }

  Future<void> deleteWine(String id) async {
    final wine = await ref.read(wineRepositoryProvider).getWineById(id);
    await ref.read(wineMemoryRepositoryProvider).deleteByWine(id);
    await ref.read(wineRepositoryProvider).deleteWine(id);

    // Mental model: deleting a wine from your personal log also retracts
    // your own ratings of that bottle from any groups (Untappd / Vivino /
    // Letterboxd convention). Other members' ratings of the same canonical
    // bottle stay — they are independent rating events.
    final canonicalId = wine?.canonicalWineId;
    final userId = ref.read(currentUserIdProvider);
    if (canonicalId != null && userId != null) {
      try {
        await ref
            .read(supabaseClientProvider)
            .from('group_wine_ratings')
            .delete()
            .eq('user_id', userId)
            .eq('canonical_wine_id', canonicalId);
      } catch (_) {
        // Local delete already done; sync will reconcile next session.
      }
    }
    _invalidateTasteAggregates();
    ref.read(analyticsProvider).capture('wine_deleted');
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
    ref.read(analyticsProvider).capture('wine_memory_added');
  }

  Future<void> deleteMemory(String id) async {
    await ref.read(wineMemoryRepositoryProvider).deleteMemory(id);
    ref.read(analyticsProvider).capture('wine_memory_deleted');
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
    final next =
        WineSortMode.values[(state.index + 1) % WineSortMode.values.length];
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_wineSortModeKey, next.name);
    state = next;
  }
}
