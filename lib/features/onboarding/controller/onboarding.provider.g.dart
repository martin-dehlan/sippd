// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'3bcc961a26cc3371119df4825e5d8b958b5511ad';

/// Injected in `main.dart` via a ProviderScope override after
/// SharedPreferences.getInstance() resolves.
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = ProviderRef<SharedPreferences>;
String _$isGuestHash() => r'af6e04aac8290facdbd9f072fb79651a20f068c1';

/// See also [isGuest].
@ProviderFor(isGuest)
final isGuestProvider = AutoDisposeProvider<bool>.internal(
  isGuest,
  name: r'isGuestProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isGuestHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsGuestRef = AutoDisposeProviderRef<bool>;
String _$onboardingSeenHash() => r'befa05251634dc2a96afd7db35e10125267cb05d';

/// See also [onboardingSeen].
@ProviderFor(onboardingSeen)
final onboardingSeenProvider = AutoDisposeProvider<bool>.internal(
  onboardingSeen,
  name: r'onboardingSeenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingSeenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingSeenRef = AutoDisposeProviderRef<bool>;
String _$onboardingControllerHash() =>
    r'6420b5b435bc8e291cc80aebf4f72ca747234c89';

/// See also [OnboardingController].
@ProviderFor(OnboardingController)
final onboardingControllerProvider =
    AutoDisposeNotifierProvider<
      OnboardingController,
      ({bool seen, bool guest})
    >.internal(
      OnboardingController.new,
      name: r'onboardingControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingController = AutoDisposeNotifier<({bool seen, bool guest})>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
