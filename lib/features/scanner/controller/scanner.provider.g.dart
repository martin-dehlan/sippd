// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scannerApiHash() => r'92a964743a2922e27b0a3cc63fbb98bfb7ed9f29';

/// See also [scannerApi].
@ProviderFor(scannerApi)
final scannerApiProvider = AutoDisposeProvider<ScannerApi>.internal(
  scannerApi,
  name: r'scannerApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scannerApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ScannerApiRef = AutoDisposeProviderRef<ScannerApi>;
String _$scannerRepositoryHash() => r'1b882d58e9f8640d2311cc6a169e551003cea8af';

/// See also [scannerRepository].
@ProviderFor(scannerRepository)
final scannerRepositoryProvider =
    AutoDisposeProvider<ScannerRepository>.internal(
      scannerRepository,
      name: r'scannerRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scannerRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ScannerRepositoryRef = AutoDisposeProviderRef<ScannerRepository>;
String _$scanQuotaHash() => r'51e9dda1bdc837c02c7dedebe6fe61dd3a406dae';

/// Remaining scans in the rolling window (read-only — does not consume).
/// Powers the "N scans left" badge near the scan entry point.
///
/// Copied from [scanQuota].
@ProviderFor(scanQuota)
final scanQuotaProvider = AutoDisposeFutureProvider<ScanQuotaEntity?>.internal(
  scanQuota,
  name: r'scanQuotaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scanQuotaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ScanQuotaRef = AutoDisposeFutureProviderRef<ScanQuotaEntity?>;
String _$scannerControllerHash() => r'3add4f71a70362b86e19448471c13fd5836d473d';

/// Drives the capture → recognition → result flow. `build` returns null
/// (idle); [scan] transitions loading → data(result) | error.
///
/// Copied from [ScannerController].
@ProviderFor(ScannerController)
final scannerControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      ScannerController,
      ScanResultEntity?
    >.internal(
      ScannerController.new,
      name: r'scannerControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scannerControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScannerController = AutoDisposeAsyncNotifier<ScanResultEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
