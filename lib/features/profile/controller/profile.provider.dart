import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/services/analytics/analytics.provider.dart';
import '../../auth/controller/auth.provider.dart';
import '../../onboarding/domain/onboarding_answers.dart';
import '../../wines/controller/wine.provider.dart';
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

/// Local-first profile stream. Drift is the source of truth — the
/// returned stream tracks the cached row so the router and profile UI
/// render immediately on cold start, including offline. A background
/// task pulls the latest from Supabase and writes it back to Drift,
/// which causes the watch stream to emit the fresh value. On network
/// failure the local row is served unchanged.
@riverpod
Stream<ProfileEntity?> currentProfile(CurrentProfileRef ref) {
  final authed = ref.watch(isAuthenticatedProvider);
  if (!authed) return Stream.value(null);

  final client = ref.watch(supabaseClientProvider);
  final uid = client.auth.currentUser?.id;
  if (uid == null) return Stream.value(null);

  final dao = ref.watch(appDatabaseProvider).profilesDao;

  // Fire-and-forget: pull fresh row + persist. Errors are swallowed so
  // offline / slow networks never throw on the consuming UI; the local
  // stream keeps serving the cached row.
  Future(() async {
    try {
      final fresh = await ref.read(profileApiProvider).fetchMyProfile();
      if (fresh != null) {
        await dao.upsert(fresh.toTableData());
      }
    } catch (e) {
      ref.read(analyticsProvider).syncFailed('profile_fetch', error: e);
    }
  });

  return dao.watchById(uid).map((row) => row?.toModel().toEntity());
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<void> build() {}

  Future<bool> isAvailable(String username) {
    return ref.read(profileApiProvider).isUsernameAvailable(username);
  }

  /// Refetches the row from Supabase and writes it to Drift. The
  /// [currentProfileProvider] watch stream emits the new value
  /// automatically — no [Ref.invalidate] needed (which would tear down
  /// the stream and momentarily yield stale data).
  Future<void> _syncBack() async {
    final fresh = await ref.read(profileApiProvider).fetchMyProfile();
    if (fresh != null) {
      await ref
          .read(appDatabaseProvider)
          .profilesDao
          .upsert(fresh.toTableData());
    }
  }

  Future<void> setUsername(String username) async {
    await ref.read(profileApiProvider).updateUsername(username);
    await _syncBack();
  }

  Future<void> setDisplayName(String? displayName) async {
    final clean = displayName?.trim();
    await ref
        .read(profileApiProvider)
        .updateDisplayName(clean == null || clean.isEmpty ? null : clean);
    await _syncBack();
  }

  Future<void> setAvatarUrl(String? avatarUrl) async {
    await ref.read(profileApiProvider).updateAvatarUrl(avatarUrl);
    await _syncBack();
  }

  Future<void> markOnboardingCompleted() async {
    await ref.read(profileApiProvider).markOnboardingCompleted();
    await _syncBack();
  }

  /// Atomic write of all onboarding outputs. Single sync-back at the end
  /// so the watch stream only emits once with the final consistent
  /// profile state (username + onboarding_completed both true),
  /// preventing the Gate-2b flicker that would briefly redirect to
  /// /onboarding.
  Future<void> seedFromOnboarding({
    required String username,
    String? displayName,
    required OnboardingAnswers answers,
  }) async {
    await ref
        .read(profileApiProvider)
        .seedProfileFromOnboarding(
          username: username,
          displayName: displayName,
          answers: answers,
        );
    await _syncBack();
  }

  Future<void> updateTasteProfile(OnboardingAnswers answers) async {
    await ref.read(profileApiProvider).updateTasteProfile(answers);
    await _syncBack();
  }

  Future<void> deleteAccount() async {
    final uid =
        ref.read(supabaseClientProvider).auth.currentUser?.id;
    await ref.read(profileApiProvider).deleteMyAccount();
    if (uid != null) {
      await ref.read(appDatabaseProvider).profilesDao.deleteById(uid);
    }
    // Server cascade wiped data. Route sign-out through AuthController so
    // the onboarding SharedPreferences buffer is cleared too — otherwise
    // a deleted account's taste answers would leak to the next user on
    // this device.
    await ref.read(authControllerProvider.notifier).signOut();
  }
}
