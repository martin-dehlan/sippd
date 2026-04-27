import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';

class OnboardingOptionCard extends StatelessWidget {
  final String label;
  final String? subtitle;
  final String? emoji;
  final IconData? icon;
  final Color? iconColor;
  final bool selected;
  final VoidCallback onTap;

  const OnboardingOptionCard({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.emoji,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: context.s),
      child: Material(
        color: selected
            ? cs.primary.withValues(alpha: 0.12)
            : cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(context.w * 0.04),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.w * 0.045,
              vertical: context.m,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.w * 0.04),
              border: Border.all(
                color: selected ? cs.primary : cs.outlineVariant,
                width: selected ? 1.5 : 0.5,
              ),
            ),
            child: Row(
              children: [
                if (emoji != null)
                  Text(emoji!, style: TextStyle(fontSize: context.w * 0.07)),
                if (icon != null)
                  Icon(
                    icon,
                    size: context.w * 0.06,
                    color:
                        iconColor ??
                        (selected ? cs.primary : cs.onSurfaceVariant),
                  ),
                SizedBox(width: context.w * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: context.bodyFont * 1.02,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: context.xs),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: selected ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: Icon(
                    PhosphorIconsRegular.checkCircle,
                    color: cs.primary,
                    size: context.w * 0.06,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
