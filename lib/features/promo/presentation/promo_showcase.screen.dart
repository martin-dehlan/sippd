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
/// Exports (all open the share sheet → AirDrop / Files):
///  - **PNG** — native-resolution still with a transparent surround.
///  - **Sequence** — an alpha PNG frame sequence of the pop animation, for
///    transparent motion overlays in the editor (MP4 can't carry alpha).
///  - **Record** — full-frame MP4 (background baked in; B-roll, not overlay).
///
/// Tap the widget area to hide the bar for a clean OS screen-recording.
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
  bool _shadow = false;
  PromoMotion _motion = PromoMotion.pop;

  /// Non-null only while rendering an alpha frame sequence.
  double? _seqT;

  final ScreenshotController _shot = ScreenshotController();
  late final WidgetRecorderController _rec;

  PromoEntry get _entry => promoEntries[_index];

  // Native render: share cards are already 1080-wide, so 2× is plenty;
  // smaller in-app widgets get a higher ratio for crispness.
  double get _pixelRatio => _entry.designSize != null ? 2 : 3.5;

  @override
  void initState() {
    super.initState();
    _rec = WidgetRecorderController(
      onComplete: (path) async {
        _notify('MP4 saved — opening share sheet…');
        await _share([XFile(path)], 'Sippd promo — ${_entry.name}');
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

  Future<void> _share(List<XFile> files, String subject) async {
    if (files.isEmpty) return;
    await Share.shareXFiles(files, subject: subject, text: subject);
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
      _replayTick++;
    });
    _notify('Motion: ${_motion.label}');
  }

  void _toggleShadow() {
    setState(() => _shadow = !_shadow);
    _notify('Drop shadow: ${_shadow ? 'on' : 'off'}');
  }

  Future<void> _capturePng() async {
    final bytes = await _shot.capture(
      pixelRatio: _pixelRatio,
      delay: const Duration(milliseconds: 320),
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
    await _share([XFile(file.path)], 'Sippd promo — ${_entry.name}');
  }

  /// Renders the pop as 24 transparent PNG frames into a folder, then shares
  /// them. Import as an image sequence in the editor for an alpha overlay.
  Future<void> _exportSequence() async {
    if (_entry.isScene) {
      _notify('Sequence export is for single widgets, not scenes');
      return;
    }
    const frames = 24;
    final dir = await getApplicationDocumentsDirectory();
    final ts = DateTime.now().millisecondsSinceEpoch;
    final folder = Directory('${dir.path}/seq_${_entry.slug}_$ts');
    await folder.create();

    final files = <XFile>[];
    for (var i = 0; i < frames; i++) {
      if (!mounted) break;
      setState(() => _seqT = i / (frames - 1));
      await WidgetsBinding.instance.endOfFrame;
      final bytes = await _shot.capture(pixelRatio: _pixelRatio);
      if (bytes == null) continue;
      final f = File(
        '${folder.path}/frame_${i.toString().padLeft(3, '0')}.png',
      );
      await f.writeAsBytes(bytes);
      files.add(XFile(f.path));
    }
    if (mounted) setState(() => _seqT = null);
    _notify('Sequence: ${files.length} frames → ${folder.path}');
    await _share(files, 'Sippd promo sequence — ${_entry.name}');
  }

  Future<void> _toggleRecord() async {
    if (_recording) {
      await _rec.stop();
      if (mounted) setState(() => _recording = false);
      return;
    }
    await _rec.start();
    if (!mounted) return;
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
                captureT: _seqT,
                shadow: _shadow,
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
                shadow: _shadow,
                onPrev: () => _go(-1),
                onNext: () => _go(1),
                onReplay: _replay,
                onCycleMotion: _cycleMotion,
                onToggleShadow: _toggleShadow,
                onCapture: _capturePng,
                onSequence: _exportSequence,
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
