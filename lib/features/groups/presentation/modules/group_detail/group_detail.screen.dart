import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../controller/group.provider.dart';
import '../../../domain/entities/group.entity.dart';
import 'widgets/invite_code_pill.widget.dart';
import 'widgets/members_strip.widget.dart';
import 'widgets/shared_wines_carousel.widget.dart';
import 'widgets/tastings_calendar.widget.dart';
import 'widgets/wine_picker_sheet.widget.dart';

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
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  const _FloatingBackButton();

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
    final padH = context.paddingH * 1.3;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: context.xl * 1.5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
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
            padding: EdgeInsets.symmetric(horizontal: padH),
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
        SizedBox(height: context.m),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InviteCodePill(
              code: group.inviteCode,
              groupName: group.name,
            ),
          ),
        ),
        SizedBox(height: context.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: MembersStrip(
            groupId: group.id,
            ownerId: group.createdBy,
          ),
        ),
        SizedBox(height: context.l),
        _SectionHeader(
          label: 'Shared wines',
          action: _SectionAction(
            icon: Icons.add,
            label: 'Share',
            onTap: () =>
                WinePickerSheet.show(context, groupId: group.id),
          ),
        ),
        SizedBox(height: context.s),
        SharedWinesCarousel(groupId: group.id),
        SizedBox(height: context.l),
        _SectionHeader(
          label: 'Tastings',
          action: _SectionAction(
            icon: Icons.add,
            label: 'Plan',
            onTap: () =>
                context.push(AppRoutes.tastingCreatePath(group.id)),
          ),
        ),
        SizedBox(height: context.s),
        TastingsCalendar(groupId: group.id),
        SizedBox(height: context.xl),
        Center(
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
        SizedBox(height: context.xl * 2),
      ],
    );
  }

  Future<void> _confirmLeaveOrDelete(
    BuildContext context,
    WidgetRef ref,
    String groupId,
    bool isOwner,
  ) async {
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

class _SectionHeader extends StatelessWidget {
  final String label;
  final Widget? action;
  const _SectionHeader({required this.label, this.action});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
                letterSpacing: -0.2,
              ),
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}

class _SectionAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SectionAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: context.w * 0.04, color: cs.primary),
          SizedBox(width: context.w * 0.01),
          Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w600,
              color: cs.primary,
            ),
          ),
        ],
      ),
    );
  }
}
