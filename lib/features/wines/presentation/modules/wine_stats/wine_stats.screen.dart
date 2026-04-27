import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              restorationId: 'wine_stats_scroll',
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: context.xl)),

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
                SliverToBoxAdapter(child: SizedBox(height: context.l)),

                // Hero stat cards.
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.paddingH,
                    ),
                    child: const StatsHero(),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.xl)),

                _SliverSection(
                  title: 'Wine type breakdown',
                  subtitle: 'How your taste splits across the four styles.',
                  delay: 100,
                  child: WineTypeBreakdown(data: breakdown),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.l)),

                _SliverSection(
                  title: 'Where you’ve drunk wine',
                  subtitle: 'Every wine you logged with a place.',
                  delay: 200,
                  child: const WineLocationsMap(),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.l)),

                _SliverSection(
                  title: 'Top regions',
                  subtitle: 'Where most of your bottles come from.',
                  delay: 300,
                  child: TallyBars(items: regions, maxItems: 8),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.l)),

                _SliverSection(
                  title: 'Highest rated',
                  subtitle: 'Your personal podium.',
                  delay: 400,
                  child: TopWinesList(wines: topWines, maxItems: 5),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.xl * 2)),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Animate(
      effects: [
        FadeEffect(duration: 360.ms),
      ],
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
