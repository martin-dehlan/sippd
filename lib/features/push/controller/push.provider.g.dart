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
String _$pushRegistrationHash() => r'6b7ea8c282818185d0c1ecb2e7a98363c614d570';

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
String _$notificationPrefsApiHash() =>
    r'8ee2707f5a241d5a0a59dee39abaca8bb27522f6';

/// See also [notificationPrefsApi].
@ProviderFor(notificationPrefsApi)
final notificationPrefsApiProvider =
    AutoDisposeProvider<NotificationPrefsApi?>.internal(
      notificationPrefsApi,
      name: r'notificationPrefsApiProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationPrefsApiHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationPrefsApiRef = AutoDisposeProviderRef<NotificationPrefsApi?>;
String _$notificationPrefsRepositoryHash() =>
    r'c7ade37cba2a7a0f1f0346fd47b6ca924edf0058';

/// See also [notificationPrefsRepository].
@ProviderFor(notificationPrefsRepository)
final notificationPrefsRepositoryProvider =
    AutoDisposeProvider<NotificationPrefsRepository>.internal(
      notificationPrefsRepository,
      name: r'notificationPrefsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationPrefsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationPrefsRepositoryRef =
    AutoDisposeProviderRef<NotificationPrefsRepository>;
String _$notificationPrefsControllerHash() =>
    r'94ff2f7853c127631954a573eed3e740a8c88dce';

/// Streams the authenticated user's notification preferences. Emits a defaults
/// entity until the first server sync completes so the UI never has to render
/// a loading state for what is effectively config data.
///
/// Copied from [NotificationPrefsController].
@ProviderFor(NotificationPrefsController)
final notificationPrefsControllerProvider =
    AutoDisposeStreamNotifierProvider<
      NotificationPrefsController,
      NotificationPrefsEntity
    >.internal(
      NotificationPrefsController.new,
      name: r'notificationPrefsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationPrefsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationPrefsController =
    AutoDisposeStreamNotifier<NotificationPrefsEntity>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
