import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/wine_card.widget.dart';
import '../../widgets/wine_type_filter.widget.dart';

class WineListScreen extends ConsumerWidget {
  const WineListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(wineControllerProvider);
    final typeFilter = ref.watch(wineTypeFilterProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: context.xl)),

            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.paddingH * 1.3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                              SizedBox(width: context.w * 0.025),
                              Text(
                                '🍷',
                                style:
                                    TextStyle(fontSize: context.titleFont * 0.9),
                              ),
                            ],
                          ),
                          SizedBox(height: context.xs),
                          Text(
                            'Your wine rankings',
                            style: TextStyle(
                              fontSize: context.captionFont,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _HeaderIconButton(
                      icon: Icons.qr_code_scanner,
                      onTap: () => context.push(AppRoutes.scan),
                      tooltip: 'Scan wine',
                    ),
                    SizedBox(width: context.w * 0.02),
                    _HeaderIconButton(
                      icon: Icons.add,
                      onTap: () => context.push(AppRoutes.wineAdd),
                      tooltip: 'Add wine',
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: context.l)),

            // Filter chips
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
                child: const WineTypeFilterBar(),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: context.m)),

            // Wine list
            winesAsync.when(
              data: (wines) {
                final filtered = typeFilter == null
                    ? wines
                    : wines.where((w) => w.type == typeFilter).toList();

                if (filtered.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: WineEmptyState(hasFilter: typeFilter != null),
                  );
                }

                final sorted = List<WineEntity>.from(filtered)
                  ..sort((a, b) => b.rating.compareTo(a.rating));

                return SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingH),
                  sliver: SliverList.separated(
                    itemCount: sorted.length,
                    separatorBuilder: (_, _) =>
                        SizedBox(height: context.s),
                    itemBuilder: (context, index) => AnimatedWineCard(
                      index: index,
                      child: WineCardWidget(
                        wine: sorted[index],
                        rank: index + 1,
                        onTap: () => context.push(
                            AppRoutes.wineDetailPath(sorted[index].id)),
                      ),
                    ),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => SliverFillRemaining(
                child: Center(child: Text('Error: $error')),
              ),
            ),

            // Bottom padding
            SliverToBoxAdapter(child: SizedBox(height: context.xl * 2)),
          ],
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

  const AnimatedWineCard({
    super.key,
    required this.index,
    required this.child,
  });

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
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

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
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

class WineEmptyState extends StatelessWidget {
  final bool hasFilter;
  const WineEmptyState({super.key, this.hasFilter = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
              Icons.wine_bar_outlined,
              size: context.w * 0.1,
              color: cs.primary,
            ),
          ),
          SizedBox(height: context.m),
          Text(
            hasFilter ? 'No wines match filter' : 'No wines yet',
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (hasFilter) ...[
            SizedBox(height: context.xs),
            Text(
              'Try a different filter',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ] else ...[
            SizedBox(height: context.l),
            FilledButton.icon(
              onPressed: () => context.push(AppRoutes.wineAdd),
              icon: const Icon(Icons.add),
              label: const Text('Add wine'),
            ),
          ],
        ],
      ),
    );
  }
}
