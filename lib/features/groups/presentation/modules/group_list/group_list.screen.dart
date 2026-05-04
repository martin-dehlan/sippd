import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/services/analytics/analytics.provider.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../paywall/controller/paywall.provider.dart';
import '../../../controller/group.provider.dart';
import '../../../domain/entities/group.entity.dart';
import '../../widgets/group_invitations_inbox.widget.dart';
import '../group_detail/widgets/invite_share_sheet.widget.dart';

/// Free users can create up to this many groups before the paywall sheet
/// gates further group creation. Confirmed in monetization plan.
const int kFreeGroupLimit = 3;

class GroupListScreen extends ConsumerWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(groupControllerProvider);
    final sortMode = ref.watch(groupSortProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.xl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GROUPS',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: context.titleFont * 1.3,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            height: 1.05,
                          ),
                        ),
                        SizedBox(height: context.xs),
                        Text(
                          'Taste together',
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tooltip(
                    message: sortMode == GroupSortMode.recent
                        ? 'Sort: recent'
                        : 'Sort: name',
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () =>
                          ref.read(groupSortProvider.notifier).toggle(),
                      child: Padding(
                        padding: EdgeInsets.all(context.w * 0.02),
                        child: Icon(
                          sortMode == GroupSortMode.recent
                              ? PhosphorIconsRegular.clock
                              : PhosphorIconsRegular.sortAscending,
                          size: context.w * 0.055,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: context.w * 0.01),
                  _HeaderAddButton(
                    onTap: () => _onCreateTap(context, ref),
                    tooltip: 'Create group',
                  ),
                ],
              ),
            ),
            SizedBox(height: context.l),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
              child: _JoinCard(onTap: () => _showJoinSheet(context, ref)),
            ),
            SizedBox(height: context.m),
            const GroupInvitationsInbox(),
            Expanded(
              child: groupsAsync.when(
                data: (groups) {
                  if (groups.isEmpty) {
                    return _GroupEmptyState(
                      onCreate: () => _onCreateTap(context, ref),
                    );
                  }
                  final sorted = List<GroupEntity>.from(groups)
                    ..sort(switch (sortMode) {
                      GroupSortMode.recent => (a, b) => b.createdAt.compareTo(
                        a.createdAt,
                      ),
                      GroupSortMode.name =>
                        (a, b) => a.name.toLowerCase().compareTo(
                          b.name.toLowerCase(),
                        ),
                    });
                  return ListView.separated(
                    restorationId: 'group_list_scroll',
                    padding: EdgeInsets.symmetric(
                      horizontal: context.paddingH * 1.3,
                    ),
                    itemCount: sorted.length,
                    separatorBuilder: (_, _) => SizedBox(height: context.s),
                    itemBuilder: (_, index) => _GroupCard(group: sorted[index]),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: ErrorView(
                    title: "Couldn't load groups",
                    onRetry: () => ref.invalidate(groupControllerProvider),
                    error: e,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Gate: free users get [kFreeGroupLimit] groups. The 4th create attempt
  /// pushes the paywall screen; on successful purchase we drop straight
  /// into the create sheet so the user finishes the action they started.
  Future<void> _onCreateTap(BuildContext context, WidgetRef ref) async {
    final groups = ref.read(groupControllerProvider).valueOrNull ?? const [];
    final isPro = ref.read(isProProvider);
    if (!isPro && groups.length >= kFreeGroupLimit) {
      ref
          .read(analyticsProvider)
          .capture('group_gate_hit', properties: {'count': groups.length});
      final purchased = await context.push<bool>(
        AppRoutes.paywall,
        extra: const {'source': 'group_limit'},
      );
      if (!context.mounted || purchased != true) return;
      _showCreateSheet(context, ref);
      return;
    }
    _showCreateSheet(context, ref);
  }

  void _showCreateSheet(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (ctx) => _CreateSheet(
        nameController: nameController,
        onSubmit: () async {
          final name = nameController.text.trim();
          if (name.isEmpty) return;
          final created = await ref
              .read(groupControllerProvider.notifier)
              .createGroup(name);
          if (!ctx.mounted) return;
          Navigator.pop(ctx);
          // Group is fresh and empty — chain straight into the invite sheet
          // so the user fills it before they leave the moment.
          if (created != null && context.mounted) {
            await InviteShareSheet.show(
              context,
              code: created.inviteCode,
              groupId: created.id,
              groupName: created.name,
            );
          }
        },
      ),
    );
  }

  void _showJoinSheet(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (ctx) => _JoinSheet(
        controller: controller,
        onSubmit: () async {
          final code = controller.text.trim();
          if (code.isEmpty) return;
          try {
            await ref.read(groupControllerProvider.notifier).joinGroup(code);
            if (ctx.mounted) Navigator.pop(ctx);
          } catch (_) {
            if (ctx.mounted) {
              ScaffoldMessenger.of(
                ctx,
              ).showSnackBar(const SnackBar(content: Text('Group not found')));
            }
          }
        },
      ),
    );
  }
}

class _HeaderAddButton extends StatelessWidget {
  final VoidCallback onTap;
  final String tooltip;
  const _HeaderAddButton({required this.onTap, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.1;
    return Tooltip(
      message: tooltip,
      child: Material(
        color: cs.surfaceContainer,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              PhosphorIconsRegular.plus,
              color: cs.onSurface,
              size: context.w * 0.055,
            ),
          ),
        ),
      ),
    );
  }
}

