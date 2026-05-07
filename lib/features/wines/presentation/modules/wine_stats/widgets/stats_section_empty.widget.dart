import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../common/utils/responsive.dart';

/// Compact actionable empty-state used inside a stats section when the
/// user already has wines logged but the specific section has no data
/// (no location, no region, no price). Distinct from the zero-wines
/// preview skeletons — those say "this is what you'll see", these say
/// "fill this in to unlock this section".
class StatsSectionEmpty extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final String? ctaLabel;
  final VoidCallback? onTap;

  const StatsSectionEmpty({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.ctaLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Animate(
      effects: [FadeEffect(duration: 360.ms)],
      child: Container(
        padding: EdgeInsets.all(context.w * 0.045),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.05),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.w * 0.11,
                  height: context.w * 0.11,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(context.w * 0.03),
                  ),
                  child: Icon(icon, color: cs.primary, size: context.w * 0.055),
                ),
                SizedBox(width: context.s),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: context.xs * 0.6),
                      Text(
                        body,
                        style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (ctaLabel != null && onTap != null) ...[
              SizedBox(height: context.m),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: cs.onSurface,
                    side: BorderSide(color: cs.outlineVariant, width: 0.5),
                    padding: EdgeInsets.symmetric(vertical: context.m * 0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.035),
                    ),
                  ),
                  child: Text(
                    ctaLabel!,
                    style: TextStyle(
                      fontSize: context.captionFont * 1.05,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
