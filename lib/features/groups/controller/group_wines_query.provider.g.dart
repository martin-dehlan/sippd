// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_wines_query.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupDetailHash() => r'e7d69445f8a4146b2fb0db49681acd9741b7c751';

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

/// Single group's metadata. Network-only — the list provider has the
/// realtime invalidation hook, this is just a one-off lookup.
///
/// Copied from [groupDetail].
@ProviderFor(groupDetail)
const groupDetailProvider = GroupDetailFamily();

/// Single group's metadata. Network-only — the list provider has the
/// realtime invalidation hook, this is just a one-off lookup.
///
/// Copied from [groupDetail].
class GroupDetailFamily extends Family<AsyncValue<GroupEntity?>> {
  /// Single group's metadata. Network-only — the list provider has the
  /// realtime invalidation hook, this is just a one-off lookup.
  ///
  /// Copied from [groupDetail].
  const GroupDetailFamily();

  /// Single group's metadata. Network-only — the list provider has the
  /// realtime invalidation hook, this is just a one-off lookup.
  ///
  /// Copied from [groupDetail].
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

/// Single group's metadata. Network-only — the list provider has the
/// realtime invalidation hook, this is just a one-off lookup.
///
/// Copied from [groupDetail].
class GroupDetailProvider extends AutoDisposeFutureProvider<GroupEntity?> {
  /// Single group's metadata. Network-only — the list provider has the
  /// realtime invalidation hook, this is just a one-off lookup.
  ///
  /// Copied from [groupDetail].
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

String _$groupMembersHash() => r'6523dfbe588589e0e2c7511567fefb4fbcca7643';

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

String _$groupWinesHash() => r'719bf0766593e3a04aad240ef287399842e02169';

/// Wines shared into [groupId]. Returned entities are catalog-keyed:
/// `id` is the canonical_wine.id and `userId` is the original sharer
/// (so downstream can compute "is owner"). Personal log fields (rating,
/// notes, photos) come from the local `wines` mirror when the caller
/// owns the bottle, otherwise from the canonical_wine catalog.
///
/// Copied from [groupWines].
@ProviderFor(groupWines)
const groupWinesProvider = GroupWinesFamily();

/// Wines shared into [groupId]. Returned entities are catalog-keyed:
/// `id` is the canonical_wine.id and `userId` is the original sharer
/// (so downstream can compute "is owner"). Personal log fields (rating,
/// notes, photos) come from the local `wines` mirror when the caller
/// owns the bottle, otherwise from the canonical_wine catalog.
///
/// Copied from [groupWines].
class GroupWinesFamily extends Family<AsyncValue<List<WineEntity>>> {
  /// Wines shared into [groupId]. Returned entities are catalog-keyed:
  /// `id` is the canonical_wine.id and `userId` is the original sharer
  /// (so downstream can compute "is owner"). Personal log fields (rating,
  /// notes, photos) come from the local `wines` mirror when the caller
  /// owns the bottle, otherwise from the canonical_wine catalog.
  ///
  /// Copied from [groupWines].
  const GroupWinesFamily();

  /// Wines shared into [groupId]. Returned entities are catalog-keyed:
  /// `id` is the canonical_wine.id and `userId` is the original sharer
  /// (so downstream can compute "is owner"). Personal log fields (rating,
  /// notes, photos) come from the local `wines` mirror when the caller
  /// owns the bottle, otherwise from the canonical_wine catalog.
  ///
  /// Copied from [groupWines].
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

/// Wines shared into [groupId]. Returned entities are catalog-keyed:
/// `id` is the canonical_wine.id and `userId` is the original sharer
/// (so downstream can compute "is owner"). Personal log fields (rating,
/// notes, photos) come from the local `wines` mirror when the caller
/// owns the bottle, otherwise from the canonical_wine catalog.
///
/// Copied from [groupWines].
class GroupWinesProvider extends AutoDisposeFutureProvider<List<WineEntity>> {
  /// Wines shared into [groupId]. Returned entities are catalog-keyed:
  /// `id` is the canonical_wine.id and `userId` is the original sharer
  /// (so downstream can compute "is owner"). Personal log fields (rating,
  /// notes, photos) come from the local `wines` mirror when the caller
  /// owns the bottle, otherwise from the canonical_wine catalog.
  ///
  /// Copied from [groupWines].
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

String _$groupWineShareMetaHash() =>
    r'673948050ad36cd61dcb9ebaa8229edc0b60d5d5';

/// Returns who originally shared [canonicalWineId] into [groupId].
/// Used to decide who can unshare it (sharer + group owner).
///
/// Copied from [groupWineShareMeta].
@ProviderFor(groupWineShareMeta)
const groupWineShareMetaProvider = GroupWineShareMetaFamily();

/// Returns who originally shared [canonicalWineId] into [groupId].
/// Used to decide who can unshare it (sharer + group owner).
///
/// Copied from [groupWineShareMeta].
class GroupWineShareMetaFamily extends Family<AsyncValue<String?>> {
  /// Returns who originally shared [canonicalWineId] into [groupId].
  /// Used to decide who can unshare it (sharer + group owner).
  ///
  /// Copied from [groupWineShareMeta].
  const GroupWineShareMetaFamily();

