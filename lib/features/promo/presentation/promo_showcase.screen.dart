import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:widget_recorder_plus/widget_recorder_plus.dart';

import '../../../common/utils/responsive.dart';
import 'promo_registry.dart';
import 'widgets/promo_debug_menu.widget.dart';
import 'widgets/promo_stage.widget.dart';

/// Clean, chrome-free stage that shows one promo widget at a time. The only
/// affordance is a 5-tap corner that opens the [PromoDebugMenu]; everything
/// else (navigation, capture, recording) lives in that sheet so recordings
/// stay pristine.
class PromoShowcaseScreen extends StatefulWidget {
  const PromoShowcaseScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<PromoShowcaseScreen> createState() => _PromoShowcaseScreenState();
}

class _PromoShowcaseScreenState extends State<PromoShowcaseScreen> {
  late int _index = widget.initialIndex.clamp(0, promoEntries.length - 1);
  int _replayTick = 0;
  bool _recording = false;

  final ScreenshotController _shot = ScreenshotController();
  late final WidgetRecorderController _rec;

  PromoEntry get _entry => promoEntries[_index];

  @override
  void initState() {
    super.initState();
    _rec = WidgetRecorderController(
      onComplete: (path) => _notify('Saved MP4 → $path'),
      onError: (error) => _notify('Recording failed: $error'),
    );
  }

  @override
  void dispose() {
    _rec.dispose();
    super.dispose();
  }

  void _notify(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _select(int index) {
    Navigator.of(context).pop();
    setState(() {
      _index = index;
      _replayTick++;
    });
  }

  void _replay() {
    Navigator.of(context).pop();
    setState(() => _replayTick++);
  }

  Future<void> _capturePng() async {
    Navigator.of(context).pop();
    // Let the entrance settle so the still isn't mid-fade.
    final bytes = await _shot.capture(
      pixelRatio: 3,
      delay: const Duration(milliseconds: 700),
    );
    if (bytes == null) {
      _notify('Capture returned no image');
      return;
    }
    final dir = await getApplicationDocumentsDirectory();
    final ts = DateTime.now().millisecondsSinceEpoch;
    final file = File('${dir.path}/promo_${_entry.slug}_$ts.png');
    await file.writeAsBytes(bytes);
    _notify('Saved PNG → ${file.path}');
  }

  Future<void> _toggleRecord() async {
    Navigator.of(context).pop();
    if (_recording) {
      await _rec.stop(); // onComplete reports the path
      if (mounted) setState(() => _recording = false);
      return;
    }
    await _rec.start();
    if (mounted) setState(() => _recording = true);
  }

  void _openMenu() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => PromoDebugMenu(
        entries: promoEntries,
        currentIndex: _index,
        recording: _recording,
        onSelect: _select,
        onReplay: _replay,
        onCapture: _capturePng,
        onToggleRecord: _toggleRecord,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _entry.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: PromoStage(
              entry: _entry,
              replayTick: _replayTick,
              screenshotController: _shot,
              recorderController: _rec,
            ),
          ),
          // Invisible 5-tap target, top-left corner.
          Positioned(
            top: 0,
            left: 0,
            child: _FiveTapCorner(onTrigger: _openMenu),
          ),
          if (_recording)
            Positioned(
              top: context.m,
              right: context.m,
              child: SafeArea(child: _RecordingDot()),
            ),
        ],
      ),
    );
  }
}

/// Counts five taps within a short window before firing [onTrigger].
class _FiveTapCorner extends StatefulWidget {
  const _FiveTapCorner({required this.onTrigger});

  final VoidCallback onTrigger;

  @override
  State<_FiveTapCorner> createState() => _FiveTapCornerState();
}

class _FiveTapCornerState extends State<_FiveTapCorner> {
  int _taps = 0;
  Timer? _reset;

  void _onTap() {
    _reset?.cancel();
    _taps++;
    if (_taps >= 5) {
      _taps = 0;
      widget.onTrigger();
      return;
    }
    _reset = Timer(const Duration(milliseconds: 700), () => _taps = 0);
  }

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final side = context.w * 0.16;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: SizedBox(width: side, height: side),
    );
  }
}

class _RecordingDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = context.w * 0.03;
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFE5484D),
        shape: BoxShape.circle,
      ),
    );
  }
}
