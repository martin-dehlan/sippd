import 'package:flutter/material.dart';

import '../promo.config.dart';
import 'demo_spotlight.widget.dart';

/// A number that animates up to [value] so it reads as "being set" in a flow
/// video. Production (and non-demo) shows a plain static [Text].
///
/// If [beat] is given, the count-up fires when that feature beat becomes
/// active (i.e. when the value is being spotlighted) — showing 0 until then,
/// so the change is visible *during* the highlight. With no [beat] it counts
/// up once on first build.
class DemoCountUp extends StatefulWidget {
  const DemoCountUp({
    super.key,
    required this.value,
    required this.format,
    this.style,
    this.beat,
    this.duration = const Duration(milliseconds: 1100),
  });

  final double value;
  final String Function(double) format;
  final TextStyle? style;
  final int? beat;
  final Duration duration;

  @override
  State<DemoCountUp> createState() => _DemoCountUpState();
}

class _DemoCountUpState extends State<DemoCountUp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  bool _started = false;

  @override
  void initState() {
    super.initState();
    if (widget.beat == null) {
      _started = true;
      _controller.forward();
    } else {
      demoDetailBeat.addListener(_onBeat);
    }
  }

  void _onBeat() {
    if (!_started && demoDetailBeat.value == widget.beat) {
      _started = true;
      _controller.forward();
    }
  }

  @override
  void dispose() {
    demoDetailBeat.removeListener(_onBeat);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsDemo) return Text(widget.format(widget.value), style: widget.style);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final v = _started ? widget.value * _controller.value : 0.0;
        return Text(widget.format(v), style: widget.style);
      },
    );
  }
}