  /// Returns who originally shared [canonicalWineId] into [groupId].
  /// Used to decide who can unshare it (sharer + group owner).
  ///
  /// Copied from [groupWineShareMeta].
  GroupWineShareMetaProvider call(String groupId, String canonicalWineId) {
    return GroupWineShareMetaProvider(groupId, canonicalWineId);
  }

  @override
  GroupWineShareMetaProvider getProviderOverride(
    covariant GroupWineShareMetaProvider provider,
  ) {
    return call(provider.groupId, provider.canonicalWineId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupWineShareMetaProvider';
}

/// Returns who originally shared [canonicalWineId] into [groupId].
/// Used to decide who can unshare it (sharer + group owner).
///
/// Copied from [groupWineShareMeta].
class GroupWineShareMetaProvider extends AutoDisposeFutureProvider<String?> {
  /// Returns who originally shared [canonicalWineId] into [groupId].
  /// Used to decide who can unshare it (sharer + group owner).
  ///
  /// Copied from [groupWineShareMeta].
  GroupWineShareMetaProvider(String groupId, String canonicalWineId)
    : this._internal(
        (ref) => groupWineShareMeta(
          ref as GroupWineShareMetaRef,
          groupId,
          canonicalWineId,
        ),
        from: groupWineShareMetaProvider,
        name: r'groupWineShareMetaProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupWineShareMetaHash,
        dependencies: GroupWineShareMetaFamily._dependencies,
        allTransitiveDependencies:
            GroupWineShareMetaFamily._allTransitiveDependencies,
        groupId: groupId,
        canonicalWineId: canonicalWineId,
      );

  GroupWineShareMetaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
    required this.canonicalWineId,
  }) : super.internal();

  final String groupId;
  final String canonicalWineId;

