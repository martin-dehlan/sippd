import 'package:flutter/material.dart';

import '../promo.config.dart';

/// Renders a number that counts up from 0 to [value] on first build — but
/// only in demo builds, so a value reads as "being set" in a flow video.
/// In production it's a plain static [Text], identical to the final frame.
class DemoCountUp extends StatelessWidget {
  const DemoCountUp({
    super.key,
    required this.value,
    required this.format,
    this.style,
    this.duration = const Duration(milliseconds: 1100),
  });

  final double value;
  final String Function(double) format;
  final TextStyle? style;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    if (!kIsDemo) return Text(format(value), style: style);
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Text(format(v), style: style),
    );
  }
}
