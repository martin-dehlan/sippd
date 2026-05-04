import 'package:riverpod_annotation/riverpod_annotation.dart';
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

part 'tastings.provider.g.dart';

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
  final model = await api.fetchById(tastingId).withNetTimeout();
  return model?.toEntity();
}

@riverpod
Future<List<WineEntity>> tastingWines(
    TastingWinesRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const [];
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
@riverpod
Future<Map<String, double>> tastingWineRatings(
    TastingWineRatingsRef ref, String tastingId) async {
  final tasting = await ref.watch(tastingDetailProvider(tastingId).future);
  if (tasting == null) return const {};
  final wines = await ref.watch(tastingWinesProvider(tastingId).future);
  if (wines.isEmpty) return const {};
  ref.requireOnline();
  final client = ref.read(supabaseClientProvider);
  final groupId = tasting.groupId;
  final canonicalIds = wines
      .map((w) => w.canonicalWineId ?? w.id)
      .toSet()
      .toList();

  final shareRows = (await client
      .from('group_wines')
      .select('canonical_wine_id, shared_by')
      .eq('group_id', groupId)
      .inFilter('canonical_wine_id', canonicalIds)) as List;
  final ownerByCanonical = <String, String>{
    for (final r in shareRows)
      (r as Map<String, dynamic>)['canonical_wine_id'] as String:
          r['shared_by'] as String,
  };

  final ownerRatingByCanonical = <String, double>{};
  if (ownerByCanonical.isNotEmpty) {
    final wineRows = (await client
        .from('wines')
        .select('canonical_wine_id, user_id, rating')
        .inFilter('canonical_wine_id', canonicalIds)) as List;
    for (final r in wineRows) {
      final m = r as Map<String, dynamic>;
      final cid = m['canonical_wine_id'] as String;
      final uid = m['user_id'] as String;
      final rating = (m['rating'] as num?)?.toDouble();
      if (rating == null || rating <= 0) continue;
      if (ownerByCanonical[cid] != uid) continue;
      ownerRatingByCanonical[cid] = rating;
    }
  }

  final memberRows = (await client
      .from('group_wine_ratings')
      .select('canonical_wine_id, user_id, rating')
      .eq('group_id', groupId)
      .inFilter('canonical_wine_id', canonicalIds)) as List;

  final perCanonical = <String, List<double>>{};
  ownerRatingByCanonical.forEach((cid, r) => perCanonical[cid] = [r]);
  for (final r in memberRows) {
    final m = r as Map<String, dynamic>;
    final cid = m['canonical_wine_id'] as String;
    final uid = m['user_id'] as String;
    final rating = (m['rating'] as num).toDouble();
    if (rating <= 0) continue;
    if (ownerByCanonical[cid] == uid) continue;
    perCanonical.putIfAbsent(cid, () => []).add(rating);
  }

  return {
    for (final e in perCanonical.entries)
      if (e.value.isNotEmpty)
        e.key: e.value.reduce((a, b) => a + b) / e.value.length,
  };
}

@riverpod
Future<List<TastingAttendeeEntity>> tastingAttendees(
    TastingAttendeesRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const [];
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

  Future<TastingEntity?> updateTasting({
    required String tastingId,
    required String groupId,
    required String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    required DateTime scheduledAt,
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
