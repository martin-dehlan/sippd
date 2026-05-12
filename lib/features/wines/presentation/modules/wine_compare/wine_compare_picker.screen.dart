import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../controller/wine.provider.dart';
import '../../widgets/wine_card.widget.dart';

class WineComparePickerScreen extends ConsumerWidget {
  final String? excludeId;

  const WineComparePickerScreen({super.key, this.excludeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(wineControllerProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: context.l)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.paddingH * 1.3,
                    ),
                    child: const _Header(),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.l)),
                winesAsync.when(
                  data: (wines) {
                    final filtered =
                        wines.where((w) => w.id != excludeId).toList()
                          ..sort((a, b) => b.rating.compareTo(a.rating));
                    if (filtered.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: _EmptyState(),
                      );
                    }
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.paddingH,
                      ),
                      sliver: SliverList.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => SizedBox(height: context.s),
                        itemBuilder: (_, i) {
                          final wine = filtered[i];
                          return Animate(
                            effects: [
                              FadeEffect(
                                duration: 360.ms,
                                delay: Duration(
                                  milliseconds: 60 + (i * 30).clamp(0, 240),
                                ),
                              ),
                            ],
                            child: WineCardWidget(
                              wine: wine,
                              rank: i + 1,
                              compact: true,
                              hideRatingIfEmpty: true,
                              onTap: () => context.pop(wine.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (e, _) => SliverFillRemaining(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(context.paddingH),
                        child: Text(
                          describeAppError(
                            e,
                            fallback: AppLocalizations.of(
                              context,
                            ).winesComparePickerErrorFallback,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: context.w * 0.3)),
              ],
            ),
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
    final l10n = AppLocalizations.of(context);
    return Animate(
      effects: [FadeEffect(duration: 360.ms)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.winesCompareHeader,
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
            l10n.winesComparePickerSubtitle,
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

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.wine,
              size: context.w * 0.16,
              color: cs.outline,
            ),
            SizedBox(height: context.m),
            Text(
              l10n.winesComparePickerEmptyTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              l10n.winesComparePickerEmptyBody,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
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
        heroTag: 'wine-compare-picker-back',
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
