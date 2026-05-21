import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../common/utils/responsive.dart';
import '../../../core/routes/app.routes.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/domain/entities/wine.entity.dart';
import 'demo_caption.dart';

/// Hands-free demo tour: tap ▶ and the app drives itself through the flow,
/// announcing each section with a keynote-style caption and letting every
/// screen's demo animations play. The button hides while running, so it
/// never shows in a recording.
///
/// Mount only in demo builds (guarded at the call site). Reads the real
/// signed-in wine list, so navigation targets are real wines.
class DemoTour extends ConsumerStatefulWidget {
  const DemoTour({super.key});

  @override
  ConsumerState<DemoTour> createState() => _DemoTourState();
}

class _DemoTourState extends ConsumerState<DemoTour> {
  bool _running = false;

  Future<void> _wait(int ms) => Future<void>.delayed(Duration(milliseconds: ms));

  void _cleanup() {
    demoCaption.value = null;
    if (mounted) setState(() => _running = false);
  }

  Future<void> _run() async {
    setState(() => _running = true);
    final router = GoRouter.of(context);
    final shown =
        (ref.read(wineControllerProvider).valueOrNull ?? const <WineEntity>[])
            .take(3)
            .toList();

    const captions = [
      'Remember what you loved',
      'Every note, photo & place',
      'Compare your favourites',
    ];

    // Beat 0 — the list itself, while the tiles stagger in.
    demoCaption.value = 'Every bottle, rated';
    await _wait(2800);

    for (var i = 0; i < shown.length; i++) {
      if (!mounted) return _cleanup();
      // Announce, hold so the label reads, then open — anticipation first.
      demoCaption.value = captions[i % captions.length];
      await _wait(1400);
      router.push(AppRoutes.wineDetailPath(shown[i].id), extra: shown[i]);
      // Cinematic transition + image expand + staggered stats + a read beat.
      await _wait(4600);
      if (!mounted) return _cleanup();
      if (router.canPop()) router.pop();
      await _wait(1600);
    }

    if (!mounted) return _cleanup();
    demoCaption.value = 'Your taste, visualised';
    await _wait(1300);
    router.push(AppRoutes.wineStats);
    await _wait(4600);
    if (!mounted) return _cleanup();
    if (router.canPop()) router.pop();
    await _wait(900);

    _cleanup();
  }

  @override
  Widget build(BuildContext context) {
    if (_running) return const SizedBox.shrink();
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.15;
    return SafeArea(
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: context.w * 0.05),
          child: Material(
            color: cs.primary,
            shape: const CircleBorder(),
            elevation: 3,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _run,
              child: SizedBox(
                width: size,
                height: size,
                child: Icon(
                  PhosphorIconsFill.play,
                  color: cs.onPrimary,
                  size: size * 0.42,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
