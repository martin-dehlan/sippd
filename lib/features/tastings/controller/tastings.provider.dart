import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/services/analytics/analytics.provider.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/data/models/friend_profile.model.dart';
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
