import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../../common/widgets/overflow_menu.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../controller/group.provider.dart';
import '../../../domain/entities/group.entity.dart';
import 'widgets/edit_group_sheet.widget.dart';
import 'widgets/invite_share_sheet.widget.dart';
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
          error: (e, _) => Center(
            child: ErrorView(title: "Couldn't load group", error: e),
          ),
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
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  final GroupEntity group;
  const _Body({required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUid = ref.watch(currentUserIdProvider);
    final isOwner = currentUid == group.createdBy;
    final padH = context.paddingH * 1.3;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: context.xl * 1.5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  group.name.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 1.2,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.05,
                  ),
                ),
              ),
              SizedBox(width: context.m),
              _GroupMenu(
                isOwner: isOwner,
                onEdit: () => EditGroupSheet.show(context, group),
                onDelete: () => _confirmDelete(context, ref, group.id),
                onLeave: () => _confirmLeave(context, ref, group.id),
              ),
            ],
          ),
        ),
        SizedBox(height: context.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: Align(
            alignment: Alignment.centerLeft,
            child: MembersStrip(
              groupId: group.id,
              ownerId: group.createdBy,
              onInviteTap: () => InviteShareSheet.show(
                context,
                code: group.inviteCode,
                groupId: group.id,
                groupName: group.name,
              ),
            ),
          ),
        ),
        SizedBox(height: context.l),
        _SectionHeader(
          label: 'Shared wines',
          action: _SectionAction(
            icon: PhosphorIconsRegular.plus,
            label: 'Share',
            onTap: () => WinePickerSheet.show(context, groupId: group.id),
          ),
        ),
        SizedBox(height: context.s),
        SharedWinesCarousel(groupId: group.id),
        SizedBox(height: context.l),
        _SectionHeader(
          label: 'Tastings',
          action: _SectionAction(
            icon: PhosphorIconsRegular.plus,
            label: 'Plan',
            onTap: () => context.push(AppRoutes.tastingCreatePath(group.id)),
          ),
        ),
        SizedBox(height: context.s),
        TastingsCalendar(groupId: group.id),
        SizedBox(height: context.xl * 2),
      ],
    );
  }

  Future<void> _confirmLeave(
    BuildContext context,
    WidgetRef ref,
    String groupId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave group?'),
        content: const Text('You can rejoin later with the invite code.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Leave',
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await ref.read(groupControllerProvider.notifier).leaveGroup(groupId);
    if (context.mounted) context.pop();
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String groupId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete group?'),
        content: const Text(
          'The group and its shared wines will be removed for everyone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await ref.read(groupControllerProvider.notifier).deleteGroup(groupId);
    if (context.mounted) context.pop();
  }
}

class _GroupMenu extends StatelessWidget {
  final bool isOwner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onLeave;
  const _GroupMenu({
    required this.isOwner,
    required this.onEdit,
    required this.onDelete,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowMenu(
      groups: [
        if (isOwner)
          [
            OverflowMenuItem(
              icon: PhosphorIconsRegular.pencilSimple,
              label: 'Edit group',
              onTap: onEdit,
            ),
            OverflowMenuItem(
              icon: PhosphorIconsRegular.trash,
              label: 'Delete group',
              destructive: true,
              onTap: onDelete,
            ),
          ]
        else
          [
            OverflowMenuItem(
              icon: PhosphorIconsRegular.signOut,
              label: 'Leave group',
              destructive: true,
              onTap: onLeave,
            ),
          ],
      ],
    );
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
              label.toUpperCase(),
              style: TextStyle(
                fontSize: context.captionFont * 0.95,
                fontWeight: FontWeight.w700,
                color: cs.onSurface.withValues(alpha: 0.72),
                letterSpacing: 1.2,
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
