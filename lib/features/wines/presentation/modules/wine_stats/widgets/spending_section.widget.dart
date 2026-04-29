import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../controller/wine_stats.provider.dart';
import '../../../../domain/entities/wine.entity.dart';
import '../../../widgets/wine_thumb.widget.dart';

class SpendingSection extends ConsumerWidget {
  const SpendingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final spend = ref.watch(statsSpendingProvider);

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: spend.pricedCount == 0
          ? const _Empty()
          : _Content(spend: spend, cs: cs),
    );
  }
}

class _Content extends StatelessWidget {
  final StatsSpending spend;
  final ColorScheme cs;
  const _Content({required this.spend, required this.cs});

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.simpleCurrency(name: spend.currency);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RATED PORTFOLIO',
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            color: cs.onSurfaceVariant,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: context.s),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: spend.total),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => Text(
                fmt.format(v),
                style: TextStyle(
                  fontSize: context.titleFont * 1.4,
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                  height: 1,
                  letterSpacing: -1.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.xs),
        Text(
          'across ${spend.pricedCount} priced '
          '${spend.pricedCount == 1 ? 'wine' : 'wines'}'
          ' · avg ${fmt.format(spend.avg)}',
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: context.l),
        if (spend.mostExpensive != null)
          _Highlight(
            icon: PhosphorIconsFill.crown,
            label: 'Most expensive',
            wine: spend.mostExpensive!,
            valueFormatter: (w) => fmt.format(w.price ?? 0),
            valueDetail: null,
            cs: cs,
            delay: 100,
          ),
        if (spend.mostExpensive != null && spend.bestValue != null)
          SizedBox(height: context.s),
        if (spend.bestValue != null && spend.bestValue != spend.mostExpensive)
          _Highlight(
            icon: PhosphorIconsFill.gift,
            label: 'Best value',
            wine: spend.bestValue!,
            valueFormatter: (w) => fmt.format(w.price ?? 0),
            valueDetail: '★ ${spend.bestValue!.rating.toStringAsFixed(1)}',
            cs: cs,
            delay: 200,
          ),
      ],
    );
  }
}

class _Highlight extends StatelessWidget {
  final IconData icon;
  final String label;
  final WineEntity wine;
  final String Function(WineEntity wine) valueFormatter;
  final String? valueDetail;
  final ColorScheme cs;
  final int delay;

  const _Highlight({
    required this.icon,
    required this.label,
    required this.wine,
    required this.valueFormatter,
    required this.valueDetail,
    required this.cs,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final origin = wine.region ?? wine.country;
    return Animate(
      effects: [
        FadeEffect(
          duration: 360.ms,
          delay: Duration(milliseconds: delay),
        ),
        SlideEffect(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
          duration: 360.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeOut,
        ),
      ],
      child: Row(
        children: [
          WineThumb(
            wine: wine,
            size: context.w * 0.13,
            cornerOverlay: _IconCorner(icon: icon),
          ),
          SizedBox(width: context.s * 1.4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: context.captionFont * 0.8,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: context.xs * 0.5),
                Text(
                  wine.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
                if (origin != null) ...[
                  SizedBox(height: context.xs * 0.5),
                  Text(
                    origin,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: context.s),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                valueFormatter(wine),
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              if (valueDetail != null) ...[
                SizedBox(height: context.xs * 0.5),
                Text(
                  valueDetail!,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(
            width: context.w * 0.32,
            height: context.captionFont * 0.85,
          ),
          SizedBox(height: context.s),
          SkeletonBox(
            width: context.w * 0.45,
            height: context.titleFont * 1.4,
            radius: 4,
          ),
          SizedBox(height: context.xs),
          SkeletonBox(width: context.w * 0.55, height: context.captionFont),
          SizedBox(height: context.l),
          const _HighlightSkeleton(),
          SizedBox(height: context.s),
          const _HighlightSkeleton(),
        ],
      ),
    );
  }
}

class _IconCorner extends StatelessWidget {
  final IconData icon;
  const _IconCorner({required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.052;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cs.primary,
        shape: BoxShape.circle,
        border: Border.all(color: cs.surface, width: 1.5),
      ),
      child: Icon(icon, color: cs.onPrimary, size: size * 0.55),
    );
  }
}

class _HighlightSkeleton extends StatelessWidget {
  const _HighlightSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SkeletonBox(
          width: context.w * 0.13,
          height: context.w * 0.13,
          radius: context.w * 0.13 * 0.22,
        ),
        SizedBox(width: context.s * 1.4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(
                width: context.w * 0.28,
                height: context.captionFont * 0.8,
              ),
              SizedBox(height: context.xs * 0.5),
              SkeletonBox(width: context.w * 0.5, height: context.bodyFont),
              SizedBox(height: context.xs * 0.5),
              SkeletonBox(width: context.w * 0.3, height: context.captionFont),
            ],
          ),
        ),
        SizedBox(width: context.s),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SkeletonBox(width: context.w * 0.18, height: context.bodyFont),
            SizedBox(height: context.xs * 0.5),
            SkeletonBox(width: context.w * 0.12, height: context.captionFont),
          ],
        ),
      ],
    );
  }
}
