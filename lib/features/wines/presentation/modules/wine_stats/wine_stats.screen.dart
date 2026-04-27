import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../paywall/controller/paywall.provider.dart';
import '../../../controller/wine_stats.provider.dart';
import 'widgets/stats_hero.widget.dart';
import 'widgets/stats_section.widget.dart';
import 'widgets/tally_bars.widget.dart';

class WineStatsScreen extends ConsumerWidget {
  const WineStatsScreen({super.key});

  void _openPaywall(BuildContext context, String source) {
    context.push(
      AppRoutes.paywall,
      extra: {'source': 'stats_$source'},
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isPro = ref.watch(isProProvider);
    final regions = ref.watch(statsTopRegionsProvider);
    final topWines = ref.watch(statsTopWinesProvider);

    return Scaffold(
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
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            context.paddingH,
            context.m,
            context.paddingH,
            context.xl * 2,
          ),
          children: [
            const StatsHero(),
            SizedBox(height: context.xl),

            // Top regions — free shows top 3, Pro shows top 10.
            StatsSection(
              title: 'Top regions',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TallyBars(
                    items: regions,
                    maxItems: isPro ? 10 : 3,
                  ),
                  if (!isPro && regions.length > 3) ...[
                    SizedBox(height: context.m),
                    _PreviewCta(
                      label: '+${regions.length - 3} more in Sippd Pro',
                      onTap: () => _openPaywall(context, 'top_regions'),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: context.m),

            // Top wines — free shows the highest-rated only.
            StatsSection(
              title: 'Highest rated',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (topWines.isEmpty)
                    Text(
                      'Rate your first wine to see it here.',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                    )
                  else ...[
                    for (int i = 0; i < (isPro ? topWines.length : 1); i++) ...[
                      if (i > 0) SizedBox(height: context.s),
                      _TopWineRow(
                        rank: i + 1,
                        name: topWines[i].name,
                        rating: topWines[i].rating,
                      ),
                    ],
                  ],
                  if (!isPro && topWines.length > 1) ...[
                    SizedBox(height: context.m),
                    _PreviewCta(
                      label: 'See your top 10 in Sippd Pro',
                      onTap: () => _openPaywall(context, 'top_wines'),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: context.m),

            // Pro-locked: top wineries.
            StatsSection(
              title: 'Top wineries',
              subtitle: 'Which producers you keep coming back to.',
              locked: !isPro,
              onLockedTap: () => _openPaywall(context, 'top_wineries'),
              child: Consumer(
                builder: (context, ref, _) {
                  final wineries = ref.watch(statsTopWineriesProvider);
                  return TallyBars(
                    items: wineries,
                    maxItems: 10,
                  );
                },
              ),
            ),
            SizedBox(height: context.m),

            // Pro-locked placeholder: world map.
            StatsSection(
              title: 'Where you’ve drunk wine',
              subtitle: 'Every wine you logged with a place, on a map.',
              locked: !isPro,
              onLockedTap: () => _openPaywall(context, 'map'),
              child: SizedBox(
                height: context.h * 0.22,
                child: Center(
                  child: Icon(
                    PhosphorIconsRegular.mapTrifold,
                    size: context.w * 0.18,
                    color: cs.outlineVariant,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.m),

            // Pro-locked placeholder: drinking partners.
            StatsSection(
              title: 'Drinking partners',
              subtitle: 'The people you most often share wine with.',
              locked: !isPro,
              onLockedTap: () => _openPaywall(context, 'partners'),
              child: SizedBox(
                height: context.h * 0.16,
                child: Center(
                  child: Icon(
                    PhosphorIconsRegular.usersThree,
                    size: context.w * 0.18,
                    color: cs.outlineVariant,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.m),

            // Pro-locked placeholder: calendar heatmap.
            StatsSection(
              title: 'Tasting calendar',
              subtitle: 'A year of your ratings at a glance.',
              locked: !isPro,
              onLockedTap: () => _openPaywall(context, 'calendar'),
              child: SizedBox(
                height: context.h * 0.16,
                child: Center(
                  child: Icon(
                    PhosphorIconsRegular.calendarBlank,
                    size: context.w * 0.18,
                    color: cs.outlineVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewCta extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PreviewCta({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.s,
        ),
        decoration: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
        child: Row(
          children: [
            Icon(
              PhosphorIconsBold.lockKey,
              color: cs.primary,
              size: context.w * 0.04,
            ),
            SizedBox(width: context.s),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              PhosphorIconsRegular.caretRight,
              color: cs.primary,
              size: context.w * 0.035,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopWineRow extends StatelessWidget {
  final int rank;
  final String name;
  final double rating;

  const _TopWineRow({
    required this.rank,
    required this.name,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: context.w * 0.07,
          height: context.w * 0.07,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: rank == 1
                ? cs.primary
                : cs.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Text(
            rank.toString(),
            style: TextStyle(
              color: rank == 1 ? cs.onPrimary : cs.primary,
              fontWeight: FontWeight.w800,
              fontSize: context.captionFont,
            ),
          ),
        ),
        SizedBox(width: context.s),
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
        ),
        SizedBox(width: context.s),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.bodyFont,
            fontWeight: FontWeight.w800,
            color: cs.primary,
          ),
        ),
      ],
    );
  }
}
