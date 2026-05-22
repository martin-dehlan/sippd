import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../common/utils/responsive.dart';
import '../../../core/routes/app.routes.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/controller/wine_stats.provider.dart';
import '../../wines/domain/entities/wine.entity.dart';
import 'demo_spotlight.widget.dart';

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

  Future<void> _wait(int ms) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  /// Waits for the just-opened screen's demo director to finish (it flips
  /// [demoScreenBusy]); falls back to [max] so a screen without a director
  /// doesn't stall the tour.
  Future<void> _waitUntilIdle({int max = 16000}) async {
    await _wait(400); // let the director set busy = true first
    var waited = 0;
    while (mounted && demoScreenBusy.value && waited < max) {
      await _wait(200);
      waited += 200;
    }
  }

  void _cleanup() {
    demoSpotlightId.value = null;
    if (mounted) setState(() => _running = false);
  }

  Future<void> _run() async {
    setState(() => _running = true);
    final router = GoRouter.of(context);
    final shown =
        (ref.read(wineControllerProvider).valueOrNull ?? const <WineEntity>[])
            .take(3)
            .toList();

    if (shown.isEmpty) return _cleanup();

    // Let the staggered list entrance finish.
    await _wait(2400);

    // Browse: pop each tile in turn so the list reads as interactive.
    for (final wine in shown) {
      if (!mounted) return _cleanup();
      demoSpotlightId.value = wine.id;
      await _wait(950);
    }
    await _wait(300);

    // Deep-dive the top wine — its detail spotlights each feature once
    // (image → rating → price → origin), so nothing is shown twice.
    demoSpotlightId.value = shown.first.id;
    await _wait(1000);
    if (!mounted) return _cleanup();
    router.push(AppRoutes.wineDetailPath(shown.first.id), extra: shown.first);
    await _waitUntilIdle(
      max: 42000,
    ); // beats + edit sheets + pickers + sections
    if (!mounted) return _cleanup();
    if (router.canPop()) router.pop();
    demoSpotlightId.value = null;
    await _wait(1400);

    // Stats (TRACK) — prewarm the unified rating summary first (and keep it
    // alive) so the hero average animates straight to its final value instead
    // of counting to the local avg then snapping to the server one mid-focus.
    if (!mounted) return _cleanup();
    final summarySub = ref.listenManual(userRatingSummaryProvider, (_, _) {});
    try {
      await ref.read(userRatingSummaryProvider.future);
    } catch (_) {
      // Fall through — the hero still renders, just possibly local-only.
    }
    if (mounted) {
      router.push(AppRoutes.wineStats);
      await _waitUntilIdle(max: 30000); // all chart sections incl. Pro
      if (mounted && router.canPop()) router.pop();
    }
    summarySub.close();
    if (!mounted) return _cleanup();
    await _wait(900);

    // Groups (HOST / SHARE) — tab switch, then spotlight the group cards.
    if (!mounted) return _cleanup();
    router.go(AppRoutes.groups);
    await _wait(1100);
    for (var b = 0; b < 2; b++) {
      if (!mounted) return _cleanup();
      demoDetailBeat.value = b;
      await _wait(2200);
    }
    demoDetailBeat.value = null;
    await _wait(500);

    // Taste profile (your palate) — tab switch, then spotlight the
    // wine-personality hero.
    if (!mounted) return _cleanup();
    router.go(AppRoutes.profile);
    await _wait(1100);
    demoDetailBeat.value = 0;
    await _wait(3200);
    demoDetailBeat.value = null;
    await _wait(500);

    // Back home.
    if (!mounted) return _cleanup();
    router.go(AppRoutes.wines);
    await _wait(800);

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
