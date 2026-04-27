import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../controller/wine_stats.provider.dart';
import 'widgets/stats_hero.widget.dart';
import 'widgets/tally_bars.widget.dart';
import 'widgets/top_wines_list.widget.dart';
import 'widgets/wine_locations_map.widget.dart';
import 'widgets/wine_type_breakdown.widget.dart';

class WineStatsScreen extends ConsumerWidget {
  const WineStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final regions = ref.watch(statsTopRegionsProvider);
    final breakdown = ref.watch(statsTypeBreakdownProvider);
    final topWines = ref.watch(statsTopWinesProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Your stats',
          style: TextStyle(
            fontSize: context.bodyFont * 1.1,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            context.paddingH,
            context.s,
            context.paddingH,
            context.xl * 2,
          ),
          children: [
            const StatsHero(),
            SizedBox(height: context.xl),

            _Section(
              title: 'Wine type breakdown',
              subtitle: 'How your taste splits across the four styles.',
              delay: 100,
              child: WineTypeBreakdown(data: breakdown),
            ),
            SizedBox(height: context.l),

            _Section(
              title: 'Where you’ve drunk wine',
              subtitle: 'Every wine you logged with a place.',
              delay: 200,
              child: const WineLocationsMap(),
            ),
            SizedBox(height: context.l),

            _Section(
              title: 'Top regions',
              subtitle: 'Where most of your bottles come from.',
              delay: 300,
              child: TallyBars(items: regions, maxItems: 8),
            ),
            SizedBox(height: context.l),

            _Section(
              title: 'Highest rated',
              subtitle: 'Your personal podium.',
              delay: 400,
              child: TopWinesList(wines: topWines, maxItems: 5),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final int delay;

  const _Section({
    required this.title,
    this.subtitle,
    required this.child,
    this.delay = 0,
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
        SlideEffect(
          begin: const Offset(0, 0.05),
          end: Offset.zero,
          duration: 420.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeOut,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: context.xs * 0.5),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
          SizedBox(height: context.m),
          child,
        ],
      ),
    );
  }
}
