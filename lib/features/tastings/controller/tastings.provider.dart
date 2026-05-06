import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common/services/analytics/analytics.provider.dart';
import '../../../common/services/connectivity/connectivity.provider.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/data/models/friend_profile.model.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../data/data_sources/tastings.api.dart';
import '../data/models/tasting.model.dart';
import '../domain/entities/tasting.entity.dart';
import '../domain/entities/tasting_attendee.entity.dart';
import '../domain/entities/tasting_recap_entry.entity.dart';

part 'tastings.provider.g.dart';

/// Subscribes the calling provider to postgres changes on [table] for a
/// single [filterValue] and invalidates it when an INSERT / UPDATE /
/// DELETE arrives. Channel is removed on `ref.onDispose`. Kept private
/// to this file because the providers using it cluster around the same
/// tasting screen — extracting further would obscure intent.
void _wireTastingRealtime(
  Ref ref, {
  required SupabaseClient client,
  required String table,
  required String filterColumn,
  required String filterValue,
  required VoidCallback onChange,
  String? channelSuffix,
}) {
  final channelName =
      '${table}_${channelSuffix ?? filterValue}_${identityHashCode(ref)}';
  final channel = client.channel(channelName);
  channel
      .onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: table,
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: filterColumn,
          value: filterValue,
        ),
        callback: (_) => onChange(),
      )
      .subscribe();
  ref.onDispose(() => client.removeChannel(channel));
}

@riverpod
TastingsApi? tastingsApi(TastingsApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return TastingsApi(client);
}

@riverpod
Future<List<TastingEntity>> groupTastings(
    GroupTastingsRef ref, String groupId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const [];
  ref.requireOnline();
  final models = await api.fetchForGroup(groupId).withNetTimeout();
  return models.map((m) => m.toEntity()).toList();
}

@riverpod
Future<TastingEntity?> tastingDetail(
    TastingDetailRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return null;
  ref.requireOnline();
  // Realtime: state transitions (Start / End / lineup_mode flip / edit)
  // by the host land on every attendee's banner without a manual
  // refresh.
  _wireTastingRealtime(
    ref,
    client: ref.read(supabaseClientProvider),
    table: 'group_tastings',
    filterColumn: 'id',
    filterValue: tastingId,
    onChange: ref.invalidateSelf,
  );
  final model = await api.fetchById(tastingId).withNetTimeout();
  return model?.toEntity();
}

@riverpod
Future<List<WineEntity>> tastingWines(
    TastingWinesRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const [];
  // Realtime: any going-attendee can drop a wine into the lineup
  // mid-tasting; everyone else's screen needs to pick it up without a
  // manual refresh.
  _wireTastingRealtime(
    ref,
    client: ref.read(supabaseClientProvider),
    table: 'tasting_wines',
    filterColumn: 'tasting_id',
    filterValue: tastingId,
    onChange: ref.invalidateSelf,
  );
  // Re-run when the local wine list changes so owner photo edits and
  // newly-added (offline) bottles surface their image immediately.
  // Entities stay catalog-keyed (id == canonical_wine_id) — only the
  // image fields are grafted from the owner's local row, so the
  // remove / detail call sites keep working.
  final localWines = ref.watch(wineControllerProvider).valueOrNull ?? const [];
  final localByCanonical = <String, WineEntity>{
    for (final w in localWines)
      if (w.canonicalWineId != null) w.canonicalWineId!: w,
  };
  ref.requireOnline();
  final wines = await api.fetchWines(tastingId).withNetTimeout();
  return [
    for (final w in wines)
      _mergeLocalImage(w, localByCanonical[w.canonicalWineId ?? w.id]),
  ];
}

WineEntity _mergeLocalImage(WineEntity remote, WineEntity? local) {
  if (local == null) return remote;
  if (remote.imageUrl != null && remote.localImagePath == null) return remote;
  return remote.copyWith(
    imageUrl: remote.imageUrl ?? local.imageUrl,
    localImagePath: remote.localImagePath ?? local.localImagePath,
  );
}

