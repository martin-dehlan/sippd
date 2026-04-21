import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding.provider.g.dart';

const _onboardingSeenKey = 'onboarding_seen';
const _guestModeKey      = 'guest_mode';

/// Injected in `main.dart` via a ProviderScope override after
/// SharedPreferences.getInstance() resolves.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) =>
    throw UnimplementedError('Override sharedPreferencesProvider in main().');

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  ({bool seen, bool guest}) build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return (
      seen: prefs.getBool(_onboardingSeenKey) ?? false,
      guest: prefs.getBool(_guestModeKey) ?? false,
    );
  }

  Future<void> markSeen() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_onboardingSeenKey, true);
    state = (seen: true, guest: state.guest);
  }

  Future<void> enterGuest() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_onboardingSeenKey, true);
    await prefs.setBool(_guestModeKey, true);
    state = (seen: true, guest: true);
  }

  Future<void> exitGuest() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_guestModeKey, false);
    state = (seen: state.seen, guest: false);
  }
}

@riverpod
bool isGuest(IsGuestRef ref) =>
    ref.watch(onboardingControllerProvider).guest;

@riverpod
bool onboardingSeen(OnboardingSeenRef ref) =>
    ref.watch(onboardingControllerProvider).seen;
