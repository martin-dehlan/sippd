import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/services/analytics/analytics.provider.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/data/models/friend_profile.model.dart';
import '../../push/controller/push.provider.dart';
import '../../wines/data/models/wine.model.dart';
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
  final models = await api.fetchForGroup(groupId);
  return models.map((m) => m.toEntity()).toList();
}

@riverpod
Future<TastingEntity?> tastingDetail(
    TastingDetailRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return null;
  final model = await api.fetchById(tastingId);
  return model?.toEntity();
}

@riverpod
Future<List<WineEntity>> tastingWines(
    TastingWinesRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const [];
  final models = await api.fetchWines(tastingId);
  return models.map((m) => m.toEntity()).toList();
}

@riverpod
Future<List<TastingAttendeeEntity>> tastingAttendees(
    TastingAttendeesRef ref, String tastingId) async {
  final api = ref.watch(tastingsApiProvider);
  if (api == null) return const [];
  final rows = await api.fetchAttendees(tastingId);
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
    await _scheduleReminderRespectingPrefs(
      tastingId: model.id,
      title: title,
      scheduledAt: scheduledAt,
    );
    ref.invalidate(groupTastingsProvider(groupId));
    return model.toEntity();
  }

  Future<void> _scheduleReminderRespectingPrefs({
    required String tastingId,
    required String title,
    required DateTime scheduledAt,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    // Prefer the live stream value (already hydrated for the settings screen)
    // and fall back to a one-shot fetch when it hasn't emitted yet.
    final cached =
        ref.read(notificationPrefsControllerProvider).valueOrNull;
    final prefs = cached ??
        await ref
            .read(notificationPrefsRepositoryProvider)
            .getPrefs(userId);
    if (!prefs.tastingReminders) return;
    final offsetHours = prefs.tastingReminderHours;
    final reminderAt =
        scheduledAt.subtract(Duration(hours: offsetHours));
    await ref.read(pushHandlerProvider).scheduleTastingReminder(
          tastingId: tastingId,
          tastingTitle: title,
          reminderAt: reminderAt,
          offsetHours: offsetHours,
        );
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
    await ref.read(pushHandlerProvider).cancelTastingReminder(tastingId);
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
    // Re-schedule against the new wall-clock time. cancel + schedule keeps
    // the deterministic id so a stale reminder can't slip through. Uses the
    // user's current notification prefs (offset hours + master toggle).
    await ref.read(pushHandlerProvider).cancelTastingReminder(tastingId);
    await _scheduleReminderRespectingPrefs(
      tastingId: tastingId,
      title: title,
      scheduledAt: scheduledAt,
    );
    ref.invalidate(tastingDetailProvider(tastingId));
    ref.invalidate(groupTastingsProvider(groupId));
    return model.toEntity();
  }
}
