import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/data/models/friend_profile.model.dart';
import '../../friends/domain/entities/friend_profile.entity.dart';
import '../../onboarding/controller/onboarding.provider.dart';
import '../../../common/utils/name_normalizer.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/data/models/wine.model.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../domain/entities/share_match_candidate.entity.dart';
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

  Future<void> createGroup(String name) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    await client.from('groups').insert({
      'name': name,
      'created_by': userId,
    });

    ref.invalidateSelf();
  }

  Future<void> joinGroup(String inviteCode) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    await client.rpc(
      'join_group_by_invite_code',
      params: {'p_code': inviteCode},
    );

    ref.invalidateSelf();
  }

  /// Shares [wineId] into [groupId] as its own canonical wine.
  /// Upserts the local wine to Supabase first so RLS + FK resolve.
  Future<void> shareWineToGroup(String groupId, String wineId) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    final wine = await ref.read(wineRepositoryProvider).getWineById(wineId);
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

  /// Shares [canonicalWineId] into [groupId]. No local upsert — the caller
  /// guarantees the canonical wine already exists in Supabase (typical when
  /// linking to another member's wine via [WineAliasRepository]).
  Future<void> shareCanonicalToGroup({
    required String groupId,
    required String canonicalWineId,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final client = ref.read(supabaseClientProvider);
    await client.from('group_wines').upsert({
      'group_id': groupId,
      'wine_id': canonicalWineId,
      'shared_by': userId,
    });
  }

  /// Returns wines already shared in [groupId] whose normalized name matches
  /// [localWine], excluding [localWine] itself. Each candidate includes the
  /// original sharer's username for the dedup dialog.
  Future<List<ShareMatchCandidate>> findShareMatchCandidates({
    required String groupId,
    required WineEntity localWine,
  }) async {
    final nameNorm = normalizeName(localWine.name);
    if (nameNorm.isEmpty) return const [];

    final client = ref.read(supabaseClientProvider);

    final shareRows = (await client
        .from('group_wines')
        .select('wine_id, shared_by')
        .eq('group_id', groupId)) as List;
    if (shareRows.isEmpty) return const [];

    final sharerByWine = <String, String>{};
    for (final r in shareRows) {
      final m = r as Map<String, dynamic>;
      sharerByWine[m['wine_id'] as String] = m['shared_by'] as String;
    }

    final sharedWineIds = sharerByWine.keys
        .where((id) => id != localWine.id)
        .toList();
    if (sharedWineIds.isEmpty) return const [];

    final wineRows = (await client
        .from('wines')
        .select()
        .inFilter('id', sharedWineIds)
        .eq('name_norm', nameNorm)) as List;
    if (wineRows.isEmpty) return const [];

    final matches = wineRows
        .map((r) => WineModel.fromJson(r as Map<String, dynamic>).toEntity())
        .toList();

    final sharerIds = matches
        .map((w) => sharerByWine[w.id])
        .whereType<String>()
        .toSet()
        .toList();
    final usernameById = <String, String>{};
    if (sharerIds.isNotEmpty) {
      final profiles = (await client
          .from('profiles')
          .select('id, username')
          .inFilter('id', sharerIds)) as List;
      for (final p in profiles) {
        final m = p as Map<String, dynamic>;
        final uname = m['username'] as String?;
        if (uname != null) usernameById[m['id'] as String] = uname;
      }
    }

    return matches
        .map((w) => ShareMatchCandidate(
              wine: w,
              sharedByUsername: usernameById[sharerByWine[w.id]],
            ))
        .toList();
  }

  Future<void> deleteGroup(String groupId) async {
    final client = ref.read(supabaseClientProvider);
    await client.from('groups').delete().eq('id', groupId);
    ref.invalidateSelf();
  }

  /// Removes [wineId] from [groupId]. RLS restricts this to the original
  /// sharer and the group owner; other members get a permission error.
  Future<void> unshareWineFromGroup({
    required String groupId,
    required String wineId,
  }) async {
    final client = ref.read(supabaseClientProvider);
    final rows = await client
        .from('group_wines')
        .delete()
        .eq('group_id', groupId)
        .eq('wine_id', wineId)
        .select();
    if (rows.isEmpty) {
      throw Exception('You cannot remove this wine from the group.');
    }
    ref.invalidate(groupWinesProvider(groupId));
    ref.invalidate(groupWineShareMetaProvider(groupId, wineId));
  }

  Future<void> updateGroup({
    required String groupId,
    String? name,
    String? imageUrl,
    bool clearImage = false,
  }) async {
    final client = ref.read(supabaseClientProvider);
    final patch = <String, dynamic>{};
    if (name != null) patch['name'] = name;
    if (clearImage) {
      patch['image_url'] = null;
    } else if (imageUrl != null) {
      patch['image_url'] = imageUrl;
    }
    if (patch.isEmpty) return;
    final rows = await client
        .from('groups')
        .update(patch)
        .eq('id', groupId)
        .select();
    if (rows.isEmpty) {
      throw Exception('You do not have permission to edit this group.');
    }
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

// ========================================
// SORT STATE
// ========================================

enum GroupSortMode { recent, name }

const _groupSortModeKey = 'group_sort_mode';

@riverpod
class GroupSort extends _$GroupSort {
  @override
  GroupSortMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final stored = prefs.getString(_groupSortModeKey);
    return GroupSortMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => GroupSortMode.recent,
    );
  }

  Future<void> toggle() async {
    final next = state == GroupSortMode.recent
        ? GroupSortMode.name
        : GroupSortMode.recent;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_groupSortModeKey, next.name);
    state = next;
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

/// Lightweight metadata about how a wine was shared into a group.
/// Used to decide who can unshare it (sharer + group owner).
@riverpod
Future<String?> groupWineShareMeta(
    GroupWineShareMetaRef ref, String groupId, String wineId) async {
  final client = ref.read(supabaseClientProvider);
  final row = await client
      .from('group_wines')
      .select('shared_by')
      .eq('group_id', groupId)
      .eq('wine_id', wineId)
      .maybeSingle();
  return row?['shared_by'] as String?;
}


