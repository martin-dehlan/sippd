// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationSearchServiceHash() =>
    r'99c83b70272a7bd6b632fac0af6febcd5c676e2a';

/// See also [locationSearchService].
@ProviderFor(locationSearchService)
final locationSearchServiceProvider =
    AutoDisposeProvider<LocationSearchService>.internal(
      locationSearchService,
      name: r'locationSearchServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$locationSearchServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationSearchServiceRef =
    AutoDisposeProviderRef<LocationSearchService>;
String _$locationSearchControllerHash() =>
    r'90daa64fe82a0f98a542c4ac747ba3df4ae32f98';

/// See also [LocationSearchController].
@ProviderFor(LocationSearchController)
final locationSearchControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      LocationSearchController,
      List<LocationEntity>
    >.internal(
      LocationSearchController.new,
      name: r'locationSearchControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$locationSearchControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LocationSearchController =
    AutoDisposeAsyncNotifier<List<LocationEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
