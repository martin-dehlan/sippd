import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/data/models/friend_profile.model.dart';
import '../../friends/domain/entities/friend_profile.entity.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/data/models/wine.model.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../data/data_sources/group_image.service.dart';
import '../domain/entities/group.entity.dart';
import '../domain/entities/group_wine_rating.entity.dart';
import '../data/models/group.model.dart';
import '../data/models/group_wine_rating.model.dart';

part 'group.provider.g.dart';

@riverpod
class GroupController extends _$GroupController {
  @override
  Future<List<GroupEntity>> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return [];

    final client = ref.read(supabaseClientProvider);

    // Get groups where user is a member
    final memberships = await client
        .from('group_members')
        .select('group_id')
        .eq('user_id', userId);

    if (memberships.isEmpty) return [];

    final groupIds =
        (memberships as List).map((m) => m['group_id'] as String).toList();

    final groupsData =
        await client.from('groups').select().inFilter('id', groupIds);

    final groups = (groupsData as List)
        .map((g) => GroupModel.fromJson(g).toEntity())
        .toList();

    return groups;
  }

  Future<void> createGroup(String name, {String? description}) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    await client.from('groups').insert({
      'name': name,
      'description': description,
      'created_by': userId,
    });

    ref.invalidateSelf();
  }

  Future<void> joinGroup(String inviteCode) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    // Find group by invite code
    final groupData = await client
        .from('groups')
        .select()
        .eq('invite_code', inviteCode)
        .maybeSingle();

    if (groupData == null) throw Exception('Group not found');

    // Join as member
    await client.from('group_members').insert({
      'group_id': groupData['id'],
      'user_id': userId,
      'role': 'member',
    });

    ref.invalidateSelf();
  }

  Future<void> shareWineToGroup(String groupId, String wineId) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    // Ensure the wine exists in Supabase before creating the FK row.
    // Local-first wines may not be synced yet (or may carry a legacy
    // `local_user` user_id) — upsert with current uid so RLS + FK pass.
    final wine =
        await ref.read(wineRepositoryProvider).getWineById(wineId);
    if (wine != null) {
      final model = wine
          .copyWith(userId: userId, updatedAt: DateTime.now())
          .toModel();
      await client.from('wines').upsert(model.toJson());
    }

    await client.from('group_wines').upsert({
      'group_id': groupId,
      'wine_id': wineId,
      'shared_by': userId,
    });
  }

  Future<void> deleteGroup(String groupId) async {
    final client = ref.read(supabaseClientProvider);
    await client.from('groups').delete().eq('id', groupId);
    ref.invalidateSelf();
  }

  Future<void> updateGroup({
    required String groupId,
    String? name,
    String? description,
    String? imageUrl,
    bool clearImage = false,
  }) async {
    final client = ref.read(supabaseClientProvider);
    final patch = <String, dynamic>{};
    if (name != null) patch['name'] = name;
    if (description != null) patch['description'] = description;
    if (clearImage) {
      patch['image_url'] = null;
    } else if (imageUrl != null) {
      patch['image_url'] = imageUrl;
    }
    if (patch.isEmpty) return;
    await client.from('groups').update(patch).eq('id', groupId);
    ref.invalidateSelf();
    ref.invalidate(groupDetailProvider(groupId));
  }

  Future<void> leaveGroup(String groupId) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    await client
        .from('group_members')
        .delete()
        .eq('group_id', groupId)
        .eq('user_id', userId);

    ref.invalidateSelf();
  }
}

@riverpod
GroupImageService groupImageService(GroupImageServiceRef ref) {
  final client = ref.read(supabaseClientProvider);
  return GroupImageService(client);
}

@riverpod
Future<GroupEntity?> groupDetail(GroupDetailRef ref, String groupId) async {
  final client = ref.read(supabaseClientProvider);
  final row =
      await client.from('groups').select().eq('id', groupId).maybeSingle();
  if (row == null) return null;
  return GroupModel.fromJson(row).toEntity();
}

@riverpod
Future<List<FriendProfileEntity>> groupMembers(
    GroupMembersRef ref, String groupId) async {
  final client = ref.read(supabaseClientProvider);
  final memberRows = (await client
      .from('group_members')
      .select('user_id, role')
      .eq('group_id', groupId)) as List;
  if (memberRows.isEmpty) return const [];
  final ids = memberRows
      .map((m) => (m as Map<String, dynamic>)['user_id'] as String)
      .toList();
  final profileRows = (await client
      .from('profiles')
      .select()
      .inFilter('id', ids)) as List;
  return profileRows
      .map((p) => FriendProfileModel.fromJson(p as Map<String, dynamic>)
          .toEntity())
      .toList();
}

