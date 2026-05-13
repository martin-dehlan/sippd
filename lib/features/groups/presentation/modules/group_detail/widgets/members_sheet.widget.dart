import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';
import '../../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../../friends/presentation/widgets/friend_avatar.widget.dart';

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
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (_) =>
          MembersSheet(groupId: groupId, members: members, ownerId: ownerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
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
                  members.length == 1
                      ? l10n.groupMembersCountOne
                      : l10n.groupMembersCountMany(members.length),
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.s),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: members.length,
                separatorBuilder: (_, _) => SizedBox(height: context.xs),
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

class _MemberRow extends StatelessWidget {
  final FriendProfileEntity member;
  final bool isOwner;
  const _MemberRow({required this.member, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final name =
        member.displayName ?? member.username ?? l10n.groupMembersUnknown;
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
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (member.username != null) ...[
                    SizedBox(height: context.xs * 0.4),
                    Text(
                      '@${member.username}',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
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
                child: Text(
                  l10n.groupMembersOwnerBadge,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.75,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
