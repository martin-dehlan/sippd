import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/onboarding/controller/onboarding.provider.dart';

part 'motion.provider.g.dart';

/// A toggleable category of in-app micro-animation. Each maps to one switch
/// in the animation settings screen and gates a set of animation call sites.
enum MotionFeature {
  /// Detail pages fade + slide in when opened.
  screenTransitions,

  /// Cards / lists stagger-fade in.
  listEntrances,

  /// Bottom-nav tab switches cross-fade.
  tabCrossfade,

  /// Numbers count up and bars fill (stats + group rating bars).
  valueAnimations,
}

/// Device-local animation preferences. Defaults to everything on — the app is
/// meant to feel lively; users opt out, not in. Persisted per-device (motion
/// comfort is a device thing), never synced.
class MotionPrefs {
  const MotionPrefs({
    this.master = true,
    this.screenTransitions = true,
    this.listEntrances = true,
    this.tabCrossfade = true,
    this.valueAnimations = true,
  });

  final bool master;
  final bool screenTransitions;
  final bool listEntrances;
  final bool tabCrossfade;
  final bool valueAnimations;

  /// Whether [feature] is enabled — false if the master switch is off.
  bool enabled(MotionFeature feature) {
    if (!master) return false;
    return switch (feature) {
      MotionFeature.screenTransitions => screenTransitions,
      MotionFeature.listEntrances => listEntrances,
      MotionFeature.tabCrossfade => tabCrossfade,
      MotionFeature.valueAnimations => valueAnimations,
    };
  }

  MotionPrefs copyWith({
    bool? master,
    bool? screenTransitions,
    bool? listEntrances,
    bool? tabCrossfade,
    bool? valueAnimations,
  }) => MotionPrefs(
    master: master ?? this.master,
    screenTransitions: screenTransitions ?? this.screenTransitions,
    listEntrances: listEntrances ?? this.listEntrances,
    tabCrossfade: tabCrossfade ?? this.tabCrossfade,
    valueAnimations: valueAnimations ?? this.valueAnimations,
  );
}

const _kMaster = 'motion_master';
const _kScreenTransitions = 'motion_screen_transitions';
const _kListEntrances = 'motion_list_entrances';
const _kTabCrossfade = 'motion_tab_crossfade';
const _kValueAnimations = 'motion_value_animations';

String _prefKey(MotionFeature f) => switch (f) {
  MotionFeature.screenTransitions => _kScreenTransitions,
  MotionFeature.listEntrances => _kListEntrances,
  MotionFeature.tabCrossfade => _kTabCrossfade,
  MotionFeature.valueAnimations => _kValueAnimations,
};

@riverpod
class MotionController extends _$MotionController {
  @override
  MotionPrefs build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return MotionPrefs(
      master: prefs.getBool(_kMaster) ?? true,
      screenTransitions: prefs.getBool(_kScreenTransitions) ?? true,
      listEntrances: prefs.getBool(_kListEntrances) ?? true,
      tabCrossfade: prefs.getBool(_kTabCrossfade) ?? true,
      valueAnimations: prefs.getBool(_kValueAnimations) ?? true,
    );
  }

  Future<void> setMaster(bool value) async {
    await ref.read(sharedPreferencesProvider).setBool(_kMaster, value);
    state = state.copyWith(master: value);
  }

  Future<void> setFeature(MotionFeature feature, bool value) async {
    await ref.read(sharedPreferencesProvider).setBool(_prefKey(feature), value);
    state = switch (feature) {
      MotionFeature.screenTransitions => state.copyWith(
        screenTransitions: value,
      ),
      MotionFeature.listEntrances => state.copyWith(listEntrances: value),
      MotionFeature.tabCrossfade => state.copyWith(tabCrossfade: value),
      MotionFeature.valueAnimations => state.copyWith(valueAnimations: value),
    };
  }
}

/// Single entry point for animation call sites: combines the user's stored
/// preference with the OS "reduce motion" accessibility setting. Use from any
/// `ConsumerWidget` / `ConsumerState`:
///
/// ```dart
/// if (ref.motionOn(MotionFeature.screenTransitions, context)) { ... }
/// ```
extension MotionRefX on WidgetRef {
  /// Build-time check — `watch`es the pref and honours the OS reduce-motion
  /// setting via [MediaQuery]. Use inside `build()`.
  bool motionOn(MotionFeature feature, BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return false;
    return watch(motionControllerProvider).enabled(feature);
  }

  /// Context-free check for `initState` (where there's no reliable
  /// [MediaQuery]). Reads the pref once and honours OS reduce-motion via the
  /// platform dispatcher. Use for one-shot entrance controllers.
  bool motionOnNow(MotionFeature feature) {
    final reduced = WidgetsBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations;
    if (reduced) return false;
    return read(motionControllerProvider).enabled(feature);
  }
}
