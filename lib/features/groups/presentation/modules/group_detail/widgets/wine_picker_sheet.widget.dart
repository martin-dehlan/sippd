import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../auth/controller/auth.provider.dart';
import '../../../../../wines/controller/wine.provider.dart';
import '../../../../../wines/domain/entities/wine.entity.dart';
import '../../../../../wines/presentation/widgets/wine_card.widget.dart';
import '../../../../controller/group.provider.dart';
import 'group_wine_rating_sheet.widget.dart';
import 'share_match_dialog.widget.dart';

class WinePickerSheet extends ConsumerWidget {
  final String groupId;
  const WinePickerSheet({super.key, required this.groupId});

  static Future<void> show(BuildContext context, {required String groupId}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (_) => WinePickerSheet(groupId: groupId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(wineControllerProvider);
    final sharedCanonicalIds =
        ref
            .watch(groupWinesProvider(groupId))
            .valueOrNull
            ?.map((w) => w.canonicalWineId)
            .whereType<String>()
            .toSet() ??
        const <String>{};

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
              'Share a wine',
              style: TextStyle(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.s),
            Flexible(
              child: winesAsync.when(
                data: (wines) => _PickerList(
                  groupId: groupId,
                  wines: wines,
                  sharedCanonicalIds: sharedCanonicalIds,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text(
                  'Error: $e',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.error,
                  ),
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

class _PickerList extends ConsumerStatefulWidget {
  final String groupId;
  final List<WineEntity> wines;
  final Set<String> sharedCanonicalIds;

  const _PickerList({
    required this.groupId,
    required this.wines,
    required this.sharedCanonicalIds,
  });

  @override
  ConsumerState<_PickerList> createState() => _PickerListState();
}

class _PickerListState extends ConsumerState<_PickerList> {
  String? _busyWineId;

  bool _isShared(WineEntity wine) {
    final cid = wine.canonicalWineId;
    return cid != null && widget.sharedCanonicalIds.contains(cid);
  }

  Future<void> _onPick(WineEntity wine) async {
    if (_busyWineId != null) return;
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    setState(() => _busyWineId = wine.id);
    try {
      final groupCtrl = ref.read(groupControllerProvider.notifier);
      final candidates = await groupCtrl.findShareMatchCandidates(
        groupId: widget.groupId,
        localWine: wine,
      );

      if (candidates.isEmpty) {
        await _shareAsOwn(wine);
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
          final canonical = result.canonical;
          if (canonical == null) return;
          await _shareCanonical(canonical.id, openRatingFor: canonical);
        case ShareMatchChoice.different:
          await _shareAsOwn(wine);
        case ShareMatchChoice.cancel:
          return;
      }
    } finally {
      if (mounted) setState(() => _busyWineId = null);
    }
  }

  Future<void> _shareAsOwn(WineEntity wine) async {
    await ref
        .read(groupControllerProvider.notifier)
        .shareWineToGroup(widget.groupId, wine.id);
    ref.invalidate(groupWinesProvider(widget.groupId));
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _shareCanonical(
    String canonicalWineId, {
    WineEntity? openRatingFor,
  }) async {
    await ref
        .read(groupControllerProvider.notifier)
        .shareCanonicalToGroup(
          groupId: widget.groupId,
          canonicalWineId: canonicalWineId,
        );
    ref.invalidate(groupWinesProvider(widget.groupId));
    if (!mounted) return;
    Navigator.pop(context);
    if (openRatingFor != null) {
      await showGroupWineRatingSheet(
        context: context,
        groupId: widget.groupId,
        wine: openRatingFor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (widget.wines.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.l),
        child: Text(
          'You have no wines yet.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
          ),
        ),
      );
    }

    final sorted = List<WineEntity>.from(widget.wines)
      ..sort((a, b) {
        final aShared = _isShared(a) ? 1 : 0;
        final bShared = _isShared(b) ? 1 : 0;
        if (aShared != bShared) return aShared - bShared;
        return b.rating.compareTo(a.rating);
      });
    return ListView.separated(
      shrinkWrap: true,
      itemCount: sorted.length,
      separatorBuilder: (_, _) => SizedBox(height: context.xs),
      itemBuilder: (_, i) {
        final wine = sorted[i];
        final isShared = _isShared(wine);
        final isBusy = _busyWineId == wine.id;
        return _WinePickerRow(
          wine: wine,
          isShared: isShared,
          isBusy: isBusy,
          onTap: (isShared || isBusy) ? null : () => _onPick(wine),
        );
      },
    );
  }
}

class _WinePickerRow extends StatelessWidget {
  final WineEntity wine;
  final VoidCallback? onTap;
  final bool isShared;
  final bool isBusy;

  const _WinePickerRow({
    required this.wine,
    required this.onTap,
    this.isShared = false,
    this.isBusy = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Opacity(
      opacity: isShared ? 0.5 : 1,
      child: Material(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(right: context.w * 0.035),
            child: Row(
              children: [
                WineCardImage(wine: wine, compact: true),
                SizedBox(width: context.w * 0.01),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        wine.name,
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.xs * 0.5),
                      Row(
                        children: [
                          WineTypeDot(type: wine.type),
                          SizedBox(width: context.w * 0.015),
                          Flexible(
                            child: Text(
                              [
                                if (wine.vintage != null)
                                  wine.vintage.toString(),
                                if (wine.country != null) wine.country,
                              ].join(' · '),
                              style: TextStyle(
                                fontSize: context.captionFont,
                                color: cs.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
                else if (isShared)
                  _SharedChip()
                else
                  Text(
                    wine.rating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: context.bodyFont * 1.1,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SharedChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.025,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.w * 0.02),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsRegular.check,
            size: context.w * 0.035,
            color: cs.onSurfaceVariant,
          ),
          SizedBox(width: context.xs),
          Text(
            'Shared',
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
