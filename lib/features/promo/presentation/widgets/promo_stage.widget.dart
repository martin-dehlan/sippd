import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:widget_recorder_plus/widget_recorder_plus.dart';

import '../../../../common/utils/responsive.dart';
import '../promo_registry.dart';
import 'promo_entrance.widget.dart';
import 'promo_spotlight.widget.dart';

/// Renders a single [PromoEntry] (or a [PromoScene]) on a clean canvas,
/// ready to screen-record or export.
///
/// Capture quality: the [Screenshot] boundary wraps the widget at its
/// **native** size (for share cards that's the full 1080×1920), and the
/// FittedBox that fits it to screen sits *outside* the boundary. So a
/// `capture(pixelRatio: …)` re-rasterises the native layer — sharp, not the
/// scaled-down on-screen pixels — while still living in the real tree so
/// Theme / MediaQuery / Localizations resolve.
class PromoStage extends StatelessWidget {
  const PromoStage({
    super.key,
    required this.entry,
    required this.replayTick,
    required this.motion,
    required this.screenshotController,
    required this.recorderController,
    this.captureT,
    this.shadow = false,
  });

  final PromoEntry entry;
  final int replayTick;
  final PromoMotion motion;
  final ScreenshotController screenshotController;
  final WidgetRecorderController recorderController;

  /// When set (0..1), bakes a scale+fade pose *inside* the capture boundary
  /// so an exported PNG frame carries that animation state — used to render
  /// an alpha frame sequence.
  final double? captureT;

  /// Bakes a shape-agnostic drop shadow into the captured widget so it reads
  /// on any footage. Ignored for fixed-canvas share cards.
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    if (entry.isScene) {
      return WidgetRecorder(
        controller: recorderController,
        child: ColoredBox(
          color: entry.background,
          child: Screenshot(
            controller: screenshotController,
            child: PromoScene(
              key: ValueKey('${entry.slug}-scene-$replayTick'),
              title: entry.name.replaceFirst('Scene · ', ''),
              slots: entry.slots!,
            ),
          ),
        ),
      );
    }

    return WidgetRecorder(
      controller: recorderController,
      child: ColoredBox(
        color: entry.background,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.w * 0.06),
            child: Center(child: _single(context)),
          ),
        ),
      ),
    );
  }

  Widget _single(BuildContext context) {
    final designSize = entry.designSize;

    // Bake the frame-sequence pose (if exporting) inside the boundary.
    Widget framed = Builder(builder: entry.builder!);
    final t = captureT;
    if (t != null) {
      framed = Opacity(
        opacity: Curves.easeOut.transform(t.clamp(0.0, 1.0)),
        child: Transform.scale(
          scale: ui.lerpDouble(
            0.85,
            1,
            Curves.easeOutCubic.transform(t.clamp(0.0, 1.0)),
          ),
          child: framed,
        ),
      );
    }

    // Drop shadow only makes sense for in-app widgets, not full-bleed cards.
    if (shadow && designSize == null) framed = _shadowed(framed);

    final boundaryChild = designSize != null
        ? SizedBox.fromSize(size: designSize, child: framed)
        : framed;

    final captured = Screenshot(
      controller: screenshotController,
      child: boundaryChild,
    );

    final display = designSize != null
        ? FittedBox(fit: BoxFit.contain, child: captured)
        : captured;

    return PromoEntrance(
      key: ValueKey('${entry.slug}-${motion.name}-$replayTick'),
      motion: motion,
      child: display,
    );
  }

  /// Shape-agnostic drop shadow: a blurred, darkened silhouette of the
  /// widget (alpha preserved) offset behind it. Padding gives the blur room
  /// so it isn't clipped out of the capture.
  Widget _shadowed(Widget child) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(44, 36, 44, 56),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, 14),
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: Opacity(
                opacity: 0.5,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcATop,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
