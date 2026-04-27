import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';
import '../../../../domain/entities/wine.entity.dart';

class WineTypeBreakdown extends StatelessWidget {
  final List<TypeBreakdown> data;
  const WineTypeBreakdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final total = data.fold<int>(0, (acc, t) => acc + t.count);
    if (total == 0) {
      return _EmptyState(cs: cs);
    }

    final mostDrunk = data.reduce((a, b) => a.count >= b.count ? a : b);
    final highestRated = data
        .where((t) => t.count > 0)
        .toList()
        ..sort((a, b) => b.avgRating.compareTo(a.avgRating));
    final topRated = highestRated.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: context.w * 0.5,
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
                      title: 'Most drunk',
                      value: _label(mostDrunk.type),
                      detail: '${mostDrunk.count} '
                          '${mostDrunk.count == 1 ? 'wine' : 'wines'}',
                      color: _colorFor(mostDrunk.type, cs),
                    ),
                    SizedBox(height: context.m),
                    _Highlight(
                      title: 'Top rated',
                      value: _label(topRated.type),
                      detail: '${topRated.avgRating.toStringAsFixed(1)} avg',
                      color: _colorFor(topRated.type, cs),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.l),
        Row(
          children: [
            for (int i = 0; i < data.length; i++) ...[
              if (i > 0) SizedBox(width: context.s),
              Expanded(
                child: _TypeCard(
                  data: data[i],
                  color: _colorFor(data[i].type, cs),
                  delay: 80 * i,
                ),
              ),
            ],
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

  String _label(WineType type) {
    switch (type) {
      case WineType.red:
        return 'Red';
      case WineType.white:
        return 'White';
      case WineType.rose:
        return 'Rosé';
      case WineType.sparkling:
        return 'Sparkling';
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
              total == 1 ? 'wine' : 'wines',
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

class _TypeCard extends StatelessWidget {
  final TypeBreakdown data;
  final Color color;
  final int delay;

  const _TypeCard({
    required this.data,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final empty = data.count == 0;
    return Animate(
      effects: [
        FadeEffect(
          duration: 360.ms,
          delay: Duration(milliseconds: 180 + delay),
        ),
        SlideEffect(
          begin: const Offset(0, 0.25),
          end: Offset.zero,
          duration: 360.ms,
          delay: Duration(milliseconds: 180 + delay),
          curve: Curves.easeOut,
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.025,
          vertical: context.s,
        ),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(
            color: empty ? cs.outlineVariant : color.withValues(alpha: 0.5),
            width: empty ? 0.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.w * 0.025,
              height: context.w * 0.025,
              decoration: BoxDecoration(
                color: empty ? cs.outlineVariant : color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              _label(data.type),
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: context.xs * 0.5),
            Text(
              data.count.toString(),
              style: TextStyle(
                fontSize: context.headingFont * 0.85,
                fontWeight: FontWeight.w800,
                color: empty ? cs.outline : cs.onSurface,
                letterSpacing: -0.4,
                height: 1,
              ),
            ),
            SizedBox(height: context.xs * 0.5),
            Text(
              empty ? '—' : '${data.avgRating.toStringAsFixed(1)} avg',
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _label(WineType type) {
    switch (type) {
      case WineType.red:
        return 'Red';
      case WineType.white:
        return 'White';
      case WineType.rose:
        return 'Rosé';
      case WineType.sparkling:
        return 'Sparkling';
    }
  }
}

class _Highlight extends StatelessWidget {
  final String title;
  final String value;
  final String detail;
  final Color color;

  const _Highlight({
    required this.title,
    required this.value,
    required this.detail,
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
            Text(
              value,
              style: TextStyle(
                fontSize: context.headingFont * 0.95,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: context.xs * 0.5),
        Padding(
          padding: EdgeInsets.only(left: context.s + context.w * 0.018),
          child: Text(
            detail,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final ColorScheme cs;
  const _EmptyState({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.l),
      child: Center(
        child: Text(
          'Rate a wine to start tracking your taste.',
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
