import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../paywall/controller/paywall.provider.dart';
import '../../../controller/wine_stats.provider.dart';
import 'widgets/drinking_partners.widget.dart';
import 'widgets/spending_section.widget.dart';
import 'widgets/stats_empty_hero.widget.dart';
import 'widgets/stats_hero.widget.dart';
import 'widgets/stats_pro_lock.widget.dart';
import 'widgets/stats_section_empty.widget.dart';
import 'widgets/region_skyline.widget.dart';
import 'widgets/top_wines_list.widget.dart';
import 'widgets/wine_locations_map.widget.dart';
import 'widgets/wine_timeline.widget.dart';
import 'widgets/wine_type_breakdown.widget.dart';

class WineStatsScreen extends ConsumerWidget {
  const WineStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final regions = ref.watch(statsTopRegionsProvider);
    final breakdown = ref.watch(statsTypeBreakdownProvider);
    final topWines = ref.watch(statsTopWinesProvider);
    final timeline = ref.watch(statsTimelineProvider);
    final partnersAsync = ref.watch(statsDrinkingPartnersProvider);
    final isPro = ref.watch(isProProvider);
    final hasWines = ref.watch(
      statsHeroProvider.select((h) => h.totalWines > 0),
    );
    final hasLocations = ref.watch(statsWinesWithLocationProvider).isNotEmpty;
    final hasPriced = ref.watch(
      statsSpendingProvider.select((s) => s.pricedCount > 0),
    );

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              restorationId: 'wine_stats_scroll',
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: context.l)),

                // Header — same family as wine_list (Playfair display +
                // muted subtitle) so the slide-in feels like a sister page.
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.paddingH * 1.3,
                    ),
                    child: const _Header(),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.m)),

                // Hero stat card. Swaps to an actionable empty-state with a
                // "Rate a wine" CTA when the user has zero ratings — sections
                // below still render as faint skeleton previews so the user
                // sees what's coming.
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.paddingH),
                    child: hasWines
                        ? const StatsHero()
                        : const StatsEmptyHero(),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.l)),
                if (!hasWines)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.paddingH,
                      ),
                      child: const _PreviewLabel(),
                    ),
                  ),
                if (!hasWines)
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                _SliverSection(
                  title: 'Wine type breakdown',
                  subtitle: 'How your taste splits across the four styles.',
                  delay: 100,
                  child: WineTypeBreakdown(data: breakdown),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.m)),

                _SliverSection(
                  title: 'Highest rated',
                  subtitle: 'Your personal podium.',
                  delay: 150,
                  child: TopWinesList(wines: topWines, maxItems: 5),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.m)),

                if (isPro) ...[
                  _SliverSection(
                    title: 'Timeline',
                    subtitle: 'Month by month, the wines that wrote your year.',
                    delay: 175,
                    child: hasWines
                        ? WineTimeline(months: timeline)
                        : const WineTimeline(months: []),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                  _SliverSection(
                    title: 'Drinking partners',
                    subtitle: 'Who you taste with most.',
                    delay: 220,
                    child: partnersAsync.when(
                      loading: () => const DrinkingPartnersSkeleton(),
                      error: (_, _) => StatsSectionEmpty(
                        icon: PhosphorIconsFill.usersThree,
                        title: 'Couldn\'t load partners',
                        body: 'Pull down or come back in a moment.',
                      ),
                      data: (partners) => partners.isEmpty
                          ? StatsSectionEmpty(
                              icon: PhosphorIconsFill.usersThree,
                              title: 'Rate together',
                              body:
                                  'Once you and a friend rate the same wine '
                                  'in a group, they\'ll show up here.',
                              ctaLabel: 'Open groups',
                              onTap: () => context.go(AppRoutes.groups),
                            )
                          : DrinkingPartners(partners: partners),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                  _SliverSection(
                    title: 'Prices & value',
                    subtitle:
                        'Sum of bottle prices logged on your rated wines '
                        '— not actual consumption spend.',
                    delay: 200,
                    child: hasWines && !hasPriced
                        ? StatsSectionEmpty(
                            icon: PhosphorIconsFill.tag,
                            title: 'Add a price',
                            body:
                                'Log what you paid on a wine to unlock '
                                'spend, average cost and best-value picks.',
                            ctaLabel: 'Edit a wine',
                            onTap: () => context.pop(),
                          )
                        : const SpendingSection(),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                  _SliverSection(
                    title: 'Where you’ve drunk wine',
                    subtitle: 'Every wine you logged with a place.',
                    delay: 300,
                    child: hasWines && !hasLocations
                        ? StatsSectionEmpty(
                            icon: PhosphorIconsFill.mapPin,
                            title: 'Add a location',
                            body:
                                'Drop a pin on a wine to start mapping '
                                'where you drink — bars, dinners, trips.',
                            ctaLabel: 'Edit a wine',
                            onTap: () => context.pop(),
                          )
                        : const WineLocationsMap(),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                  _SliverSection(
                    title: 'Top regions',
                    subtitle: 'Where most of your bottles come from.',
                    delay: 400,
                    child: hasWines && regions.isEmpty
                        ? StatsSectionEmpty(
                            icon: PhosphorIconsFill.globe,
                            title: 'Add a region',
                            body:
                                'Tag wines with a region or country to '
                                'see where your taste leans.',
                            ctaLabel: 'Edit a wine',
                            onTap: () => context.pop(),
                          )
                        : RegionSkyline(items: regions),
                  ),
                ] else ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.paddingH,
                      ),
                      child: const StatsProLock(),
                    ),
                  ),
                ],
                // Floating back button is ~w*0.16 + bottom margin, so reserve
                // enough space here that scrollable content never disappears
                // behind it on the last section.
                SliverToBoxAdapter(child: SizedBox(height: context.w * 0.3)),
              ],
            ),

            // Floating back — matches the wine_add scaffolding pattern so
            // navigation stays consistent across screens that aren't shell
            // tabs.
            Positioned(
              left: context.paddingH,
              bottom: context.m,
              child: _FloatingBackButton(onPressed: () => context.pop()),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewLabel extends StatelessWidget {
  const _PreviewLabel();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.025,
            vertical: context.xs * 0.7,
          ),
          decoration: BoxDecoration(
            color: cs.surfaceContainer,
            borderRadius: BorderRadius.circular(context.w * 0.015),
            border: Border.all(color: cs.outlineVariant, width: 0.5),
          ),
          child: Text(
            'PREVIEW',
            style: TextStyle(
              fontSize: context.captionFont * 0.75,
              fontWeight: FontWeight.w800,
              color: cs.onSurfaceVariant,
              letterSpacing: 1.4,
            ),
          ),
        ),
        SizedBox(width: context.s),
        Expanded(
          child: Text(
            'What you’ll see after a few ratings.',
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Animate(
      effects: [FadeEffect(duration: 360.ms)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STATS',
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 1.3,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.05,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            'Your wine journey, visualised',
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

class _SliverSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final int delay;

  const _SliverSection({
    required this.title,
    this.subtitle,
    required this.child,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH),
        child: Animate(
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
        ),
      ),
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _FloatingBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'wine-stats-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}
