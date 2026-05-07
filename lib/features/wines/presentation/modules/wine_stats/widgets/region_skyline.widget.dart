import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../controller/wine_stats.provider.dart';

class RegionSkyline extends StatelessWidget {
  final List<Tally> items;

  const RegionSkyline({super.key, required this.items});

  static const int _topN = 5;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _SkylineSkeleton();

    final cs = Theme.of(context).colorScheme;
    final visible = items.take(_topN).toList();
    final remaining = items.length - visible.length;
    final maxCount = visible.first.count;

    return Animate(
      effects: [
        FadeEffect(duration: 360.ms),
        SlideEffect(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
          duration: 480.ms,
          curve: Curves.easeOutCubic,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.h * 0.22,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxCount.toDouble() * 1.18,
                minY: 0,
                barTouchData: BarTouchData(enabled: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: context.h * 0.06,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= visible.length) {
                          return const SizedBox.shrink();
                        }
                        return _BarCaption(
                          item: visible[idx],
                          isHero: idx == 0,
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (int i = 0; i < visible.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: visible[i].count.toDouble(),
                          width: context.w * 0.085,
                          color: _barColor(cs, i),
                          borderSide: i >= 3
                              ? BorderSide(
                                  color: cs.primary.withValues(alpha: 0.4),
                                  width: 1.4,
                                )
                              : BorderSide.none,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(context.w * 0.02),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
            ),
          ),
          if (remaining > 0) ...[
            SizedBox(height: context.s),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.xs),
              child: Text(
                '+ $remaining more',
                style: TextStyle(
                  fontSize: context.captionFont * 0.92,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _barColor(ColorScheme cs, int rank) {
    if (rank == 0) return cs.primary;
    if (rank <= 2) return cs.primary.withValues(alpha: 0.65);
    return Colors.transparent;
  }
}

class _BarCaption extends StatelessWidget {
  final Tally item;
  final bool isHero;

  const _BarCaption({required this.item, required this.isHero});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(top: context.xs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: context.w * 0.16,
            child: Text(
              item.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                color: isHero ? cs.onSurface : cs.onSurfaceVariant,
                fontWeight: isHero ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.2,
                height: 1.15,
              ),
            ),
          ),
          SizedBox(height: context.xs * 0.5),
          Text(
            item.count.toString(),
            style: TextStyle(
              fontSize: context.captionFont * 0.78,
              color: cs.outline,
              fontWeight: FontWeight.w600,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkylineSkeleton extends StatelessWidget {
  const _SkylineSkeleton();

  @override
  Widget build(BuildContext context) {
    final widths = [0.85, 0.62, 0.5, 0.38, 0.3];
    return Skeleton(
      child: SizedBox(
        height: context.h * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final f in widths)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SkeletonBox(
                    width: context.w * 0.085,
                    height: context.h * 0.16 * f,
                    radius: context.w * 0.02,
                  ),
                  SizedBox(height: context.s),
                  SkeletonBox(
                    width: context.w * 0.13,
                    height: context.captionFont * 0.85,
                  ),
                  SizedBox(height: context.xs * 0.5),
                  SkeletonBox(
                    width: context.w * 0.04,
                    height: context.captionFont * 0.78,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
