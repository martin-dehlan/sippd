import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../controller/wine_stats.provider.dart';
import '../../../../domain/entities/wine.entity.dart';

class WineTypeBreakdown extends StatelessWidget {
  final List<TypeBreakdown> data;
  const WineTypeBreakdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final total = data.fold<int>(0, (acc, t) => acc + t.count);

    final card = Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: total == 0
          ? const _EmptyState()
          : _content(context, cs, total, l10n),
    );

    return card;
  }

  Widget _content(
    BuildContext context,
    ColorScheme cs,
    int total,
    AppLocalizations l10n,
  ) {
    final mostDrunk = data.reduce((a, b) => a.count >= b.count ? a : b);
    final ratedTypes = data.where((t) => t.count > 0).toList()
      ..sort((a, b) => b.avgRating.compareTo(a.avgRating));
    final topRated = ratedTypes.first;
    // With <3 wines or when both highlights resolve to the same type the
    // donut + dual highlights row is just noise — show only the rows.
    final showHero = total >= 3 && mostDrunk.type != topRated.type;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHero) ...[
          SizedBox(
            height: context.w * 0.45,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _Donut(data: data, total: total),
                ),
                SizedBox(width: context.w * 0.04),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Highlight(
                        title: l10n.winesStatsTypeBreakdownMostDrunk,
                        value: _label(mostDrunk.type, l10n),
                        chip: '${(mostDrunk.count / total * 100).round()}%',
                        color: _colorFor(mostDrunk.type, cs),
                      ),
                      SizedBox(height: context.m),
                      _Highlight(
                        title: l10n.winesStatsTypeBreakdownTopRated,
                        value: _label(topRated.type, l10n),
                        chip: '★ ${topRated.avgRating.toStringAsFixed(1)}',
                        color: _colorFor(topRated.type, cs),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.l),
        ],
        for (int i = 0; i < data.length; i++) ...[
          if (i > 0) SizedBox(height: context.m),
          _TypeRow(
            data: data[i],
            color: _colorFor(data[i].type, cs),
            label: _label(data[i].type, l10n),
            total: total,
            delay: 80 * i,
          ),
        ],
      ],
    );
  }

  Color _colorFor(WineType type, ColorScheme cs) {
    switch (type) {
      case WineType.red:
        return cs.primary;
      case WineType.white:
        return const Color(0xFFE8D9A1);
      case WineType.rose:
        return const Color(0xFFE3A6BA);
      case WineType.sparkling:
        return const Color(0xFFB7C7DC);
    }
  }

  String _label(WineType type, AppLocalizations l) {
    switch (type) {
      case WineType.red:
        return l.wineTypeRed;
      case WineType.white:
        return l.wineTypeWhite;
      case WineType.rose:
        return l.wineTypeRose;
      case WineType.sparkling:
        return l.wineTypeSparkling;
    }
  }
}

class _Donut extends StatelessWidget {
  final List<TypeBreakdown> data;
  final int total;
  const _Donut({required this.data, required this.total});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final visible = data.where((t) => t.count > 0).toList();
    final radius = context.w * 0.04;

    return Stack(
      alignment: Alignment.center,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (_, t, _) {
            return PieChart(
              PieChartData(
                startDegreeOffset: -90,
                sectionsSpace: 2,
                centerSpaceRadius: context.w * 0.13,
                sections: [
                  for (final entry in visible)
                    PieChartSectionData(
                      value: entry.count.toDouble() * t,
                      color: _colorFor(entry.type, cs),
                      radius: radius,
                      showTitle: false,
                    ),
                ],
              ),
            );
          },
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: total.toDouble()),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => Text(
                v.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: context.titleFont,
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                  letterSpacing: -0.5,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: context.xs * 0.5),
            Text(
              total == 1
                  ? AppLocalizations.of(context).winesStatsTypeBreakdownTotalOne
                  : AppLocalizations.of(
                      context,
                    ).winesStatsTypeBreakdownTotalMany,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _colorFor(WineType type, ColorScheme cs) {
    switch (type) {
      case WineType.red:
        return cs.primary;
      case WineType.white:
        return const Color(0xFFE8D9A1);
      case WineType.rose:
        return const Color(0xFFE3A6BA);
      case WineType.sparkling:
        return const Color(0xFFB7C7DC);
    }
  }
}

class _TypeRow extends StatelessWidget {
  final TypeBreakdown data;
  final Color color;
  final String label;
  final int total;
  final int delay;

