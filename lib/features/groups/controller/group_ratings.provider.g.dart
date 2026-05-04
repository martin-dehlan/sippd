// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_ratings.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupWineRatingsHash() => r'94e1a39f3a37f574b193e17dbda455df70eb2d6f';

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

/// All member ratings + the owner's personal rating for a single bottle
/// inside a group. Owner row is synthesized from the local `wines` mirror
/// (or remote fallback) so it stays in lockstep with the wine-detail
/// rating, then merged with `group_wine_ratings` rows from other members.
///
/// Copied from [groupWineRatings].
@ProviderFor(groupWineRatings)
const groupWineRatingsProvider = GroupWineRatingsFamily();

/// All member ratings + the owner's personal rating for a single bottle
/// inside a group. Owner row is synthesized from the local `wines` mirror
/// (or remote fallback) so it stays in lockstep with the wine-detail
/// rating, then merged with `group_wine_ratings` rows from other members.
///
/// Copied from [groupWineRatings].
class GroupWineRatingsFamily
    extends Family<AsyncValue<List<GroupWineRatingEntity>>> {
  /// All member ratings + the owner's personal rating for a single bottle
  /// inside a group. Owner row is synthesized from the local `wines` mirror
  /// (or remote fallback) so it stays in lockstep with the wine-detail
  /// rating, then merged with `group_wine_ratings` rows from other members.
  ///
  /// Copied from [groupWineRatings].
  const GroupWineRatingsFamily();

  /// All member ratings + the owner's personal rating for a single bottle
  /// inside a group. Owner row is synthesized from the local `wines` mirror
  /// (or remote fallback) so it stays in lockstep with the wine-detail
  /// rating, then merged with `group_wine_ratings` rows from other members.
  ///
  /// Copied from [groupWineRatings].
  GroupWineRatingsProvider call(String groupId, String canonicalWineId) {
    return GroupWineRatingsProvider(groupId, canonicalWineId);
  }

  @override
  GroupWineRatingsProvider getProviderOverride(
    covariant GroupWineRatingsProvider provider,
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
  String? get name => r'groupWineRatingsProvider';
}

/// All member ratings + the owner's personal rating for a single bottle
/// inside a group. Owner row is synthesized from the local `wines` mirror
/// (or remote fallback) so it stays in lockstep with the wine-detail
/// rating, then merged with `group_wine_ratings` rows from other members.
///
/// Copied from [groupWineRatings].
class GroupWineRatingsProvider
    extends AutoDisposeFutureProvider<List<GroupWineRatingEntity>> {
  /// All member ratings + the owner's personal rating for a single bottle
  /// inside a group. Owner row is synthesized from the local `wines` mirror
  /// (or remote fallback) so it stays in lockstep with the wine-detail
  /// rating, then merged with `group_wine_ratings` rows from other members.
  ///
  /// Copied from [groupWineRatings].
  GroupWineRatingsProvider(String groupId, String canonicalWineId)
    : this._internal(
        (ref) => groupWineRatings(
          ref as GroupWineRatingsRef,
          groupId,
          canonicalWineId,
        ),
        from: groupWineRatingsProvider,
        name: r'groupWineRatingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupWineRatingsHash,
        dependencies: GroupWineRatingsFamily._dependencies,
        allTransitiveDependencies:
            GroupWineRatingsFamily._allTransitiveDependencies,
        groupId: groupId,
        canonicalWineId: canonicalWineId,
      );

  GroupWineRatingsProvider._internal(
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
        canonicalWineId: canonicalWineId,
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
mixin GroupWineRatingsRef
    on AutoDisposeFutureProviderRef<List<GroupWineRatingEntity>> {
  /// The parameter `groupId` of this provider.
  String get groupId;

  /// The parameter `canonicalWineId` of this provider.
  String get canonicalWineId;
}

class _GroupWineRatingsProviderElement
    extends AutoDisposeFutureProviderElement<List<GroupWineRatingEntity>>
    with GroupWineRatingsRef {
  _GroupWineRatingsProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupWineRatingsProvider).groupId;
  @override
  String get canonicalWineId =>
      (origin as GroupWineRatingsProvider).canonicalWineId;
}

String _$groupWineRanksHash() => r'fbe8788c934e6a047c472c9f7819447ebbdaf95b';

/// Map from canonical_wine_id → 1-based rank inside [groupId], averaged
/// across owner + member ratings. Ties share a rank.
///
/// Copied from [groupWineRanks].
@ProviderFor(groupWineRanks)
const groupWineRanksProvider = GroupWineRanksFamily();

/// Map from canonical_wine_id → 1-based rank inside [groupId], averaged
/// across owner + member ratings. Ties share a rank.
///
/// Copied from [groupWineRanks].
class GroupWineRanksFamily extends Family<AsyncValue<Map<String, int>>> {
  /// Map from canonical_wine_id → 1-based rank inside [groupId], averaged
  /// across owner + member ratings. Ties share a rank.
  ///
  /// Copied from [groupWineRanks].
  const GroupWineRanksFamily();

  /// Map from canonical_wine_id → 1-based rank inside [groupId], averaged
  /// across owner + member ratings. Ties share a rank.
  ///
  /// Copied from [groupWineRanks].
  GroupWineRanksProvider call(String groupId) {
    return GroupWineRanksProvider(groupId);
  }

  @override
  GroupWineRanksProvider getProviderOverride(
    covariant GroupWineRanksProvider provider,
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
  String? get name => r'groupWineRanksProvider';
}

/// Map from canonical_wine_id → 1-based rank inside [groupId], averaged
/// across owner + member ratings. Ties share a rank.
///
/// Copied from [groupWineRanks].
class GroupWineRanksProvider
    extends AutoDisposeFutureProvider<Map<String, int>> {
  /// Map from canonical_wine_id → 1-based rank inside [groupId], averaged
  /// across owner + member ratings. Ties share a rank.
  ///
  /// Copied from [groupWineRanks].
  GroupWineRanksProvider(String groupId)
    : this._internal(
        (ref) => groupWineRanks(ref as GroupWineRanksRef, groupId),
        from: groupWineRanksProvider,
        name: r'groupWineRanksProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupWineRanksHash,
        dependencies: GroupWineRanksFamily._dependencies,
        allTransitiveDependencies:
            GroupWineRanksFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  GroupWineRanksProvider._internal(
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
    FutureOr<Map<String, int>> Function(GroupWineRanksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupWineRanksProvider._internal(
        (ref) => create(ref as GroupWineRanksRef),
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
  AutoDisposeFutureProviderElement<Map<String, int>> createElement() {
    return _GroupWineRanksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupWineRanksProvider && other.groupId == groupId;
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
mixin GroupWineRanksRef on AutoDisposeFutureProviderRef<Map<String, int>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupWineRanksProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, int>>
    with GroupWineRanksRef {
  _GroupWineRanksProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupWineRanksProvider).groupId;
}

String _$groupWineRatingControllerHash() =>
    r'4c891b08e8cb1bb876f3cd57643070a85211d37d';

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
