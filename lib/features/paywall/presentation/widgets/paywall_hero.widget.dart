import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';

/// Paywall hero — narrates the upgrade itself, not just brand identity.
///
/// Animation: an empty wine glass fades in, fills with wine (outline →
/// solid), then three sparkles "crown" the glass on a staggered cadence.
/// The whole sequence reads as "your taste, but elevated" instead of a
/// generic logo flash. No gradients, no shadows, just primary tints and
/// motion.
class PaywallHero extends StatelessWidget {
  const PaywallHero({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = size ?? context.w * 0.3;
    final iconSize = s * 0.46;

    return SizedBox(
      width: s * 1.5,
      height: s * 1.3,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Outermost halo — barely-there primary tint.
          Container(
                width: s * 1.15,
                height: s * 1.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primary.withValues(alpha: 0.08),
                ),
              )
              .animate()
              .fadeIn(duration: 320.ms)
              .scale(
                begin: const Offset(0.7, 0.7),
                end: const Offset(1, 1),
                duration: 360.ms,
                curve: Curves.easeOutCubic,
              ),

          // Mid ring — primaryContainer washed.
          Container(
                width: s * 0.94,
                height: s * 0.94,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primaryContainer.withValues(alpha: 0.55),
                ),
              )
              .animate()
              .fadeIn(delay: 80.ms, duration: 320.ms)
              .scale(
                begin: const Offset(0.7, 0.7),
                end: const Offset(1, 1),
                delay: 80.ms,
                duration: 360.ms,
                curve: Curves.easeOutCubic,
              ),

          // Inner disc — solid primaryContainer with thin primary edge.
          Container(
                width: s * 0.74,
                height: s * 0.74,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primaryContainer,
                  border: Border.all(
                    color: cs.primary.withValues(alpha: 0.55),
                    width: 1,
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 160.ms, duration: 320.ms)
              .scale(
                begin: const Offset(0.75, 0.75),
                end: const Offset(1, 1),
                delay: 160.ms,
                duration: 360.ms,
                curve: Curves.easeOutCubic,
              ),

          // Empty wine glass — outline only, fades in first as the
          // "before" state.
          Icon(
            PhosphorIconsRegular.wine,
            color: cs.onPrimaryContainer.withValues(alpha: 0.45),
            size: iconSize,
          ).animate().fadeIn(delay: 320.ms, duration: 320.ms),

          // Filled wine glass — fades in on top of the outline so the
          // glass appears to fill itself with wine. This is the
          // upgrade beat.
          Icon(
                PhosphorIconsFill.wine,
                color: cs.onPrimaryContainer,
                size: iconSize,
              )
              .animate()
              .fadeIn(delay: 640.ms, duration: 460.ms)
              .scale(
                begin: const Offset(0.92, 0.92),
                end: const Offset(1, 1),
                delay: 640.ms,
                duration: 460.ms,
                curve: Curves.easeOutBack,
              ),

          // Sparkle 1 — large, top-right, lands first after the fill.
          Positioned(
            top: s * 0.04,
            right: s * 0.16,
            child:
                Icon(
                      PhosphorIconsFill.sparkle,
                      color: cs.primary,
                      size: s * 0.18,
                    )
                    .animate()
                    .fadeIn(delay: 1100.ms, duration: 280.ms)
                    .scale(
                      begin: const Offset(0, 0),
                      end: const Offset(1, 1),
                      delay: 1100.ms,
                      duration: 380.ms,
                      curve: Curves.easeOutBack,
                    ),
          ),

          // Sparkle 2 — medium, upper-left.
          Positioned(
            top: s * 0.16,
            left: s * 0.13,
            child:
                Icon(
                      PhosphorIconsFill.sparkle,
                      color: cs.primary,
                      size: s * 0.12,
                    )
                    .animate()
                    .fadeIn(delay: 1260.ms, duration: 260.ms)
                    .scale(
                      begin: const Offset(0, 0),
                      end: const Offset(1, 1),
                      delay: 1260.ms,
                      duration: 360.ms,
                      curve: Curves.easeOutBack,
                    ),
          ),

          // Sparkle 3 — small, bottom-right.
          Positioned(
            bottom: s * 0.18,
            right: s * 0.06,
            child:
                Icon(
                      PhosphorIconsFill.sparkle,
                      color: cs.primary,
                      size: s * 0.09,
                    )
                    .animate()
                    .fadeIn(delay: 1400.ms, duration: 260.ms)
                    .scale(
                      begin: const Offset(0, 0),
                      end: const Offset(1, 1),
                      delay: 1400.ms,
                      duration: 360.ms,
                      curve: Curves.easeOutBack,
                    ),
          ),
        ],
      ),
    );
  }
}
