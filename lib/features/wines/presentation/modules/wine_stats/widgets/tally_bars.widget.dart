import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';

/// Polished horizontal bar list — labels + counts, bars animate from 0
/// to their proportional width on first build. No chart dep needed.
class TallyBars extends StatelessWidget {
  final List<Tally> items;
  final int maxItems;

  const TallyBars({
    super.key,
    required this.items,
    this.maxItems = 5,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.s),
        child: Text(
          'No data yet.',
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
          ),
        ),
      );
    }
    final visible = items.take(maxItems).toList();
    final maxCount = visible.first.count;
    return Column(
      children: [
        for (int i = 0; i < visible.length; i++) ...[
          if (i > 0) SizedBox(height: context.m),
          _TallyRow(
            item: visible[i],
            maxCount: maxCount,
            delay: i * 70,
          ),
        ],
      ],
    );
  }
}

class _TallyRow extends StatelessWidget {
  final Tally item;
  final int maxCount;
  final int delay;

  const _TallyRow({
    required this.item,
    required this.maxCount,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ratio = maxCount == 0 ? 0.0 : item.count / maxCount;
    return Animate(
      effects: [
        FadeEffect(
          duration: 360.ms,
          delay: Duration(milliseconds: delay),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.captionFont * 1.15,
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
              SizedBox(width: context.s),
              Text(
                item.count.toString(),
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: context.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(context.w * 0.012),
            child: Stack(
              children: [
                Container(
                  height: context.w * 0.022,
                  color: cs.outlineVariant.withValues(alpha: 0.35),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: ratio.clamp(0.05, 1.0)),
                  duration: Duration(milliseconds: 800 + delay),
                  curve: Curves.easeOutCubic,
                  builder: (_, v, _) => FractionallySizedBox(
                    widthFactor: v,
                    child: Container(
                      height: context.w * 0.022,
                      color: cs.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
