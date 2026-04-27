import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';

class StatsHero extends ConsumerWidget {
  const StatsHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hero = ref.watch(statsHeroProvider);
    final cards = <_HeroCardData>[
      _HeroCardData(
        icon: PhosphorIconsFill.wine,
        label: 'Wines',
        value: hero.totalWines.toDouble(),
        decimals: 0,
      ),
      _HeroCardData(
        icon: PhosphorIconsFill.mapPin,
        label: 'Regions',
        value: hero.distinctRegions.toDouble(),
        decimals: 0,
      ),
      _HeroCardData(
        icon: PhosphorIconsFill.globe,
        label: 'Countries',
        value: hero.distinctCountries.toDouble(),
        decimals: 0,
      ),
      _HeroCardData(
        icon: PhosphorIconsFill.star,
        label: 'Avg rating',
        value: hero.avgRating,
        decimals: 1,
        placeholder: hero.totalWines == 0 ? '—' : null,
      ),
    ];

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          if (i > 0) SizedBox(width: context.s),
          Expanded(child: _HeroCard(data: cards[i], delay: i * 70)),
        ],
      ],
    );
  }
}

class _HeroCardData {
  final IconData icon;
  final String label;
  final double value;
  final int decimals;
  final String? placeholder;

  const _HeroCardData({
    required this.icon,
    required this.label,
    required this.value,
    required this.decimals,
    this.placeholder,
  });
}

class _HeroCard extends StatelessWidget {
  final _HeroCardData data;
  final int delay;

  const _HeroCard({required this.data, required this.delay});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Animate(
      effects: [
        FadeEffect(
          duration: 420.ms,
          delay: Duration(milliseconds: delay),
        ),
        SlideEffect(
          begin: const Offset(0, 0.25),
          end: Offset.zero,
          duration: 420.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeOutCubic,
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.025,
          vertical: context.s,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.w * 0.07,
              height: context.w * 0.07,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(context.w * 0.02),
              ),
              child: Icon(
                data.icon,
                color: cs.primary,
                size: context.w * 0.035,
              ),
            ),
            SizedBox(height: context.s),
            if (data.placeholder != null)
              Text(
                data.placeholder!,
                style: TextStyle(
                  fontSize: context.headingFont * 0.95,
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                  height: 1,
                  letterSpacing: -0.5,
                ),
              )
            else
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: data.value),
                duration: Duration(milliseconds: 1000 + delay),
                curve: Curves.easeOutCubic,
                builder: (_, v, _) => Text(
                  v.toStringAsFixed(data.decimals),
                  style: TextStyle(
                    fontSize: context.headingFont * 0.95,
                    fontWeight: FontWeight.w900,
                    color: cs.onSurface,
                    height: 1,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            SizedBox(height: context.xs * 0.5),
            Text(
              data.label,
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                color: cs.onSurfaceVariant,
                letterSpacing: 0.25,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
