import 'package:flutter/material.dart';

import '../promo.config.dart';

/// Which list tile is currently spotlighted during the demo tour, keyed by
/// wine id. The tour sets this just before opening a tile; [DemoSpotlightTile]
/// wrappers react. `null` = nothing spotlighted (normal list).
final ValueNotifier<String?> demoSpotlightId = ValueNotifier<String?>(null);

/// Active demo "feature beat" on whichever screen is running its director
/// (wine detail or stats). [DemoBeatHighlight] wrappers react: the matching
/// beat pops, the rest dim. `null` = nothing highlighted.
final ValueNotifier<int?> demoDetailBeat = ValueNotifier<int?>(null);

/// True while a screen's demo director is mid-sequence (including briefly
/// opened sheets). The auto-tour waits for this to clear before navigating
/// away, so timing isn't hard-coded in two places.
final ValueNotifier<bool> demoScreenBusy = ValueNotifier<bool>(false);

/// Target page for a demo-driven horizontal carousel (group shared-wines).
/// The carousel's [PageController] animates to this index when it changes;
/// `null` = no demo scroll. Lets a screen director browse the cards
/// hands-free before opening one. No-op in prod.
final ValueNotifier<int?> demoCarouselPage = ValueNotifier<int?>(null);

/// Id of the wine the scan demo just created. The tour deletes it in its
/// cleanup so each run starts fresh (the scan flow re-creates it). `null` =
/// nothing to clean up. No-op in prod.
final ValueNotifier<String?> demoCreatedWineId = ValueNotifier<String?>(null);

/// Wraps a detail-screen feature so it pops forward when it's the active
/// [beat] and dims when a *different* feature is active. No-op in prod.
class DemoBeatHighlight extends StatelessWidget {
  const DemoBeatHighlight({
    super.key,
    required this.beat,
    required this.child,
    this.activeScale = 1.06,
  });

  final int beat;
  final Widget child;
  final double activeScale;

  @override
  Widget build(BuildContext context) {
    if (!kIsDemo) return child;
    return ValueListenableBuilder<int?>(
      valueListenable: demoDetailBeat,
      builder: (context, active, _) {
        final isActive = active == beat;
        final dimmed = active != null && !isActive;
        return AnimatedScale(
          scale: isActive ? activeScale : 1,
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutBack,
          child: AnimatedOpacity(
            opacity: dimmed ? 0.4 : 1,
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOut,
            child: child,
          ),
        );
      },
    );
  }
}

/// Wraps a list tile so that, in demo builds, it pops forward when it's the
/// spotlighted one and dims when a *different* tile is spotlighted — the
/// "look here" beat before the tour opens it. No-op passthrough in prod.
class DemoSpotlightTile extends StatelessWidget {
  const DemoSpotlightTile({super.key, required this.id, required this.child});

  final String id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!kIsDemo) return child;
    return ValueListenableBuilder<String?>(
      valueListenable: demoSpotlightId,
      builder: (context, activeId, _) {
        final isActive = activeId == id;
        final dimmed = activeId != null && !isActive;
        return AnimatedScale(
          scale: isActive ? 1.06 : 1,
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeOutBack,
          child: AnimatedOpacity(
            opacity: dimmed ? 0.32 : 1,
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOut,
            child: child,
          ),
        );
      },
    );
  }
}
