import 'package:flutter/material.dart';

/// Slide-up + fade-in entrance for a showcased widget. The animation runs
/// once on mount; replay it by giving this widget a fresh [Key] (the
/// showcase bumps a tick counter), which forces a remount and re-runs the
/// controller from zero — handy for re-shooting a clip without leaving the
/// screen.
class PromoEntrance extends StatefulWidget {
  const PromoEntrance({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
  });

  final Widget child;
  final Duration duration;

  @override
  State<PromoEntrance> createState() => _PromoEntranceState();
}

class _PromoEntranceState extends State<PromoEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..forward();

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _slide =
      Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
