import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/controller/auth.provider.dart';
import '../../profile/controller/profile.provider.dart';
import '../../profile/domain/entities/profile.entity.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../domain/onboarding_answers.dart';

part 'onboarding.provider.g.dart';

const _onboardingSeenKey = 'onboarding_seen';
const _onboardingAnswersKey = 'onboarding_answers';
const _profileSeedPendingKey = 'onboarding_profile_seed_pending';

/// Injected in `main.dart` via a ProviderScope override after
/// SharedPreferences.getInstance() resolves.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) =>
    throw UnimplementedError('Override sharedPreferencesProvider in main().');

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_onboardingSeenKey) ?? false;
  }

  Future<void> markSeen() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_onboardingSeenKey, true);
    state = true;
  }
}

@riverpod
bool onboardingSeen(OnboardingSeenRef ref) =>
    ref.watch(onboardingControllerProvider);

/// Stores quiz answers from onboarding. Also used later from edit_profile
/// so users can adjust level / styles / frequency / goals.
///
/// Source of truth:
///  - Pre-auth: SharedPreferences buffer.
///  - Post-auth: Supabase profile row. The buffer is bypassed so taste
///    answers survive reinstalls (cross-device) and don't leak between
///    accounts on the same device.
@riverpod
class OnboardingAnswersController extends _$OnboardingAnswersController {
  @override
  OnboardingAnswers build() {
    final authed = ref.watch(isAuthenticatedProvider);
    if (authed) {
      final profile = ref.watch(currentProfileProvider).valueOrNull;
      if (profile != null && profile.hasTasteData) {
        return profile.toOnboardingAnswers();
      }
    }
    return _readPrefs();
  }

  OnboardingAnswers _readPrefs() {
    final prefs = ref.read(sharedPreferencesProvider);
    final raw = prefs.getString(_onboardingAnswersKey);
    if (raw == null) return const OnboardingAnswers();
    try {
      return OnboardingAnswers.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return const OnboardingAnswers();
    }
  }

  Future<void> _persist(OnboardingAnswers next) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_onboardingAnswersKey, jsonEncode(next.toJson()));
    state = next;
  }

  /// When authed, writes flow through the profile API; profile stream
  /// re-emits and `build()` returns the new server state. Pre-auth, writes
  /// stay in the SharedPreferences buffer.
  Future<void> _save(OnboardingAnswers next) async {
    if (ref.read(isAuthenticatedProvider)) {
      // Optimistic UI: update state immediately so editors don't lag the
      // network round-trip. The profile stream will re-emit shortly with
      // the canonical server values.
      state = next;
      try {
        await ref
            .read(profileControllerProvider.notifier)
            .updateTasteProfile(next);
      } catch (_) {
        // On failure leave optimistic state in place; the next profile
        // stream tick will reconcile.
      }
    } else {
      await _persist(next);
    }
  }

  Future<void> setTasteLevel(TasteLevel level) =>
      _save(state.copyWith(tasteLevel: level));

  Future<void> setFrequency(DrinkFrequency f) =>
      _save(state.copyWith(frequency: f));

  Future<void> toggleGoal(OnboardingGoal g) {
    final next = {...state.goals};
    next.contains(g) ? next.remove(g) : next.add(g);
    return _save(state.copyWith(goals: next));
  }

  Future<void> setGoals(Set<OnboardingGoal> goals) =>
      _save(state.copyWith(goals: goals));

  Future<void> toggleStyle(WineType t) {
    final next = {...state.styles};
    next.contains(t) ? next.remove(t) : next.add(t);
    return _save(state.copyWith(styles: next));
  }

  Future<void> setStyles(Set<WineType> styles) =>
      _save(state.copyWith(styles: styles));

  /// Display name + emoji are only edited inside the funnel; post-auth
  /// edits use the dedicated edit-profile screen. Always written to the
  /// SharedPreferences buffer so the post-signup seed picks them up.
  Future<void> setName({String? displayName, String? emoji}) => _persist(
    state.copyWith(
      displayName: displayName ?? state.displayName,
      emoji: emoji ?? state.emoji,
    ),
  );

  Future<void> markNotificationsAsked() =>
      _persist(state.copyWith(notificationsAsked: true));

  /// Marks the SharedPreferences buffer as needing to be flushed into the
  /// new account's profile on next authenticated run. The seeder in
  /// choose_username clears this flag after applying.
  Future<void> markProfileSeedPending() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_profileSeedPendingKey, true);
  }

  Future<void> clearProfileSeedPending() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_profileSeedPendingKey, false);
  }
}

@riverpod
bool profileSeedPending(ProfileSeedPendingRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(_profileSeedPendingKey) ?? false;
}
