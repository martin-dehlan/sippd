import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../common/services/deep_link/deep_link.service.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../controller/group_invitation.provider.dart';

class InviteShareSheet extends ConsumerWidget {
  final String code;
  final String groupId;
  final String groupName;

  const InviteShareSheet({
    super.key,
    required this.code,
    required this.groupId,
    required this.groupName,
  });

  static Future<void> show(
    BuildContext context, {
    required String code,
    required String groupId,
    required String groupName,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (_) => InviteShareSheet(
        code: code,
        groupId: groupId,
        groupName: groupName,
      ),
    );
  }

  String get _inviteUri => DeepLinkService.groupInviteHttpsUri(code);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final maxH = MediaQuery.of(context).size.height * 0.85;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxH),
        child: Padding(
          padding: EdgeInsets.only(
            left: context.paddingH * 1.3,
            right: context.paddingH * 1.3,
            top: context.l,
            bottom: context.l,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: context.w * 0.1,
                  height: context.xs,
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(context.xs),
                  ),
                ),
              ),
              SizedBox(height: context.l),
              Text(
                'INVITE',
                style: TextStyle(
                  fontSize: context.captionFont * 0.95,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: context.l),
              _CodeBlock(code: code),
              SizedBox(height: context.m),
              _ActionRow(
                onCopy: () => _copy(context),
                onShare: () => _share(context),
              ),
              SizedBox(height: context.l),
              Divider(color: cs.outlineVariant, height: 1),
              SizedBox(height: context.m),
              Text(
                'INVITE FRIENDS',
                style: TextStyle(
                  fontSize: context.captionFont * 0.95,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: context.s),
              Flexible(child: _FriendList(groupId: groupId)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: code));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invite code copied'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _share(BuildContext context) async {
    await Share.share(
      'Join "$groupName" on Sippd 🍷\n\n$_inviteUri\n\nOr enter code: $code',
      subject: 'Join $groupName on Sippd',
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.m,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.vpn_key_outlined,
              color: cs.primary, size: context.w * 0.05),
          SizedBox(width: context.w * 0.025),
          Text(
            code,
            style: TextStyle(
              fontSize: context.bodyFont * 1.25,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
              color: cs.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final VoidCallback onCopy;
  final VoidCallback onShare;
  const _ActionRow({required this.onCopy, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Action(
            icon: Icons.copy_rounded,
            label: 'Copy code',
            onTap: onCopy,
          ),
        ),
        SizedBox(width: context.s),
        Expanded(
          child: _Action(
            icon: Icons.ios_share_rounded,
            label: 'Share link',
            onTap: onShare,
            filled: true,
          ),
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;
  const _Action({
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = filled ? cs.primary : cs.surfaceContainer;
    final fg = filled ? cs.onPrimary : cs.onSurface;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.m),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fg, size: context.w * 0.045),
              SizedBox(width: context.w * 0.02),
              Text(
                label,
                style: TextStyle(
                  fontSize: context.captionFont * 1.05,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FriendList extends ConsumerWidget {
  final String groupId;
  const _FriendList({required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final friendsAsync = ref.watch(invitableFriendsForGroupProvider(groupId));

    return friendsAsync.when(
      data: (friends) {
        if (friends.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: context.m),
            child: Text(
              'No friends available to invite.',
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
          separatorBuilder: (_, _) => SizedBox(height: context.xs),
          itemBuilder: (_, i) => _FriendRow(
            friend: friends[i],
            onInvite: () => _invite(context, ref, friends[i]),
          ),
        );
      },
      loading: () => Padding(
        padding: EdgeInsets.symmetric(vertical: context.m),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: EdgeInsets.symmetric(vertical: context.m),
        child: Text('Could not load friends: $e',
            style: TextStyle(color: cs.error)),
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
