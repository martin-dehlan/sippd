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

String _$wineControllerHash() => r'3eea439fd75a0dd0090f8da46c3558f3e86e498e';

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
String _$wineTypeFilterHash() => r'18cccdfcd3b77a9c7ff2d4f7b3efdbc65c9c432d';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
