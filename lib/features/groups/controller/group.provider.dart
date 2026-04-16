import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../domain/entities/group.entity.dart';
import '../data/models/group.model.dart';

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

    await client.from('group_wines').upsert({
      'group_id': groupId,
      'wine_id': wineId,
      'shared_by': userId,
    });
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