/// Group-context rating average per canonical wine for the tasting's
/// lineup. Mirrors `groupWineRatings`: owner of each canonical (via
/// `group_wines.shared_by`) contributes their personal `wines.rating`,
/// other members contribute their `group_wine_ratings.rating`. Each
/// user counted at most once per canonical (member rows from the owner
/// are dropped). Canonicals with zero usable ratings are omitted, so
/// callers can `Map.containsKey` to decide whether to render a badge.
/// Average rating per canonical wine for the tasting, sourced from
/// `tasting_ratings`. Tasting context is intentionally separate from
/// group-historical ratings — the same canonical may have a different
/// score in tonight's flight than in last weekend's group dinner.
@riverpod
Future<Map<String, double>> tastingWineRatings(
    TastingWineRatingsRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const {};
  ref.requireOnline();
  // Realtime: any rating submitted or edited recomputes the avg pill
  // shown on lineup cards live, so attendees rating around a table
  // see scores converge in real time.
  _wireTastingRealtime(
    ref,
    client: ref.read(supabaseClientProvider),
    table: 'tasting_ratings',
    filterColumn: 'tasting_id',
    filterValue: tastingId,
    onChange: ref.invalidateSelf,
    channelSuffix: 'avg_$tastingId',
  );
  return api.fetchTastingAverages(tastingId);
}

/// All submitted ratings for the tasting joined with rater profiles.
/// Powers the concluded-state recap view (top wine + per-wine
/// breakdown). Empty list when no ratings exist yet.
@riverpod
Future<List<TastingRecapEntry>> tastingRecapEntries(
  TastingRecapEntriesRef ref,
  String tastingId,
) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const [];
  ref.requireOnline();
  // Realtime: same source as tastingWineRatings but separate channel
  // so the recap section refreshes per-attendee chips (not just the
  // avg) when ratings land.
  _wireTastingRealtime(
    ref,
    client: ref.read(supabaseClientProvider),
    table: 'tasting_ratings',
    filterColumn: 'tasting_id',
    filterValue: tastingId,
    onChange: ref.invalidateSelf,
    channelSuffix: 'recap_$tastingId',
  );
  return api.fetchTastingRecapEntries(tastingId);
}

/// The caller's own rating for a single wine in a tasting. Null if not
/// yet rated. Used to prefill the rate-sheet so re-opening shows the
/// last value the user submitted.
@riverpod
Future<double?> myTastingRating(
  MyTastingRatingRef ref,
  String tastingId,
  String canonicalWineId,
) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return null;
  ref.requireOnline();
  return api.fetchMyTastingRating(
    tastingId: tastingId,
    canonicalWineId: canonicalWineId,
  );
}

@riverpod
Future<List<TastingAttendeeEntity>> tastingAttendees(
    TastingAttendeesRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const [];
  // Realtime: RSVP transitions (going / maybe / declined / no_response)
  // refresh the attendee cluster + going-count + the
  // canAdd-during-active rule for everyone watching the screen.
  _wireTastingRealtime(
    ref,
    client: ref.read(supabaseClientProvider),
    table: 'tasting_attendees',
    filterColumn: 'tasting_id',
    filterValue: tastingId,
    onChange: ref.invalidateSelf,
  );
  ref.requireOnline();
  final rows = await api.fetchAttendees(tastingId).withNetTimeout();
  return rows
      .map((r) => TastingAttendeeEntity(
            tastingId: r.tastingId,
            userId: r.userId,
            status: RsvpStatusX.fromWire(r.status),
            profile: r.profile?.toEntity(),
          ))
      .toList();
}

@riverpod
class TastingsController extends _$TastingsController {
  @override
  FutureOr<void> build() {}

  Future<TastingEntity?> create({
    required String groupId,
    required String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    required DateTime scheduledAt,
    List<String> wineIds = const [],
    TastingLineupMode lineupMode = TastingLineupMode.planned,
  }) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return null;