@riverpod
Future<List<GroupWineRatingEntity>> groupWineRatings(
    GroupWineRatingsRef ref, String groupId, String wineId) async {
  final client = ref.read(supabaseClientProvider);

  // Watch local wines so owner edits (rating/notes) propagate immediately.
  final localWines = ref.watch(wineControllerProvider).valueOrNull ?? const [];
  final localWine = localWines.where((w) => w.id == wineId).firstOrNull;

  String? ownerId;
  double? ownerRating;
  String? ownerUpdated;
  if (localWine != null) {
    ownerId = localWine.userId;
    ownerRating = localWine.rating;
    ownerUpdated = localWine.updatedAt?.toIso8601String();
  } else {
    final wineRow = await client
        .from('wines')
        .select('user_id, rating, updated_at, created_at')
        .eq('id', wineId)
        .maybeSingle();
    ownerId = wineRow?['user_id'] as String?;
    ownerRating = (wineRow?['rating'] as num?)?.toDouble();
    ownerUpdated = wineRow?['updated_at'] as String? ??
        wineRow?['created_at'] as String?;
  }

  final memberRows = (await client
      .from('group_wine_ratings')
      .select()
      .eq('group_id', groupId)
      .eq('wine_id', wineId)) as List;

  final memberModels = memberRows
      .map((r) => GroupWineRatingModel.fromJson(r as Map<String, dynamic>))
      .where((m) => m.userId != ownerId)
      .toList();

  final userIds = <String>{
    ...memberModels.map((m) => m.userId),
    ?ownerId,
  }.toList();
  if (userIds.isEmpty) return const [];

  final profileRows = (await client
      .from('profiles')
      .select('id, username, display_name, avatar_url')
      .inFilter('id', userIds)) as List;
  final profiles = {
    for (final p in profileRows)
      (p as Map<String, dynamic>)['id'] as String: p,
  };

  final list = <GroupWineRatingEntity>[];
  if (ownerId != null && ownerRating != null) {
    list.add(GroupWineRatingEntity(
      groupId: groupId,
      wineId: wineId,
      userId: ownerId,
      rating: ownerRating,
      updatedAt: DateTime.tryParse(ownerUpdated ?? '') ?? DateTime.now(),
      username: profiles[ownerId]?['username'] as String?,
      displayName: profiles[ownerId]?['display_name'] as String?,
      avatarUrl: profiles[ownerId]?['avatar_url'] as String?,
      isOwner: true,
    ));
  }
  list.addAll(memberModels.map((m) => m.toEntity(
        username: profiles[m.userId]?['username'] as String?,
        displayName: profiles[m.userId]?['display_name'] as String?,
        avatarUrl: profiles[m.userId]?['avatar_url'] as String?,
      )));

  list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return list;
}

@riverpod
class GroupWineRatingController extends _$GroupWineRatingController {
  @override
  FutureOr<void> build() {}

  Future<void> upsertRating({
    required String groupId,
    required String wineId,
    required double rating,
    String? notes,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final client = ref.read(supabaseClientProvider);
    await client.from('group_wine_ratings').upsert({
      'group_id': groupId,
      'wine_id': wineId,
      'user_id': userId,
      'rating': rating,
      'notes': notes,
      'updated_at': DateTime.now().toIso8601String(),
    });
    ref.invalidate(groupWineRatingsProvider(groupId, wineId));
    ref.invalidate(groupWineRanksProvider(groupId));
  }

  Future<void> deleteRating({
    required String groupId,
    required String wineId,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final client = ref.read(supabaseClientProvider);
    await client
        .from('group_wine_ratings')
        .delete()
        .eq('group_id', groupId)
        .eq('wine_id', wineId)
        .eq('user_id', userId);
    ref.invalidate(groupWineRatingsProvider(groupId, wineId));
    ref.invalidate(groupWineRanksProvider(groupId));
  }
}

@riverpod
Future<Map<String, int>> groupWineRanks(
    GroupWineRanksRef ref, String groupId) async {
  final wines = await ref.watch(groupWinesProvider(groupId).future);
  if (wines.isEmpty) return const {};

  final client = ref.read(supabaseClientProvider);
  final wineIds = wines.map((w) => w.id).toList();

  final ratingRows = (await client
      .from('group_wine_ratings')
      .select('wine_id, user_id, rating')
      .eq('group_id', groupId)
      .inFilter('wine_id', wineIds)) as List;

  final ownerByWine = {for (final w in wines) w.id: w.userId};

  // Owner rating counts once; member ratings excluded if from owner
  final perWine = <String, List<double>>{};
  for (final w in wines) {
    perWine[w.id] = [w.rating];
  }
  for (final row in ratingRows) {
    final m = row as Map<String, dynamic>;
    final wineId = m['wine_id'] as String;
    final userId = m['user_id'] as String;
    if (userId == ownerByWine[wineId]) continue;
    perWine.putIfAbsent(wineId, () => []).add((m['rating'] as num).toDouble());
  }

  final avgByWine = <String, double>{
    for (final e in perWine.entries)
      if (e.value.isNotEmpty)
        e.key: e.value.reduce((a, b) => a + b) / e.value.length,
  };

  final sorted = avgByWine.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  final ranks = <String, int>{};
  int prevRank = 0;
  double? prevAvg;
  for (var i = 0; i < sorted.length; i++) {
    final e = sorted[i];
    final rank = (prevAvg != null && prevAvg == e.value) ? prevRank : i + 1;
    ranks[e.key] = rank;
    prevRank = rank;
    prevAvg = e.value;
  }
  return ranks;
}

@riverpod
Future<List<WineEntity>> groupWines(
    GroupWinesRef ref, String groupId) async {
  // Re-run whenever local wines change so owner edits propagate instantly.
  final localWines = ref.watch(wineControllerProvider).valueOrNull ?? const [];
  final localById = {for (final w in localWines) w.id: w};

  final client = ref.read(supabaseClientProvider);
  final shareRows = (await client
      .from('group_wines')
      .select('wine_id, shared_at')
      .eq('group_id', groupId)
      .order('shared_at', ascending: false)) as List;
  if (shareRows.isEmpty) return const [];

  final wineIds = shareRows
      .map((s) => (s as Map<String, dynamic>)['wine_id'] as String)
      .toList();

  final missingIds =
      wineIds.where((id) => !localById.containsKey(id)).toList();
  final remoteById = <String, WineEntity>{};
  if (missingIds.isNotEmpty) {
    final wineRows = (await client
        .from('wines')
        .select()
        .inFilter('id', missingIds)) as List;
    for (final r in wineRows) {
      final m = r as Map<String, dynamic>;
      remoteById[m['id'] as String] = WineModel.fromJson(m).toEntity();
    }
  }

  return wineIds
      .map((id) => localById[id] ?? remoteById[id])
      .whereType<WineEntity>()
      .toList();
}
