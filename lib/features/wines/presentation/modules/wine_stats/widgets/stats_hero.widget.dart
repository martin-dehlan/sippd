import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';

/// Single rich hero card. Primary number on the left, avg-rating pill on
/// the right, secondary "12 regions · 5 countries" caption underneath
/// separated by a thin divider. Replaces the older 4-tile row that
/// overflowed labels on narrow phones.
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _PrimaryNumber(
                    value: hero.totalWines.toDouble(),
                    label: hero.totalWines == 1
                        ? 'Wine rated'
                        : 'Wines rated',
                  ),
                ),
                if (hasWines) _AvgRatingPill(value: hero.avgRating),
              ],
            ),
            SizedBox(height: context.m),
            Container(
              height: 1,
              color: cs.outlineVariant.withValues(alpha: 0.5),
            ),
            SizedBox(height: context.s),
            Row(
              children: [
                _SecondaryStat(
                  icon: PhosphorIconsFill.mapPin,
                  count: hero.distinctRegions,
                  label: hero.distinctRegions == 1 ? 'region' : 'regions',
                  delay: 80,
                ),
                SizedBox(width: context.l),
                _SecondaryStat(
                  icon: PhosphorIconsFill.globe,
                  count: hero.distinctCountries,
                  label: hero.distinctCountries == 1 ? 'country' : 'countries',
                  delay: 160,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryNumber extends StatelessWidget {
  final double value;
  final String label;
  const _PrimaryNumber({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value),
          duration: const Duration(milliseconds: 1100),
          curve: Curves.easeOutCubic,
          builder: (_, v, _) => Text(
            v.toStringAsFixed(0),
            style: TextStyle(
              fontSize: context.titleFont * 1.6,
              fontWeight: FontWeight.w900,
              color: cs.onSurface,
              height: 1,
              letterSpacing: -1.5,
            ),
          ),
        ),
        SizedBox(height: context.xs),
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
            letterSpacing: 0.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _AvgRatingPill extends StatelessWidget {
  final double value;
  const _AvgRatingPill({required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Animate(
      effects: [
        FadeEffect(duration: 420.ms, delay: 200.ms),
        ScaleEffect(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
          duration: 420.ms,
          delay: 200.ms,
          curve: Curves.easeOutBack,
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.s,
          vertical: context.xs,
        ),
        decoration: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsFill.star,
              color: cs.primary,
              size: context.captionFont * 1.1,
            ),
            SizedBox(width: context.xs),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: context.captionFont * 1.05,
                fontWeight: FontWeight.w800,
                color: cs.primary,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(width: context.xs * 0.5),
            Text(
              'avg',
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                color: cs.primary.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecondaryStat extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;
  final int delay;

  const _SecondaryStat({
    required this.icon,
    required this.count,
    required this.label,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Animate(
      effects: [
        FadeEffect(
          duration: 420.ms,
          delay: Duration(milliseconds: delay),
        ),
      ],
      child: Row(
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
      ),
    );
  }
}
