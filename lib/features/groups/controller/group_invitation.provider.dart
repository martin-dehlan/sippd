import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/services/analytics/analytics.provider.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/controller/friends.provider.dart';
import '../../friends/domain/entities/friend_profile.entity.dart';
import '../data/models/group_invitation.model.dart';
import '../domain/entities/group_invitation.entity.dart';
import 'group.provider.dart';

part 'group_invitation.provider.g.dart';

/// Groups the current user can invite a friend to:
/// groups they're a member of, minus the ones the friend already joined
/// or already has a pending invite for.
@riverpod
Future<List<({String groupId, String name, String? imageUrl})>>
    invitableGroupsForFriend(
  InvitableGroupsForFriendRef ref,
  String friendId,
) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const [];

  final client = ref.read(supabaseClientProvider);

  // My groups.
  final myMemberships = await client
      .from('group_members')
      .select('group_id')
      .eq('user_id', userId);
  if ((myMemberships as List).isEmpty) return const [];
  final myGroupIds =
      myMemberships.map((m) => m['group_id'] as String).toList();

  // Groups the friend already joined.
  final friendMemberships = await client
      .from('group_members')
      .select('group_id')
      .eq('user_id', friendId)
      .inFilter('group_id', myGroupIds);
  final friendGroupIds = (friendMemberships as List)
      .map((m) => m['group_id'] as String)
      .toSet();

  // Pending invites already sent to friend for these groups.
  final pendingInvites = await client
      .from('group_invitations')
      .select('group_id')
      .eq('invitee_id', friendId)
      .eq('status', 'pending')
      .inFilter('group_id', myGroupIds);
  final pendingGroupIds = (pendingInvites as List)
      .map((m) => m['group_id'] as String)
      .toSet();

  final eligibleIds = myGroupIds
      .where((id) =>
          !friendGroupIds.contains(id) && !pendingGroupIds.contains(id))
      .toList();
  if (eligibleIds.isEmpty) return const [];

  final groups = await client
      .from('groups')
      .select('id, name, image_url')
      .inFilter('id', eligibleIds);

  return (groups as List)
      .map((g) => (
            groupId: g['id'] as String,
            name: g['name'] as String,
            imageUrl: g['image_url'] as String?,
          ))
      .toList();
}

/// Friends of the current user who are not yet in the group and don't
/// already have a pending invite. Used by the group members sheet to
/// offer an "Invite friends" flow.
@riverpod
Future<List<FriendProfileEntity>> invitableFriendsForGroup(
  InvitableFriendsForGroupRef ref,
  String groupId,
) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const [];

  final client = ref.read(supabaseClientProvider);

  final friends =
      await ref.watch(friendsListProvider.future);
  if (friends.isEmpty) return const [];
  final friendIds = friends.map((f) => f.id).toList();

  final members = await client
      .from('group_members')
      .select('user_id')
      .eq('group_id', groupId)
      .inFilter('user_id', friendIds);
  final memberIds = (members as List)
      .map((m) => m['user_id'] as String)
      .toSet();

  final pending = await client
      .from('group_invitations')
      .select('invitee_id')
      .eq('group_id', groupId)
      .eq('status', 'pending')
      .inFilter('invitee_id', friendIds);
  final pendingIds = (pending as List)
      .map((m) => m['invitee_id'] as String)
      .toSet();

  return friends
      .where((f) =>
          !memberIds.contains(f.id) && !pendingIds.contains(f.id))
      .toList();
}

/// Pending invitations addressed to the current user, enriched with
/// group + inviter info for display in the inbox.
@riverpod
Future<List<GroupInvitationInboxItem>> myGroupInvitations(
  MyGroupInvitationsRef ref,
) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const [];

  final client = ref.read(supabaseClientProvider);

  // Realtime: refetch when a new invitation arrives or its status changes
  // (another device accepting/declining it).
  final channel = client.channel('group_invitations_inbox_$userId');
  channel
      .onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'group_invitations',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'invitee_id',
          value: userId,
        ),
        callback: (_) => ref.invalidateSelf(),
      )
      .subscribe();
  ref.onDispose(() {
    client.removeChannel(channel);
  });

  final rows = await client
      .from('group_invitations')
      .select()
      .eq('invitee_id', userId)
      .eq('status', 'pending')
      .order('created_at', ascending: false);

  final invitations = (rows as List)
      .map((r) => GroupInvitationModel.fromJson(r).toEntity())
      .toList();
  if (invitations.isEmpty) return const [];

  final groupIds = invitations.map((i) => i.groupId).toSet().toList();
  final inviterIds = invitations.map((i) => i.inviterId).toSet().toList();

  final groups = await client
      .from('groups')
      .select('id, name, image_url')
      .inFilter('id', groupIds);
  final groupMap = {
    for (final g in groups as List)
      g['id'] as String: (
        name: g['name'] as String,
        imageUrl: g['image_url'] as String?,
      ),
  };

  final profiles = await client
      .from('profiles')
      .select('id, display_name, username, avatar_url')
      .inFilter('id', inviterIds);
  final profileMap = {
    for (final p in profiles as List)
      p['id'] as String: (
        displayName: p['display_name'] as String?,
        username: p['username'] as String?,
        avatarUrl: p['avatar_url'] as String?,
      ),
  };

  return invitations.map((inv) {
    final g = groupMap[inv.groupId];
    final p = profileMap[inv.inviterId];
    return GroupInvitationInboxItem(
      invitation: inv,
      groupName: g?.name ?? 'Unknown group',
      groupImageUrl: g?.imageUrl,
      inviterDisplayName: p?.displayName,
      inviterUsername: p?.username,
      inviterAvatarUrl: p?.avatarUrl,
    );
  }).toList();
}

@riverpod
class GroupInvitationController extends _$GroupInvitationController {
  @override
  void build() {}

  Future<void> invite({
    required String groupId,
    required String inviteeId,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) throw Exception('Not signed in');
    final client = ref.read(supabaseClientProvider);

    await client.from('group_invitations').insert({
      'group_id': groupId,
      'inviter_id': userId,
      'invitee_id': inviteeId,
    });

    ref.read(analyticsProvider).capture('group_invite_sent');
    ref.invalidate(invitableGroupsForFriendProvider(inviteeId));
    ref.invalidate(invitableFriendsForGroupProvider(groupId));
  }

  Future<void> accept(GroupInvitationEntity invitation) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null || userId != invitation.inviteeId) {
      throw Exception('Not authorised');
    }
    final client = ref.read(supabaseClientProvider);

    // Insert membership first; if it fails, leave invitation pending.
    await client.from('group_members').insert({
      'group_id': invitation.groupId,
      'user_id': userId,
      'role': 'member',
    });

    await client
        .from('group_invitations')
        .update({
          'status': 'accepted',
          'responded_at': DateTime.now().toIso8601String(),
        })
        .eq('id', invitation.id);

    ref.read(analyticsProvider).capture(
      'group_joined',
      properties: const {'via': 'invitation'},
    );
    ref.invalidate(myGroupInvitationsProvider);
    ref.invalidate(groupControllerProvider);
  }

  Future<void> decline(GroupInvitationEntity invitation) async {
    final client = ref.read(supabaseClientProvider);
    await client
        .from('group_invitations')
        .update({
          'status': 'declined',
          'responded_at': DateTime.now().toIso8601String(),
        })
        .eq('id', invitation.id);
    ref.read(analyticsProvider).capture('group_invite_declined');
    ref.invalidate(myGroupInvitationsProvider);
  }
}
