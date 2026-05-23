import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/price_format.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import 'widgets/wine_compare_attribute_row.widget.dart';
import 'widgets/wine_compare_hero.widget.dart';
import 'widgets/wine_compare_notes.widget.dart';
import 'widgets/wine_compare_tasting.widget.dart';

class WineCompareScreen extends ConsumerWidget {
  final String? leftId;
  final String? rightId;

  const WineCompareScreen({super.key, this.leftId, this.rightId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    final missing = leftId == null || rightId == null || leftId == rightId;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Stack(
          children: [
            if (missing)
              _MissingState(sameWine: leftId != null && leftId == rightId)
            else
              _LoadedBody(leftId: leftId!, rightId: rightId!, ref: ref),
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

class _LoadedBody extends StatelessWidget {
  final String leftId;
  final String rightId;
  final WidgetRef ref;

  const _LoadedBody({
    required this.leftId,
    required this.rightId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final leftAsync = ref.watch(wineDetailProvider(leftId));
    final rightAsync = ref.watch(wineDetailProvider(rightId));

    if (leftAsync.isLoading || rightAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final err = leftAsync.error ?? rightAsync.error;
    if (err != null) return _ErrorView(error: err);
    final left = leftAsync.valueOrNull;
    final right = rightAsync.valueOrNull;
    if (left == null || right == null) {
      return const _MissingState(sameWine: false);
    }

    return _ScrollBody(left: left, right: right);
  }
}

class _ScrollBody extends StatelessWidget {
  final WineEntity left;
  final WineEntity right;

  const _ScrollBody({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: context.l)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: _Header(left: left, right: right),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: context.l)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            child: Animate(
              effects: [
                FadeEffect(duration: 420.ms, delay: 80.ms),
                SlideEffect(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                  duration: 420.ms,
                  delay: 80.ms,
                  curve: Curves.easeOut,
                ),
              ],
              child: WineCompareHeroWidget(left: left, right: right),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: context.l)),
        _Section(
          title: l10n.winesCompareSectionAtAGlance,
          delay: 160,
          child: _AttributesCard(left: left, right: right),
        ),
        SliverToBoxAdapter(child: SizedBox(height: context.m)),
        _Section(
          title: l10n.winesCompareSectionTasting,
          subtitle: l10n.winesCompareSectionTastingSubtitle,
          delay: 220,
          child: WineCompareTastingWidget(left: left, right: right),
        ),
        SliverToBoxAdapter(child: SizedBox(height: context.m)),
        if ((left.notes ?? '').isNotEmpty ||
            (right.notes ?? '').isNotEmpty) ...[
          _Section(
            title: l10n.winesCompareSectionNotes,
            delay: 280,
            child: WineCompareNotesWidget(left: left, right: right),
          ),
          SliverToBoxAdapter(child: SizedBox(height: context.m)),
        ],
        SliverToBoxAdapter(child: SizedBox(height: context.w * 0.3)),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final WineEntity left;
  final WineEntity right;

  const _Header({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Animate(
      effects: [FadeEffect(duration: 360.ms)],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
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
                  '${left.name}   ·   ${right.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.s),
          _SwapButton(
            onPressed: () => context.pushReplacement(
              AppRoutes.wineComparePath(right.id, left.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwapButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SwapButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.11;
    return Material(
      color: cs.surfaceContainer,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            PhosphorIconsRegular.swap,
            size: context.w * 0.05,
            color: cs.onSurface,
          ),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: context.bodyFont * 1.1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                  color: cs.onSurface,
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
              SizedBox(height: context.s),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _AttributesCard extends StatelessWidget {
  final WineEntity left;
  final WineEntity right;

  const _AttributesCard({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.s,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WineCompareAttributeRow(
            label: l10n.winesCompareAttrType,
            leftValue: _type(left, l10n),
            rightValue: _type(right, l10n),
          ),
          _Divider(),
          WineCompareAttributeRow(
            label: l10n.winesCompareAttrVintage,
            leftValue: left.vintage?.toString(),
            rightValue: right.vintage?.toString(),
          ),
          _Divider(),
          WineCompareAttributeRow(
            label: l10n.winesCompareAttrGrape,
            leftValue: _grape(left),
            rightValue: _grape(right),
          ),
          _Divider(),
          WineCompareAttributeRow(
            label: l10n.winesCompareAttrOrigin,
            leftValue: _origin(left),
            rightValue: _origin(right),
          ),
          _Divider(),
          WineCompareAttributeRow(
            label: l10n.winesCompareAttrPrice,
            leftValue: _price(left),
            rightValue: _price(right),
          ),
        ],
      ),
    );
  }

  static String _type(WineEntity w, AppLocalizations l) => switch (w.type) {
    WineType.red => l.wineTypeRed,
    WineType.white => l.wineTypeWhite,
    WineType.rose => l.wineTypeRose,
    WineType.sparkling => l.wineTypeSparkling,
  };

  static String? _grape(WineEntity w) {
    final g = w.grape ?? w.grapeFreetext;
    return (g == null || g.isEmpty) ? null : g;
  }

  static String? _origin(WineEntity w) {
    final parts = [w.region, w.country].whereType<String>().toList();
    return parts.isEmpty ? null : parts.join(', ');
  }

  static String? _price(WineEntity w) =>
      w.price == null ? null : '${w.currency} ${formatPrice(w.price!)}';
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 0.5,
      color: cs.outlineVariant.withValues(alpha: 0.55),
    );
  }
}

class _MissingState extends StatelessWidget {
  final bool sameWine;
  const _MissingState({required this.sameWine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final msg = sameWine
        ? l10n.winesCompareMissingSameWine
        : l10n.winesCompareMissingDefault;
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
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final Object error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.paddingH),
        child: Text(
          describeAppError(error, fallback: l10n.winesCompareErrorFallback),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: context.captionFont, color: cs.error),
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
        heroTag: 'wine-compare-back',
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
