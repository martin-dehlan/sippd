import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widget_recorder_plus/widget_recorder_plus.dart';

import '../../../common/utils/responsive.dart';
import 'promo_registry.dart';
import 'widgets/promo_controls.widget.dart';
import 'widgets/promo_debug_menu.widget.dart';
import 'widgets/promo_entrance.widget.dart';
import 'widgets/promo_stage.widget.dart';

/// Stage that shows one promo widget at a time with a bottom control bar.
///
/// Workflow:
///  - **Record** captures just the widget to an MP4 (replays the entrance
///    first so the clip starts clean), then opens the share sheet.
///  - **PNG** captures a transparent-surround still, then shares it.
///  - Tap the widget area to hide the bar for a clean OS screen-recording.
///
/// Exports capture only the widget subtree, so the control bar never shows
/// up in a PNG/MP4 — only in OS-level screen recordings.
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
  bool _chromeVisible = true;
  PromoMotion _motion = PromoMotion.pop;

  final ScreenshotController _shot = ScreenshotController();
  late final WidgetRecorderController _rec;

  PromoEntry get _entry => promoEntries[_index];

  @override
  void initState() {
    super.initState();
    _rec = WidgetRecorderController(
      onComplete: (path) async {
        _notify('MP4 saved — opening share sheet…');
        await _share(path, 'Sippd promo — ${_entry.name}');
      },
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

  Future<void> _share(String path, String subject) async {
    await Share.shareXFiles([XFile(path)], subject: subject, text: subject);
  }

  void _go(int delta) {
    setState(() {
      _index = (_index + delta) % promoEntries.length;
      if (_index < 0) _index += promoEntries.length;
      _replayTick++;
    });
  }

  void _select(int index) {
    Navigator.of(context).pop();
    setState(() {
      _index = index;
      _replayTick++;
    });
  }

  void _replay() => setState(() => _replayTick++);

  void _cycleMotion() {
    setState(() {
      _motion = _motion.next;
      _replayTick++; // remount so the new motion plays immediately
    });
    _notify('Motion: ${_motion.label}');
  }

  Future<void> _capturePng() async {
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
    if (!mounted) return;
    _notify('PNG saved — opening share sheet…');
    await _share(file.path, 'Sippd promo — ${_entry.name}');
  }

  Future<void> _toggleRecord() async {
    if (_recording) {
      await _rec.stop(); // onComplete handles sharing
      if (mounted) setState(() => _recording = false);
      return;
    }
    await _rec.start();
    if (!mounted) return;
    // Restart the entrance so the clip captures the animation from zero.
    setState(() {
      _recording = true;
      _replayTick++;
    });
  }

  void _openList() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => PromoDebugMenu(
        entries: promoEntries,
        currentIndex: _index,
        recording: _recording,
        onSelect: _select,
        onReplay: () {
          Navigator.of(context).pop();
          _replay();
        },
        onCapture: () {
          Navigator.of(context).pop();
          _capturePng();
        },
        onToggleRecord: () {
          Navigator.of(context).pop();
          _toggleRecord();
        },
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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _chromeVisible = !_chromeVisible),
              child: PromoStage(
                entry: _entry,
                replayTick: _replayTick,
                motion: _motion,
                screenshotController: _shot,
                recorderController: _rec,
              ),
            ),
          ),
          if (_recording)
            Positioned(
              top: context.m,
              right: context.m,
              child: SafeArea(child: _RecordingDot()),
            ),
          if (_chromeVisible)
            Align(
              alignment: Alignment.bottomCenter,
              child: PromoControlsBar(
                entry: _entry,
                recording: _recording,
                motion: _motion,
                onPrev: () => _go(-1),
                onNext: () => _go(1),
                onReplay: _replay,
                onCycleMotion: _cycleMotion,
                onCapture: _capturePng,
                onToggleRecord: _toggleRecord,
                onOpenList: _openList,
              ),
            ),
        ],
      ),
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
