import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/taste_compass.entity.dart';

/// Six-axis taste fingerprint. Fixed dimensions so the shape never
/// degenerates into a sliver and the radar always reads as a compass:
///
///   1. Red          — share of red bottles
///   2. White        — share of white bottles
///   3. Sparkling    — share of sparkling + rosé (the "fizzy / pale" axis)
///   4. Old World    — share of EU heritage countries
///   5. New World    — share of non-EU producers
///   6. Adventurous  — variety of distinct regions, capped at six
///
/// Every value is normalised to 0..1 so the polygon shape encodes the
/// user's taste lean instead of raw counts. A subtle radial gradient
/// behind the chart pulls focus to the centre; only one ring + the
/// outline polygon are drawn so the data shape is the focal point.
class CompassRadar extends StatelessWidget {
  const CompassRadar({super.key, required this.compass});

  final TasteCompassEntity compass;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fingerprint = _buildFingerprint(compass);
    if (fingerprint.allEmpty) return const SizedBox.shrink();

    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _FingerprintPainter(
          axes: fingerprint.axes,
          fillColor: cs.primary.withValues(alpha: 0.22),
          strokeColor: cs.primary,
          vertexColor: cs.primary,
          ringColor: cs.outlineVariant.withValues(alpha: 0.45),
          haloColor: cs.primary.withValues(alpha: 0.05),
          labelColor: cs.onSurface,
          mutedLabelColor: cs.onSurfaceVariant,
          labelFontSize: context.captionFont,
          mutedFontSize: context.captionFont * 0.78,
        ),
      ),
    );
  }
}

class _Axis {
  const _Axis({required this.label, required this.value, this.detail});
  final String label;
  final double value; // 0..1
  final String? detail;
}

class _Fingerprint {
  const _Fingerprint(this.axes);
  final List<_Axis> axes;
  bool get allEmpty => axes.every((a) => a.value <= 0);
}

const _oldWorldCountries = {
  'france', 'italy', 'spain', 'germany', 'portugal', 'austria',
  'greece', 'hungary', 'croatia', 'slovenia', 'georgia', 'romania',
  'bulgaria', 'switzerland', 'czechia', 'czech republic', 'slovakia',
  'moldova', 'ukraine', 'serbia', 'macedonia', 'cyprus', 'lebanon',
  'turkey', 'israel',
};
const _newWorldCountries = {
  'united states', 'usa', 'us', 'argentina', 'chile', 'australia',
  'new zealand', 'south africa', 'canada', 'brazil', 'uruguay',
  'mexico', 'china', 'japan', 'india',
};

_Fingerprint _buildFingerprint(TasteCompassEntity c) {
  final total = c.totalCount;
  if (total <= 0) {
    return const _Fingerprint([]);
  }

  int countOf(String type) => c.typeBreakdown
      .where((b) => b.label.toLowerCase() == type)
      .fold<int>(0, (sum, b) => sum + b.count);

  final red = countOf('red');
  final white = countOf('white');
  final rose = countOf('rose');
  final sparkling = countOf('sparkling');

  int countryShare(Set<String> set) => c.topCountries
      .where((b) => set.contains(b.label.toLowerCase()))
      .fold<int>(0, (sum, b) => sum + b.count);

  final oldWorld = countryShare(_oldWorldCountries);
  final newWorld = countryShare(_newWorldCountries);

  final adventurous = (c.topRegions.length / 6).clamp(0.0, 1.0);

  String pct(int n) => total == 0 ? '' : '${(n * 100 / total).round()}%';

  return _Fingerprint([
    _Axis(
      label: 'Red',
      value: red / total,
      detail: pct(red),
    ),
    _Axis(
      label: 'New world',
      value: newWorld / total,
      detail: pct(newWorld),
    ),
    _Axis(
      label: 'Adventurous',
      value: adventurous,
      detail: '${c.topRegions.length} regions',
    ),
    _Axis(
      label: 'Sparkling',
      value: (sparkling + rose) / total,
      detail: pct(sparkling + rose),
    ),
    _Axis(
      label: 'Old world',
      value: oldWorld / total,
      detail: pct(oldWorld),
    ),
    _Axis(
      label: 'White',
      value: white / total,
      detail: pct(white),
    ),
  ]);
}

class _FingerprintPainter extends CustomPainter {
  _FingerprintPainter({
    required this.axes,
    required this.fillColor,
    required this.strokeColor,
    required this.vertexColor,
    required this.ringColor,
    required this.haloColor,
    required this.labelColor,
    required this.mutedLabelColor,
    required this.labelFontSize,
    required this.mutedFontSize,
  });

  final List<_Axis> axes;
  final Color fillColor;
  final Color strokeColor;
  final Color vertexColor;
  final Color ringColor;
  final Color haloColor;
  final Color labelColor;
  final Color mutedLabelColor;
  final double labelFontSize;
  final double mutedFontSize;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Reserve outer band for labels so they don't hug the polygon.
    final radius = math.min(size.width, size.height) / 2 * 0.62;
    final n = axes.length;
    if (n < 3) return;

    final twoPi = math.pi * 2;
    final startAngle = -math.pi / 2; // first axis at top