  @override
  Override overrideWith(
    FutureOr<String?> Function(GroupWineShareMetaRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupWineShareMetaProvider._internal(
        (ref) => create(ref as GroupWineShareMetaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
        canonicalWineId: canonicalWineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _GroupWineShareMetaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupWineShareMetaProvider &&
        other.groupId == groupId &&
        other.canonicalWineId == canonicalWineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);
    hash = _SystemHash.combine(hash, canonicalWineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupWineShareMetaRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `groupId` of this provider.
  String get groupId;

  /// The parameter `canonicalWineId` of this provider.
  String get canonicalWineId;
}

class _GroupWineShareMetaProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with GroupWineShareMetaRef {
  _GroupWineShareMetaProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupWineShareMetaProvider).groupId;
  @override
  String get canonicalWineId =>
      (origin as GroupWineShareMetaProvider).canonicalWineId;
}

String _$groupWineShareDetailsHash() =>
    r'9d2c3844c9a2926187419de18827837b4ef4827f';

/// Sharer profile + when the bottle was shared into [groupId]. Used by
/// the group wine detail screen to show "shared by @user · X ago".
///
/// Copied from [groupWineShareDetails].
@ProviderFor(groupWineShareDetails)
const groupWineShareDetailsProvider = GroupWineShareDetailsFamily();

/// Sharer profile + when the bottle was shared into [groupId]. Used by
/// the group wine detail screen to show "shared by @user · X ago".
///
/// Copied from [groupWineShareDetails].
class GroupWineShareDetailsFamily
    extends Family<AsyncValue<GroupWineShareEntity?>> {
  /// Sharer profile + when the bottle was shared into [groupId]. Used by
  /// the group wine detail screen to show "shared by @user · X ago".
  ///
  /// Copied from [groupWineShareDetails].
  const GroupWineShareDetailsFamily();

  /// Sharer profile + when the bottle was shared into [groupId]. Used by
  /// the group wine detail screen to show "shared by @user · X ago".
  ///
  /// Copied from [groupWineShareDetails].
  GroupWineShareDetailsProvider call(String groupId, String canonicalWineId) {
    return GroupWineShareDetailsProvider(groupId, canonicalWineId);
  }

  @override
  GroupWineShareDetailsProvider getProviderOverride(
    covariant GroupWineShareDetailsProvider provider,
  ) {
    return call(provider.groupId, provider.canonicalWineId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupWineShareDetailsProvider';
}

/// Sharer profile + when the bottle was shared into [groupId]. Used by
/// the group wine detail screen to show "shared by @user · X ago".
///
/// Copied from [groupWineShareDetails].
class GroupWineShareDetailsProvider
    extends AutoDisposeFutureProvider<GroupWineShareEntity?> {
  /// Sharer profile + when the bottle was shared into [groupId]. Used by
  /// the group wine detail screen to show "shared by @user · X ago".
  ///
  /// Copied from [groupWineShareDetails].
  GroupWineShareDetailsProvider(String groupId, String canonicalWineId)
    : this._internal(
        (ref) => groupWineShareDetails(
          ref as GroupWineShareDetailsRef,
          groupId,
          canonicalWineId,
        ),
        from: groupWineShareDetailsProvider,
        name: r'groupWineShareDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupWineShareDetailsHash,
        dependencies: GroupWineShareDetailsFamily._dependencies,
        allTransitiveDependencies:
            GroupWineShareDetailsFamily._allTransitiveDependencies,
        groupId: groupId,
        canonicalWineId: canonicalWineId,
      );

  GroupWineShareDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
    required this.canonicalWineId,
  }) : super.internal();

  final String groupId;
  final String canonicalWineId;

  @override
  Override overrideWith(
    FutureOr<GroupWineShareEntity?> Function(GroupWineShareDetailsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupWineShareDetailsProvider._internal(
        (ref) => create(ref as GroupWineShareDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
        canonicalWineId: canonicalWineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GroupWineShareEntity?> createElement() {
    return _GroupWineShareDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupWineShareDetailsProvider &&
        other.groupId == groupId &&
        other.canonicalWineId == canonicalWineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);
    hash = _SystemHash.combine(hash, canonicalWineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupWineShareDetailsRef
    on AutoDisposeFutureProviderRef<GroupWineShareEntity?> {
  /// The parameter `groupId` of this provider.
  String get groupId;

  /// The parameter `canonicalWineId` of this provider.
  String get canonicalWineId;
}

class _GroupWineShareDetailsProviderElement
    extends AutoDisposeFutureProviderElement<GroupWineShareEntity?>
    with GroupWineShareDetailsRef {
  _GroupWineShareDetailsProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupWineShareDetailsProvider).groupId;
  @override
  String get canonicalWineId =>
      (origin as GroupWineShareDetailsProvider).canonicalWineId;
}

String _$groupsContainingWineHash() =>
    r'0839de6bfbd661f1fca36071b7668e67452a7b6e';

/// Set of group IDs that already contain the canonical bottle for
/// the personal wine [wineId]. Used by the share sheet to mark groups
/// that already received this wine.
///
/// Copied from [groupsContainingWine].
@ProviderFor(groupsContainingWine)
const groupsContainingWineProvider = GroupsContainingWineFamily();

/// Set of group IDs that already contain the canonical bottle for
/// the personal wine [wineId]. Used by the share sheet to mark groups
/// that already received this wine.
///
/// Copied from [groupsContainingWine].
class GroupsContainingWineFamily extends Family<AsyncValue<Set<String>>> {
  /// Set of group IDs that already contain the canonical bottle for
  /// the personal wine [wineId]. Used by the share sheet to mark groups
  /// that already received this wine.
  ///
  /// Copied from [groupsContainingWine].
  const GroupsContainingWineFamily();

  /// Set of group IDs that already contain the canonical bottle for
  /// the personal wine [wineId]. Used by the share sheet to mark groups
  /// that already received this wine.
  ///
  /// Copied from [groupsContainingWine].
  GroupsContainingWineProvider call(String wineId) {
    return GroupsContainingWineProvider(wineId);
  }

  @override
  GroupsContainingWineProvider getProviderOverride(
    covariant GroupsContainingWineProvider provider,
  ) {
    return call(provider.wineId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupsContainingWineProvider';
}

/// Set of group IDs that already contain the canonical bottle for
/// the personal wine [wineId]. Used by the share sheet to mark groups
/// that already received this wine.
///
/// Copied from [groupsContainingWine].
class GroupsContainingWineProvider
    extends AutoDisposeFutureProvider<Set<String>> {
  /// Set of group IDs that already contain the canonical bottle for
  /// the personal wine [wineId]. Used by the share sheet to mark groups
  /// that already received this wine.
  ///
  /// Copied from [groupsContainingWine].
  GroupsContainingWineProvider(String wineId)
    : this._internal(
        (ref) => groupsContainingWine(ref as GroupsContainingWineRef, wineId),
        from: groupsContainingWineProvider,
        name: r'groupsContainingWineProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupsContainingWineHash,
        dependencies: GroupsContainingWineFamily._dependencies,
        allTransitiveDependencies:
            GroupsContainingWineFamily._allTransitiveDependencies,
        wineId: wineId,
      );

  GroupsContainingWineProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wineId,
  }) : super.internal();

  final String wineId;

  @override
  Override overrideWith(
    FutureOr<Set<String>> Function(GroupsContainingWineRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupsContainingWineProvider._internal(
        (ref) => create(ref as GroupsContainingWineRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wineId: wineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Set<String>> createElement() {
    return _GroupsContainingWineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupsContainingWineProvider && other.wineId == wineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GroupsContainingWineRef on AutoDisposeFutureProviderRef<Set<String>> {
  /// The parameter `wineId` of this provider.
  String get wineId;
}

class _GroupsContainingWineProviderElement
    extends AutoDisposeFutureProviderElement<Set<String>>
    with GroupsContainingWineRef {
  _GroupsContainingWineProviderElement(super.provider);

  @override
  String get wineId => (origin as GroupsContainingWineProvider).wineId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
