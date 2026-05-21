import 'package:flutter/material.dart';

/// Entrance / emphasis styles for a showcased widget, cycled from the
/// control bar. Tuned for screen capture — punchy enough to "pop" on
/// camera without looking gimmicky.
enum PromoMotion {
  /// Subtle slide-up + fade. Calm, editorial.
  slideUp('Slide up'),

  /// Scale-in with an overshoot so the widget springs out.
  pop('Pop'),

  /// Pop entrance, then a gentle continuous pulse so it stays highlighted
  /// for the whole clip.
  popPulse('Pop + pulse');

  const PromoMotion(this.label);
  final String label;

  PromoMotion get next =>
      PromoMotion.values[(index + 1) % PromoMotion.values.length];
}

/// Plays the chosen [motion] once on mount; replay it by giving this widget
/// a fresh [Key] (the showcase bumps a tick counter), which remounts and
/// re-runs the animation from zero.
class PromoEntrance extends StatefulWidget {
  const PromoEntrance({
    super.key,
    required this.child,
    this.motion = PromoMotion.pop,
    this.duration = const Duration(milliseconds: 700),
  });

  final Widget child;
  final PromoMotion motion;
  final Duration duration;

  @override
  State<PromoEntrance> createState() => _PromoEntranceState();
}

class _PromoEntranceState extends State<PromoEntrance>
    with TickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..forward();

  /// Only created for [PromoMotion.popPulse].
  AnimationController? _pulse;

  late final Animation<double> _fade = CurvedAnimation(
    parent: _intro,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.12),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic));

  late final Animation<double> _popScale = Tween<double>(
    begin: 0.82,
    end: 1,
  ).animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutBack));

  @override
  void initState() {
    super.initState();
    if (widget.motion == PromoMotion.popPulse) {
      _pulse = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1600),
      )..repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _intro.dispose();
    _pulse?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final faded = FadeTransition(opacity: _fade, child: widget.child);

    switch (widget.motion) {
      case PromoMotion.slideUp:
        return SlideTransition(position: _slide, child: faded);
      case PromoMotion.pop:
        return ScaleTransition(scale: _popScale, child: faded);
      case PromoMotion.popPulse:
        final pulse = _pulse!;
        return ScaleTransition(
          scale: _popScale,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1,
              end: 1.04,
            ).animate(CurvedAnimation(parent: pulse, curve: Curves.easeInOut)),
            child: faded,
          ),
        );
    }
  }
}
