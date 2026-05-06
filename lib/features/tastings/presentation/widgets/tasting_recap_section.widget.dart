import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../groups/controller/group.provider.dart';
import '../../../share_cards/controller/share_card.provider.dart';
import '../../../share_cards/presentation/cards/tasting_recap_card.widget.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../controller/tastings.provider.dart';
import '../../domain/entities/tasting_attendee.entity.dart';
import '../../domain/entities/tasting_recap_entry.entity.dart';

/// Concluded-state replacement for the planning lineup. Surfaces the
/// top wine of the night, then a ranked list of every bottle with its
/// per-attendee breakdown so the group can re-litigate the night
/// without scrolling away. Share-recap CTA renders the F3 IG-story
/// share card via [ShareCardService.shareTastingRecapCard].
class TastingRecapSection extends ConsumerWidget {
  const TastingRecapSection({
    super.key,
    required this.tastingId,
    required this.groupId,
    required this.tastingTitle,
    required this.scheduledAt,
    required this.wines,
  });

  final String tastingId;
  final String groupId;
  final String tastingTitle;
  final DateTime scheduledAt;
  final List<WineEntity> wines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final entriesAsync = ref.watch(tastingRecapEntriesProvider(tastingId));
    final entries = entriesAsync.valueOrNull ?? const <TastingRecapEntry>[];

    final byCanonical = <String, List<TastingRecapEntry>>{};
    for (final e in entries) {
      byCanonical.putIfAbsent(e.canonicalWineId, () => []).add(e);
    }

    final ranked = wines
        .map((w) {
          final cid = w.canonicalWineId ?? w.id;
          final ratings = byCanonical[cid] ?? const <TastingRecapEntry>[];
          final avg = ratings.isEmpty
              ? null
              : ratings.map((r) => r.rating).reduce((a, b) => a + b) /
                  ratings.length;
          return _RankedWine(wine: w, ratings: ratings, avg: avg);
        })
        .toList()
      ..sort((a, b) {
        final aHas = a.avg != null;
        final bHas = b.avg != null;
        if (aHas != bHas) return aHas ? -1 : 1;
        if (a.avg == null) return 0;
        return b.avg!.compareTo(a.avg!);
      });

    final top = ranked.firstOrNull;
    final hasAnyRating = top?.avg != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'RESULTS',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.72),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              _ShareRecapButton(
                cs: cs,
                enabled: hasAnyRating,
                onTap: () => _share(context, ref, ranked),
              ),
            ],
          ),
        ),
        if (!hasAnyRating)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.paddingH * 1.3,
              vertical: context.l,
            ),
            child: _NoRatingsYet(cs: cs),
          )
        else ...[
          SizedBox(height: context.m),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: _TopWineCard(top: top!, cs: cs),
          ),
          SizedBox(height: context.l),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            itemCount: ranked.length,
            separatorBuilder: (_, _) => Padding(
              padding: EdgeInsets.symmetric(vertical: context.s),
              child: Divider(
                color: cs.outlineVariant.withValues(alpha: 0.6),
                height: 1,
              ),
            ),
            itemBuilder: (_, i) =>
                _RecapWineRow(rank: i + 1, item: ranked[i], cs: cs),
          ),
        ],
      ],
    );
  }
}

class _RankedWine {
  final WineEntity wine;
  final List<TastingRecapEntry> ratings;
  final double? avg;
  _RankedWine({required this.wine, required this.ratings, required this.avg});
}

extension on TastingRecapSection {
  Future<void> _share(
    BuildContext context,
    WidgetRef ref,
    List<_RankedWine> ranked,
  ) async {
    final group =
        ref.read(groupDetailProvider(groupId)).valueOrNull;
    final attendees = ref
            .read(tastingAttendeesProvider(tastingId))
            .valueOrNull ??
        const <TastingAttendeeEntity>[];
    final goingCount = attendees
        .where((a) => a.status == RsvpStatus.going)
        .length;
    final top = ranked.firstWhere(
      (w) => w.avg != null,
      orElse: () => ranked.first,
    );
    final data = TastingRecapCardData(
      groupName: group?.name ?? 'Group tasting',
      tastingTitle: tastingTitle,
      date: scheduledAt,
      topWineName: top.avg == null ? null : top.wine.name,
      topWineWinery: top.wine.winery,
      topWineVintage: top.wine.vintage,
      topWineAvg: top.avg,
      ranked: [
        for (final r in ranked)
          TastingRecapCardLine(name: r.wine.name, avg: r.avg),
      ],
      attendeeCount: goingCount,
    );
    await ref.read(shareCardProvider).shareTastingRecapCard(
          context: context,
          tastingId: tastingId,
          data: data,
          source: 'concluded_recap',
        );
  }
}

