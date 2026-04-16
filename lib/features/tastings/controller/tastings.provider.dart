import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/domain/entities/friend_profile.entity.dart';
import '../../friends/data/models/friend_profile.model.dart';
import '../../wines/data/models/wine.model.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../data/data_sources/tastings.api.dart';
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

    state = const AsyncValue.loading();
    TastingEntity? created;
    state = await AsyncValue.guard(() async {
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
      created = model.toEntity();
    });
    ref.invalidate(groupTastingsProvider(groupId));
    return created;
  }

  Future<void> setRsvp(String tastingId, RsvpStatus status) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return;
    await api.setMyRsvp(tastingId: tastingId, status: status.wire);
    ref.invalidate(tastingAttendeesProvider(tastingId));
  }

  Future<void> deleteTasting(String tastingId, {String? groupId}) async {
    final api = ref.read(tastingsApiProvider);
    if (api == null) return;
    await api.deleteTasting(tastingId);
    if (groupId != null) ref.invalidate(groupTastingsProvider(groupId));
  }
}
