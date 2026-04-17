// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupDetailHash() => r'e304511963d1d1fcc064a0ea0bbb9981d16b62ba';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [groupDetail].
@ProviderFor(groupDetail)
const groupDetailProvider = GroupDetailFamily();

/// See also [groupDetail].
class GroupDetailFamily extends Family<AsyncValue<GroupEntity?>> {
  /// See also [groupDetail].
  const GroupDetailFamily();

  /// See also [groupDetail].
  GroupDetailProvider call(String groupId) {
    return GroupDetailProvider(groupId);
  }

  @override
  GroupDetailProvider getProviderOverride(
    covariant GroupDetailProvider provider,
  ) {
    return call(provider.groupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupDetailProvider';
}

/// See also [groupDetail].
class GroupDetailProvider extends AutoDisposeFutureProvider<GroupEntity?> {
  /// See also [groupDetail].
  GroupDetailProvider(String groupId)
    : this._internal(
        (ref) => groupDetail(ref as GroupDetailRef, groupId),
        from: groupDetailProvider,
        name: r'groupDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupDetailHash,
        dependencies: GroupDetailFamily._dependencies,
        allTransitiveDependencies: GroupDetailFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  GroupDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    FutureOr<GroupEntity?> Function(GroupDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupDetailProvider._internal(
        (ref) => create(ref as GroupDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GroupEntity?> createElement() {
    return _GroupDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupDetailProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupDetailRef on AutoDisposeFutureProviderRef<GroupEntity?> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupDetailProviderElement
    extends AutoDisposeFutureProviderElement<GroupEntity?>
    with GroupDetailRef {
  _GroupDetailProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupDetailProvider).groupId;
}

String _$groupMembersHash() => r'bab363d1869da151e07bf7f68fc01aa6f5b2ca5d';

/// See also [groupMembers].
@ProviderFor(groupMembers)
const groupMembersProvider = GroupMembersFamily();

/// See also [groupMembers].
class GroupMembersFamily extends Family<AsyncValue<List<FriendProfileEntity>>> {
  /// See also [groupMembers].
  const GroupMembersFamily();

  /// See also [groupMembers].
  GroupMembersProvider call(String groupId) {
    return GroupMembersProvider(groupId);
  }

  @override
  GroupMembersProvider getProviderOverride(
    covariant GroupMembersProvider provider,
  ) {
    return call(provider.groupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupMembersProvider';
}

/// See also [groupMembers].
class GroupMembersProvider
    extends AutoDisposeFutureProvider<List<FriendProfileEntity>> {
  /// See also [groupMembers].
  GroupMembersProvider(String groupId)
    : this._internal(
        (ref) => groupMembers(ref as GroupMembersRef, groupId),
        from: groupMembersProvider,
        name: r'groupMembersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupMembersHash,
        dependencies: GroupMembersFamily._dependencies,
        allTransitiveDependencies:
            GroupMembersFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  GroupMembersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    FutureOr<List<FriendProfileEntity>> Function(GroupMembersRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupMembersProvider._internal(
        (ref) => create(ref as GroupMembersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FriendProfileEntity>> createElement() {
    return _GroupMembersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupMembersProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupMembersRef
    on AutoDisposeFutureProviderRef<List<FriendProfileEntity>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupMembersProviderElement
    extends AutoDisposeFutureProviderElement<List<FriendProfileEntity>>
    with GroupMembersRef {
  _GroupMembersProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupMembersProvider).groupId;
}

String _$groupWineRatingsHash() => r'5ca2bc08e60796894b59ed06322f19759219f401';

/// See also [groupWineRatings].
@ProviderFor(groupWineRatings)
const groupWineRatingsProvider = GroupWineRatingsFamily();

/// See also [groupWineRatings].
class GroupWineRatingsFamily
    extends Family<AsyncValue<List<GroupWineRatingEntity>>> {
  /// See also [groupWineRatings].
  const GroupWineRatingsFamily();

  /// See also [groupWineRatings].
  GroupWineRatingsProvider call(String groupId, String wineId) {
    return GroupWineRatingsProvider(groupId, wineId);
  }

  @override
  GroupWineRatingsProvider getProviderOverride(
    covariant GroupWineRatingsProvider provider,
  ) {
    return call(provider.groupId, provider.wineId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupWineRatingsProvider';
}

/// See also [groupWineRatings].
class GroupWineRatingsProvider
    extends AutoDisposeFutureProvider<List<GroupWineRatingEntity>> {
  /// See also [groupWineRatings].
  GroupWineRatingsProvider(String groupId, String wineId)
    : this._internal(
        (ref) => groupWineRatings(ref as GroupWineRatingsRef, groupId, wineId),
        from: groupWineRatingsProvider,
        name: r'groupWineRatingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupWineRatingsHash,
        dependencies: GroupWineRatingsFamily._dependencies,
        allTransitiveDependencies:
            GroupWineRatingsFamily._allTransitiveDependencies,
        groupId: groupId,
        wineId: wineId,
      );

  GroupWineRatingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
    required this.wineId,
  }) : super.internal();

  final String groupId;
  final String wineId;

  @override
  Override overrideWith(
    FutureOr<List<GroupWineRatingEntity>> Function(GroupWineRatingsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupWineRatingsProvider._internal(
        (ref) => create(ref as GroupWineRatingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
        wineId: wineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<GroupWineRatingEntity>>
  createElement() {
    return _GroupWineRatingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupWineRatingsProvider &&
        other.groupId == groupId &&
        other.wineId == wineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);
    hash = _SystemHash.combine(hash, wineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupWineRatingsRef
    on AutoDisposeFutureProviderRef<List<GroupWineRatingEntity>> {
  /// The parameter `groupId` of this provider.
  String get groupId;

  /// The parameter `wineId` of this provider.
  String get wineId;
}

class _GroupWineRatingsProviderElement
    extends AutoDisposeFutureProviderElement<List<GroupWineRatingEntity>>
    with GroupWineRatingsRef {
  _GroupWineRatingsProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupWineRatingsProvider).groupId;
  @override
  String get wineId => (origin as GroupWineRatingsProvider).wineId;
}

String _$groupWinesHash() => r'43e0acdfda4c4f3b89ed2889c1545ae19e6bf4f3';

/// See also [groupWines].
@ProviderFor(groupWines)
const groupWinesProvider = GroupWinesFamily();

/// See also [groupWines].
class GroupWinesFamily extends Family<AsyncValue<List<WineEntity>>> {
  /// See also [groupWines].
  const GroupWinesFamily();

  /// See also [groupWines].
  GroupWinesProvider call(String groupId) {
    return GroupWinesProvider(groupId);
  }

  @override
  GroupWinesProvider getProviderOverride(
    covariant GroupWinesProvider provider,
  ) {
    return call(provider.groupId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupWinesProvider';
}

/// See also [groupWines].
class GroupWinesProvider extends AutoDisposeFutureProvider<List<WineEntity>> {
  /// See also [groupWines].
  GroupWinesProvider(String groupId)
    : this._internal(
        (ref) => groupWines(ref as GroupWinesRef, groupId),
        from: groupWinesProvider,
        name: r'groupWinesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupWinesHash,
        dependencies: GroupWinesFamily._dependencies,
        allTransitiveDependencies: GroupWinesFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  GroupWinesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    FutureOr<List<WineEntity>> Function(GroupWinesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupWinesProvider._internal(
        (ref) => create(ref as GroupWinesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WineEntity>> createElement() {
    return _GroupWinesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupWinesProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupWinesRef on AutoDisposeFutureProviderRef<List<WineEntity>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupWinesProviderElement
    extends AutoDisposeFutureProviderElement<List<WineEntity>>
    with GroupWinesRef {
  _GroupWinesProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupWinesProvider).groupId;
}

String _$groupControllerHash() => r'591047af0a8eb4fbe8e13f3313eb64c6247c561e';

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
String _$groupWineRatingControllerHash() =>
    r'56a6c9e0684728ae50f766e48f38521e5c33cf1a';

/// See also [GroupWineRatingController].
@ProviderFor(GroupWineRatingController)
final groupWineRatingControllerProvider =
    AutoDisposeAsyncNotifierProvider<GroupWineRatingController, void>.internal(
      GroupWineRatingController.new,
      name: r'groupWineRatingControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$groupWineRatingControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GroupWineRatingController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
