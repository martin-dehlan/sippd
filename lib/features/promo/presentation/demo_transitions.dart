import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../promo.config.dart';

/// Cinematic page transition for demo builds: fade + a subtle rise + a gentle
/// scale-up, so navigation feels like a polished pitch in flow videos.
Page<void> demoPage(LocalKey key, Widget child) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 520),
    reverseTransitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curve,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curve),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1).animate(curve),
            child: child,
          ),
        ),
      );
    },
  );
}

/// Builds a [GoRoute] that uses the cinematic [demoPage] transition **only**
/// in demo builds. In normal builds it returns a plain `builder` route, i.e.
/// the platform-default page — so production navigation is byte-for-byte
/// unchanged.
GoRoute demoRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
}) {
  if (kIsDemo) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) =>
          demoPage(state.pageKey, builder(context, state)),
    );
  }
  return GoRoute(path: path, builder: builder);
}
