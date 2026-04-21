import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../controller/group.provider.dart';
import 'members_sheet.widget.dart';

class MembersStrip extends ConsumerWidget {
  final String groupId;
  final String? ownerId;
  const MembersStrip({super.key, required this.groupId, this.ownerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final membersAsync = ref.watch(groupMembersProvider(groupId));
    return membersAsync.when(
      data: (members) {
        if (members.isEmpty) {
          return Text('No members yet.',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ));
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => MembersSheet.show(context,
                groupId: groupId, members: members, ownerId: ownerId),
            borderRadius: BorderRadius.circular(context.w * 0.1),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.xs, horizontal: context.xs),
              child: _AvatarStack(
                members: members.take(5).toList(),
                extra: members.length > 5 ? members.length - 5 : 0,
                size: context.w * 0.11,
              ),
            ),
          ),
        );
      },
      loading: () => _MembersSkeleton(size: context.w * 0.11),
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
  const _AvatarStack({
    required this.members,
    required this.size,
    this.extra = 0,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final overlap = size * 0.35;
    final slots = members.length + (extra > 0 ? 1 : 0);
    final width = size + (slots - 1) * (size - overlap);
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
                  size: size - size * 0.06,
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
                  width: size - size * 0.06,
                  height: size - size * 0.06,
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
        ],
      ),
    );
  }
}
