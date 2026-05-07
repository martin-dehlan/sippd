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

String _$tastingDetailHash() => r'17c376225e9df929e326900c381467cf8170ffa9';

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

String _$tastingWinesHash() => r'b33eb7350915f145c51159797a07a69d3d7b3a7f';

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
    r'fd6409be173ec1796eb6a975a2146db3ccd6976b';

/// Group-context rating average per canonical wine for the tasting's
/// lineup. Mirrors `groupWineRatings`: owner of each canonical (via
/// `group_wines.shared_by`) contributes their personal `wines.rating`,
/// other members contribute their `group_wine_ratings.rating`. Each
/// user counted at most once per canonical (member rows from the owner
/// are dropped). Canonicals with zero usable ratings are omitted, so
/// callers can `Map.containsKey` to decide whether to render a badge.
/// Average rating per canonical wine for the tasting, sourced from
/// `tasting_ratings`. Tasting context is intentionally separate from
/// group-historical ratings — the same canonical may have a different
/// score in tonight's flight than in last weekend's group dinner.
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
/// Average rating per canonical wine for the tasting, sourced from
/// `tasting_ratings`. Tasting context is intentionally separate from
/// group-historical ratings — the same canonical may have a different
/// score in tonight's flight than in last weekend's group dinner.
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
  /// Average rating per canonical wine for the tasting, sourced from
  /// `tasting_ratings`. Tasting context is intentionally separate from
  /// group-historical ratings — the same canonical may have a different
  /// score in tonight's flight than in last weekend's group dinner.
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
  /// Average rating per canonical wine for the tasting, sourced from
  /// `tasting_ratings`. Tasting context is intentionally separate from
  /// group-historical ratings — the same canonical may have a different
  /// score in tonight's flight than in last weekend's group dinner.
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
/// Average rating per canonical wine for the tasting, sourced from
/// `tasting_ratings`. Tasting context is intentionally separate from
/// group-historical ratings — the same canonical may have a different
/// score in tonight's flight than in last weekend's group dinner.
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
  /// Average rating per canonical wine for the tasting, sourced from
  /// `tasting_ratings`. Tasting context is intentionally separate from
  /// group-historical ratings — the same canonical may have a different
  /// score in tonight's flight than in last weekend's group dinner.
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

String _$tastingRecapEntriesHash() =>
    r'353b98ae05eac4ef7f83758bdcb71982ae11a4e9';

/// All submitted ratings for the tasting joined with rater profiles.
/// Powers the concluded-state recap view (top wine + per-wine
/// breakdown). Empty list when no ratings exist yet.
///
/// Copied from [tastingRecapEntries].
@ProviderFor(tastingRecapEntries)
const tastingRecapEntriesProvider = TastingRecapEntriesFamily();

