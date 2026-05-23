import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/wine_card.widget.dart';
import '../../widgets/wine_search_bar.widget.dart';
import '../../widgets/wine_type_filter.widget.dart';
import '../wine_compare/wine_compare_flow.dart';

class WineListScreen extends ConsumerStatefulWidget {
  const WineListScreen({super.key});

  @override
  ConsumerState<WineListScreen> createState() => _WineListScreenState();
}

class _WineListScreenState extends ConsumerState<WineListScreen>
    with SingleTickerProviderStateMixin {
  // Overscroll-pull thresholds (px). Below dead zone = nothing; over range = open.
  static const _kPullDeadZone = 60.0;
  static const _kPullRange = 60.0;

  late final AnimationController _revealController;
  bool _pullTriggered = false;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
      value: ref.read(wineSearchBarVisibleProvider) ? 1.0 : 0.0,
    );
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  bool _handleScroll(ScrollNotification n) {
    if (_pullTriggered || ref.read(wineSearchBarVisibleProvider)) {
      if (n is ScrollEndNotification) _pullTriggered = false;
      return false;
    }
    if (n is ScrollUpdateNotification && n.metrics.pixels < 0) {
      final overscroll = -n.metrics.pixels;
      final v = ((overscroll - _kPullDeadZone) / _kPullRange).clamp(0.0, 1.0);
      _revealController.value = v;
      if (v >= 1.0) {
        _pullTriggered = true;
        ref.read(wineSearchBarVisibleProvider.notifier).show();
      }
    } else if (n is ScrollUpdateNotification && n.metrics.pixels >= 0) {
      if (_revealController.value > 0) _revealController.value = 0.0;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final winesAsync = ref.watch(wineControllerProvider);
    final typeFilter = ref.watch(wineTypeFilterProvider);
    final sortMode = ref.watch(wineSortProvider);
    final searchQuery = ref.watch(wineSearchQueryProvider).trim().toLowerCase();
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    ref.listen<bool>(wineSearchBarVisibleProvider, (_, next) {
      if (next) {
        _revealController.animateTo(
          1.0,
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOut,
        );
      } else {
        _revealController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: _handleScroll,
          child: CustomScrollView(
            restorationId: 'wine_list_scroll',
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: context.xl)),

              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.paddingH * 1.3,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SIPPD',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: context.titleFont * 1.3,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                                height: 1.05,
                              ),
                            ),
                            SizedBox(height: context.xs),
                            Text(
                              l10n.winesListSubtitle,
                              style: TextStyle(
                                fontSize: context.captionFont,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: switch (sortMode) {
                          WineSortMode.rating => l10n.winesListSortRating,
                          WineSortMode.recent => l10n.winesListSortRecent,
                          WineSortMode.name => l10n.winesListSortName,
                        },
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () =>
                              ref.read(wineSortProvider.notifier).toggle(),
                          child: Padding(
                            padding: EdgeInsets.all(context.w * 0.02),
                            child: Icon(
                              // One icon per sort mode so the toggle
                              // visibly shifts on each tap (rating ↔ recent
                              // ↔ name had only two icons before).
                              switch (sortMode) {
                                WineSortMode.rating =>
                                  PhosphorIconsRegular.star,
                                WineSortMode.recent =>
                                  PhosphorIconsRegular.clock,
                                WineSortMode.name =>
                                  PhosphorIconsRegular.textAa,
                              },
                              size: context.w * 0.055,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: context.w * 0.01),
                      _HeaderIconButton(
                        icon: PhosphorIconsRegular.chartBar,
                        onTap: () => context.push(AppRoutes.wineStats),
                        tooltip: l10n.winesListTooltipStats,
                      ),
                      SizedBox(width: context.w * 0.01),
                      _HeaderIconButton(
                        icon: PhosphorIconsRegular.plus,
                        onTap: () => context.push(AppRoutes.wineAdd),
                        tooltip: l10n.winesListTooltipAddWine,
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: context.l)),

              // Filter chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.paddingH * 1.3,
                  ),
                  child: const WineTypeFilterBar(),
                ),
              ),

              // Pull-down search bar (revealed via overscroll above filters)
              SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: _revealController,
                  builder: (context, child) {
                    final t = _revealController.value;
                    if (t == 0.0) return const SizedBox.shrink();
                    return ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: t,
                        child: Opacity(opacity: t, child: child),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.paddingH,
                      context.m,
                      context.paddingH,
                      0,
                    ),
                    child: const WineSearchBar(),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: context.m)),

              // Wine list
              winesAsync.when(
                data: (wines) {
                  var filtered = typeFilter == null
                      ? wines
                      : wines.where((w) => w.type == typeFilter).toList();

                  if (searchQuery.isNotEmpty) {
                    filtered = filtered.where((w) {
                      final name = w.name.toLowerCase();
                      final winery = (w.winery ?? '').toLowerCase();
                      final region = (w.region ?? '').toLowerCase();
                      return name.contains(searchQuery) ||
                          winery.contains(searchQuery) ||
                          region.contains(searchQuery);
                    }).toList();
                  }

                  if (filtered.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: WineEmptyState(
                        hasFilter: typeFilter != null || searchQuery.isNotEmpty,
                      ),
                    );
                  }

                  final byRating = List<WineEntity>.from(filtered)
                    ..sort((a, b) => b.rating.compareTo(a.rating));
                  final rankById = {
                    for (var i = 0; i < byRating.length; i++)
                      byRating[i].id: i + 1,
                  };
                  final sorted = switch (sortMode) {
                    WineSortMode.rating => byRating,
                    WineSortMode.recent => List<WineEntity>.from(
                      filtered,
                    )..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
                    WineSortMode.name =>
                      List<WineEntity>.from(filtered)..sort(
                        (a, b) => a.name.toLowerCase().compareTo(
                          b.name.toLowerCase(),
                        ),
                      ),
                  };

                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: context.paddingH),
                    sliver: SliverList.separated(
                      itemCount: sorted.length,
                      separatorBuilder: (_, _) => SizedBox(height: context.s),
                      itemBuilder: (context, index) => AnimatedWineCard(
                        index: index,
                        child: WineCardWidget(
                          wine: sorted[index],
                          rank: rankById[sorted[index].id] ?? index + 1,
                          compact: true,
                          circularImage: false,
                          onTap: () => context.push(
                            AppRoutes.wineDetailPath(sorted[index].id),
                          ),
                          onLongPress: () => startCompareFlow(
                            context,
                            sourceWineId: sorted[index].id,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => SliverFillRemaining(
                  child: Center(
                    child: ErrorView(
                      title: l10n.winesListErrorLoad,
                      onRetry: () => ref.invalidate(wineControllerProvider),
                      error: error,
                    ),
                  ),
                ),
              ),

              // Bottom padding
              SliverToBoxAdapter(child: SizedBox(height: context.xl * 2)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.1;
    return Tooltip(
      message: tooltip,
      child: Material(
        color: cs.surfaceContainer,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(icon, color: cs.onSurface, size: context.w * 0.055),
          ),
        ),
      ),
    );
  }
}

class AnimatedWineCard extends StatefulWidget {
  final int index;
  final Widget child;

  const AnimatedWineCard({super.key, required this.index, required this.child});

  @override
  State<AnimatedWineCard> createState() => _AnimatedWineCardState();
}

class _AnimatedWineCardState extends State<AnimatedWineCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: 60 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

class WineEmptyState extends StatelessWidget {
  final bool hasFilter;
  const WineEmptyState({super.key, this.hasFilter = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: context.w * 0.2,
            height: context.w * 0.2,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsRegular.wine,
              size: context.w * 0.1,
              color: cs.primary,
            ),
          ),
          SizedBox(height: context.m),
          Text(
            hasFilter ? l10n.winesEmptyFilteredTitle : l10n.winesEmptyTitle,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (hasFilter) ...[
            SizedBox(height: context.xs),
            Text(
              l10n.winesEmptyFilteredBody,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ] else ...[
            SizedBox(height: context.l),
            FilledButton.icon(
              onPressed: () => context.push(AppRoutes.wineAdd),
              icon: const Icon(PhosphorIconsRegular.plus),
              label: Text(l10n.winesEmptyAddWineCta),
            ),
          ],
        ],
      ),
    );
  }
}
