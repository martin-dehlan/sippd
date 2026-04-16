// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$openFoodFactsApiHash() => r'9aa87a1ef27dbd1c4e75e978f6d9e30309bedddf';

/// See also [openFoodFactsApi].
@ProviderFor(openFoodFactsApi)
final openFoodFactsApiProvider = AutoDisposeProvider<OpenFoodFactsApi>.internal(
  openFoodFactsApi,
  name: r'openFoodFactsApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$openFoodFactsApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OpenFoodFactsApiRef = AutoDisposeProviderRef<OpenFoodFactsApi>;
String _$scannerControllerHash() => r'bef4cc868ca1bdf4d1d323802e55e4c06ee950f3';

/// See also [ScannerController].
@ProviderFor(ScannerController)
final scannerControllerProvider =
    AutoDisposeNotifierProvider<
      ScannerController,
      AsyncValue<ScannedWineData?>
    >.internal(
      ScannerController.new,
      name: r'scannerControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scannerControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScannerController = AutoDisposeNotifier<AsyncValue<ScannedWineData?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
