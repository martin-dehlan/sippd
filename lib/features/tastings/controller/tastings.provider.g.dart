// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tastings.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tastingsApiHash() => r'd2e231c9c9d793aea2a584ae6db41e49f6b9252e';

/// See also [tastingsApi].
@ProviderFor(tastingsApi)
final tastingsApiProvider = AutoDisposeProvider<TastingsApi?>.internal(
  tastingsApi,
  name: r'tastingsApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tastingsApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TastingsApiRef = AutoDisposeProviderRef<TastingsApi?>;
String _$groupTastingsHash() => r'c749aec4d655dc98bf8d459b6155f5d81613fc7f';

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

/// See also [groupTastings].
@ProviderFor(groupTastings)
const groupTastingsProvider = GroupTastingsFamily();

/// See also [groupTastings].
class GroupTastingsFamily extends Family<AsyncValue<List<TastingEntity>>> {
  /// See also [groupTastings].
  const GroupTastingsFamily();

  /// See also [groupTastings].
  GroupTastingsProvider call(String groupId) {
    return GroupTastingsProvider(groupId);
  }

  @override
  GroupTastingsProvider getProviderOverride(
    covariant GroupTastingsProvider provider,
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
  String? get name => r'groupTastingsProvider';
}

/// See also [groupTastings].
class GroupTastingsProvider
    extends AutoDisposeFutureProvider<List<TastingEntity>> {
  /// See also [groupTastings].
  GroupTastingsProvider(String groupId)
    : this._internal(
        (ref) => groupTastings(ref as GroupTastingsRef, groupId),
        from: groupTastingsProvider,
        name: r'groupTastingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$groupTastingsHash,
        dependencies: GroupTastingsFamily._dependencies,
        allTransitiveDependencies:
            GroupTastingsFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  GroupTastingsProvider._internal(
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
    FutureOr<List<TastingEntity>> Function(GroupTastingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupTastingsProvider._internal(
        (ref) => create(ref as GroupTastingsRef),
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
  AutoDisposeFutureProviderElement<List<TastingEntity>> createElement() {
    return _GroupTastingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupTastingsProvider && other.groupId == groupId;
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
mixin GroupTastingsRef on AutoDisposeFutureProviderRef<List<TastingEntity>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupTastingsProviderElement
    extends AutoDisposeFutureProviderElement<List<TastingEntity>>
    with GroupTastingsRef {
  _GroupTastingsProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupTastingsProvider).groupId;
}

String _$tastingDetailHash() => r'46341b7e5804c1f49c68b3d297f7ea5884ab7141';

/// See also [tastingDetail].
@ProviderFor(tastingDetail)
const tastingDetailProvider = TastingDetailFamily();

/// See also [tastingDetail].
class TastingDetailFamily extends Family<AsyncValue<TastingEntity?>> {
  /// See also [tastingDetail].
  const TastingDetailFamily();

  /// See also [tastingDetail].
  TastingDetailProvider call(String tastingId) {
    return TastingDetailProvider(tastingId);
  }

  @override
  TastingDetailProvider getProviderOverride(
    covariant TastingDetailProvider provider,
  ) {
    return call(provider.tastingId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tastingDetailProvider';
}

/// See also [tastingDetail].
class TastingDetailProvider extends AutoDisposeFutureProvider<TastingEntity?> {
  /// See also [tastingDetail].
  TastingDetailProvider(String tastingId)
    : this._internal(
        (ref) => tastingDetail(ref as TastingDetailRef, tastingId),
        from: tastingDetailProvider,
        name: r'tastingDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tastingDetailHash,
        dependencies: TastingDetailFamily._dependencies,
        allTransitiveDependencies:
            TastingDetailFamily._allTransitiveDependencies,
        tastingId: tastingId,
      );

  TastingDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tastingId,
  }) : super.internal();

  final String tastingId;

  @override
  Override overrideWith(
    FutureOr<TastingEntity?> Function(TastingDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TastingDetailProvider._internal(
        (ref) => create(ref as TastingDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tastingId: tastingId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TastingEntity?> createElement() {
    return _TastingDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TastingDetailProvider && other.tastingId == tastingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tastingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TastingDetailRef on AutoDisposeFutureProviderRef<TastingEntity?> {
  /// The parameter `tastingId` of this provider.
  String get tastingId;
}

class _TastingDetailProviderElement
    extends AutoDisposeFutureProviderElement<TastingEntity?>
    with TastingDetailRef {
  _TastingDetailProviderElement(super.provider);

  @override
  String get tastingId => (origin as TastingDetailProvider).tastingId;
}

String _$tastingWinesHash() => r'5fe5793e576b8c118be7a7b2edffd2d33d705ee8';

/// See also [tastingWines].
@ProviderFor(tastingWines)
const tastingWinesProvider = TastingWinesFamily();

/// See also [tastingWines].
class TastingWinesFamily extends Family<AsyncValue<List<WineEntity>>> {
  /// See also [tastingWines].
  const TastingWinesFamily();

  /// See also [tastingWines].
  TastingWinesProvider call(String tastingId) {
    return TastingWinesProvider(tastingId);
  }

  @override
  TastingWinesProvider getProviderOverride(
    covariant TastingWinesProvider provider,
  ) {
    return call(provider.tastingId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tastingWinesProvider';
}

/// See also [tastingWines].
class TastingWinesProvider extends AutoDisposeFutureProvider<List<WineEntity>> {
  /// See also [tastingWines].
  TastingWinesProvider(String tastingId)
    : this._internal(
        (ref) => tastingWines(ref as TastingWinesRef, tastingId),
        from: tastingWinesProvider,
        name: r'tastingWinesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tastingWinesHash,
        dependencies: TastingWinesFamily._dependencies,
        allTransitiveDependencies:
            TastingWinesFamily._allTransitiveDependencies,
        tastingId: tastingId,
      );

  TastingWinesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tastingId,
  }) : super.internal();

  final String tastingId;

  @override
  Override overrideWith(
    FutureOr<List<WineEntity>> Function(TastingWinesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TastingWinesProvider._internal(
        (ref) => create(ref as TastingWinesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tastingId: tastingId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WineEntity>> createElement() {
    return _TastingWinesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TastingWinesProvider && other.tastingId == tastingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tastingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TastingWinesRef on AutoDisposeFutureProviderRef<List<WineEntity>> {
  /// The parameter `tastingId` of this provider.
  String get tastingId;
}

class _TastingWinesProviderElement
    extends AutoDisposeFutureProviderElement<List<WineEntity>>
    with TastingWinesRef {
  _TastingWinesProviderElement(super.provider);

  @override
  String get tastingId => (origin as TastingWinesProvider).tastingId;
}

String _$tastingWineRatingsHash() =>
    r'59c88312c5f7534d8f8a5001feb9b58b5e0f6514';

/// Group-context rating average per canonical wine for the tasting's
/// lineup. Mirrors `groupWineRatings`: owner of each canonical (via
/// `group_wines.shared_by`) contributes their personal `wines.rating`,
/// other members contribute their `group_wine_ratings.rating`. Each
/// user counted at most once per canonical (member rows from the owner
/// are dropped). Canonicals with zero usable ratings are omitted, so
/// callers can `Map.containsKey` to decide whether to render a badge.
///
/// Copied from [tastingWineRatings].
@ProviderFor(tastingWineRatings)
const tastingWineRatingsProvider = TastingWineRatingsFamily();

/// Group-context rating average per canonical wine for the tasting's
/// lineup. Mirrors `groupWineRatings`: owner of each canonical (via
/// `group_wines.shared_by`) contributes their personal `wines.rating`,
/// other members contribute their `group_wine_ratings.rating`. Each
/// user counted at most once per canonical (member rows from the owner
/// are dropped). Canonicals with zero usable ratings are omitted, so
/// callers can `Map.containsKey` to decide whether to render a badge.
///
/// Copied from [tastingWineRatings].
class TastingWineRatingsFamily extends Family<AsyncValue<Map<String, double>>> {
  /// Group-context rating average per canonical wine for the tasting's
  /// lineup. Mirrors `groupWineRatings`: owner of each canonical (via
  /// `group_wines.shared_by`) contributes their personal `wines.rating`,
  /// other members contribute their `group_wine_ratings.rating`. Each
  /// user counted at most once per canonical (member rows from the owner
  /// are dropped). Canonicals with zero usable ratings are omitted, so
  /// callers can `Map.containsKey` to decide whether to render a badge.
  ///
  /// Copied from [tastingWineRatings].
  const TastingWineRatingsFamily();

  /// Group-context rating average per canonical wine for the tasting's
  /// lineup. Mirrors `groupWineRatings`: owner of each canonical (via
  /// `group_wines.shared_by`) contributes their personal `wines.rating`,
  /// other members contribute their `group_wine_ratings.rating`. Each
  /// user counted at most once per canonical (member rows from the owner
  /// are dropped). Canonicals with zero usable ratings are omitted, so
  /// callers can `Map.containsKey` to decide whether to render a badge.
  ///
  /// Copied from [tastingWineRatings].
  TastingWineRatingsProvider call(String tastingId) {
    return TastingWineRatingsProvider(tastingId);
  }

  @override
  TastingWineRatingsProvider getProviderOverride(
    covariant TastingWineRatingsProvider provider,
  ) {
    return call(provider.tastingId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tastingWineRatingsProvider';
}

/// Group-context rating average per canonical wine for the tasting's
/// lineup. Mirrors `groupWineRatings`: owner of each canonical (via
/// `group_wines.shared_by`) contributes their personal `wines.rating`,
/// other members contribute their `group_wine_ratings.rating`. Each
/// user counted at most once per canonical (member rows from the owner
/// are dropped). Canonicals with zero usable ratings are omitted, so
/// callers can `Map.containsKey` to decide whether to render a badge.
///
/// Copied from [tastingWineRatings].
class TastingWineRatingsProvider
    extends AutoDisposeFutureProvider<Map<String, double>> {
  /// Group-context rating average per canonical wine for the tasting's
  /// lineup. Mirrors `groupWineRatings`: owner of each canonical (via
  /// `group_wines.shared_by`) contributes their personal `wines.rating`,
  /// other members contribute their `group_wine_ratings.rating`. Each
  /// user counted at most once per canonical (member rows from the owner
  /// are dropped). Canonicals with zero usable ratings are omitted, so
  /// callers can `Map.containsKey` to decide whether to render a badge.
  ///
  /// Copied from [tastingWineRatings].
  TastingWineRatingsProvider(String tastingId)
    : this._internal(
        (ref) => tastingWineRatings(ref as TastingWineRatingsRef, tastingId),
        from: tastingWineRatingsProvider,
        name: r'tastingWineRatingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tastingWineRatingsHash,
        dependencies: TastingWineRatingsFamily._dependencies,
        allTransitiveDependencies:
            TastingWineRatingsFamily._allTransitiveDependencies,
        tastingId: tastingId,
      );

  TastingWineRatingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tastingId,
  }) : super.internal();

  final String tastingId;

  @override
  Override overrideWith(
    FutureOr<Map<String, double>> Function(TastingWineRatingsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TastingWineRatingsProvider._internal(
        (ref) => create(ref as TastingWineRatingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tastingId: tastingId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, double>> createElement() {
    return _TastingWineRatingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TastingWineRatingsProvider && other.tastingId == tastingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tastingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TastingWineRatingsRef
    on AutoDisposeFutureProviderRef<Map<String, double>> {
  /// The parameter `tastingId` of this provider.
  String get tastingId;
}

class _TastingWineRatingsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, double>>
    with TastingWineRatingsRef {
  _TastingWineRatingsProviderElement(super.provider);

  @override
  String get tastingId => (origin as TastingWineRatingsProvider).tastingId;
}

String _$tastingAttendeesHash() => r'5da5e01641c554a1b9c8882d7c5989ee8f3b86aa';

/// See also [tastingAttendees].
@ProviderFor(tastingAttendees)
const tastingAttendeesProvider = TastingAttendeesFamily();

/// See also [tastingAttendees].
class TastingAttendeesFamily
    extends Family<AsyncValue<List<TastingAttendeeEntity>>> {
  /// See also [tastingAttendees].
  const TastingAttendeesFamily();

  /// See also [tastingAttendees].
  TastingAttendeesProvider call(String tastingId) {
    return TastingAttendeesProvider(tastingId);
  }

  @override
  TastingAttendeesProvider getProviderOverride(
    covariant TastingAttendeesProvider provider,
  ) {
    return call(provider.tastingId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tastingAttendeesProvider';
}

/// See also [tastingAttendees].
class TastingAttendeesProvider
    extends AutoDisposeFutureProvider<List<TastingAttendeeEntity>> {
  /// See also [tastingAttendees].
  TastingAttendeesProvider(String tastingId)
    : this._internal(
        (ref) => tastingAttendees(ref as TastingAttendeesRef, tastingId),
        from: tastingAttendeesProvider,
        name: r'tastingAttendeesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tastingAttendeesHash,
        dependencies: TastingAttendeesFamily._dependencies,
        allTransitiveDependencies:
            TastingAttendeesFamily._allTransitiveDependencies,
        tastingId: tastingId,
      );

  TastingAttendeesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tastingId,
  }) : super.internal();

  final String tastingId;

  @override
  Override overrideWith(
    FutureOr<List<TastingAttendeeEntity>> Function(TastingAttendeesRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TastingAttendeesProvider._internal(
        (ref) => create(ref as TastingAttendeesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tastingId: tastingId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TastingAttendeeEntity>>
  createElement() {
    return _TastingAttendeesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TastingAttendeesProvider && other.tastingId == tastingId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tastingId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TastingAttendeesRef
    on AutoDisposeFutureProviderRef<List<TastingAttendeeEntity>> {
  /// The parameter `tastingId` of this provider.
  String get tastingId;
}

class _TastingAttendeesProviderElement
    extends AutoDisposeFutureProviderElement<List<TastingAttendeeEntity>>
    with TastingAttendeesRef {
  _TastingAttendeesProviderElement(super.provider);

  @override
  String get tastingId => (origin as TastingAttendeesProvider).tastingId;
}

String _$tastingsControllerHash() =>
    r'cc516f7ee2cb86f3b549a5e895711f88754cb1c1';

/// See also [TastingsController].
@ProviderFor(TastingsController)
final tastingsControllerProvider =
    AutoDisposeAsyncNotifierProvider<TastingsController, void>.internal(
      TastingsController.new,
      name: r'tastingsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tastingsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TastingsController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
