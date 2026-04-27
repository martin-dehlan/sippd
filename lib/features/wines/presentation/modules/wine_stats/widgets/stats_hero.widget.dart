import 'package:flutter/material.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsHero extends ConsumerWidget {
  const StatsHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hero = ref.watch(statsHeroProvider);
    return Row(
      children: [
        Expanded(
          child: _HeroNumber(
            label: 'Wines',
            value: hero.totalWines.toString(),
          ),
        ),
        Expanded(
          child: _HeroNumber(
            label: 'Regions',
            value: hero.distinctRegions.toString(),
          ),
        ),
        Expanded(
          child: _HeroNumber(
            label: 'Countries',
            value: hero.distinctCountries.toString(),
          ),
        ),
        Expanded(
          child: _HeroNumber(
            label: 'Avg',
            value: hero.totalWines == 0
                ? '—'
                : hero.avgRating.toStringAsFixed(1),
          ),
        ),
      ],
    );
  }
}

class _HeroNumber extends StatelessWidget {
  final String label;
  final String value;
  const _HeroNumber({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: context.titleFont * 0.9,
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
            letterSpacing: -0.5,
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
    );
  }
}
