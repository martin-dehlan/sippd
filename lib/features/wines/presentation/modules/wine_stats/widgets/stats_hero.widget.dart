import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';

/// Wine-rating-first hero. Headline is the user's average rating with
/// a visual meter — that's the metric that defines them as a rater on
/// a 0–10 scale. Volume (wines + regions) is a thin caption underneath.
class StatsHero extends ConsumerWidget {
  const StatsHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hero = ref.watch(statsHeroProvider);
    final cs = Theme.of(context).colorScheme;
    final hasWines = hero.totalWines > 0;

    return Animate(
      effects: [
        FadeEffect(duration: 420.ms),
        SlideEffect(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
          duration: 420.ms,
          curve: Curves.easeOutCubic,
        ),
      ],
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.w * 0.05,
          context.m,
          context.w * 0.05,
          context.m,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.05),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: hasWines
            ? _RatedContent(
                avgRating: hero.avgRating,
                totalWines: hero.totalWines,
                regions: hero.distinctRegions,
                cs: cs,
              )
            : _EmptyContent(cs: cs),
      ),
    );
  }
}

class _RatedContent extends StatelessWidget {
  final double avgRating;
  final int totalWines;
  final int regions;
  final ColorScheme cs;

  const _RatedContent({
    required this.avgRating,
    required this.totalWines,
    required this.regions,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = (avgRating / 10).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'YOUR AVG',
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                color: cs.onSurfaceVariant,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: context.s),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              PhosphorIconsFill.star,
              color: cs.primary,
              size: context.titleFont * 0.95,
            ),
            SizedBox(width: context.xs),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: avgRating),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => Text(
                v.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: context.titleFont * 1.4,
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                  height: 1,
                  letterSpacing: -1.5,
                ),
              ),
            ),
            SizedBox(width: context.xs),
            Padding(
              padding: EdgeInsets.only(bottom: context.xs * 0.6),
              child: Text(
                '/ 10',
                style: TextStyle(
                  fontSize: context.bodyFont * 1.05,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.s),
        // Visual meter: avg rating filling a horizontal bar.
        ClipRRect(
          borderRadius: BorderRadius.circular(context.w * 0.012),
          child: Stack(
            children: [
              Container(
                height: context.w * 0.018,
                color: cs.outlineVariant.withValues(alpha: 0.35),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: ratio),
                duration: const Duration(milliseconds: 1100),
                curve: Curves.easeOutCubic,
                builder: (_, v, _) => FractionallySizedBox(
                  widthFactor: v,
                  child: Container(
                    height: context.w * 0.018,
                    color: cs.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.m),
        Row(
          children: [
            _CaptionStat(
              icon: PhosphorIconsFill.wine,
              count: totalWines,
              label: totalWines == 1 ? 'wine' : 'wines',
              cs: cs,
            ),
            SizedBox(width: context.l),
            _CaptionStat(
              icon: PhosphorIconsFill.mapPin,
              count: regions,
              label: regions == 1 ? 'region' : 'regions',
              cs: cs,
            ),
          ],
        ),
      ],
    );
  }
}

class _CaptionStat extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;
  final ColorScheme cs;

  const _CaptionStat({
    required this.icon,
    required this.count,
    required this.label,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: cs.primary,
          size: context.captionFont * 1.05,
        ),
        SizedBox(width: context.xs),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: context.bodyFont,
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(width: context.xs * 0.7),
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _EmptyContent extends StatelessWidget {
  final ColorScheme cs;
  const _EmptyContent({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No ratings yet',
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            'Rate your first wine to start tracking your taste.',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
