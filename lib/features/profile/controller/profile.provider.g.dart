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
String _$currentProfileHash() => r'996922c57154a9e4193f71ff627f6f466a9118da';

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
