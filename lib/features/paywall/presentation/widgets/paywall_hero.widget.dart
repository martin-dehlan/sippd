import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';

/// Animated brand crest used as the standalone paywall hero. Gentle pulse
/// keeps the eye on it without crossing into AI-slop territory (no
/// gradients, no shadows, just primary-tinted color and a thin ring).
class PaywallHero extends StatelessWidget {
  const PaywallHero({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final s = size ?? context.w * 0.32;

    return SizedBox(
          width: s,
          height: s,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Soft outer ring — radius slightly bigger than the inner disc.
              Container(
                width: s,
                height: s,
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
              // Inner disc.
              Container(
                width: s * 0.78,
                height: s * 0.78,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: cs.primary, width: 1.5),
                ),
                child: Icon(
                  PhosphorIconsFill.sparkle,
                  color: cs.primary,
                  size: s * 0.4,
                ),
              ),
              // PRO pill bottom-right.
              Positioned(
                right: 0,
                bottom: s * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: s * 0.07,
                    vertical: s * 0.025,
                  ),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(s * 0.1),
                  ),
                  child: Text(
                    'PRO',
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontSize: s * 0.11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 360.ms)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1.0, 1.0),
          duration: 420.ms,
          curve: Curves.easeOutBack,
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.04, 1.04),
          duration: 1800.ms,
          curve: Curves.easeInOut,
        );
  }
}
