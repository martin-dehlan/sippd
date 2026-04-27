import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';
import '../../../../domain/entities/wine.entity.dart';

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
          ? _Empty(cs: cs)
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
          'TOTAL SPEND',
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
            valueDetail:
                '★ ${spend.bestValue!.rating.toStringAsFixed(1)}',
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
          Container(
            width: context.w * 0.085,
            height: context.w * 0.085,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(context.w * 0.025),
            ),
            child: Icon(
              icon,
              color: cs.primary,
              size: context.w * 0.04,
            ),
          ),
          SizedBox(width: context.s),
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
  final ColorScheme cs;
  const _Empty({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No prices yet',
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            'Add a price when you rate a wine to see your spend and best-value finds.',
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
