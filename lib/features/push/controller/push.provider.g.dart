// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fcmServiceHash() => r'7d21e59493054604c0941df97de08906b6afa844';

/// See also [fcmService].
@ProviderFor(fcmService)
final fcmServiceProvider = Provider<FcmService>.internal(
  fcmService,
  name: r'fcmServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fcmServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FcmServiceRef = ProviderRef<FcmService>;
String _$pushRegistrationHash() => r'54899fecfe16db841108b97de31452dd56f42740';

/// Kicks off FCM token registration whenever we have an authenticated user.
/// Keep-alive so it runs for the lifetime of the app.
///
/// Copied from [pushRegistration].
@ProviderFor(pushRegistration)
final pushRegistrationProvider = FutureProvider<void>.internal(
  pushRegistration,
  name: r'pushRegistrationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pushRegistrationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PushRegistrationRef = FutureProviderRef<void>;
String _$pushHandlerHash() => r'10c1da847f21c8b5f7a4f642a61c1c8cd9c88b7d';

/// See also [pushHandler].
@ProviderFor(pushHandler)
final pushHandlerProvider = Provider<PushHandlerService>.internal(
  pushHandler,
  name: r'pushHandlerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pushHandlerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PushHandlerRef = ProviderRef<PushHandlerService>;
String _$pushTapsHash() => r'5d0bf60f9163dd93888f549a7b95bb18971d465d';

/// See also [pushTaps].
@ProviderFor(pushTaps)
final pushTapsProvider = StreamProvider<RemoteMessage>.internal(
  pushTaps,
  name: r'pushTapsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pushTapsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PushTapsRef = StreamProviderRef<RemoteMessage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
