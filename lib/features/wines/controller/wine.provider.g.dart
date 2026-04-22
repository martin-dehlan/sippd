// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'3d3a397d2ea952fc020fce0506793a5564e93530';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
String _$wineSupabaseApiHash() => r'c7f531f534bb916800db25129831814544f26c5d';

/// See also [wineSupabaseApi].
@ProviderFor(wineSupabaseApi)
final wineSupabaseApiProvider = AutoDisposeProvider<WineSupabaseApi?>.internal(
  wineSupabaseApi,
  name: r'wineSupabaseApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wineSupabaseApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WineSupabaseApiRef = AutoDisposeProviderRef<WineSupabaseApi?>;
String _$wineRepositoryHash() => r'7930a0aab308db7eb920f1ffa561f1ac8bd4075d';

/// See also [wineRepository].
@ProviderFor(wineRepository)
final wineRepositoryProvider = AutoDisposeProvider<WineRepository>.internal(
  wineRepository,
  name: r'wineRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wineRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WineRepositoryRef = AutoDisposeProviderRef<WineRepository>;
String _$wineImageServiceHash() => r'263d5737d1742b3a280a87c42a0accafb3d1ec06';

/// See also [wineImageService].
@ProviderFor(wineImageService)
final wineImageServiceProvider =
    AutoDisposeProvider<WineImageService?>.internal(
      wineImageService,
      name: r'wineImageServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wineImageServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WineImageServiceRef = AutoDisposeProviderRef<WineImageService?>;
String _$wineMemorySupabaseApiHash() =>
    r'223bf6db0966b3409f2eaabb7520205275fa0c0d';

/// See also [wineMemorySupabaseApi].
@ProviderFor(wineMemorySupabaseApi)
final wineMemorySupabaseApiProvider =
    AutoDisposeProvider<WineMemorySupabaseApi?>.internal(
      wineMemorySupabaseApi,
      name: r'wineMemorySupabaseApiProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wineMemorySupabaseApiHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WineMemorySupabaseApiRef =
    AutoDisposeProviderRef<WineMemorySupabaseApi?>;
String _$wineMemoryRepositoryHash() =>
    r'6e49d54d9eb5316d7b68058da124898531242b4b';

/// See also [wineMemoryRepository].
@ProviderFor(wineMemoryRepository)
final wineMemoryRepositoryProvider =
    AutoDisposeProvider<WineMemoryRepository>.internal(
      wineMemoryRepository,
      name: r'wineMemoryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wineMemoryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WineMemoryRepositoryRef = AutoDisposeProviderRef<WineMemoryRepository>;
String _$wineDetailHash() => r'e16e2db7c1f552d816b73dc417075b660dab01b5';

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

/// See also [wineDetail].
@ProviderFor(wineDetail)
const wineDetailProvider = WineDetailFamily();

/// See also [wineDetail].
class WineDetailFamily extends Family<AsyncValue<WineEntity?>> {
  /// See also [wineDetail].
  const WineDetailFamily();

  /// See also [wineDetail].
  WineDetailProvider call(String wineId) {
    return WineDetailProvider(wineId);
  }

  @override
  WineDetailProvider getProviderOverride(
    covariant WineDetailProvider provider,
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
  String? get name => r'wineDetailProvider';
}

/// See also [wineDetail].
class WineDetailProvider extends AutoDisposeFutureProvider<WineEntity?> {
  /// See also [wineDetail].
  WineDetailProvider(String wineId)
    : this._internal(
        (ref) => wineDetail(ref as WineDetailRef, wineId),
        from: wineDetailProvider,
        name: r'wineDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$wineDetailHash,
        dependencies: WineDetailFamily._dependencies,
        allTransitiveDependencies: WineDetailFamily._allTransitiveDependencies,
        wineId: wineId,
      );

  WineDetailProvider._internal(
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
    FutureOr<WineEntity?> Function(WineDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WineDetailProvider._internal(
        (ref) => create(ref as WineDetailRef),
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
  AutoDisposeFutureProviderElement<WineEntity?> createElement() {
    return _WineDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WineDetailProvider && other.wineId == wineId;
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
mixin WineDetailRef on AutoDisposeFutureProviderRef<WineEntity?> {
  /// The parameter `wineId` of this provider.
  String get wineId;
}

class _WineDetailProviderElement
    extends AutoDisposeFutureProviderElement<WineEntity?>
    with WineDetailRef {
  _WineDetailProviderElement(super.provider);

  @override
  String get wineId => (origin as WineDetailProvider).wineId;
}

String _$wineControllerHash() => r'9dbc95be1de884c3d2d189d3ae56bf1fb2f7ab76';

/// See also [WineController].
@ProviderFor(WineController)
final wineControllerProvider =
    AutoDisposeStreamNotifierProvider<
      WineController,
      List<WineEntity>
    >.internal(
      WineController.new,
      name: r'wineControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wineControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WineController = AutoDisposeStreamNotifier<List<WineEntity>>;
String _$wineMemoriesControllerHash() =>
    r'0ef78da4e923322e3c2eac93fafb47e465f10b42';

abstract class _$WineMemoriesController
    extends BuildlessAutoDisposeStreamNotifier<List<WineMemoryEntity>> {
  late final String wineId;

  Stream<List<WineMemoryEntity>> build(String wineId);
}

/// See also [WineMemoriesController].
@ProviderFor(WineMemoriesController)
const wineMemoriesControllerProvider = WineMemoriesControllerFamily();

/// See also [WineMemoriesController].
class WineMemoriesControllerFamily
    extends Family<AsyncValue<List<WineMemoryEntity>>> {
  /// See also [WineMemoriesController].
  const WineMemoriesControllerFamily();

  /// See also [WineMemoriesController].
  WineMemoriesControllerProvider call(String wineId) {
    return WineMemoriesControllerProvider(wineId);
  }

  @override
  WineMemoriesControllerProvider getProviderOverride(
    covariant WineMemoriesControllerProvider provider,
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
  String? get name => r'wineMemoriesControllerProvider';
}

/// See also [WineMemoriesController].
class WineMemoriesControllerProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          WineMemoriesController,
          List<WineMemoryEntity>
        > {
  /// See also [WineMemoriesController].
  WineMemoriesControllerProvider(String wineId)
    : this._internal(
        () => WineMemoriesController()..wineId = wineId,
        from: wineMemoriesControllerProvider,
        name: r'wineMemoriesControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$wineMemoriesControllerHash,
        dependencies: WineMemoriesControllerFamily._dependencies,
        allTransitiveDependencies:
            WineMemoriesControllerFamily._allTransitiveDependencies,
        wineId: wineId,
      );

  WineMemoriesControllerProvider._internal(
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
  Stream<List<WineMemoryEntity>> runNotifierBuild(
    covariant WineMemoriesController notifier,
  ) {
    return notifier.build(wineId);
  }

  @override
  Override overrideWith(WineMemoriesController Function() create) {
    return ProviderOverride(
      origin: this,
      override: WineMemoriesControllerProvider._internal(
        () => create()..wineId = wineId,
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
  AutoDisposeStreamNotifierProviderElement<
    WineMemoriesController,
    List<WineMemoryEntity>
  >
  createElement() {
    return _WineMemoriesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WineMemoriesControllerProvider && other.wineId == wineId;
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
mixin WineMemoriesControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<WineMemoryEntity>> {
  /// The parameter `wineId` of this provider.
  String get wineId;
}

class _WineMemoriesControllerProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          WineMemoriesController,
          List<WineMemoryEntity>
        >
    with WineMemoriesControllerRef {
  _WineMemoriesControllerProviderElement(super.provider);

  @override
  String get wineId => (origin as WineMemoriesControllerProvider).wineId;
}

String _$wineTypeFilterHash() => r'fa4fc894cabfe8e15545bdc6193fc12bebaf4a2e';

/// See also [WineTypeFilter].
@ProviderFor(WineTypeFilter)
final wineTypeFilterProvider =
    AutoDisposeNotifierProvider<WineTypeFilter, WineType?>.internal(
      WineTypeFilter.new,
      name: r'wineTypeFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wineTypeFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WineTypeFilter = AutoDisposeNotifier<WineType?>;
String _$wineSortHash() => r'7b13a1132eb7ef2178713afb8914b0840bfa0a9a';

/// See also [WineSort].
@ProviderFor(WineSort)
final wineSortProvider =
    AutoDisposeNotifierProvider<WineSort, WineSortMode>.internal(
      WineSort.new,
      name: r'wineSortProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wineSortHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WineSort = AutoDisposeNotifier<WineSortMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
