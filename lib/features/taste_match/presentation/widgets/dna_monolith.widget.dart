import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/entities/user_style_dna.entity.dart';

/// Minimalist replacement for [DnaShape]. Renders the user's six-axis
/// Style DNA as a sharp geometric monolith — straight-line polygon
/// connecting six vertices whose distance from the centre is driven by
/// the trait values. No grid lines, no axis labels, no vertex dots, no
/// glow. Stroke is thin and matte (40% alpha); fill is a barely-there
/// 5% wash. Spring-physics transition when the data changes so the
/// silhouette snaps into the new form with a dampened feel.
///
/// Drop-in replacement: same constructor as [DnaShape], so swapping
/// the import + class name on a callsite migrates without other code
/// changes. Reverting is a one-line swap (or a single git revert).
class DnaMonolith extends StatefulWidget {
  const DnaMonolith({
    super.key,
    required this.dna,
    required this.color,
    this.size = 96,
  });

  final UserStyleDna? dna;

  /// Accent colour. Used at low alpha — the monolith is matte, not
  /// branded-loud, but the accent still carries the archetype identity.
  final Color color;
  final double size;

  static const _axes = [
    'body',
    'tannin',
    'acidity',
    'sweetness',
    'oak',
    'intensity',
  ];

  @override
  State<DnaMonolith> createState() => _DnaMonolithState();
}

class _DnaMonolithState extends State<DnaMonolith>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<double> _from;
  late List<double> _to;

  @override
  void initState() {
    super.initState();
    _to = _extract(widget.dna);
    _from = List<double>.from(_to);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 720),
    )..value = 1.0;
  }

  @override
  void didUpdateWidget(covariant DnaMonolith old) {
    super.didUpdateWidget(old);
    final next = _extract(widget.dna);
    if (!_equal(next, _to)) {
      // Capture the currently-rendered values as the new origin so a
      // mid-flight rebuild doesn't snap visually.
      _from = _interpolate(_from, _to, _controller.value);
      _to = next;
      _controller
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static List<double> _extract(UserStyleDna? dna) =>
      DnaMonolith._axes
          .map((k) => (dna?.values[k] ?? 0.5).clamp(0.0, 1.0))
          .toList(growable: false);

  static bool _equal(List<double> a, List<double> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static List<double> _interpolate(List<double> a, List<double> b, double t) {
    final out = List<double>.filled(a.length, 0);
    for (var i = 0; i < a.length; i++) {
      out[i] = a[i] + (b[i] - a[i]) * t;
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, _) {
          final eased = Curves.easeOutBack.transform(_controller.value);
          final values = _interpolate(_from, _to, eased);
          return CustomPaint(
            painter: _MonolithPainter(values: values, color: widget.color),
          );
        },
      ),
    );
  }
}

class _MonolithPainter extends CustomPainter {
  _MonolithPainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    // Slightly larger inner-room than the smoothed blob so low values
    // don't collapse the polygon into an unreadable star.
    final maxR = math.min(cx, cy) * 0.92;
    final minRatio = 0.32;
    final span = 1 - minRatio;

    final n = values.length;
    final points = <Offset>[];
    for (var i = 0; i < n; i++) {
      final angle = (math.pi * 2 / n) * i - math.pi / 2;
      final radius = maxR * (minRatio + values[i] * span);
      points.add(Offset(cx + math.cos(angle) * radius, cy + math.sin(angle) * radius));
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    // Matte fill — barely-there wash so the silhouette doesn't read as
    // a transparent ring on light surfaces. 5% alpha matches the brief.
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.05)
        ..style = PaintingStyle.fill,
    );

    // Thin elegant stroke — 1px effective width with 40% alpha lets the
    // shape feel architectural rather than diagrammatic. Mitered joins
    // keep the vertices sharp (the "monolith" feel from the brief).
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..strokeJoin = StrokeJoin.miter
        ..strokeMiterLimit = 4
        ..isAntiAlias = true,
    );
  }

  @override
  bool shouldRepaint(covariant _MonolithPainter old) {
    if (old.color != color) return true;
    if (old.values.length != values.length) return true;
    for (var i = 0; i < values.length; i++) {
      if (old.values[i] != values[i]) return true;
    }
    return false;
  }
}
