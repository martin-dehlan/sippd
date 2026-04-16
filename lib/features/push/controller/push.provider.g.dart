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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
