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
String _$onboardingSeenHash() => r'82ec9407cfc4aa057e24e48c9684335d6aa76df0';

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
String _$profileSeedPendingHash() =>
    r'96928f22f791f43832d762806f6841c1f87663c3';

/// See also [profileSeedPending].
@ProviderFor(profileSeedPending)
final profileSeedPendingProvider = AutoDisposeProvider<bool>.internal(
  profileSeedPending,
  name: r'profileSeedPendingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileSeedPendingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileSeedPendingRef = AutoDisposeProviderRef<bool>;
String _$onboardingControllerHash() =>
    r'ef76686fed6feb2a6358d2b105cfb2a3338fef22';

/// See also [OnboardingController].
@ProviderFor(OnboardingController)
final onboardingControllerProvider =
    AutoDisposeNotifierProvider<OnboardingController, bool>.internal(
      OnboardingController.new,
      name: r'onboardingControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingController = AutoDisposeNotifier<bool>;
String _$onboardingAnswersControllerHash() =>
    r'4b9e57ca80c20bd6b125e90614833e994d6b030f';

/// Stores quiz answers from onboarding. Also used later from edit_profile
/// so users can adjust level / styles / frequency / goals.
///
/// Copied from [OnboardingAnswersController].
@ProviderFor(OnboardingAnswersController)
final onboardingAnswersControllerProvider =
    AutoDisposeNotifierProvider<
      OnboardingAnswersController,
      OnboardingAnswers
    >.internal(
      OnboardingAnswersController.new,
      name: r'onboardingAnswersControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingAnswersControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingAnswersController = AutoDisposeNotifier<OnboardingAnswers>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