/// All submitted ratings for the tasting joined with rater profiles.
/// Powers the concluded-state recap view (top wine + per-wine
/// breakdown). Empty list when no ratings exist yet.
///
/// Copied from [tastingRecapEntries].
class TastingRecapEntriesFamily
    extends Family<AsyncValue<List<TastingRecapEntry>>> {
  /// All submitted ratings for the tasting joined with rater profiles.
  /// Powers the concluded-state recap view (top wine + per-wine
  /// breakdown). Empty list when no ratings exist yet.
  ///
  /// Copied from [tastingRecapEntries].
  const TastingRecapEntriesFamily();

  /// All submitted ratings for the tasting joined with rater profiles.
  /// Powers the concluded-state recap view (top wine + per-wine
  /// breakdown). Empty list when no ratings exist yet.
  ///
  /// Copied from [tastingRecapEntries].
  TastingRecapEntriesProvider call(String tastingId) {
    return TastingRecapEntriesProvider(tastingId);
  }

  @override
  TastingRecapEntriesProvider getProviderOverride(
    covariant TastingRecapEntriesProvider provider,
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
  String? get name => r'tastingRecapEntriesProvider';
}

/// All submitted ratings for the tasting joined with rater profiles.
/// Powers the concluded-state recap view (top wine + per-wine
/// breakdown). Empty list when no ratings exist yet.
///
/// Copied from [tastingRecapEntries].
class TastingRecapEntriesProvider
    extends AutoDisposeFutureProvider<List<TastingRecapEntry>> {
  /// All submitted ratings for the tasting joined with rater profiles.
  /// Powers the concluded-state recap view (top wine + per-wine
  /// breakdown). Empty list when no ratings exist yet.
  ///
  /// Copied from [tastingRecapEntries].
  TastingRecapEntriesProvider(String tastingId)
    : this._internal(
        (ref) => tastingRecapEntries(ref as TastingRecapEntriesRef, tastingId),
        from: tastingRecapEntriesProvider,
        name: r'tastingRecapEntriesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tastingRecapEntriesHash,
        dependencies: TastingRecapEntriesFamily._dependencies,
        allTransitiveDependencies:
            TastingRecapEntriesFamily._allTransitiveDependencies,
        tastingId: tastingId,
      );

  TastingRecapEntriesProvider._internal(
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
    FutureOr<List<TastingRecapEntry>> Function(TastingRecapEntriesRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TastingRecapEntriesProvider._internal(
        (ref) => create(ref as TastingRecapEntriesRef),
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
  AutoDisposeFutureProviderElement<List<TastingRecapEntry>> createElement() {
    return _TastingRecapEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TastingRecapEntriesProvider && other.tastingId == tastingId;
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
mixin TastingRecapEntriesRef
    on AutoDisposeFutureProviderRef<List<TastingRecapEntry>> {
  /// The parameter `tastingId` of this provider.
  String get tastingId;
}

class _TastingRecapEntriesProviderElement
    extends AutoDisposeFutureProviderElement<List<TastingRecapEntry>>
    with TastingRecapEntriesRef {
  _TastingRecapEntriesProviderElement(super.provider);

  @override
  String get tastingId => (origin as TastingRecapEntriesProvider).tastingId;
}

String _$myTastingRatingHash() => r'77d84e96898b085a5ed7d89123d495b0646603a6';

/// The caller's own rating for a single wine in a tasting. Null if not
/// yet rated. Used to prefill the rate-sheet so re-opening shows the
/// last value the user submitted.
///
/// Copied from [myTastingRating].
@ProviderFor(myTastingRating)
const myTastingRatingProvider = MyTastingRatingFamily();

/// The caller's own rating for a single wine in a tasting. Null if not
/// yet rated. Used to prefill the rate-sheet so re-opening shows the
/// last value the user submitted.
///
/// Copied from [myTastingRating].
class MyTastingRatingFamily extends Family<AsyncValue<double?>> {
  /// The caller's own rating for a single wine in a tasting. Null if not
  /// yet rated. Used to prefill the rate-sheet so re-opening shows the
  /// last value the user submitted.
  ///
  /// Copied from [myTastingRating].
  const MyTastingRatingFamily();

  /// The caller's own rating for a single wine in a tasting. Null if not
  /// yet rated. Used to prefill the rate-sheet so re-opening shows the
  /// last value the user submitted.
  ///
  /// Copied from [myTastingRating].
  MyTastingRatingProvider call(String tastingId, String canonicalWineId) {
    return MyTastingRatingProvider(tastingId, canonicalWineId);
  }

  @override
  MyTastingRatingProvider getProviderOverride(
    covariant MyTastingRatingProvider provider,
  ) {
    return call(provider.tastingId, provider.canonicalWineId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'myTastingRatingProvider';
}

/// The caller's own rating for a single wine in a tasting. Null if not
/// yet rated. Used to prefill the rate-sheet so re-opening shows the
/// last value the user submitted.
///
/// Copied from [myTastingRating].
class MyTastingRatingProvider extends AutoDisposeFutureProvider<double?> {
  /// The caller's own rating for a single wine in a tasting. Null if not
  /// yet rated. Used to prefill the rate-sheet so re-opening shows the
  /// last value the user submitted.
  ///
  /// Copied from [myTastingRating].
  MyTastingRatingProvider(String tastingId, String canonicalWineId)
    : this._internal(
        (ref) => myTastingRating(
          ref as MyTastingRatingRef,
          tastingId,
          canonicalWineId,
        ),
        from: myTastingRatingProvider,
        name: r'myTastingRatingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$myTastingRatingHash,
        dependencies: MyTastingRatingFamily._dependencies,
        allTransitiveDependencies:
            MyTastingRatingFamily._allTransitiveDependencies,
        tastingId: tastingId,
        canonicalWineId: canonicalWineId,
      );

  MyTastingRatingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tastingId,
    required this.canonicalWineId,
  }) : super.internal();

  final String tastingId;
  final String canonicalWineId;

  @override
  Override overrideWith(
    FutureOr<double?> Function(MyTastingRatingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyTastingRatingProvider._internal(
        (ref) => create(ref as MyTastingRatingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tastingId: tastingId,
        canonicalWineId: canonicalWineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double?> createElement() {
    return _MyTastingRatingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyTastingRatingProvider &&
        other.tastingId == tastingId &&
        other.canonicalWineId == canonicalWineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tastingId.hashCode);
    hash = _SystemHash.combine(hash, canonicalWineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MyTastingRatingRef on AutoDisposeFutureProviderRef<double?> {
  /// The parameter `tastingId` of this provider.
  String get tastingId;

  /// The parameter `canonicalWineId` of this provider.
  String get canonicalWineId;
}

class _MyTastingRatingProviderElement
    extends AutoDisposeFutureProviderElement<double?>
    with MyTastingRatingRef {
  _MyTastingRatingProviderElement(super.provider);

  @override
  String get tastingId => (origin as MyTastingRatingProvider).tastingId;
  @override
  String get canonicalWineId =>
      (origin as MyTastingRatingProvider).canonicalWineId;
}

String _$tastingAttendeesHash() => r'80c4ca180fd8a4d4103e502b2dfb10f08c20574c';

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
    r'976bb469206e586b32d483d8ab0bc302f77021d7';

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
