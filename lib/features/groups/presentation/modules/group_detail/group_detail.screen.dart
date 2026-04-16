import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/group.provider.dart';
import '../../../domain/entities/group.entity.dart';

class GroupDetailScreen extends ConsumerWidget {
  final String groupId;
  const GroupDetailScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupAsync = ref.watch(groupDetailProvider(groupId));

    return Scaffold(
      body: SafeArea(
        child: groupAsync.when(
          data: (group) {
            if (group == null) {
              return const Center(child: Text('Group not found'));
            }
            return _Body(group: group);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
      floatingActionButton: const _BackFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _BackFab extends StatelessWidget {
  const _BackFab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'group-detail-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => context.pop(),
        child: Icon(Icons.arrow_back_ios_new, size: context.w * 0.06),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  final GroupEntity group;
  const _Body({required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final currentUid = ref.watch(currentUserIdProvider);
    final isOwner = currentUid == group.createdBy;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: context.xl * 1.5),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Text(
            group.name.toUpperCase(),
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 1.2,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.05,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (group.description != null && group.description!.isNotEmpty) ...[
          SizedBox(height: context.s),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: Text(
              group.description!,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ),
        ],
        SizedBox(height: context.l),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: _InviteCodeCard(code: group.inviteCode),
        ),
        SizedBox(height: context.l),
        _SectionHeader(label: 'Members'),
        SizedBox(height: context.s),
        _MembersRow(groupId: group.id),
        SizedBox(height: context.l),
        _SectionHeader(label: 'Shared wines'),
        SizedBox(height: context.s),
        _SharedWines(groupId: group.id),
        SizedBox(height: context.l),
        _SectionHeader(label: 'Tastings'),
        SizedBox(height: context.s),
        _TastingsPlaceholder(),
        SizedBox(height: context.xl),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Center(
            child: TextButton(
              onPressed: () => _confirmLeaveOrDelete(
                  context, ref, group.id, isOwner),
              child: Text(
                isOwner ? 'Delete group' : 'Leave group',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w500,
                  color: cs.error,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: context.xl * 2),
      ],
    );
  }

  Future<void> _confirmLeaveOrDelete(BuildContext context, WidgetRef ref,
      String groupId, bool isOwner) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isOwner ? 'Delete group?' : 'Leave group?'),
        content: Text(isOwner
            ? 'The group and its shared wines will be removed for everyone.'
            : 'You can rejoin later with the invite code.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(isOwner ? 'Delete' : 'Leave',
                style:
                    TextStyle(color: Theme.of(ctx).colorScheme.error)),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    if (isOwner) {
      await ref.read(groupControllerProvider.notifier).deleteGroup(groupId);
    } else {
      await ref.read(groupControllerProvider.notifier).leaveGroup(groupId);
    }
    if (context.mounted) context.pop();
  }
}

class _InviteCodeCard extends StatelessWidget {
  final String code;
  const _InviteCodeCard({required this.code});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: code));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invite code copied')),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.04, vertical: context.m),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Icon(Icons.link, color: cs.primary, size: context.w * 0.05),
            SizedBox(width: context.w * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Invite code',
                      style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.primary,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3)),
                  SizedBox(height: context.xs * 0.3),
                  Text(code,
                      style: TextStyle(
                          fontSize: context.bodyFont * 1.1,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5)),
                ],
              ),
            ),
            Icon(Icons.copy, color: cs.outline, size: context.w * 0.05),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Text(label,
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w700,
            color: cs.primary,
            letterSpacing: 0.3,
          )),
    );
  }
}

class _MembersRow extends ConsumerWidget {
  final String groupId;
  const _MembersRow({required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(groupMembersProvider(groupId));
    return membersAsync.when(
      data: (members) {
        if (members.isEmpty) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: Text('No members yet.',
                style: TextStyle(
                    fontSize: context.captionFont,
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          );
        }
        return SizedBox(
          height: context.w * 0.2,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            itemCount: members.length,
            separatorBuilder: (_, __) => SizedBox(width: context.w * 0.03),
            itemBuilder: (_, i) => _MemberAvatar(member: members[i]),
          ),
        );
      },
      loading: () => SizedBox(
        height: context.w * 0.2,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  final FriendProfileEntity member;
  const _MemberAvatar({required this.member});

  @override
  Widget build(BuildContext context) {
    final name = member.displayName ?? member.username ?? '?';
    return GestureDetector(
      onTap: () => context.push(AppRoutes.friendProfilePath(member.id)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FriendAvatar(profile: member, size: context.w * 0.13),
          SizedBox(height: context.xs * 0.5),
          SizedBox(
            width: context.w * 0.16,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SharedWines extends ConsumerWidget {
  final String groupId;
  const _SharedWines({required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(groupWinesProvider(groupId));
    return winesAsync.when(
      data: (wines) {
        if (wines.isEmpty) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: Text('No wines shared yet.',
                style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant)),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          itemCount: wines.length,
          separatorBuilder: (_, __) => SizedBox(height: context.s),
          itemBuilder: (_, i) => _GroupWineRow(wine: wines[i]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _GroupWineRow extends StatelessWidget {
  final WineEntity wine;
  const _GroupWineRow({required this.wine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
    };
    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        children: [
          Container(
            width: context.w * 0.025,
            height: context.w * 0.1,
            decoration: BoxDecoration(
              color: typeColor,
              borderRadius: BorderRadius.circular(context.w * 0.01),
            ),
          ),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wine.name.toUpperCase(),
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: context.xs * 0.4),
                Text(
                  [
                    if (wine.vintage != null) wine.vintage.toString(),
                    if (wine.country != null) wine.country,
                  ].join(' · '),
                  style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Text(wine.rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: context.bodyFont * 1.2,
                fontWeight: FontWeight.bold,
                color: cs.primary,
              )),
        ],
      ),
    );
  }
}

class _TastingsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Container(
        padding: EdgeInsets.all(context.m),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Icon(Icons.event_outlined,
                color: cs.outline, size: context.w * 0.05),
            SizedBox(width: context.w * 0.03),
            Expanded(
              child: Text('Tastings coming soon',
                  style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant)),
            ),
          ],
        ),
      ),
    );
  }
}
