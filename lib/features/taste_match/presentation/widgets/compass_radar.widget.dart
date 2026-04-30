import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../common/utils/responsive.dart';

/// Renders a 3-to-6-axis radar chart for the taste compass. Each axis
/// is one of the user's top buckets (region or country); the radial
/// value is the bucket count normalised to the largest bucket. Sub-
/// label sits under the bucket name and shows the average rating.
class CompassRadar extends StatelessWidget {
  const CompassRadar({super.key, required this.axes});

  final List<RadarAxisData> axes;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (axes.length < 3) {
      // Radar geometry needs ≥3 axes — caller should branch on this and
      // render a list instead.
      return const SizedBox.shrink();
    }

    final maxValue = axes
        .map((a) => a.value)
        .fold<double>(0, (m, v) => v > m ? v : m);
    if (maxValue <= 0) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w * 0.04),
        child: CustomPaint(
          painter: _RadarPainter(
            axes: axes,
            maxValue: maxValue,
            fillColor: cs.primary.withValues(alpha: 0.18),
            strokeColor: cs.primary,
            vertexColor: cs.primary,
            gridColor: cs.outlineVariant,
            labelColor: cs.onSurface,
            sublabelColor: cs.onSurfaceVariant,
            labelFontSize: context.captionFont * 0.95,
            sublabelFontSize: context.captionFont * 0.8,
          ),
        ),
      ),
    );
  }
}

class RadarAxisData {
  const RadarAxisData({
    required this.label,
    this.sublabel,
    required this.value,
  });

  final String label;
  final String? sublabel;
  final double value;
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({
    required this.axes,
    required this.maxValue,
    required this.fillColor,
    required this.strokeColor,
    required this.vertexColor,
    required this.gridColor,
    required this.labelColor,
    required this.sublabelColor,
    required this.labelFontSize,
    required this.sublabelFontSize,
  });

  final List<RadarAxisData> axes;
  final double maxValue;
  final Color fillColor;
  final Color strokeColor;
  final Color vertexColor;
  final Color gridColor;
  final Color labelColor;
  final Color sublabelColor;
  final double labelFontSize;
  final double sublabelFontSize;

  static const _gridRings = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2;
    // Reserve outer band for labels.
    final radius = maxRadius * 0.65;
    final n = axes.length;
    final twoPi = math.pi * 2;
    final startAngle = -math.pi / 2; // first axis points up

    final gridPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    // Concentric rings — polygons, not circles, so they hug the radar.
    for (var ring = 1; ring <= _gridRings; ring++) {
      final r = radius * ring / _gridRings;
      final path = Path();
      for (var i = 0; i <= n; i++) {
        final angle = startAngle + (i % n) * twoPi / n;
        final p = center + Offset(r * math.cos(angle), r * math.sin(angle));
        if (i == 0) {
          path.moveTo(p.dx, p.dy);
        } else {
          path.lineTo(p.dx, p.dy);
        }
      }
      canvas.drawPath(path, gridPaint);
    }

    // Axis lines from centre outward.
    for (var i = 0; i < n; i++) {
      final angle = startAngle + i * twoPi / n;
      final end = center +
          Offset(radius * math.cos(angle), radius * math.sin(angle));
      canvas.drawLine(center, end, gridPaint);
    }

    // Data polygon — filled and stroked.
    final dataPath = Path();
    final vertices = <Offset>[];
    for (var i = 0; i < n; i++) {
      final angle = startAngle + i * twoPi / n;
      final v = (axes[i].value / maxValue).clamp(0.0, 1.0);
      // Floor at small visible value so single-bucket axes still show.
      final r = radius * (v == 0 ? 0 : math.max(v, 0.08));
      final p = center + Offset(r * math.cos(angle), r * math.sin(angle));
      vertices.add(p);
      if (i == 0) {
        dataPath.moveTo(p.dx, p.dy);
      } else {
        dataPath.lineTo(p.dx, p.dy);
      }
    }
    dataPath.close();

    canvas.drawPath(
      dataPath,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      dataPath,
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Vertex dots.
    final vertexPaint = Paint()
      ..color = vertexColor
      ..style = PaintingStyle.fill;
    for (final v in vertices) {
      canvas.drawCircle(v, 3.0, vertexPaint);
    }

    // Labels just outside each vertex.
    for (var i = 0; i < n; i++) {
      final angle = startAngle + i * twoPi / n;
      final cosA = math.cos(angle);
      final sinA = math.sin(angle);
      final labelRadius = radius + 14;
      final labelCenter =
          center + Offset(labelRadius * cosA, labelRadius * sinA);

      final label = _truncate(axes[i].label, 14);
      final main = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            fontSize: labelFontSize,
            color: labelColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: size.width * 0.32);

      final sublabelText = axes[i].sublabel;
      final sub = sublabelText == null
          ? null
          : (TextPainter(
              text: TextSpan(
                text: sublabelText,
                style: TextStyle(
                  fontSize: sublabelFontSize,
                  color: sublabelColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              textDirection: TextDirection.ltr,
              maxLines: 1,
            )..layout(maxWidth: size.width * 0.32));

      // Anchor labels on the axis side: top, sides, bottom — using the
      // angle to push the label outward from the vertex.
      final dx = -main.width / 2 + main.width * 0.5 * cosA;
      final dy = -main.height / 2 + main.height * 0.5 * sinA;
      final mainOffset =
          labelCenter.translate(dx, dy - (sub == null ? 0 : sub.height * 0.6));
      main.paint(canvas, mainOffset);
      if (sub != null) {
        final subDx = -sub.width / 2 + sub.width * 0.5 * cosA;
        final subOffset = labelCenter.translate(
          subDx,
          dy + main.height * 0.55 - sub.height * 0.5,
        );
        sub.paint(canvas, subOffset);
      }
    }
  }

  String _truncate(String s, int max) =>
      s.length <= max ? s : '${s.substring(0, max - 1)}…';

  @override
  bool shouldRepaint(covariant _RadarPainter old) =>
      old.axes != axes ||
      old.maxValue != maxValue ||
      old.fillColor != fillColor ||
      old.strokeColor != strokeColor ||
      old.gridColor != gridColor;
}
