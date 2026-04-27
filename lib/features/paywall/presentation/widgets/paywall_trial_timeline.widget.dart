import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';

class PaywallTrialTimeline extends StatelessWidget {
  const PaywallTrialTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final rows = [
      (
        icon: PhosphorIconsRegular.sparkle,
        title: 'Today',
        subtitle: 'Full Pro access unlocked.',
      ),
      (
        icon: PhosphorIconsRegular.bell,
        title: 'Day 5',
        subtitle: 'We\'ll remind you before billing.',
      ),
      (
        icon: PhosphorIconsRegular.creditCard,
        title: 'Day 7',
        subtitle: 'Trial ends. Cancel anytime.',
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.m,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) SizedBox(height: context.s),
            Row(
              children: [
                Icon(
                  rows[i].icon,
                  color: cs.primary,
                  size: context.w * 0.055,
                ),
                SizedBox(width: context.w * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rows[i].title,
                        style: TextStyle(
                          fontSize: context.bodyFont * 0.95,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      Text(
                        rows[i].subtitle,
                        style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
