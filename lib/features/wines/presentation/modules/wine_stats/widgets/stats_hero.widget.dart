import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';

class StatsHero extends ConsumerWidget {
  const StatsHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hero = ref.watch(statsHeroProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _HeroNumber(
            label: 'Wines',
            value: hero.totalWines.toDouble(),
            decimals: 0,
            delay: 0,
          ),
        ),
        Expanded(
          child: _HeroNumber(
            label: 'Regions',
            value: hero.distinctRegions.toDouble(),
            decimals: 0,
            delay: 80,
          ),
        ),
        Expanded(
          child: _HeroNumber(
            label: 'Countries',
            value: hero.distinctCountries.toDouble(),
            decimals: 0,
            delay: 160,
          ),
        ),
        Expanded(
          child: _HeroNumber(
            label: 'Avg',
            value: hero.avgRating,
            decimals: 1,
            delay: 240,
            placeholder: hero.totalWines == 0 ? '—' : null,
          ),
        ),
      ],
    );
  }
}

class _HeroNumber extends StatelessWidget {
  final String label;
  final double value;
  final int decimals;
  final int delay;
  final String? placeholder;

  const _HeroNumber({
    required this.label,
    required this.value,
    required this.decimals,
    required this.delay,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Animate(
      effects: [
        FadeEffect(
          duration: 420.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeOut,
        ),
        SlideEffect(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
          duration: 420.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeOutCubic,
        ),
      ],
      child: Column(
        children: [
          if (placeholder != null)
            Text(
              placeholder!,
              style: TextStyle(
                fontSize: context.titleFont * 0.95,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                height: 1,
              ),
            )
          else
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: value),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => Text(
                v.toStringAsFixed(decimals),
                style: TextStyle(
                  fontSize: context.titleFont * 0.95,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                  height: 1,
                  letterSpacing: -0.6,
                ),
              ),
            ),
          SizedBox(height: context.xs),
          Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
