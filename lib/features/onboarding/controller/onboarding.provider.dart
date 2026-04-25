import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
@riverpod
class OnboardingAnswersController extends _$OnboardingAnswersController {
  @override
  OnboardingAnswers build() {
    final prefs = ref.watch(sharedPreferencesProvider);
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

  Future<void> setTasteLevel(TasteLevel level) =>
      _persist(state.copyWith(tasteLevel: level));

  Future<void> setFrequency(DrinkFrequency f) =>
      _persist(state.copyWith(frequency: f));

  Future<void> toggleGoal(OnboardingGoal g) {
    final next = {...state.goals};
    next.contains(g) ? next.remove(g) : next.add(g);
    return _persist(state.copyWith(goals: next));
  }

  Future<void> setGoals(Set<OnboardingGoal> goals) =>
      _persist(state.copyWith(goals: goals));

  Future<void> toggleStyle(WineType t) {
    final next = {...state.styles};
    next.contains(t) ? next.remove(t) : next.add(t);
    return _persist(state.copyWith(styles: next));
  }

  Future<void> setStyles(Set<WineType> styles) =>
      _persist(state.copyWith(styles: styles));

  Future<void> setName({String? displayName, String? emoji}) => _persist(
    state.copyWith(
      displayName: displayName ?? state.displayName,
      emoji: emoji ?? state.emoji,
    ),
  );

  Future<void> markNotificationsAsked() =>
      _persist(state.copyWith(notificationsAsked: true));

  /// Mark displayName/emoji as needing to seed the Supabase profile on next
  /// authenticated run. The seeder clears this flag after applying.
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
