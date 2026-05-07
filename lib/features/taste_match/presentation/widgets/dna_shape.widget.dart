import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/entities/user_style_dna.entity.dart';

/// Renders the user's six-axis Style DNA as a smoothed organic blob.
/// Each axis becomes a vertex offset from the centre; the path is
/// closed and smoothed with catmull-rom so the silhouette feels grown
/// rather than charted. The shape is data-driven and ownable — no two
/// DNA vectors produce the same outline.
class DnaShape extends StatelessWidget {
  const DnaShape({
    super.key,
    required this.dna,
    required this.color,
    this.size = 96,
    this.strokeWidth = 1.4,
    this.vertexRadius = 1.6,
  });

  final UserStyleDna? dna;
  final Color color;
  final double size;

  /// Outline thickness in logical pixels. Small in-app surfaces look
  /// right at the default; large export surfaces (the 1080×1920 share
  /// card) bump this so the silhouette doesn't read as a hairline.
  final double strokeWidth;

  /// Radius of the vertex dot at each axis tick. Same scale-up logic
  /// as [strokeWidth] — defaults match the in-app density.
  final double vertexRadius;

  static const _axes = [
    'body',
    'tannin',
    'acidity',
    'sweetness',
    'oak',
    'intensity',
  ];

  @override
  Widget build(BuildContext context) {
    final values = _axes
        .map((k) => (dna?.values[k] ?? 0.5).clamp(0.0, 1.0))
        .toList(growable: false);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DnaShapePainter(
          values: values,
          color: color,
          strokeWidth: strokeWidth,
          vertexRadius: vertexRadius,
        ),
      ),
    );
  }
}

class _DnaShapePainter extends CustomPainter {
  _DnaShapePainter({
    required this.values,
    required this.color,
    required this.strokeWidth,
    required this.vertexRadius,
  });

  final List<double> values;
  final Color color;
  final double strokeWidth;
  final double vertexRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy) * 0.86;

    final points = <Offset>[];
    for (var i = 0; i < values.length; i++) {
      final angle = (math.pi * 2 / values.length) * i - math.pi / 2;
      final radius = r * (0.42 + values[i] * 0.58);
      points.add(
        Offset(cx + math.cos(angle) * radius, cy + math.sin(angle) * radius),
      );
    }

    final path = _catmullRomClosed(points);

    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.12)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeJoin = StrokeJoin.round,
    );

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    for (final p in points) {
      canvas.drawCircle(p, vertexRadius, dotPaint);
    }
  }

  Path _catmullRomClosed(List<Offset> pts) {
    final path = Path();
    final n = pts.length;
    if (n < 2) return path;

    Offset at(int i) => pts[(i % n + n) % n];

    path.moveTo(pts[0].dx, pts[0].dy);
    for (var i = 0; i < n; i++) {
      final p0 = at(i - 1);
      final p1 = at(i);
      final p2 = at(i + 1);
      final p3 = at(i + 2);
      final c1 = Offset(
        p1.dx + (p2.dx - p0.dx) / 6,
        p1.dy + (p2.dy - p0.dy) / 6,
      );
      final c2 = Offset(
        p2.dx - (p3.dx - p1.dx) / 6,
        p2.dy - (p3.dy - p1.dy) / 6,
      );
      path.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p2.dx, p2.dy);
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _DnaShapePainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.vertexRadius != vertexRadius ||
      !_listsEqual(old.values, values);

  bool _listsEqual(List<double> a, List<double> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
