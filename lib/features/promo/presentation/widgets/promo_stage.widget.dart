import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:widget_recorder_plus/widget_recorder_plus.dart';

import '../../../../common/utils/responsive.dart';
import '../promo_registry.dart';
import 'promo_entrance.widget.dart';
import 'promo_spotlight.widget.dart';

/// Renders a single [PromoEntry] isolated on a clean canvas, ready to be
/// screen-recorded or screenshotted.
///
/// Layering, outside-in:
///  - [WidgetRecorder] captures the full canvas (solid backdrop included)
///    so exported MP4s aren't transparent-black.
///  - the [ColoredBox] backdrop fills the frame.
///  - [Screenshot] wraps *only* the widget, so captured PNGs have a
///    transparent surround — drop straight onto a Rotato mockup.
///  - [PromoEntrance] plays the slide-up + fade on mount / replay.
class PromoStage extends StatelessWidget {
  const PromoStage({
    super.key,
    required this.entry,
    required this.replayTick,
    required this.motion,
    required this.screenshotController,
    required this.recorderController,
  });

  final PromoEntry entry;

  /// Bumped by the showcase to force the entrance animation to replay.
  final int replayTick;

  /// Entrance / emphasis style to play.
  final PromoMotion motion;

  final ScreenshotController screenshotController;
  final WidgetRecorderController recorderController;

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

    final Widget raw = Builder(builder: entry.builder!);

    // Fixed-canvas artifacts (the 1080×1920 share cards) are scaled to fit;
    // responsive in-app widgets render at their natural box size.
    final designSize = entry.designSize;
    final Widget content = designSize != null
        ? FittedBox(
            fit: BoxFit.contain,
            child: SizedBox.fromSize(size: designSize, child: raw),
          )
        : raw;

    return WidgetRecorder(
      controller: recorderController,
      child: ColoredBox(
        color: entry.background,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.w * 0.06),
            child: Center(
              child: Screenshot(
                controller: screenshotController,
                child: PromoEntrance(
                  key: ValueKey('${entry.slug}-${motion.name}-$replayTick'),
                  motion: motion,
                  child: content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
