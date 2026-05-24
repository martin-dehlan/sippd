import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../controller/wine_stats.provider.dart';

/// "Where your bottles come from" — the top regions drawn as a little
/// skyline of wine bottles. Bottle height scales with the count; the top
/// three are filled in the brand accent, the rest are outlined.
class RegionSkyline extends StatelessWidget {
  final List<Tally> items;

  const RegionSkyline({super.key, required this.items});

  static const int _topN = 5;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _SkylineSkeleton();

    final cs = Theme.of(context).colorScheme;
    final visible = items.take(_topN).toList();
    final remaining = items.length - visible.length;
    final maxCount = visible.first.count;
    final areaHeight = context.h * 0.22;

    return Animate(
      effects: [FadeEffect(duration: 360.ms)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < visible.length; i++)
                Expanded(
                  child: _BottleColumn(
                    item: visible[i],
                    rank: i,
                    maxCount: maxCount,
                    areaHeight: areaHeight,
                  ),
                ),
            ],
          ),
          if (remaining > 0) ...[
            SizedBox(height: context.s),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.xs),
              child: Text(
                AppLocalizations.of(context).winesStatsRegionsMore(remaining),
                style: TextStyle(
                  fontSize: context.captionFont * 0.92,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BottleColumn extends StatelessWidget {
  final Tally item;
  final int rank;
  final int maxCount;
  final double areaHeight;

  const _BottleColumn({
    required this.item,
    required this.rank,
    required this.maxCount,
    required this.areaHeight,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isHero = rank == 0;
    final outlined = rank >= 3;
    final frac = maxCount == 0 ? 0.0 : item.count / maxCount;
    // Keep even a single-bottle region a recognisable bottle, not a stub.
    final bottleHeight = areaHeight * (0.45 + 0.55 * frac);

    final fill = isHero
        ? cs.primary
        : rank <= 2
        ? cs.primary.withValues(alpha: 0.55)
        : Colors.transparent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: areaHeight,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _Bottle(
              width: context.w * 0.085,
              height: bottleHeight,
              fill: fill,
              outline: cs.primary.withValues(alpha: 0.4),
              outlined: outlined,
            ),
          ),
        ),
        SizedBox(height: context.s),
        SizedBox(
          width: context.w * 0.16,
          child: Text(
            item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              color: isHero ? cs.onSurface : cs.onSurfaceVariant,
              fontWeight: isHero ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: 0.2,
              height: 1.15,
            ),
          ),
        ),
        SizedBox(height: context.xs * 0.5),
        Text(
          item.count.toString(),
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            color: cs.outline,
            fontWeight: FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

/// A single bottle silhouette that rises up from its base on first paint.
class _Bottle extends StatelessWidget {
  final double width;
  final double height;
  final Color fill;
  final Color outline;
  final bool outlined;

  const _Bottle({
    required this.width,
    required this.height,
    required this.fill,
    required this.outline,
    required this.outlined,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (_, t, child) => Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.diagonal3Values(1, t, 1),
        child: child,
      ),
      child: CustomPaint(
        size: Size(width, height),
        painter: _BottlePainter(
          fill: fill,
          outline: outline,
          outlined: outlined,
        ),
      ),
    );
  }
}

class _BottlePainter extends CustomPainter {
  final Color fill;
  final Color outline;
  final bool outlined;

  _BottlePainter({
    required this.fill,
    required this.outline,
    required this.outlined,
  });

  @override
  void paint(Canvas canvas, Size s) {
    final path = _bottlePath(s);
    if (outlined) {
      canvas.drawPath(
        path,
        Paint()
          ..color = outline
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4
          ..strokeJoin = StrokeJoin.round,
      );
    } else {
      canvas.drawPath(path, Paint()..color = fill);
    }
  }

  Path _bottlePath(Size s) {
    final w = s.width;
    final h = s.height;
    final cx = w / 2;
    final capW = w * 0.34;
    final neckW = w * 0.24;
    final bodyW = w * 0.94;
    final capH = h * 0.05;
    final neckBot = h * 0.30; // neck ends, shoulder begins
    final shoulderBot = h * 0.44; // body begins
    final bodyR = math.min(w * 0.18, (h - shoulderBot) * 0.4);

    return Path()
      ..moveTo(cx - capW / 2, 0)
      ..lineTo(cx - capW / 2, capH)
      ..lineTo(cx - neckW / 2, capH)
      ..lineTo(cx - neckW / 2, neckBot)
      ..quadraticBezierTo(cx - bodyW / 2, neckBot, cx - bodyW / 2, shoulderBot)
      ..lineTo(cx - bodyW / 2, h - bodyR)
      ..quadraticBezierTo(cx - bodyW / 2, h, cx - bodyW / 2 + bodyR, h)
      ..lineTo(cx + bodyW / 2 - bodyR, h)
      ..quadraticBezierTo(cx + bodyW / 2, h, cx + bodyW / 2, h - bodyR)
      ..lineTo(cx + bodyW / 2, shoulderBot)
      ..quadraticBezierTo(cx + bodyW / 2, neckBot, cx + neckW / 2, neckBot)
      ..lineTo(cx + neckW / 2, capH)
      ..lineTo(cx + capW / 2, capH)
      ..lineTo(cx + capW / 2, 0)
      ..close();
  }

  @override
  bool shouldRepaint(covariant _BottlePainter old) =>
      old.fill != fill || old.outline != outline || old.outlined != outlined;
}

class _SkylineSkeleton extends StatelessWidget {
  const _SkylineSkeleton();

  @override
  Widget build(BuildContext context) {
    final widths = [0.85, 0.62, 0.5, 0.38, 0.3];
    return Skeleton(
      child: SizedBox(
        height: context.h * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final f in widths)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SkeletonBox(
                    width: context.w * 0.085,
                    height: context.h * 0.16 * f,
                    radius: context.w * 0.02,
                  ),
                  SizedBox(height: context.s),
                  SkeletonBox(
                    width: context.w * 0.13,
                    height: context.captionFont * 0.85,
                  ),
                  SizedBox(height: context.xs * 0.5),
                  SkeletonBox(
                    width: context.w * 0.04,
                    height: context.captionFont * 0.78,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
