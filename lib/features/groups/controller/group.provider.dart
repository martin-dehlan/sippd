import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/data/models/friend_profile.model.dart';
import '../../friends/domain/entities/friend_profile.entity.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/data/models/wine.model.dart';
import '../../wines/domain/entities/wine.entity.dart';
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
  final rows = (await client
      .from('group_wine_ratings')
      .select()
      .eq('group_id', groupId)
      .eq('wine_id', wineId)) as List;
  if (rows.isEmpty) return const [];

  final models = rows
      .map((r) => GroupWineRatingModel.fromJson(r as Map<String, dynamic>))
      .toList();

  final userIds = models.map((m) => m.userId).toSet().toList();
  final profileRows = (await client
      .from('profiles')
      .select('id, username, display_name, avatar_url')
      .inFilter('id', userIds)) as List;
  final profiles = {
    for (final p in profileRows)
      (p as Map<String, dynamic>)['id'] as String: p,
  };

  return models
      .map((m) => m.toEntity(
            username: profiles[m.userId]?['username'] as String?,
            displayName: profiles[m.userId]?['display_name'] as String?,
            avatarUrl: profiles[m.userId]?['avatar_url'] as String?,
          ))
      .toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
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
  }
}

@riverpod
Future<List<WineEntity>> groupWines(
    GroupWinesRef ref, String groupId) async {
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
  final wineRows = (await client
      .from('wines')
      .select()
      .inFilter('id', wineIds)) as List;
  final byId = {
    for (final r in wineRows)
      (r as Map<String, dynamic>)['id'] as String:
          WineModel.fromJson(r).toEntity(),
  };
  return wineIds.map((id) => byId[id]).whereType<WineEntity>().toList();
}
