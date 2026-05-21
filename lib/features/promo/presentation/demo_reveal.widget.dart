import 'package:flutter/material.dart';

import '../promo.config.dart';

/// Wraps a widget in a delayed scale-pop + fade entrance — but only in demo
/// builds. In normal builds it returns the child untouched (zero cost), so
/// production screens are unaffected.
///
/// Stagger a group of these with increasing [delay] to make elements
/// highlight one after another for a flow video (e.g. rating → price →
/// region popping in sequence on a wine detail screen).
class DemoReveal extends StatelessWidget {
  const DemoReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.fromScale = 0.9,
  });

  final Widget child;
  final Duration delay;
  final double fromScale;

  @override
  Widget build(BuildContext context) {
    if (!kIsDemo) return child;
    return _DemoRevealAnim(delay: delay, fromScale: fromScale, child: child);
  }
}

class _DemoRevealAnim extends StatefulWidget {
  const _DemoRevealAnim({
    required this.child,
    required this.delay,
    required this.fromScale,
  });

  final Widget child;
  final Duration delay;
  final double fromScale;

  @override
  State<_DemoRevealAnim> createState() => _DemoRevealAnimState();
}

class _DemoRevealAnimState extends State<_DemoRevealAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 560),
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  late final Animation<double> _scale =
      Tween<double>(begin: widget.fromScale, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
      );

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
