import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/utils/responsive.dart';
import 'compass_modes.dart';

/// Generic radar with skill-tree styling. Takes any list of axes and
/// renders a hexagonal/polygonal compass; tapping an axis selects it
/// (orb pulses, others dim, detail card slides in below).
class CompassRadar extends StatefulWidget {
  const CompassRadar({super.key, required this.axes});

  final List<RadarAxis> axes;

  @override
  State<CompassRadar> createState() => _CompassRadarState();
}

class _CompassRadarState extends State<CompassRadar>
    with SingleTickerProviderStateMixin {
  int? _selected;
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant CompassRadar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset selection when axis set changes (mode switch).
    if (oldWidget.axes.length != widget.axes.length ||
        (oldWidget.axes.isNotEmpty &&
            widget.axes.isNotEmpty &&
            oldWidget.axes.first.label != widget.axes.first.label)) {
      _selected = null;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _select(int? index) {
    if (index == _selected) {
      setState(() => _selected = null);
    } else {
      HapticFeedback.selectionClick();
      setState(() => _selected = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final axes = widget.axes;
    if (axes.length < 3) return const SizedBox.shrink();
    final selectedAxis = _selected != null ? axes[_selected!] : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTapDown: (d) {
                        final hit = _hitTestAxis(
                          d.localPosition,
                          constraints.biggest,
                          axes.length,
                        );
                        _select(hit);
                      },
                      child: AnimatedBuilder(
                        animation: _pulse,
                        builder: (_, _) => CustomPaint(
                          painter: _RadarPainter(
                            axes: axes,
                            selected: _selected,
                            pulse: _pulse.value,
                            fillColor: cs.primary.withValues(alpha: 0.28),
                            fillCenterColor: cs.primary.withValues(alpha: 0.12),
                            strokeColor: cs.primary,
                            ringColor:
                                cs.outlineVariant.withValues(alpha: 0.45),
                            haloColor: cs.primary.withValues(alpha: 0.06),
                            surfaceColor: cs.surfaceContainerHighest,
                          ),
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < axes.length; i++)
                    _AxisLabel(
                      axis: axes[i],
                      index: i,
                      total: axes.length,
                      size: constraints.biggest,
                      selected: _selected == i,
                      onTap: () => _select(i),
                    ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: context.s),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SizeTransition(
              sizeFactor: anim,
              axisAlignment: -1,
              child: child,
            ),
          ),
          child: selectedAxis == null
              ? const SizedBox(key: ValueKey('empty'), height: 0)
              : _AxisDetailCard(
                  key: ValueKey(selectedAxis.label),
                  axis: selectedAxis,
                ),
        ),
      ],
    );
  }

  int? _hitTestAxis(Offset tap, Size size, int n) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2;
    final dist = (tap - center).distance;
    if (dist < maxRadius * 0.18 || dist > maxRadius * 0.95) return null;

    final angle = math.atan2(tap.dy - center.dy, tap.dx - center.dx);
    final twoPi = math.pi * 2;
    final startAngle = -math.pi / 2;
    int best = 0;
    double bestDelta = double.infinity;
    for (var i = 0; i < n; i++) {
      final axisAngle = startAngle + i * twoPi / n;
      var delta = (angle - axisAngle).abs();
      if (delta > math.pi) delta = twoPi - delta;
      if (delta < bestDelta) {
        bestDelta = delta;
        best = i;
      }
    }
    if (bestDelta > twoPi / (n * 2)) return null;
    return best;
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({
    required this.axes,
    required this.selected,
    required this.pulse,
    required this.fillColor,
    required this.fillCenterColor,
    required this.strokeColor,
    required this.ringColor,
    required this.haloColor,
    required this.surfaceColor,
  });

  final List<RadarAxis> axes;
  final int? selected;
  final double pulse;
  final Color fillColor;
  final Color fillCenterColor;
  final Color strokeColor;
  final Color ringColor;
  final Color haloColor;
  final Color surfaceColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.62;
    final n = axes.length;
    if (n < 3) return;
    final twoPi = math.pi * 2;
    final startAngle = -math.pi / 2;

    canvas.drawCircle(
      center,
      radius * 1.15,
      Paint()
        ..shader = ui.Gradient.radial(
          center,
          radius * 1.15,
          [haloColor, haloColor.withValues(alpha: 0)],
          [0.0, 1.0],
        ),
    );

    _drawPolygon(canvas, center, radius, n, startAngle,
        Paint()
          ..color = ringColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8);
    _drawPolygon(canvas, center, radius * 0.5, n, startAngle,
        Paint()
          ..color = ringColor.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.6);

    final spokePaint = Paint()
      ..color = ringColor.withValues(alpha: 0.25)
      ..strokeWidth = 0.5;
    for (var i = 0; i < n; i++) {
      final angle = startAngle + i * twoPi / n;
      final tip =
          center + Offset(radius * math.cos(angle), radius * math.sin(angle));
      canvas.drawLine(center, tip, spokePaint);
    }

    final vertices = <Offset>[];
    final dataPath = Path();
    for (var i = 0; i < n; i++) {
      final angle = startAngle + i * twoPi / n;
      final v = axes[i].value.clamp(0.0, 1.0);
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
        ..shader = ui.Gradient.radial(
          center,
          radius,
          [fillColor, fillCenterColor],
          [0.0, 1.0],
        )
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      dataPath,
      Paint()
        ..color = strokeColor.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawPath(
      dataPath,
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..strokeJoin = StrokeJoin.round,
    );

    for (var i = 0; i < n; i++) {
      final angle = startAngle + i * twoPi / n;
      final tip =
          center + Offset(radius * math.cos(angle), radius * math.sin(angle));
      final v = axes[i].value.clamp(0.0, 1.0);
      final isSelected = selected == i;
      final isMuted = selected != null && selected != i;
      final color = axes[i].color;
      final orbValueRadius = (4.0 + v * 7.0);
      final pulseScale =
          isSelected ? (1.0 + 0.15 * math.sin(pulse * twoPi)) : 1.0;
      final orbR = orbValueRadius * pulseScale;
      final muteFactor = isMuted ? 0.45 : 1.0;

      if (v > 0 || isSelected) {
        canvas.drawCircle(
          tip,
          orbR + 6,
          Paint()
            ..color = color.withValues(alpha: 0.25 * muteFactor)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        );
      }
      canvas.drawCircle(tip, orbR + 1.6, Paint()..color = surfaceColor);
      canvas.drawCircle(
        tip,
        orbR,
        Paint()..color = color.withValues(alpha: muteFactor),
      );
      if (isSelected) {
        canvas.drawCircle(
          tip,
          orbR + 3,
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        );
      }
    }
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
  bool shouldRepaint(covariant _RadarPainter old) {
    if (old.selected != selected) return true;
    if (old.pulse != pulse) return true;
    if (old.axes.length != axes.length) return true;
    for (var i = 0; i < axes.length; i++) {
      if (old.axes[i].value != axes[i].value) return true;
      if (old.axes[i].label != axes[i].label) return true;
    }
    return false;
  }
}

class _AxisLabel extends StatelessWidget {
  const _AxisLabel({
    required this.axis,
    required this.index,
    required this.total,
    required this.size,
    required this.selected,
    required this.onTap,
  });

  final RadarAxis axis;
  final int index;
  final int total;
  final Size size;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final twoPi = math.pi * 2;
    final angle = -math.pi / 2 + index * twoPi / total;
    final labelRadius = radius * 0.84;
    final cosA = math.cos(angle);
    final sinA = math.sin(angle);
    final labelCentre =
        center + Offset(labelRadius * cosA, labelRadius * sinA);

    final labelColor = axis.value <= 0 ? cs.outline : cs.onSurface;
    final detailColor = cs.onSurfaceVariant;

    return Positioned(
      left: labelCentre.dx - size.width * 0.18,
      top: labelCentre.dy - size.height * 0.05,
      width: size.width * 0.36,
      height: size.height * 0.1,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: axis.color
                        .withValues(alpha: axis.value <= 0 ? 0.4 : 1.0),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    axis.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight:
                          selected ? FontWeight.w800 : FontWeight.w700,
                      color: labelColor,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
              ],
            ),
            if (axis.detail.isNotEmpty)
              Text(
                axis.detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: detailColor,
                  height: 1.1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AxisDetailCard extends StatelessWidget {
  const _AxisDetailCard({super.key, required this.axis});

  final RadarAxis axis;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.s * 1.5,
        vertical: context.s * 1.2,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        border: Border.all(
          color: axis.color.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: context.h * 0.05,
            decoration: BoxDecoration(
              color: axis.color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(width: context.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  axis.label.toUpperCase(),
                  style: TextStyle(
                    fontSize: context.captionFont * 0.78,
                    fontWeight: FontWeight.w800,
                    color: axis.color,
                    letterSpacing: 0.9,
                  ),
                ),
                SizedBox(height: context.xs * 0.6),
                Text(
                  axis.headline,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurface,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
