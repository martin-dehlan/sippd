// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_match.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasteMatchApiHash() => r'6af26d38dba840293de801f5e1926801cb7d3de2';

/// See also [tasteMatchApi].
@ProviderFor(tasteMatchApi)
final tasteMatchApiProvider = AutoDisposeProvider<TasteMatchApi>.internal(
  tasteMatchApi,
  name: r'tasteMatchApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tasteMatchApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TasteMatchApiRef = AutoDisposeProviderRef<TasteMatchApi>;
String _$tasteCompassHash() => r'205011646dae575d32598d98546260111f577dca';

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

/// See also [tasteCompass].
@ProviderFor(tasteCompass)
const tasteCompassProvider = TasteCompassFamily();

/// See also [tasteCompass].
class TasteCompassFamily extends Family<AsyncValue<TasteCompassEntity>> {
  /// See also [tasteCompass].
  const TasteCompassFamily();

  /// See also [tasteCompass].
  TasteCompassProvider call(String userId) {
    return TasteCompassProvider(userId);
  }

  @override
  TasteCompassProvider getProviderOverride(
    covariant TasteCompassProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tasteCompassProvider';
}

/// See also [tasteCompass].
class TasteCompassProvider
    extends AutoDisposeFutureProvider<TasteCompassEntity> {
  /// See also [tasteCompass].
  TasteCompassProvider(String userId)
    : this._internal(
        (ref) => tasteCompass(ref as TasteCompassRef, userId),
        from: tasteCompassProvider,
        name: r'tasteCompassProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tasteCompassHash,
        dependencies: TasteCompassFamily._dependencies,
        allTransitiveDependencies:
            TasteCompassFamily._allTransitiveDependencies,
        userId: userId,
      );

  TasteCompassProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<TasteCompassEntity> Function(TasteCompassRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TasteCompassProvider._internal(
        (ref) => create(ref as TasteCompassRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TasteCompassEntity> createElement() {
    return _TasteCompassProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TasteCompassProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TasteCompassRef on AutoDisposeFutureProviderRef<TasteCompassEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _TasteCompassProviderElement
    extends AutoDisposeFutureProviderElement<TasteCompassEntity>
    with TasteCompassRef {
  _TasteCompassProviderElement(super.provider);

  @override
  String get userId => (origin as TasteCompassProvider).userId;
}

String _$sharedBottlesHash() => r'd79c7f980c91f22e088bb8ac2ed977535c0d0c63';

/// See also [sharedBottles].
@ProviderFor(sharedBottles)
const sharedBottlesProvider = SharedBottlesFamily();

/// See also [sharedBottles].
class SharedBottlesFamily extends Family<AsyncValue<List<SharedBottleEntity>>> {
  /// See also [sharedBottles].
  const SharedBottlesFamily();

  /// See also [sharedBottles].
  SharedBottlesProvider call(String otherUserId) {
    return SharedBottlesProvider(otherUserId);
  }

  @override
  SharedBottlesProvider getProviderOverride(
    covariant SharedBottlesProvider provider,
  ) {
    return call(provider.otherUserId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sharedBottlesProvider';
}

/// See also [sharedBottles].
class SharedBottlesProvider
    extends AutoDisposeFutureProvider<List<SharedBottleEntity>> {
  /// See also [sharedBottles].
  SharedBottlesProvider(String otherUserId)
    : this._internal(
        (ref) => sharedBottles(ref as SharedBottlesRef, otherUserId),
        from: sharedBottlesProvider,
        name: r'sharedBottlesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sharedBottlesHash,
        dependencies: SharedBottlesFamily._dependencies,
        allTransitiveDependencies:
            SharedBottlesFamily._allTransitiveDependencies,
        otherUserId: otherUserId,
      );

  SharedBottlesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.otherUserId,
  }) : super.internal();

  final String otherUserId;

  @override
  Override overrideWith(
    FutureOr<List<SharedBottleEntity>> Function(SharedBottlesRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SharedBottlesProvider._internal(
        (ref) => create(ref as SharedBottlesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        otherUserId: otherUserId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SharedBottleEntity>> createElement() {
    return _SharedBottlesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SharedBottlesProvider && other.otherUserId == otherUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, otherUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SharedBottlesRef
    on AutoDisposeFutureProviderRef<List<SharedBottleEntity>> {
  /// The parameter `otherUserId` of this provider.
  String get otherUserId;
}

class _SharedBottlesProviderElement
    extends AutoDisposeFutureProviderElement<List<SharedBottleEntity>>
    with SharedBottlesRef {
  _SharedBottlesProviderElement(super.provider);

  @override
  String get otherUserId => (origin as SharedBottlesProvider).otherUserId;
}

String _$tasteMatchHash() => r'a64b8869844de6508297606dc7fa21f8013beaba';

/// See also [tasteMatch].
@ProviderFor(tasteMatch)
const tasteMatchProvider = TasteMatchFamily();

/// See also [tasteMatch].
class TasteMatchFamily extends Family<AsyncValue<TasteMatchEntity>> {
  /// See also [tasteMatch].
  const TasteMatchFamily();

  /// See also [tasteMatch].
  TasteMatchProvider call(String otherUserId) {
    return TasteMatchProvider(otherUserId);
  }

  @override
  TasteMatchProvider getProviderOverride(
    covariant TasteMatchProvider provider,
  ) {
    return call(provider.otherUserId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tasteMatchProvider';
}

/// See also [tasteMatch].
class TasteMatchProvider extends AutoDisposeFutureProvider<TasteMatchEntity> {
  /// See also [tasteMatch].
  TasteMatchProvider(String otherUserId)
    : this._internal(
        (ref) => tasteMatch(ref as TasteMatchRef, otherUserId),
        from: tasteMatchProvider,
        name: r'tasteMatchProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tasteMatchHash,
        dependencies: TasteMatchFamily._dependencies,
        allTransitiveDependencies: TasteMatchFamily._allTransitiveDependencies,
        otherUserId: otherUserId,
      );

  TasteMatchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.otherUserId,
  }) : super.internal();

  final String otherUserId;

  @override
  Override overrideWith(
    FutureOr<TasteMatchEntity> Function(TasteMatchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TasteMatchProvider._internal(
        (ref) => create(ref as TasteMatchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        otherUserId: otherUserId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TasteMatchEntity> createElement() {
    return _TasteMatchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TasteMatchProvider && other.otherUserId == otherUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, otherUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TasteMatchRef on AutoDisposeFutureProviderRef<TasteMatchEntity> {
  /// The parameter `otherUserId` of this provider.
  String get otherUserId;
}

class _TasteMatchProviderElement
    extends AutoDisposeFutureProviderElement<TasteMatchEntity>
    with TasteMatchRef {
  _TasteMatchProviderElement(super.provider);

  @override
  String get otherUserId => (origin as TasteMatchProvider).otherUserId;
}

String _$userTopGrapesHash() => r'61130672021011e64d35717de9f4ae4016ccd41a';

/// See also [userTopGrapes].
@ProviderFor(userTopGrapes)
const userTopGrapesProvider = UserTopGrapesFamily();

/// See also [userTopGrapes].
class UserTopGrapesFamily extends Family<AsyncValue<List<UserGrapeShare>>> {
  /// See also [userTopGrapes].
  const UserTopGrapesFamily();

  /// See also [userTopGrapes].
  UserTopGrapesProvider call(String userId) {
    return UserTopGrapesProvider(userId);
  }

  @override
  UserTopGrapesProvider getProviderOverride(
    covariant UserTopGrapesProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userTopGrapesProvider';
}

/// See also [userTopGrapes].
class UserTopGrapesProvider
    extends AutoDisposeFutureProvider<List<UserGrapeShare>> {
  /// See also [userTopGrapes].
  UserTopGrapesProvider(String userId)
    : this._internal(
        (ref) => userTopGrapes(ref as UserTopGrapesRef, userId),
        from: userTopGrapesProvider,
        name: r'userTopGrapesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userTopGrapesHash,
        dependencies: UserTopGrapesFamily._dependencies,
        allTransitiveDependencies:
            UserTopGrapesFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserTopGrapesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<UserGrapeShare>> Function(UserTopGrapesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserTopGrapesProvider._internal(
        (ref) => create(ref as UserTopGrapesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserGrapeShare>> createElement() {
    return _UserTopGrapesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTopGrapesProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserTopGrapesRef on AutoDisposeFutureProviderRef<List<UserGrapeShare>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserTopGrapesProviderElement
    extends AutoDisposeFutureProviderElement<List<UserGrapeShare>>
    with UserTopGrapesRef {
  _UserTopGrapesProviderElement(super.provider);

  @override
  String get userId => (origin as UserTopGrapesProvider).userId;
}

String _$userStyleDnaHash() => r'1b6ac7f02b6423c68857cb8bac2534c65adaa490';

/// See also [userStyleDna].
@ProviderFor(userStyleDna)
const userStyleDnaProvider = UserStyleDnaFamily();

/// See also [userStyleDna].
class UserStyleDnaFamily extends Family<AsyncValue<UserStyleDna>> {
  /// See also [userStyleDna].
  const UserStyleDnaFamily();

  /// See also [userStyleDna].
  UserStyleDnaProvider call(String userId) {
    return UserStyleDnaProvider(userId);
  }

  @override
  UserStyleDnaProvider getProviderOverride(
    covariant UserStyleDnaProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userStyleDnaProvider';
}

/// See also [userStyleDna].
class UserStyleDnaProvider extends AutoDisposeFutureProvider<UserStyleDna> {
  /// See also [userStyleDna].
  UserStyleDnaProvider(String userId)
    : this._internal(
        (ref) => userStyleDna(ref as UserStyleDnaRef, userId),
        from: userStyleDnaProvider,
        name: r'userStyleDnaProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userStyleDnaHash,
        dependencies: UserStyleDnaFamily._dependencies,
        allTransitiveDependencies:
            UserStyleDnaFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserStyleDnaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<UserStyleDna> Function(UserStyleDnaRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserStyleDnaProvider._internal(
        (ref) => create(ref as UserStyleDnaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserStyleDna> createElement() {
    return _UserStyleDnaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserStyleDnaProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserStyleDnaRef on AutoDisposeFutureProviderRef<UserStyleDna> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserStyleDnaProviderElement
    extends AutoDisposeFutureProviderElement<UserStyleDna>
    with UserStyleDnaRef {
  _UserStyleDnaProviderElement(super.provider);

  @override
  String get userId => (origin as UserStyleDnaProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
