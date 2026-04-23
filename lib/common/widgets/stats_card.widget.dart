import 'package:flutter/material.dart';
import '../utils/responsive.dart';

typedef StatEntry = ({String label, String value});

class StatsCard extends StatelessWidget {
  final List<StatEntry> stats;
  const StatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.l,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (int i = 0; i < stats.length; i++) ...[
              Expanded(child: _StatCell(entry: stats[i])),
              if (i < stats.length - 1) const _Divider(),
            ],
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: EdgeInsets.symmetric(vertical: context.xs),
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
    );
  }
}

class _StatCell extends StatelessWidget {
  final StatEntry entry;
  const _StatCell({required this.entry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          entry.value,
          style: TextStyle(
            fontSize: context.headingFont * 1.3,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1.0,
            color: cs.onSurface,
          ),
        ),
        SizedBox(height: context.xs),
        Text(
          entry.label.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.captionFont * 0.8,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
