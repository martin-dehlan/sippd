// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupImageServiceHash() => r'8bc48a744f9157c8f5ee9e29a97ea5a8a2e99557';

/// See also [groupImageService].
@ProviderFor(groupImageService)
final groupImageServiceProvider =
    AutoDisposeProvider<GroupImageService>.internal(
      groupImageService,
      name: r'groupImageServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$groupImageServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GroupImageServiceRef = AutoDisposeProviderRef<GroupImageService>;
String _$groupControllerHash() => r'258309d1aee3a525086f262f31f33cc1f68fab24';

/// See also [GroupController].
@ProviderFor(GroupController)
final groupControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      GroupController,
      List<GroupEntity>
    >.internal(
      GroupController.new,
      name: r'groupControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$groupControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GroupController = AutoDisposeAsyncNotifier<List<GroupEntity>>;
String _$groupSortHash() => r'6f24d9bbff6d74dd2831dd22d2b96846c2d3c84c';

/// See also [GroupSort].
@ProviderFor(GroupSort)
final groupSortProvider =
    AutoDisposeNotifierProvider<GroupSort, GroupSortMode>.internal(
      GroupSort.new,
      name: r'groupSortProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$groupSortHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GroupSort = AutoDisposeNotifier<GroupSortMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
