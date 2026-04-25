import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../../onboarding/domain/onboarding_answers.dart';
import '../data/data_sources/profile.api.dart';
import '../data/data_sources/profile_image.service.dart';
import '../data/models/profile.model.dart';
import '../domain/entities/profile.entity.dart';

part 'profile.provider.g.dart';

@riverpod
ProfileApi profileApi(ProfileApiRef ref) {
  return ProfileApi(ref.watch(supabaseClientProvider));
}

@riverpod
ProfileImageService? profileImageService(ProfileImageServiceRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  return ProfileImageService(ref.watch(supabaseClientProvider));
}

@riverpod
Stream<ProfileEntity?> currentProfile(CurrentProfileRef ref) {
  final authed = ref.watch(isAuthenticatedProvider);
  if (!authed) {
    return Stream.value(null);
  }
  return ref
      .watch(profileApiProvider)
      .watchMyProfile()
      .map((m) => m?.toEntity());
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<void> build() {}

  Future<bool> isAvailable(String username) {
    return ref.read(profileApiProvider).isUsernameAvailable(username);
  }

  Future<void> setUsername(String username) async {
    await ref.read(profileApiProvider).updateUsername(username);
    ref.invalidate(currentProfileProvider);
  }

  Future<void> setDisplayName(String? displayName) async {
    final clean = displayName?.trim();
    await ref
        .read(profileApiProvider)
        .updateDisplayName(clean == null || clean.isEmpty ? null : clean);
    ref.invalidate(currentProfileProvider);
  }

  Future<void> setAvatarUrl(String? avatarUrl) async {
    await ref.read(profileApiProvider).updateAvatarUrl(avatarUrl);
    ref.invalidate(currentProfileProvider);
  }

  Future<void> markOnboardingCompleted() async {
    await ref.read(profileApiProvider).markOnboardingCompleted();
    ref.invalidate(currentProfileProvider);
  }

  /// Atomic write of all onboarding outputs. Single invalidate at the end so
  /// the router only refreshes once with the final consistent profile state
  /// (username + onboarding_completed both true), preventing the Gate-2b
  /// flicker that would briefly redirect to /onboarding.
  Future<void> seedFromOnboarding({
    required String username,
    String? displayName,
    required OnboardingAnswers answers,
  }) async {
    await ref.read(profileApiProvider).seedProfileFromOnboarding(
          username: username,
          displayName: displayName,
          answers: answers,
        );
    ref.invalidate(currentProfileProvider);
  }

  Future<void> updateTasteProfile(OnboardingAnswers answers) async {
    await ref.read(profileApiProvider).updateTasteProfile(answers);
    ref.invalidate(currentProfileProvider);
  }

  Future<void> deleteAccount() async {
    await ref.read(profileApiProvider).deleteMyAccount();
    // Server cascade wiped data. Route sign-out through AuthController so
    // the onboarding SharedPreferences buffer is cleared too — otherwise
    // a deleted account's taste answers would leak to the next user on
    // this device.
    await ref.read(authControllerProvider.notifier).signOut();
  }
}
