import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../../common/widgets/overflow_menu.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../promo/promo.config.dart';
import '../../../../promo/presentation/demo_spotlight.widget.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/group.provider.dart';
import '../../../domain/entities/group.entity.dart';
import 'widgets/edit_group_sheet.widget.dart';
import 'widgets/group_wine_rating_sheet.widget.dart';
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: groupAsync.when(
          data: (group) {
            if (group == null) {
              return Center(child: Text(l10n.groupDetailNotFound));
            }
            return _Body(group: group);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: ErrorView(title: l10n.groupDetailErrorLoad, error: e),
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

class _Body extends ConsumerStatefulWidget {
  final GroupEntity group;
  const _Body({required this.group});

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  // Demo only: scroll + spotlight the three group sections in turn.
  final ScrollController _scroll = ScrollController();
  final GlobalKey _membersKey = GlobalKey();
  final GlobalKey _sharedWinesKey = GlobalKey();
  final GlobalKey _tastingsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (kIsDemo) _runDemoBeats();
  }

  /// Demo only: walk the group's three sections one at a time — members,
  /// shared wines, then tastings. Each section is scrolled into view, then
  /// spotlighted (it pops, the rest dim) for a brief hold. Purely visual —
  /// no group data is created, shared, left, or deleted. The busy flag keeps
  /// the auto-tour from navigating away mid-sequence.
  Future<void> _runDemoBeats() async {
    demoScreenBusy.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 1400));

    // Members.
    await _spotlight(_membersKey, 0, hold: 2000);
    if (!mounted) return _endDemoBeats();

    // Shared wines: spotlight, browse the cards, then open one wine's
    // rating sheet so the member bars fill and the slider sweeps.
    await _spotlight(_sharedWinesKey, 1, hold: 1200);
    if (!mounted) return _endDemoBeats();
    await _browseSharedWines();
    if (!mounted) return _endDemoBeats();

    // Tastings.
    await _spotlight(_tastingsKey, 2, hold: 2000);

    _endDemoBeats();
  }

  /// Scroll a section into view, then spotlight it for [hold] ms.
  Future<void> _spotlight(GlobalKey key, int beat, {required int hold}) async {
    final ctx = key.currentContext;
    if (ctx != null && ctx.mounted) {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        alignment: 0.2,
      );
    }
    if (!mounted) return;
    demoDetailBeat.value = beat;
    await Future<void>.delayed(Duration(milliseconds: hold));
  }

  /// Browse the carousel ~2 cards right, settle back on the top wine, then
  /// open its rating sheet (bars fill from zero, slider sweeps) and close —
  /// never saving.
  Future<void> _browseSharedWines() async {
    for (final page in const [1, 2, 0]) {
      if (!mounted) return;
      demoCarouselPage.value = page;
      await Future<void>.delayed(const Duration(milliseconds: 1000));
    }
    demoCarouselPage.value = null;

    final wine = _topSharedWine();
    if (wine == null || !mounted) return;
    final sheet = showGroupWineRatingSheet(
      context: context,
      groupId: widget.group.id,
      wine: wine,
      demoAnimate: true,
    );
    // Cover the sweep + real save + the ranking bar re-animating to it.
    await Future<void>.delayed(const Duration(milliseconds: 6500));
    _closeSheet();
    await sheet;
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  /// Top-ranked shared wine, sorted the same way the carousel orders cards.
  WineEntity? _topSharedWine() {
    final wines = ref.read(groupWinesProvider(widget.group.id)).valueOrNull;
    if (wines == null || wines.isEmpty) return null;
    final ranks =
        ref.read(groupWineRanksProvider(widget.group.id)).valueOrNull ??
        const <String, int>{};
    final sorted = [...wines]
      ..sort((a, b) {
        final ra = ranks[a.canonicalWineId ?? a.id];
        final rb = ranks[b.canonicalWineId ?? b.id];
        if (ra == null && rb == null) return 0;
        if (ra == null) return 1;
        if (rb == null) return -1;
        return ra.compareTo(rb);
      });
    return sorted.first;
  }

  void _closeSheet() {
    if (mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  void _endDemoBeats() {
    if (mounted) demoDetailBeat.value = null;
    demoCarouselPage.value = null;
    demoScreenBusy.value = false;
  }

  @override
  void dispose() {
    demoDetailBeat.value = null;
    demoCarouselPage.value = null;
    demoScreenBusy.value = false;
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final group = widget.group;
    final currentUid = ref.watch(currentUserIdProvider);
    final isOwner = currentUid == group.createdBy;
    final padH = context.paddingH * 1.3;
    final l10n = AppLocalizations.of(context);

    return ListView(
      controller: _scroll,
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
        KeyedSubtree(
          key: _membersKey,
          child: DemoBeatHighlight(
            beat: 0,
            child: Padding(
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
          ),
        ),
        SizedBox(height: context.l),
        KeyedSubtree(
          key: _sharedWinesKey,
          child: DemoBeatHighlight(
            beat: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionHeader(
                  label: l10n.groupDetailSectionSharedWines,
                  action: _SectionAction(
                    icon: PhosphorIconsRegular.plus,
                    label: l10n.groupDetailActionShare,
                    onTap: () =>
                        WinePickerSheet.show(context, groupId: group.id),
                  ),
                ),
                SizedBox(height: context.s),
                SharedWinesCarousel(groupId: group.id),
              ],
            ),
          ),
        ),
        SizedBox(height: context.l),
        KeyedSubtree(
          key: _tastingsKey,
          child: DemoBeatHighlight(
            beat: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionHeader(
                  label: l10n.groupDetailSectionTastings,
                  action: _SectionAction(
                    icon: PhosphorIconsRegular.plus,
                    label: l10n.groupDetailActionPlan,
                    onTap: () =>
                        context.push(AppRoutes.tastingCreatePath(group.id)),
                  ),
                ),
                SizedBox(height: context.s),
                TastingsCalendar(groupId: group.id),
              ],
            ),
          ),
        ),
        SizedBox(height: context.xl * 2),
      ],
    );
  }

  Future<void> _confirmLeave(
    BuildContext context,
    WidgetRef ref,
    String groupId,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.groupDetailLeaveDialogTitle),
        content: Text(l10n.groupDetailLeaveDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.groupDetailLeaveDialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.groupDetailLeaveDialogConfirm,
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
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.groupDetailDeleteDialogTitle),
        content: Text(l10n.groupDetailDeleteDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.groupDetailDeleteDialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.groupDetailDeleteDialogConfirm,
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
    final l10n = AppLocalizations.of(context);
    return OverflowMenu(
      groups: [
        if (isOwner)
          [
            OverflowMenuItem(
              icon: PhosphorIconsRegular.pencilSimple,
              label: l10n.groupDetailMenuEdit,
              onTap: onEdit,
            ),
            OverflowMenuItem(
              icon: PhosphorIconsRegular.trash,
              label: l10n.groupDetailMenuDelete,
              destructive: true,
              onTap: onDelete,
            ),
          ]
        else
          [
            OverflowMenuItem(
              icon: PhosphorIconsRegular.signOut,
              label: l10n.groupDetailMenuLeave,
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
