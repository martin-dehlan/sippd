// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileApiHash() => r'c0af34833ebcf4da94f991548bd4fb163206dcbf';

/// See also [profileApi].
@ProviderFor(profileApi)
final profileApiProvider = AutoDisposeProvider<ProfileApi>.internal(
  profileApi,
  name: r'profileApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileApiRef = AutoDisposeProviderRef<ProfileApi>;
String _$profileImageServiceHash() =>
    r'f7910201b413071016c1a0b203b8ec1ffc38cc72';

/// See also [profileImageService].
@ProviderFor(profileImageService)
final profileImageServiceProvider =
    AutoDisposeProvider<ProfileImageService?>.internal(
      profileImageService,
      name: r'profileImageServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileImageServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileImageServiceRef = AutoDisposeProviderRef<ProfileImageService?>;
String _$currentProfileHash() => r'd8f54ef8c34a4f87a81af4ebd1ab0dd1cbae7a38';

/// Local-first profile stream. Drift is the source of truth — the
/// returned stream tracks the cached row so the router and profile UI
/// render immediately on cold start, including offline. A background
/// task pulls the latest from Supabase and writes it back to Drift,
/// which causes the watch stream to emit the fresh value. On network
/// failure the local row is served unchanged.
///
/// Copied from [currentProfile].
@ProviderFor(currentProfile)
final currentProfileProvider =
    AutoDisposeStreamProvider<ProfileEntity?>.internal(
      currentProfile,
      name: r'currentProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentProfileRef = AutoDisposeStreamProviderRef<ProfileEntity?>;
String _$profileSyncedHash() => r'531b9517519b828bcde9364644ef4b9ad1b081e3';

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
///
/// Copied from [ProfileSynced].
@ProviderFor(ProfileSynced)
final profileSyncedProvider =
    AutoDisposeNotifierProvider<ProfileSynced, bool>.internal(
      ProfileSynced.new,
      name: r'profileSyncedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileSyncedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileSynced = AutoDisposeNotifier<bool>;
String _$profileControllerHash() => r'629914082cd0a6d1ac52ef4c51273eb746d5cff5';

/// See also [ProfileController].
@ProviderFor(ProfileController)
final profileControllerProvider =
    AutoDisposeAsyncNotifierProvider<ProfileController, void>.internal(
      ProfileController.new,
      name: r'profileControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