    final model = await api.create(
      groupId: groupId,
      title: title,
      description: description,
      location: location,
      latitude: latitude,
      longitude: longitude,
      scheduledAt: scheduledAt,
      lineupMode: lineupMode.name,
    );
    if (wineIds.isNotEmpty) {
      await api.addWines(model.id, wineIds);
    }
    ref.read(analyticsProvider).capture(
      'tasting_created',
      properties: {
        'wine_count': wineIds.length,
        'has_description': (description ?? '').isNotEmpty,
        'has_location': latitude != null && longitude != null,
        'lineup_mode': lineupMode.name,
      },
    );
    // Reminder delivery is handled server-side: the `tasting-reminders`
    // edge function (cron) reads scheduled_at + the creator's
    // user_notification_prefs and pushes via FCM at the right moment. No
    // client-side scheduling required.
    ref.invalidate(groupTastingsProvider(groupId));
    return model.toEntity();
  }

  Future<void> addWines(String tastingId, List<String> wineIds) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null || wineIds.isEmpty) return;
    await api.addWines(tastingId, wineIds);
    ref.read(analyticsProvider).capture(
      'tasting_wines_added',
      properties: {'count': wineIds.length},
    );
    ref.invalidate(tastingWinesProvider(tastingId));
  }

  Future<void> removeWine(String tastingId, String wineId) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return;
    await api.removeWine(tastingId, wineId);
    ref.invalidate(tastingWinesProvider(tastingId));
  }

  Future<void> setRsvp(String tastingId, RsvpStatus status) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return;
    await api.setMyRsvp(tastingId: tastingId, status: status.wire);
    ref.read(analyticsProvider).capture(
      'tasting_rsvp_set',
      properties: {'status': status.wire},
    );
    ref.invalidate(tastingAttendeesProvider(tastingId));
  }

  Future<void> deleteTasting(String tastingId, {String? groupId}) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return;
    await api.deleteTasting(tastingId);
    ref.read(analyticsProvider).capture('tasting_deleted');
    if (groupId != null) ref.invalidate(groupTastingsProvider(groupId));
  }

  /// Host transitions tasting from upcoming → active. UI gates this so
  /// only the creator can call it; here we trust the caller and let RLS
  /// reject anyone else server-side.
  Future<TastingEntity?> startTasting(String tastingId,
      {String? groupId}) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return null;
    final model = await api.startTasting(tastingId);
    ref.read(analyticsProvider).capture('tasting_started');
    ref.invalidate(tastingDetailProvider(tastingId));
    if (groupId != null) ref.invalidate(groupTastingsProvider(groupId));
    return model.toEntity();
  }

  /// Host transitions active → concluded. No auto-end exists — the
  /// host must explicitly mark the event over (events run longer than
  /// scheduled).
  Future<TastingEntity?> endTasting(String tastingId,
      {String? groupId}) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return null;
    final model = await api.endTasting(tastingId);
    ref.read(analyticsProvider).capture('tasting_ended');
    ref.invalidate(tastingDetailProvider(tastingId));
    if (groupId != null) ref.invalidate(groupTastingsProvider(groupId));
    return model.toEntity();
  }

  Future<TastingEntity?> setLineupMode(
    String tastingId,
    TastingLineupMode mode, {
    String? groupId,
  }) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return null;
    final model = await api.setLineupMode(tastingId, mode.name);
    ref.invalidate(tastingDetailProvider(tastingId));
    if (groupId != null) ref.invalidate(groupTastingsProvider(groupId));
    return model.toEntity();
  }

  /// Submit (or update) the caller's rating for a wine in this tasting.
  /// Invalidates both the per-user prefill provider and the aggregate
  /// average so lineup cards refresh in place without a full screen
  /// rebuild.
  Future<void> rateTastingWine({
    required String tastingId,
    required String canonicalWineId,
    required double rating,
    String? notes,
  }) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return;
    await api.upsertMyTastingRating(
      tastingId: tastingId,
      canonicalWineId: canonicalWineId,
      rating: rating,
      notes: notes,
    );
    ref.read(analyticsProvider).capture(
      'tasting_wine_rated',
      properties: {'rating': rating},
    );
    ref.invalidate(myTastingRatingProvider(tastingId, canonicalWineId));
    ref.invalidate(tastingWineRatingsProvider(tastingId));
    ref.invalidate(tastingRecapEntriesProvider(tastingId));
  }

  Future<TastingEntity?> updateTasting({
    required String tastingId,
    required String groupId,
    required String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    required DateTime scheduledAt,
    TastingLineupMode? lineupMode,
  }) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return null;
    final model = await api.update(
      id: tastingId,
      title: title,
      description: description,
      location: location,
      latitude: latitude,
      longitude: longitude,
      scheduledAt: scheduledAt,
      lineupMode: lineupMode?.name,
    );
    // No client-side reminder reschedule: the BEFORE-UPDATE trigger
    // group_tastings_reset_reminder clears reminder_sent_at when
    // scheduled_at changes, so the cron will pick the new fire time up
    // automatically.
    ref.invalidate(tastingDetailProvider(tastingId));
    ref.invalidate(groupTastingsProvider(groupId));
    return model.toEntity();
  }
}
