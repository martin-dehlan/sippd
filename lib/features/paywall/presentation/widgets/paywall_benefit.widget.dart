import 'package:flutter/material.dart';

import '../../../../common/utils/responsive.dart';

/// Richer benefit row — icon-tile on the left, bold title + muted subtitle
/// on the right. Replaces the plain check-circle list so each benefit
/// reads as something specific instead of an interchangeable bullet.
class PaywallBenefitRow extends StatelessWidget {
  const PaywallBenefitRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tile = context.w * 0.1;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: tile,
            height: tile,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: cs.primary, size: tile * 0.5),
          ),
          SizedBox(width: context.w * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                    height: 1.2,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: context.xs * 0.5),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Record describing one paywall benefit so callers can pass a list.
typedef PaywallBenefit = ({IconData icon, String title, String? subtitle});
