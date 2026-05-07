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

/// Tracks whether we've completed at least one server fetch attempt
/// for the currently-authenticated user. Lets the router distinguish
/// "Drift watch stream emitted null because the row hasn't synced
/// yet on this device" from "server has been asked and confirms the
/// profile is empty (genuine new signup → choose_username)". Without
/// this, the gap between auth flipping true and the first fetch
/// completing produces a chooseUsername flash on every sign-in
/// because the Drift stream emits `null` immediately.
///
/// Resets to `false` whenever auth state changes (sign-in, sign-out)
/// because [build] watches `isAuthenticatedProvider`.
@riverpod
class ProfileSynced extends _$ProfileSynced {
  @override
  bool build() {
    ref.watch(isAuthenticatedProvider);
    return false;
  }

  void confirm() {
    if (state) return;
    state = true;
  }
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

  // Capture the dependencies BEFORE the fire-and-forget runs so the
  // background work can finish even if [ref] is invalidated mid-flight
  // (sign-out, hot reload). Reading providers off a disposed ref
  // throws — the captured api + dao remain valid because they're
  // owned by the wider ProviderContainer.
  final api = ref.read(profileApiProvider);
  final analytics = ref.read(analyticsProvider);
  final syncedNotifier = ref.read(profileSyncedProvider.notifier);

  // Fire-and-forget: pull fresh row + persist. Any error is swallowed
  // (offline, disposed-ref, unexpected) so the consuming UI never
  // throws — the local stream keeps serving the cached row. Synced
  // flag flips true regardless of fresh result so the router can stop
  // holding splash; offline failures release into the existing
  // fallback path rather than trapping the user.
  Future(() async {
    try {
      final fresh = await api.fetchMyProfile();
      if (fresh != null) {
        await dao.upsert(fresh.toTableData());
      }
      try {
        syncedNotifier.confirm();
      } catch (_) {
        // Notifier disposed (sign-out raced the fetch). Safe to
        // ignore — next sign-in rebuilds the provider.
      }
    } catch (e) {
      try {
        syncedNotifier.confirm();
      } catch (_) {
        // see above.
      }
      try {
        analytics.syncFailed('profile_fetch', error: e);
      } catch (_) {
        // Telemetry itself failed — nothing else to do.
      }
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
    final uid = ref.read(supabaseClientProvider).auth.currentUser?.id;
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
