import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../controller/wine_stats.provider.dart';

/// "Where your bottles come from" — a waffle grid where every bottle is one
/// square, coloured by its region. The top regions each get a distinct
/// accent tint; the long tail collapses into a single muted "other" colour.
/// (Kept the `RegionSkyline` name so the stats screen import is unchanged.)
class RegionSkyline extends StatelessWidget {
  final List<Tally> items;

  const RegionSkyline({super.key, required this.items});

  static const int _topN = 5;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _WaffleSkeleton();

    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final top = items.take(_topN).toList();
    final tail = items.skip(_topN).toList();
    final tailCount = tail.fold<int>(0, (a, t) => a + t.count);
    final otherColor = cs.outlineVariant;

    Color tint(int rank) => switch (rank) {
      0 => cs.primary,
      1 => cs.primary.withValues(alpha: 0.72),
      2 => cs.primary.withValues(alpha: 0.52),
      3 => cs.primary.withValues(alpha: 0.38),
      _ => cs.primary.withValues(alpha: 0.26),
    };

    // One cell per bottle, grouped by region so colours read in blocks.
    final cells = <Color>[];
    for (var i = 0; i < top.length; i++) {
      for (var c = 0; c < top[i].count; c++) {
        cells.add(tint(i));
      }
    }
    for (var c = 0; c < tailCount; c++) {
      cells.add(otherColor);
    }

    final cellSize = context.w * 0.072;
    final gap = context.w * 0.02;

    return Animate(
      effects: [FadeEffect(duration: 320.ms)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (var i = 0; i < cells.length; i++)
                Container(
                      width: cellSize,
                      height: cellSize,
                      decoration: BoxDecoration(
                        color: cells[i],
                        borderRadius: BorderRadius.circular(context.w * 0.018),
                      ),
                    )
                    .animate(delay: (i * 24).ms)
                    .fadeIn(duration: 240.ms)
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1, 1),
                      duration: 280.ms,
                      curve: Curves.easeOutBack,
                    ),
            ],
          ),
          SizedBox(height: context.m),
          Wrap(
            spacing: context.w * 0.045,
            runSpacing: context.s,
            children: [
              for (var i = 0; i < top.length; i++)
                _LegendItem(
                  color: tint(i),
                  label: top[i].label,
                  count: top[i].count,
                  hero: i == 0,
                ),
              if (tailCount > 0)
                _LegendItem(
                  color: otherColor,
                  label: l10n.winesStatsRegionsMore(tail.length),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int? count;
  final bool hero;

  const _LegendItem({
    required this.color,
    required this.label,
    this.count,
    this.hero = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.w * 0.028,
          height: context.w * 0.028,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(context.w * 0.008),
          ),
        ),
        SizedBox(width: context.w * 0.018),
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont * 0.95,
            color: hero ? cs.onSurface : cs.onSurfaceVariant,
            fontWeight: hero ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        if (count != null) ...[
          SizedBox(width: context.w * 0.012),
          Text(
            '$count',
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              color: cs.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}

class _WaffleSkeleton extends StatelessWidget {
  const _WaffleSkeleton();

  @override
  Widget build(BuildContext context) {
    final cellSize = context.w * 0.072;
    final gap = context.w * 0.02;
    return Skeleton(
      child: Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (var i = 0; i < 16; i++)
            SkeletonBox(
              width: cellSize,
              height: cellSize,
              radius: context.w * 0.018,
            ),
        ],
      ),
    );
  }
}
