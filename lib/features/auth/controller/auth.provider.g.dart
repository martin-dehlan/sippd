// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseClientHash() => r'36e9cae00709545a85bfe4a5a2cb98d8686a01ea';

/// See also [supabaseClient].
@ProviderFor(supabaseClient)
final supabaseClientProvider = AutoDisposeProvider<SupabaseClient>.internal(
  supabaseClient,
  name: r'supabaseClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SupabaseClientRef = AutoDisposeProviderRef<SupabaseClient>;
String _$isAuthenticatedHash() => r'25d3df0d09b9b93551e302f293eea32b5feaaf85';

/// See also [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$currentUserIdHash() => r'2bfbd280d6a4f001a16f0f9cbd9db0dcb9c1798d';

/// See also [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String?>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserIdRef = AutoDisposeProviderRef<String?>;
String _$authControllerHash() => r'c7879fd6cdce7dedd950353eb2b647dbfde7dfcc';

/// See also [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AutoDisposeNotifierProvider<AuthController, AsyncValue<User?>>.internal(
      AuthController.new,
      name: r'authControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthController = AutoDisposeNotifier<AsyncValue<User?>>;
String _$passwordRecoveryControllerHash() =>
    r'122144f66a6ea8a2b3f046cf2c7c33e011deb7a9';

/// See also [PasswordRecoveryController].
@ProviderFor(PasswordRecoveryController)
final passwordRecoveryControllerProvider =
    AutoDisposeNotifierProvider<PasswordRecoveryController, bool>.internal(
      PasswordRecoveryController.new,
      name: r'passwordRecoveryControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$passwordRecoveryControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PasswordRecoveryController = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
