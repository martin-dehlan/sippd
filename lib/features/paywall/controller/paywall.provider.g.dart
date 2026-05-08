// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paywall.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paywallHash() => r'eecf5e17932d99d579a4cef913a6cba8ff91040c';

/// See also [paywall].
@ProviderFor(paywall)
final paywallProvider = Provider<PaywallService>.internal(
  paywall,
  name: r'paywallProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paywallHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PaywallRef = ProviderRef<PaywallService>;
String _$customerInfoStreamHash() =>
    r'f7658b641d819b7cf00e7055a7d97d8e26543afe';

/// See also [customerInfoStream].
@ProviderFor(customerInfoStream)
final customerInfoStreamProvider = StreamProvider<CustomerInfo>.internal(
  customerInfoStream,
  name: r'customerInfoStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerInfoStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomerInfoStreamRef = StreamProviderRef<CustomerInfo>;
String _$isProHash() => r'a058ce98d1c8bda1d6713b2c8e3ef683785d2088';

/// See also [isPro].
@ProviderFor(isPro)
final isProProvider = AutoDisposeProvider<bool>.internal(
  isPro,
  name: r'isProProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isProHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsProRef = AutoDisposeProviderRef<bool>;
String _$paywallOfferingsHash() => r'c0e27c0b80df6619087adac3512729b6ac540baa';

/// See also [paywallOfferings].
@ProviderFor(paywallOfferings)
final paywallOfferingsProvider = AutoDisposeFutureProvider<Offerings?>.internal(
  paywallOfferings,
  name: r'paywallOfferingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paywallOfferingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PaywallOfferingsRef = AutoDisposeFutureProviderRef<Offerings?>;
String _$currentCustomerInfoHash() =>
    r'bbe5e4aa42c2e8b308e6b2ff5ed56e3eec3d557d';

/// Latest CustomerInfo, preferring stream values for liveness but
/// falling back to the service's cached snapshot so screens that
/// mount after the broadcast stream's initial emit still get a value.
///
/// Copied from [currentCustomerInfo].
@ProviderFor(currentCustomerInfo)
final currentCustomerInfoProvider = AutoDisposeProvider<CustomerInfo?>.internal(
  currentCustomerInfo,
  name: r'currentCustomerInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentCustomerInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentCustomerInfoRef = AutoDisposeProviderRef<CustomerInfo?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
