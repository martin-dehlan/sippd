import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../common/utils/responsive.dart';
import '../../../core/routes/app.routes.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/domain/entities/wine.entity.dart';

/// Hands-free demo tour: tap ▶ and the app drives itself through the flow
/// (list → wine detail ×3 → stats), letting each screen's demo animations
/// play. The button hides while running, so it never shows in a recording.
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

  Future<void> _run() async {
    setState(() => _running = true);
    final router = GoRouter.of(context);
    final wines =
        ref.read(wineControllerProvider).valueOrNull ?? const <WineEntity>[];

    // Let the staggered list entrance finish.
    await _wait(2400);

    for (final wine in wines.take(3)) {
      if (!mounted) return;
      router.push(AppRoutes.wineDetailPath(wine.id), extra: wine);
      // Transition + image expand + staggered stat reveal + a beat to read.
      await _wait(4400);
      if (!mounted) return;
      if (router.canPop()) router.pop();
      await _wait(1500);
    }

    if (!mounted) return;
    router.push(AppRoutes.wineStats);
    await _wait(4200);
    if (!mounted) return;
    if (router.canPop()) router.pop();

    if (mounted) setState(() => _running = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_running) return const SizedBox.shrink();
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.15;
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: context.w * 0.06,
          bottom: context.h * 0.06,
        ),
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
    );
  }
}