    // Soft halo behind centre — gives the dark theme a focal warmth.
    canvas.drawCircle(
      center,
      radius * 1.08,
      Paint()
        ..shader = ui.Gradient.radial(
          center,
          radius * 1.08,
          [haloColor, haloColor.withValues(alpha: 0)],
          [0.0, 1.0],
        ),
    );

    // Single subtle outer ring + a half-radius ring as a light scale.
    final ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;
    _drawPolygon(canvas, center, radius, n, startAngle, ringPaint);
    _drawPolygon(canvas, center, radius * 0.5, n, startAngle,
        Paint()
          ..color = ringColor.withValues(alpha: ringColor.a * 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.6);

    // Data polygon.
    final vertices = <Offset>[];
    final dataPath = Path();
    for (var i = 0; i < n; i++) {
      final angle = startAngle + i * twoPi / n;
      final v = axes[i].value.clamp(0.0, 1.0);
      // Lift very small values slightly so they remain visible without
      // dominating empty axes (which still collapse to centre).
      final scale = v == 0 ? 0.0 : math.max(v, 0.06);
      final p = center +
          Offset(radius * scale * math.cos(angle),
              radius * scale * math.sin(angle));
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
        ..strokeWidth = 1.6
        ..strokeJoin = StrokeJoin.round,
    );

    // Vertex dots only for non-zero axes — keeps the chart honest.
    final vertexPaint = Paint()
      ..color = vertexColor
      ..style = PaintingStyle.fill;
    for (var i = 0; i < n; i++) {
      if (axes[i].value > 0) {
        canvas.drawCircle(vertices[i], 3, vertexPaint);
      }
    }

    // Labels — offset radially outward from the vertex along the axis.
    for (var i = 0; i < n; i++) {
      final angle = startAngle + i * twoPi / n;
      final cosA = math.cos(angle);
      final sinA = math.sin(angle);
      final anchor = center +
          Offset((radius + 16) * cosA, (radius + 16) * sinA);

      final isMuted = axes[i].value <= 0;
      final mainTp = TextPainter(
        text: TextSpan(
          text: axes[i].label,
          style: TextStyle(
            fontSize: labelFontSize,
            fontWeight: FontWeight.w700,
            color: isMuted ? mutedLabelColor : labelColor,
            letterSpacing: -0.1,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: size.width * 0.32);

      final detailText = axes[i].detail;
      final detailTp = (detailText == null || detailText.isEmpty)
          ? null
          : (TextPainter(
              text: TextSpan(
                text: detailText,
                style: TextStyle(
                  fontSize: mutedFontSize,
                  fontWeight: FontWeight.w500,
                  color: mutedLabelColor,
                ),
              ),
              textDirection: TextDirection.ltr,
              maxLines: 1,
            )..layout(maxWidth: size.width * 0.32));

      // Vertical alignment: top-axis labels sit ABOVE the anchor,
      // bottom-axis labels BELOW. Side labels sit centred vertically.
      // Horizontal: left-of-centre labels right-align toward the anchor,
      // right-of-centre labels left-align. Centre labels (top / bottom)
      // are simply centred.
      final mainBlockHeight =
          mainTp.height + (detailTp == null ? 0 : detailTp.height + 2);
      final yAnchor =
          anchor.dy - mainBlockHeight * (sinA < 0 ? 1.0 : (sinA > 0 ? 0 : 0.5));
      final mainXAnchor = _horizontalAnchor(anchor.dx, mainTp.width, cosA);
      mainTp.paint(canvas, Offset(mainXAnchor, yAnchor));
      if (detailTp != null) {
        final detailX = _horizontalAnchor(anchor.dx, detailTp.width, cosA);
        detailTp.paint(
          canvas,
          Offset(detailX, yAnchor + mainTp.height + 2),
        );
      }
    }
  }

  double _horizontalAnchor(double anchorX, double labelWidth, double cosA) {
    // cosA in (-1..1). Below -0.3 → label sits to the LEFT of anchor
    // (right-edge aligned). Above 0.3 → label sits to the RIGHT of
    // anchor (left-edge aligned). In between → centred.
    if (cosA < -0.3) return anchorX - labelWidth;
    if (cosA > 0.3) return anchorX;
    return anchorX - labelWidth / 2;
  }

  void _drawPolygon(
    Canvas canvas,
    Offset center,
    double radius,
    int n,
    double startAngle,
    Paint paint,
  ) {
    final twoPi = math.pi * 2;
    final path = Path();
    for (var i = 0; i <= n; i++) {
      final angle = startAngle + (i % n) * twoPi / n;
      final p = center +
          Offset(radius * math.cos(angle), radius * math.sin(angle));
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _FingerprintPainter old) {
    if (old.axes.length != axes.length) return true;
    for (var i = 0; i < axes.length; i++) {
      if (old.axes[i].value != axes[i].value) return true;
      if (old.axes[i].label != axes[i].label) return true;
      if (old.axes[i].detail != axes[i].detail) return true;
    }
    return old.fillColor != fillColor ||
        old.strokeColor != strokeColor ||
        old.ringColor != ringColor;
  }
}
