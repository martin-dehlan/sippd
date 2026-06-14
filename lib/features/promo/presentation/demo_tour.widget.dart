import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../common/utils/responsive.dart';
import '../../../core/routes/app.routes.dart';
import '../../friends/controller/friends.provider.dart';
import '../../groups/controller/group.provider.dart';
import '../../groups/domain/entities/group.entity.dart';
import '../../tastings/controller/tastings.provider.dart';
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
  ///
  /// First waits (up to [armCap]) for the director to flip busy *on* — async
  /// screens (group / tasting / friend / compare) only mount their director
  /// once their data resolves, so the flag may lag the navigation. Then waits
  /// for it to clear.
  Future<void> _waitUntilIdle({int max = 16000, int armCap = 4000}) async {
    await _wait(400); // let an instant director set busy = true first
    var armed = 0;
    while (mounted && !demoScreenBusy.value && armed < armCap) {
      await _wait(150);
      armed += 150;
    }
    var waited = 0;
    while (mounted && demoScreenBusy.value && waited < max) {
      await _wait(200);
      waited += 200;
    }
  }

  void _cleanup() {
    demoSpotlightId.value = null;
    // Delete the wine the scan demo created so each run starts clean (the
    // scan flow re-creates it next time). Fire-and-forget — the tour is done.
    final createdId = demoCreatedWineId.value;
    if (createdId != null) {
      demoCreatedWineId.value = null;
      unawaited(
        ref.read(wineControllerProvider.notifier).deleteWine(createdId),
      );
    }
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

    // Main screen: highlight the first three wines one after another so the
    // home list reads as a real, browsable collection.
    for (final wine in shown) {
      if (!mounted) return _cleanup();
      demoSpotlightId.value = wine.id;
      await _wait(1300);
    }
    demoSpotlightId.value = null;
    await _wait(400);

    // Scan-to-add (how wines get in) — open the scanner; its director holds
    // on the still viewfinder, runs a mock recognition, and lands on the
    // prefilled add-wine form. pushReplacement → one pop returns home.
    if (!mounted) return _cleanup();
    router.push(AppRoutes.wineScan);
    await _waitUntilIdle(max: 22000);
    if (!mounted) return _cleanup();
    if (router.canPop()) router.pop(); // add-wine form → home
    await _wait(1000);

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

    // Compare — side-by-side of the top two wines (needs at least two).
    if (shown.length >= 2) {
      if (!mounted) return _cleanup();
      router.push(AppRoutes.wineComparePath(shown[0].id, shown[1].id));
      await _waitUntilIdle(max: 18000);
      if (!mounted) return _cleanup();
      if (router.canPop()) router.pop();
      await _wait(1000);
    }

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
    final groups = await _readGroups();
    final cardBeats = groups.isEmpty ? 0 : (groups.length < 2 ? 1 : 2);
    for (var b = 0; b < cardBeats; b++) {
      if (!mounted) return _cleanup();
      demoDetailBeat.value = b;
      await _wait(2200);
    }
    demoDetailBeat.value = null;
    await _wait(500);

    // Group detail (HOST) — open the first group; its director walks
    // members → shared wines → tastings.
    if (groups.isNotEmpty) {
      final groupId = groups.first.id;
      if (!mounted) return _cleanup();
      router.push(AppRoutes.groupDetailPath(groupId));
      await _waitUntilIdle(
        max: 24000,
      ); // sections + carousel browse + rate sheet

      // Tasting (HOST / SHARE) — drill into the group's first tasting. In
      // demo the detail screen renders a curated, self-driving walk through
      // the whole lifecycle regardless of the id, so always enter it (using
      // a sentinel when the group happens to have no tasting) to guarantee
      // the upcoming→live→concluded segment plays.
      final tastingId = await _firstTastingId(groupId);
      if (mounted) {
        router.push(AppRoutes.tastingDetailPath(tastingId ?? 'demo-tasting'));
        await _waitUntilIdle(max: 20000);
        if (!mounted) return _cleanup();
        if (router.canPop()) router.pop(); // tasting → group detail
        await _wait(700);
      }

      if (!mounted) return _cleanup();
      if (router.canPop()) router.pop(); // group detail → groups list
      await _wait(800);
    }

    // Friend taste-match (SHARE) — open the first friend's profile; its
    // director walks identity → taste personality → match % → shared bottles.
    final friendId = await _firstFriendId();
    if (mounted && friendId != null) {
      router.push(AppRoutes.friendProfilePath(friendId));
      await _waitUntilIdle(max: 16000);
      if (!mounted) return _cleanup();
      if (router.canPop()) router.pop();
      await _wait(800);
    }

    // Taste profile (your palate) — tab switch, then open the personality
    // hero and walk its top trait points one at a time. A non-null beat
    // expands the hero; each value highlights the matching trait row.
    if (!mounted) return _cleanup();
    router.go(AppRoutes.profile);
    await _wait(1100);
    demoDetailBeat.value = 0; // expands the hero + highlights the first trait
    await _wait(1700);
    for (var i = 1; i <= 2; i++) {
      if (!mounted) return _cleanup();
      demoDetailBeat.value = i;
      await _wait(1500);
    }
    demoDetailBeat.value = null;
    await _wait(500);

    // Badges (achievements) — open the badge wall; its director browses the
    // grid, fires an unlock celebration, then opens one badge's detail.
    if (!mounted) return _cleanup();
    router.push(AppRoutes.badges);
    await _waitUntilIdle(max: 16000);
    if (!mounted) return _cleanup();
    if (router.canPop()) router.pop();
    await _wait(800);

    // Back home.
    if (!mounted) return _cleanup();
    router.go(AppRoutes.wines);
    await _wait(800);

    _cleanup();
  }

  /// The signed-in user's groups, forcing a load so a freshly opened tab
  /// doesn't report empty. Returns `[]` on any error (offline, etc.).
  Future<List<GroupEntity>> _readGroups() async {
    try {
      return await ref.read(groupControllerProvider.future);
    } catch (_) {
      return const [];
    }
  }

  /// Id of the group's first tasting, or `null` if it has none / load fails.
  Future<String?> _firstTastingId(String groupId) async {
    try {
      final tastings = await ref.read(groupTastingsProvider(groupId).future);
      return tastings.isEmpty ? null : tastings.first.id;
    } catch (_) {
      return null;
    }
  }

  /// Id of the friend to spotlight, or `null` if none / load fails.
  ///
  /// Demo: prefer the curated promo friend "lukas" (clean photos) over
  /// real accounts that carry hand-set placeholder pictures; fall back to
  /// the first friend.
  Future<String?> _firstFriendId() async {
    try {
      final friends = await ref.read(friendsListProvider.future);
      if (friends.isEmpty) return null;
      final preferred = friends.firstWhere(
        (f) => f.username == 'lukas',
        orElse: () => friends.first,
      );
      return preferred.id;
    } catch (_) {
      return null;
    }
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
