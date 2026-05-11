import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';

/// Actionable empty-state shown in place of [StatsHero] when the user
/// has not rated any wine yet. One clear primary action and a short
/// promise of what the screen will become — sections below render as
/// faint skeleton previews so the user gets a feel for the layout.
class StatsEmptyHero extends StatelessWidget {
  const StatsEmptyHero({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Animate(
      effects: [
        FadeEffect(duration: 420.ms),
        SlideEffect(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
          duration: 420.ms,
          curve: Curves.easeOutCubic,
        ),
      ],
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.w * 0.05,
          context.l,
          context.w * 0.05,
          context.l,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.05),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.025,
                vertical: context.xs * 0.8,
              ),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(context.w * 0.02),
              ),
              child: Text(
                l10n.winesStatsEmptyEyebrow,
                style: TextStyle(
                  fontSize: context.captionFont * 0.78,
                  fontWeight: FontWeight.w800,
                  color: cs.primary,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            SizedBox(height: context.m),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.w * 0.14,
                  height: context.w * 0.14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(context.w * 0.035),
                  ),
                  child: Icon(
                    PhosphorIconsFill.wine,
                    color: cs.primary,
                    size: context.w * 0.075,
                  ),
                ),
                SizedBox(width: context.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.winesStatsEmptyTitle,
                        style: TextStyle(
                          fontSize: context.headingFont * 0.95,
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface,
                          letterSpacing: -0.4,
                          height: 1.15,
                        ),
                      ),
                      SizedBox(height: context.xs),
                      Text(
                        l10n.winesStatsEmptyBody,
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
            SizedBox(height: context.l),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => context.push(AppRoutes.wineAdd),
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: context.m * 0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w * 0.035),
                  ),
                ),
                icon: const Icon(PhosphorIconsRegular.plus),
                label: Text(
                  l10n.winesStatsEmptyCta,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