class _JoinCard extends StatelessWidget {
  final VoidCallback onTap;
  const _JoinCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.m,
        ),
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Icon(
              PhosphorIconsRegular.link,
              color: cs.primary,
              size: context.w * 0.05,
            ),
            SizedBox(width: context.w * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join a group',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    'Enter an invite code',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: context.w * 0.04,
              color: cs.onPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final GroupEntity group;
  const _GroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push(AppRoutes.groupDetailPath(group.id)),
      child: Container(
        padding: EdgeInsets.all(context.w * 0.04),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
        child: Row(
          children: [
            Container(
              width: context.w * 0.12,
              height: context.w * 0.12,
              decoration: BoxDecoration(
                color: group.imageUrl == null
                    ? cs.primaryContainer
                    : cs.surfaceContainer,
                borderRadius: BorderRadius.circular(context.w * 0.03),
                image: group.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(group.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: group.imageUrl == null
                  ? Icon(
                      PhosphorIconsRegular.wine,
                      color: cs.primary,
                      size: context.w * 0.06,
                    )
                  : null,
            ),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Text(
                group.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: context.w * 0.035,
              color: cs.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupEmptyState extends StatelessWidget {
  final VoidCallback onCreate;
  const _GroupEmptyState({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: context.w * 0.2,
            height: context.w * 0.2,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsRegular.users,
              size: context.w * 0.1,
              color: cs.primary,
            ),
          ),
          SizedBox(height: context.m),
          Text(
            'No groups yet',
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            'Create or join one to share wines',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.l),
          FilledButton.icon(
            onPressed: onCreate,
            icon: const Icon(PhosphorIconsRegular.plus),
            label: const Text('Create group'),
          ),
        ],
      ),
    );
  }
}

class _CreateSheet extends StatelessWidget {
  final TextEditingController nameController;
  final VoidCallback onSubmit;

  const _CreateSheet({required this.nameController, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SafeArea(
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
                'New group',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                ),
              ),
              SizedBox(height: context.s),
              _BorderlessField(
                controller: nameController,
                hint: 'Group name',
                autofocus: true,
                big: true,
                maxLength: 30,
              ),
              SizedBox(height: context.l),
              SizedBox(
                width: double.infinity,
                height: context.h * 0.055,
                child: FilledButton(
                  onPressed: onSubmit,
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                  child: Text(
                    'Create',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.s),
            ],
          ),
        ),
      ),
    );
  }
}

class _JoinSheet extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  const _JoinSheet({required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SafeArea(
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
                'Invite code',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                ),
              ),
              SizedBox(height: context.s),
              _BorderlessField(
                controller: controller,
                hint: 'e.g. a1b2c3d4',
                autofocus: true,
                big: true,
              ),
              SizedBox(height: context.s),
              Container(height: 1, color: cs.outlineVariant),
              SizedBox(height: context.l),
              SizedBox(
                width: double.infinity,
                height: context.h * 0.055,
                child: FilledButton(
                  onPressed: onSubmit,
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                  child: Text(
                    'Join',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.s),
            ],
          ),
        ),
      ),
    );
  }
}

class _BorderlessField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool autofocus;
  final bool big;
  final int? maxLength;

  const _BorderlessField({
    required this.controller,
    required this.hint,
    this.autofocus = false,
    this.big = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final style = big
        ? TextStyle(
            fontSize: context.titleFont * 1.1,
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: -0.5,
            color: cs.onSurface,
          )
        : TextStyle(
            fontSize: context.bodyFont,
            height: 1.5,
            color: cs.onSurface,
          );
    return TextField(
      controller: controller,
      autofocus: autofocus,
      maxLines: 1,
      maxLength: maxLength,
      cursorColor: cs.primary,
      cursorWidth: 1.5,
      style: style,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: style.copyWith(
          color: cs.outline,
          fontWeight: big ? FontWeight.bold : FontWeight.w400,
        ),
        filled: false,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