  const _TypeRow({
    required this.data,
    required this.color,
    required this.label,
    required this.total,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final empty = data.count == 0;
    final ratio = total == 0 ? 0.0 : data.count / total;
    return Animate(
      effects: [
        FadeEffect(
          duration: 360.ms,
          delay: Duration(milliseconds: 180 + delay),
        ),
        SlideEffect(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
          duration: 360.ms,
          delay: Duration(milliseconds: 180 + delay),
          curve: Curves.easeOut,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: context.w * 0.022,
                height: context.w * 0.022,
                decoration: BoxDecoration(
                  color: empty ? cs.outlineVariant : color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: context.xs),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.captionFont * 1.1,
                    color: empty ? cs.onSurfaceVariant : cs.onSurface,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
              SizedBox(width: context.s),
              Text(
                data.count.toString(),
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w800,
                  color: empty ? cs.outline : cs.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(width: context.s * 1.2),
              Container(
                width: 1,
                height: context.captionFont * 0.9,
                color: cs.outlineVariant,
              ),
              SizedBox(width: context.s * 1.2),
              Icon(
                Icons.star_rounded,
                size: context.captionFont * 1.05,
                color: empty ? cs.outline : cs.onSurfaceVariant,
              ),
              SizedBox(width: context.xs * 0.5),
              SizedBox(
                width: context.w * 0.07,
                child: Text(
                  empty ? '—' : data.avgRating.toStringAsFixed(1),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: empty ? cs.outline : cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(context.w * 0.012),
            child: Stack(
              children: [
                Container(
                  height: context.w * 0.018,
                  color: cs.outlineVariant.withValues(alpha: 0.3),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0,
                    end: empty ? 0.0 : ratio.clamp(0.04, 1.0),
                  ),
                  duration: Duration(milliseconds: 700 + delay),
                  curve: Curves.easeOutCubic,
                  builder: (_, v, _) => FractionallySizedBox(
                    widthFactor: v,
                    child: Container(
                      height: context.w * 0.018,
                      color: empty ? Colors.transparent : color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Highlight extends StatelessWidget {
  final String title;
  final String value;
  final String chip;
  final Color color;

  const _Highlight({
    required this.title,
    required this.value,
    required this.chip,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            color: cs.onSurfaceVariant,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: context.xs * 0.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: context.w * 0.018,
              height: context.bodyFont * 1.1,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: context.s),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: context.headingFont * 0.95,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            SizedBox(width: context.xs),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.xs * 1.4,
                vertical: context.xs * 0.6,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(context.w * 0.025),
              ),
              child: Text(
                chip,
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        children: [
          for (int i = 0; i < 4; i++) ...[
            if (i > 0) SizedBox(height: context.m),
            const _TypeRowSkeleton(),
          ],
        ],
      ),
    );
  }
}

class _TypeRowSkeleton extends StatelessWidget {
  const _TypeRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SkeletonBox.circle(size: context.w * 0.022),
            SizedBox(width: context.xs),
            Expanded(
              child: SkeletonBox(
                width: context.w * 0.22,
                height: context.captionFont * 1.1,
              ),
            ),
            SizedBox(width: context.s),
            SkeletonBox(width: context.w * 0.05, height: context.bodyFont),
            SizedBox(width: context.xs),
            SkeletonBox(width: context.w * 0.06, height: context.captionFont),
          ],
        ),
        SizedBox(height: context.xs),
        SkeletonBox(
          width: double.infinity,
          height: context.w * 0.018,
          radius: context.w * 0.012,
        ),
      ],
    );
  }
}
