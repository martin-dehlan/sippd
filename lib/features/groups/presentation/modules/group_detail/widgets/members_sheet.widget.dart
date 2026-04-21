import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';
import '../../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../controller/group_invitation.provider.dart';

class MembersSheet extends StatelessWidget {
  final String groupId;
  final List<FriendProfileEntity> members;
  final String? ownerId;
  const MembersSheet({
    super.key,
    required this.groupId,
    required this.members,
    this.ownerId,
  });

  static Future<void> show(
    BuildContext context, {
    required String groupId,
    required List<FriendProfileEntity> members,
    String? ownerId,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.w * 0.05)),
      ),
      builder: (_) => MembersSheet(
        groupId: groupId,
        members: members,
        ownerId: ownerId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.m,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.m),
            Row(
              children: [
                Text(
                  '${members.length} '
                  '${members.length == 1 ? 'member' : 'members'}',
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.s),
            _InviteButton(groupId: groupId),
            SizedBox(height: context.s),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: members.length,
                separatorBuilder: (_, _) =>
                    SizedBox(height: context.xs),
                itemBuilder: (_, i) => _MemberRow(
                  member: members[i],
                  isOwner: members[i].id == ownerId,
                ),
              ),
            ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }
}

class _InviteButton extends StatelessWidget {
  final String groupId;
  const _InviteButton({required this.groupId});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.primaryContainer,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showFriendPicker(context, groupId),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.04,
            vertical: context.s * 1.4,
          ),
          child: Row(
            children: [
              Icon(Icons.person_add_alt_1,
                  color: cs.primary, size: context.w * 0.055),
              SizedBox(width: context.w * 0.03),
              Expanded(
                child: Text(
                  'Invite friends',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onPrimaryContainer,
                  ),
                ),
              ),
              Icon(Icons.chevron_right,
                  size: context.w * 0.05, color: cs.onPrimaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}

void _showFriendPicker(BuildContext context, String groupId) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (_) => _FriendPickerSheet(groupId: groupId),
  );
}

class _FriendPickerSheet extends ConsumerWidget {
  final String groupId;
  const _FriendPickerSheet({required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final friendsAsync = ref.watch(invitableFriendsForGroupProvider(groupId));

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.m,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.m),
            Text(
              'Invite friends',
              style: TextStyle(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.m),
            Flexible(
              child: friendsAsync.when(
                data: (friends) {
                  if (friends.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: context.l),
                      child: Text(
                        'No friends available to invite. Anyone not in '
                        'this group and without a pending invite will '
                        'show up here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.bodyFont * 0.95,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: friends.length,
                    separatorBuilder: (_, _) =>
                        SizedBox(height: context.xs),
                    itemBuilder: (_, i) => _FriendRow(
                      friend: friends[i],
                      onInvite: () =>
                          _invite(context, ref, friends[i]),
                    ),
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Could not load friends: $e',
                    style: TextStyle(color: cs.error)),
              ),
            ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }

  Future<void> _invite(
    BuildContext context,
    WidgetRef ref,
    FriendProfileEntity friend,
  ) async {
    final name = friend.displayName ?? friend.username ?? 'friend';
    try {
      await ref
          .read(groupInvitationControllerProvider.notifier)
          .invite(groupId: groupId, inviteeId: friend.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invite sent to $name')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not send invite: $e')),
      );
    }
  }
}

class _FriendRow extends StatelessWidget {
  final FriendProfileEntity friend;
  final VoidCallback onInvite;

  const _FriendRow({required this.friend, required this.onInvite});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final name = friend.displayName ?? friend.username ?? 'Unknown';
    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onInvite,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.035,
            vertical: context.s,
          ),
          child: Row(
            children: [
              FriendAvatar(profile: friend, size: context.w * 0.11),
              SizedBox(width: context.w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (friend.username != null) ...[
                      SizedBox(height: context.xs * 0.4),
                      Text('@${friend.username}',
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          )),
                    ],
                  ],
                ),
              ),
              Icon(Icons.send_outlined,
                  color: cs.primary, size: context.w * 0.045),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  final FriendProfileEntity member;
  final bool isOwner;
  const _MemberRow({required this.member, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final name = member.displayName ?? member.username ?? 'Unknown';
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        context.push(AppRoutes.friendProfilePath(member.id));
      },
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.02,
          vertical: context.s,
        ),
        child: Row(
          children: [
            FriendAvatar(profile: member, size: context.w * 0.11),
            SizedBox(width: context.w * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  if (member.username != null) ...[
                    SizedBox(height: context.xs * 0.4),
                    Text('@${member.username}',
                        style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant,
                        )),
                  ],
                ],
              ),
            ),
            if (isOwner)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.025,
                  vertical: context.xs,
                ),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(context.w * 0.02),
                ),
                child: Text('OWNER',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.75,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                      letterSpacing: 0.5,
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
