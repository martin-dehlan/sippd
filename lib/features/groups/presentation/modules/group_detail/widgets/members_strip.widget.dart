import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../controller/group.provider.dart';
import 'members_sheet.widget.dart';

class MembersStrip extends ConsumerWidget {
  final String groupId;
  final String? ownerId;
  final VoidCallback? onInviteTap;

  const MembersStrip({
    super.key,
    required this.groupId,
    this.ownerId,
    this.onInviteTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = context.w * 0.09;
    final membersAsync = ref.watch(groupMembersProvider(groupId));
    return membersAsync.when(
      data: (members) {
        return InkWell(
          onTap: members.isEmpty
              ? null
              : () => MembersSheet.show(context,
                  groupId: groupId,
                  members: members,
                  ownerId: ownerId),
          borderRadius: BorderRadius.circular(context.w * 0.1),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.xs, horizontal: context.xs),
            child: _AvatarStack(
              members: members.take(5).toList(),
              extra: members.length > 5 ? members.length - 5 : 0,
              size: size,
              onInviteTap: onInviteTap,
            ),
          ),
        );
      },
      loading: () => _MembersSkeleton(size: size),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _MembersSkeleton extends StatelessWidget {
  final double size;
  const _MembersSkeleton({required this.size});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final overlap = size * 0.35;
    const count = 3;
    final width = size + (count - 1) * (size - overlap);
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.xs, horizontal: context.xs),
        child: SizedBox(
          width: width,
          height: size,
          child: Stack(
            children: [
              for (int i = 0; i < count; i++)
                Positioned(
                  left: i * (size - overlap),
                  child: Container(
                    padding: EdgeInsets.all(size * 0.03),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: size - size * 0.06,
                      height: size - size * 0.06,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  final List<FriendProfileEntity> members;
  final int extra;
  final double size;
  final VoidCallback? onInviteTap;

  const _AvatarStack({
    required this.members,
    required this.size,
    this.extra = 0,
    this.onInviteTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final overlap = size * 0.55;
    final memberSlots = members.length + (extra > 0 ? 1 : 0);
    final inviteSlot = onInviteTap != null ? 1 : 0;
    final slots = memberSlots + inviteSlot;
    final width = slots == 0 ? 0.0 : size + (slots - 1) * (size - overlap);
    final inner = size - size * 0.06;

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < members.length; i++)
            Positioned(
              left: i * (size - overlap),
              child: Container(
                padding: EdgeInsets.all(size * 0.03),
                decoration: BoxDecoration(
                  color: cs.surface,
                  shape: BoxShape.circle,
                ),
                child: FriendAvatar(
                  profile: members[i],
                  size: inner,
                ),
              ),
            ),
          if (extra > 0)
            Positioned(
              left: members.length * (size - overlap),
              child: Container(
                padding: EdgeInsets.all(size * 0.03),
                decoration: BoxDecoration(
                  color: cs.surface,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: inner,
                  height: inner,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+$extra',
                    style: TextStyle(
                      fontSize: size * 0.32,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                ),
              ),
            ),
          if (onInviteTap != null)
            Positioned(
              left: memberSlots * (size - overlap),
              child: GestureDetector(
                onTap: onInviteTap,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.all(size * 0.03),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: inner,
                    height: inner,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.surfaceContainerHighest,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      PhosphorIconsRegular.userPlus,
                      color: cs.onSurface,
                      size: inner * 0.5,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