class _ShareRecapButton extends StatelessWidget {
  const _ShareRecapButton({
    required this.cs,
    required this.enabled,
    required this.onTap,
  });

  final ColorScheme cs;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final inner = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(PhosphorIconsRegular.shareNetwork,
            size: context.w * 0.04, color: cs.primary),
        SizedBox(width: context.w * 0.012),
        Text(
          'Share recap',
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w600,
            color: cs.primary,
          ),
        ),
      ],
    );
    if (!enabled) return Opacity(opacity: 0.45, child: inner);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: inner,
    );
  }
}

class _NoRatingsYet extends StatelessWidget {
  const _NoRatingsYet({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(PhosphorIconsRegular.wine,
              size: context.bodyFont * 1.2, color: cs.onSurfaceVariant),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Text(
              'No ratings submitted for this tasting yet.',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopWineCard extends StatelessWidget {
  const _TopWineCard({required this.top, required this.cs});
  final _RankedWine top;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final wine = top.wine;
    final subtitle = [
      if (wine.winery != null && wine.winery!.isNotEmpty) wine.winery!,
      if (wine.vintage != null) wine.vintage.toString(),
    ].join(' · ');

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.045),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIconsFill.trophy,
            size: context.titleFont,
            color: cs.onPrimaryContainer,
          ),
          SizedBox(width: context.w * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOP WINE OF THE NIGHT',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color:
                        cs.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
                SizedBox(height: context.xs),
                Text(
                  wine.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 0.85,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: cs.onPrimaryContainer,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: context.xs * 0.6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color:
                          cs.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: context.w * 0.02),
          _AvgPill(value: top.avg!, cs: cs, onPrimary: true),
        ],
      ),
    );
  }
}

class _RecapWineRow extends StatelessWidget {
  const _RecapWineRow({
    required this.rank,
    required this.item,
    required this.cs,
  });

  final int rank;
  final _RankedWine item;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: context.w * 0.06,
              child: Text(
                '$rank.',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(
              child: Text(
                item.wine.name,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: context.w * 0.02),
            if (item.avg != null)
              _AvgPill(value: item.avg!, cs: cs, onPrimary: false)
            else
              Text(
                'no ratings',
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.outline,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        if (item.ratings.isNotEmpty) ...[
          SizedBox(height: context.s),
          Padding(
            padding: EdgeInsets.only(left: context.w * 0.06),
            child: Wrap(
              spacing: context.w * 0.02,
              runSpacing: context.s,
              children: [
                for (final r in item.ratings) _RaterChip(entry: r, cs: cs),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _RaterChip extends StatelessWidget {
  const _RaterChip({required this.entry, required this.cs});
  final TastingRecapEntry entry;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final label = (entry.displayName?.trim().isNotEmpty ?? false)
        ? entry.displayName!.trim()
        : (entry.username?.trim().isNotEmpty ?? false)
            ? entry.username!.trim()
            : 'Friend';
    final initial = label.characters.first.toUpperCase();
    final size = context.w * 0.06;

    return Container(
      padding: EdgeInsets.fromLTRB(
        context.xs,
        context.xs * 0.6,
        context.w * 0.025,
        context.xs * 0.6,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.06),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (entry.avatarUrl != null && entry.avatarUrl!.isNotEmpty)
            CircleAvatar(
              radius: size / 2,
              backgroundColor: cs.surfaceContainerHigh,
              backgroundImage: NetworkImage(entry.avatarUrl!),
            )
          else
            CircleAvatar(
              radius: size / 2,
              backgroundColor: cs.surfaceContainerHigh,
              child: Text(
                initial,
                style: TextStyle(
                  fontSize: context.captionFont * 0.9,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          SizedBox(width: context.w * 0.018),
          Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: context.w * 0.018),
          Text(
            entry.rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurface,
              fontWeight: FontWeight.w700,
              fontFeatures: tabularFigures,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvgPill extends StatelessWidget {
  const _AvgPill({
    required this.value,
    required this.cs,
    required this.onPrimary,
  });
  final double value;
  final ColorScheme cs;
  final bool onPrimary;

  @override
  Widget build(BuildContext context) {
    final fg = onPrimary ? cs.onPrimaryContainer : cs.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.bodyFont * 1.15,
            fontWeight: FontWeight.bold,
            color: fg,
            fontFeatures: tabularFigures,
          ),
        ),
        SizedBox(width: context.w * 0.008),
        Text(
          '/ 10',
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            color: fg.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
