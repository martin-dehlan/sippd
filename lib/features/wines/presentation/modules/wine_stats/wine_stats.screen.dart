import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);

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
                  title: l10n.winesStatsSectionTypeBreakdown,
                  subtitle: l10n.winesStatsSectionTypeBreakdownSubtitle,
                  delay: 100,
                  child: WineTypeBreakdown(data: breakdown),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.m)),

                _SliverSection(
                  title: l10n.winesStatsSectionTopRated,
                  subtitle: l10n.winesStatsSectionTopRatedSubtitle,
                  delay: 150,
                  child: TopWinesList(wines: topWines, maxItems: 5),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.m)),

                if (isPro) ...[
                  _SliverSection(
                    title: l10n.winesStatsSectionTimeline,
                    subtitle: l10n.winesStatsSectionTimelineSubtitle,
                    delay: 175,
                    child: hasWines
                        ? WineTimeline(months: timeline)
                        : const WineTimeline(months: []),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                  _SliverSection(
                    title: l10n.winesStatsSectionPartners,
                    subtitle: l10n.winesStatsSectionPartnersSubtitle,
                    delay: 220,
                    child: partnersAsync.when(
                      loading: () => const DrinkingPartnersSkeleton(),
                      error: (_, _) => StatsSectionEmpty(
                        icon: PhosphorIconsFill.usersThree,
                        title: l10n.winesStatsPartnersErrorTitle,
                        body: l10n.winesStatsPartnersErrorBody,
                      ),
                      data: (partners) => partners.isEmpty
                          ? StatsSectionEmpty(
                              icon: PhosphorIconsFill.usersThree,
                              title: l10n.winesStatsPartnersEmptyTitle,
                              body: l10n.winesStatsPartnersEmptyBody,
                              ctaLabel: l10n.winesStatsPartnersCta,
                              onTap: () => context.go(AppRoutes.groups),
                            )
                          : DrinkingPartners(partners: partners),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                  _SliverSection(
                    title: l10n.winesStatsSectionPrices,
                    subtitle: l10n.winesStatsSectionPricesSubtitle,
                    delay: 200,
                    child: hasWines && !hasPriced
                        ? StatsSectionEmpty(
                            icon: PhosphorIconsFill.tag,
                            title: l10n.winesStatsPriceEmptyTitle,
                            body: l10n.winesStatsPriceEmptyBody,
                            ctaLabel: l10n.winesStatsPriceEmptyCta,
                            onTap: () => context.pop(),
                          )
                        : const SpendingSection(),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                  _SliverSection(
                    title: l10n.winesStatsSectionPlaces,
                    subtitle: l10n.winesStatsSectionPlacesSubtitle,
                    delay: 300,
                    child: hasWines && !hasLocations
                        ? StatsSectionEmpty(
                            icon: PhosphorIconsFill.mapPin,
                            title: l10n.winesStatsPlacesEmptyTitle,
                            body: l10n.winesStatsPlacesEmptyBody,
                            ctaLabel: l10n.winesStatsPlacesEmptyCta,
                            onTap: () => context.pop(),
                          )
                        : const WineLocationsMap(),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: context.m)),

                  _SliverSection(
                    title: l10n.winesStatsSectionRegions,
                    subtitle: l10n.winesStatsSectionRegionsSubtitle,
                    delay: 400,
                    child: hasWines && regions.isEmpty
                        ? StatsSectionEmpty(
                            icon: PhosphorIconsFill.globe,
                            title: l10n.winesStatsRegionsEmptyTitle,
                            body: l10n.winesStatsRegionsEmptyBody,
                            ctaLabel: l10n.winesStatsRegionsEmptyCta,
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
    final l10n = AppLocalizations.of(context);
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
            l10n.winesStatsPreviewBadge,
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
            l10n.winesStatsPreviewHint,
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
    final l10n = AppLocalizations.of(context);
    return Animate(
      effects: [FadeEffect(duration: 360.ms)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.winesStatsHeader,
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
            l10n.winesStatsSubtitle,
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
