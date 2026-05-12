import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/inline_error.widget.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../wines/controller/wine.provider.dart';
import '../../controller/group.provider.dart';
import '../../domain/entities/group.entity.dart';
import '../modules/group_detail/widgets/share_match_dialog.widget.dart';

Future<void> showShareWineSheet({
  required BuildContext context,
  required String wineId,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (_) => _ShareWineSheet(wineId: wineId),
  );
}

class _ShareWineSheet extends ConsumerStatefulWidget {
  final String wineId;

  const _ShareWineSheet({required this.wineId});

  @override
  ConsumerState<_ShareWineSheet> createState() => _ShareWineSheetState();
}

class _ShareWineSheetState extends ConsumerState<_ShareWineSheet> {
  String? _busyGroupId;

  Future<void> _onPick(GroupEntity group) async {
    if (_busyGroupId != null) return;
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    setState(() => _busyGroupId = group.id);
    try {
      final wine = await ref
          .read(wineRepositoryProvider)
          .getWineById(widget.wineId);
      if (wine == null) return;

      final groupCtrl = ref.read(groupControllerProvider.notifier);
      final candidates = await groupCtrl.findShareMatchCandidates(
        groupId: group.id,
        localWine: wine,
      );

      if (candidates.isEmpty) {
        await groupCtrl.shareWineToGroup(group.id, widget.wineId);
        _finish(group);
        return;
      }

      if (!mounted) return;
      final result = await showShareMatchDialog(
        context: context,
        mine: wine,
        candidates: candidates,
      );
      if (!mounted || result == null) return;

      switch (result.choice) {
        case ShareMatchChoice.same:
          // Candidate's id is the canonical_wine.id (catalog identity).
          final c = result.canonical;
          if (c == null) return;
          await groupCtrl.shareCanonicalToGroup(
            groupId: group.id,
            canonicalWineId: c.id,
          );
          _finish(group);
        case ShareMatchChoice.different:
          await groupCtrl.shareWineToGroup(group.id, widget.wineId);
          _finish(group);
        case ShareMatchChoice.cancel:
          return;
      }
    } finally {
      if (mounted) setState(() => _busyGroupId = null);
    }
  }

  void _finish(GroupEntity group) {
    ref.invalidate(groupWinesProvider(group.id));
    ref.invalidate(groupsContainingWineProvider(widget.wineId));
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.groupShareWineSheetSharedSnack(group.name))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final groupsAsync = ref.watch(groupControllerProvider);

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
              l10n.groupShareWineSheetTitle,
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.m),
            groupsAsync.when(
              data: (groups) {
                if (groups.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: context.l),
                    child: Text(
                      l10n.groupShareWineSheetEmpty,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                final sharedAsync = ref.watch(
                  groupsContainingWineProvider(widget.wineId),
                );
                final shared = sharedAsync.valueOrNull ?? const <String>{};
                return Column(
                  children: [
                    for (final g in groups) ...[
                      _GroupRow(
                        group: g,
                        isBusy: _busyGroupId == g.id,
                        alreadyShared: shared.contains(g.id),
                        onTap: _busyGroupId != null || shared.contains(g.id)
                            ? null
                            : () => _onPick(g),
                      ),
                      SizedBox(height: context.s),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(
                describeAppError(
                  e,
                  fallback: l10n.groupShareWineSheetErrorLoad,
                ),
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.error,
                ),
              ),
            ),
            SizedBox(height: context.m),
          ],
        ),
      ),
    );
  }
}

class _GroupRow extends ConsumerWidget {
  final GroupEntity group;
  final VoidCallback? onTap;
  final bool isBusy;
  final bool alreadyShared;

  const _GroupRow({
    required this.group,
    required this.onTap,
    this.isBusy = false,
    this.alreadyShared = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final membersAsync = ref.watch(groupMembersProvider(group.id));
    final subtitle = alreadyShared
        ? l10n.groupShareWineSheetAlreadyShared
        : _subtitle(l10n);

    return Opacity(
      opacity: alreadyShared ? 0.55 : 1,
      child: Material(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(context.w * 0.04),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: context.xs),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: context.w * 0.02),
                if (isBusy)
                  SizedBox(
                    width: context.w * 0.05,
                    height: context.w * 0.05,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                else if (alreadyShared)
                  Icon(
                    PhosphorIconsRegular.checkCircle,
                    size: context.w * 0.055,
                    color: cs.primary,
                  )
                else
                  membersAsync.maybeWhen(
                    data: (members) => members.isEmpty
                        ? Icon(
                            PhosphorIconsRegular.caretRight,
                            size: context.w * 0.035,
                            color: cs.outline,
                          )
                        : _AvatarCluster(members: members),
                    orElse: () => Icon(
                      PhosphorIconsRegular.caretRight,
                      size: context.w * 0.035,
                      color: cs.outline,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _subtitle(AppLocalizations l10n) {
    final parts = <String>[];
    if (group.memberCount > 0) {
      parts.add(
        group.memberCount == 1
            ? l10n.groupShareWineRowMemberOne
            : l10n.groupShareWineRowMemberMany(group.memberCount),
      );
    }
    if (group.wineCount > 0) {
      parts.add(
        group.wineCount == 1
            ? l10n.groupShareWineRowWineOne
            : l10n.groupShareWineRowWineMany(group.wineCount),
      );
    }
    return parts.isEmpty ? null : parts.join(' · ');
  }
}

class _AvatarCluster extends StatelessWidget {
  final List<FriendProfileEntity> members;
  const _AvatarCluster({required this.members});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.075;
    final overlap = size * 0.5;
    final visible = members.take(3).toList();
    final extra = members.length - visible.length;
    final slots = visible.length + (extra > 0 ? 1 : 0);
    final width = slots == 0 ? 0.0 : size + (slots - 1) * (size - overlap);
    final inner = size - size * 0.08;

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * (size - overlap),
              child: Container(
                padding: EdgeInsets.all(size * 0.04),
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: FriendAvatar(profile: visible[i], size: inner),
              ),
            ),
          if (extra > 0)
            Positioned(
              left: visible.length * (size - overlap),
              child: Container(
                padding: EdgeInsets.all(size * 0.04),
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
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
                      fontSize: size * 0.3,
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
