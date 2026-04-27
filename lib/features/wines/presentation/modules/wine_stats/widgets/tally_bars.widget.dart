import 'package:flutter/material.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';

/// Lightweight horizontal bar list — no chart dep needed. Each row is
/// a label + count, with the bar width proportional to the largest
/// count in [items]. Caller controls how many entries to show.
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
          if (i > 0) SizedBox(height: context.s),
          _TallyRow(item: visible[i], maxCount: maxCount),
        ],
      ],
    );
  }
}

class _TallyRow extends StatelessWidget {
  final Tally item;
  final int maxCount;

  const _TallyRow({required this.item, required this.maxCount});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ratio = maxCount == 0 ? 0.0 : item.count / maxCount;
    return Column(
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
                  fontSize: context.captionFont * 1.1,
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: context.s),
            Text(
              item.count.toString(),
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
        SizedBox(height: context.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.w * 0.01),
          child: Stack(
            children: [
              Container(
                height: context.w * 0.015,
                color: cs.outlineVariant.withValues(alpha: 0.4),
              ),
              FractionallySizedBox(
                widthFactor: ratio.clamp(0.05, 1.0),
                child: Container(
                  height: context.w * 0.015,
                  color: cs.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
