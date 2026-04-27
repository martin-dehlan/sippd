import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../common/utils/responsive.dart';

class PaywallPlanCard extends StatelessWidget {
  const PaywallPlanCard({
    super.key,
    required this.package,
    required this.selected,
    required this.onTap,
    this.badge,
    this.savingsLabel,
  });

  final Package package;
  final bool selected;
  final VoidCallback onTap;

  /// Optional badge shown in the top-right (e.g. "BEST VALUE", "ONE-TIME").
  final String? badge;

  /// Optional savings line shown under the title (e.g. "Save 33% vs monthly").
  final String? savingsLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final product = package.storeProduct;
    final title = _titleForPackage(package);
    final hasSavings = savingsLabel != null;
    final subtitle = savingsLabel ?? _defaultSubtitle(package);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(
              horizontal: context.w * 0.045,
              vertical: context.m * 1.05,
            ),
            decoration: BoxDecoration(
              color: selected ? cs.primaryContainer : cs.surfaceContainer,
              borderRadius: BorderRadius.circular(context.w * 0.04),
              border: Border.all(
                color: selected ? cs.primary : cs.outlineVariant,
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                _Radio(selected: selected),
                SizedBox(width: context.w * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: context.bodyFont * 1.05,
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface,
                          letterSpacing: -0.2,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: context.xs * 0.5),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: hasSavings ? cs.primary : cs.onSurfaceVariant,
                            fontWeight: hasSavings
                                ? FontWeight.w800
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  product.priceString,
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.05,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              top: -context.xs,
              right: context.w * 0.04,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.025,
                  vertical: context.xs * 0.6,
                ),
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: BorderRadius.circular(context.w * 0.04),
                ),
                child: Text(
                  badge!,
                  style: TextStyle(
                    color: cs.onPrimary,
                    fontSize: context.captionFont * 0.8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _titleForPackage(Package package) {
    switch (package.packageType) {
      case PackageType.monthly:
        return 'Monthly';
      case PackageType.annual:
        return 'Annual';
      case PackageType.lifetime:
        return 'Lifetime';
      default:
        return package.storeProduct.title;
    }
  }

  String? _defaultSubtitle(Package package) {
    switch (package.packageType) {
      case PackageType.annual:
        return 'Most popular';
      case PackageType.lifetime:
        return 'Limited launch offer · pay once';
      case PackageType.monthly:
        return 'Cancel anytime';
      default:
        return null;
    }
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = context.w * 0.05;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: s,
      height: s,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: selected ? cs.primary : cs.outline, width: 2),
        color: selected ? cs.primary : Colors.transparent,
      ),
      child: selected
          ? Icon(Icons.check, size: s * 0.7, color: cs.onPrimary)
          : null,
    );
  }
}
