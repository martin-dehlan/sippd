// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goRouterHash() => r'1373e8e6c76b50d9509434738af59bd4ae9ba6bc';

/// See also [goRouter].
@ProviderFor(goRouter)
final goRouterProvider = AutoDisposeProvider<GoRouter>.internal(
  goRouter,
  name: r'goRouterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$goRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoRouterRef = AutoDisposeProviderRef<GoRouter>;
String _$splashDeadlineHash() => r'9d2b0e4eab76ff5fb28eba50e28a16803f236cb7';

/// Flips to true ~1.5s after the user becomes authenticated. Used by the
/// router to optimistically release returning users to /wines when the
/// profile fetch is too slow (e.g. cold-start while offline). Resets on
/// auth changes so a fresh sign-in waits the full window again.
///
/// The timer lives in [_arm] (called from a `ref.listen` outside the
/// build phase) rather than inside `build()` so a future maintainer
/// adding a watched dep can't accidentally spawn duplicate timers.
///
/// Copied from [SplashDeadline].
@ProviderFor(SplashDeadline)
final splashDeadlineProvider =
    AutoDisposeNotifierProvider<SplashDeadline, bool>.internal(
      SplashDeadline.new,
      name: r'splashDeadlineProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$splashDeadlineHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SplashDeadline = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
