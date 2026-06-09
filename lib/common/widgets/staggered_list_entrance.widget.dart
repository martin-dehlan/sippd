import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A subtle one-shot entrance for list/card items: a gentle fade plus a small
/// upward slide, staggered by [index] so items cascade in.
///
/// Gated by [enabled] — when false the child renders verbatim with no
/// animation and no layout shift, so callers can wire this straight to a
/// motion preference (`ref.motionOn(MotionFeature.listEntrances, context)`).
///
/// The per-item delay is capped at [maxStaggered] items so long lists never
/// feel slow; everything past the cap animates with the same final delay.
/// `flutter_animate`'s [Animate] plays once on build. With a `ListView.builder`
/// the entrance naturally replays as rows scroll into view, which reads as a
/// pleasant on-demand cascade rather than a constant loop — the effect is kept
/// short and small so that re-trigger stays unobtrusive.
class StaggeredListEntrance extends StatelessWidget {
  const StaggeredListEntrance({
    super.key,
    required this.index,
    required this.child,
    this.enabled = true,
    this.maxStaggered = 8,
  });

  final int index;
  final Widget child;
  final bool enabled;

  /// Only the first [maxStaggered] items get an increasing delay; later items
  /// reuse the final delay so the cascade can't drag on.
  final int maxStaggered;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    final steps = index < maxStaggered ? index : maxStaggered;
    final delay = Duration(milliseconds: 55 * steps);

    return Animate(
      effects: [
        FadeEffect(duration: 320.ms, delay: delay, curve: Curves.easeOut),
        // Offset is a fraction of the item's own height — 0.12 lands around a
        // ~10-15px upward slide for a typical card row, kept deliberately small.
        SlideEffect(
          begin: const Offset(0, 0.12),
          end: Offset.zero,
          duration: 320.ms,
          delay: delay,
          curve: Curves.easeOutCubic,
        ),
      ],
      child: child,
    );
  }
}
