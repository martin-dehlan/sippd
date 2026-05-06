// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_ratings.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$friendRatingsApiHash() => r'85603e0b2c1113c9da43abce15b8211b1cd21dbf';

/// See also [friendRatingsApi].
@ProviderFor(friendRatingsApi)
final friendRatingsApiProvider =
    AutoDisposeProvider<FriendRatingsApi?>.internal(
      friendRatingsApi,
      name: r'friendRatingsApiProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$friendRatingsApiHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FriendRatingsApiRef = AutoDisposeProviderRef<FriendRatingsApi?>;
String _$friendRatingsForCanonicalWineHash() =>
    r'3e5d71c6471d19303733cdd74e664251ec55f90f';

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

/// Friends who have rated the canonical wine. Empty list when no auth or
/// no overlap. Network-only — friend data is not cached in Drift (privacy
/// + freshness wins over local-first for non-owned rows).
///
/// Copied from [friendRatingsForCanonicalWine].
@ProviderFor(friendRatingsForCanonicalWine)
const friendRatingsForCanonicalWineProvider =
    FriendRatingsForCanonicalWineFamily();

/// Friends who have rated the canonical wine. Empty list when no auth or
/// no overlap. Network-only — friend data is not cached in Drift (privacy
/// + freshness wins over local-first for non-owned rows).
///
/// Copied from [friendRatingsForCanonicalWine].
class FriendRatingsForCanonicalWineFamily
    extends Family<AsyncValue<List<FriendRatingEntity>>> {
  /// Friends who have rated the canonical wine. Empty list when no auth or
  /// no overlap. Network-only — friend data is not cached in Drift (privacy
  /// + freshness wins over local-first for non-owned rows).
  ///
  /// Copied from [friendRatingsForCanonicalWine].
  const FriendRatingsForCanonicalWineFamily();

  /// Friends who have rated the canonical wine. Empty list when no auth or
  /// no overlap. Network-only — friend data is not cached in Drift (privacy
  /// + freshness wins over local-first for non-owned rows).
  ///
  /// Copied from [friendRatingsForCanonicalWine].
  FriendRatingsForCanonicalWineProvider call(String canonicalWineId) {
    return FriendRatingsForCanonicalWineProvider(canonicalWineId);
  }

  @override
  FriendRatingsForCanonicalWineProvider getProviderOverride(
    covariant FriendRatingsForCanonicalWineProvider provider,
  ) {
    return call(provider.canonicalWineId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'friendRatingsForCanonicalWineProvider';
}

/// Friends who have rated the canonical wine. Empty list when no auth or
/// no overlap. Network-only — friend data is not cached in Drift (privacy
/// + freshness wins over local-first for non-owned rows).
///
/// Copied from [friendRatingsForCanonicalWine].
class FriendRatingsForCanonicalWineProvider
    extends AutoDisposeFutureProvider<List<FriendRatingEntity>> {
  /// Friends who have rated the canonical wine. Empty list when no auth or
  /// no overlap. Network-only — friend data is not cached in Drift (privacy
  /// + freshness wins over local-first for non-owned rows).
  ///
  /// Copied from [friendRatingsForCanonicalWine].
  FriendRatingsForCanonicalWineProvider(String canonicalWineId)
    : this._internal(
        (ref) => friendRatingsForCanonicalWine(
          ref as FriendRatingsForCanonicalWineRef,
          canonicalWineId,
        ),
        from: friendRatingsForCanonicalWineProvider,
        name: r'friendRatingsForCanonicalWineProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$friendRatingsForCanonicalWineHash,
        dependencies: FriendRatingsForCanonicalWineFamily._dependencies,
        allTransitiveDependencies:
            FriendRatingsForCanonicalWineFamily._allTransitiveDependencies,
        canonicalWineId: canonicalWineId,
      );

  FriendRatingsForCanonicalWineProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.canonicalWineId,
  }) : super.internal();

  final String canonicalWineId;

  @override
  Override overrideWith(
    FutureOr<List<FriendRatingEntity>> Function(
      FriendRatingsForCanonicalWineRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FriendRatingsForCanonicalWineProvider._internal(
        (ref) => create(ref as FriendRatingsForCanonicalWineRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        canonicalWineId: canonicalWineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FriendRatingEntity>> createElement() {
    return _FriendRatingsForCanonicalWineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendRatingsForCanonicalWineProvider &&
        other.canonicalWineId == canonicalWineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, canonicalWineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FriendRatingsForCanonicalWineRef
    on AutoDisposeFutureProviderRef<List<FriendRatingEntity>> {
  /// The parameter `canonicalWineId` of this provider.
  String get canonicalWineId;
}

class _FriendRatingsForCanonicalWineProviderElement
    extends AutoDisposeFutureProviderElement<List<FriendRatingEntity>>
    with FriendRatingsForCanonicalWineRef {
  _FriendRatingsForCanonicalWineProviderElement(super.provider);

  @override
  String get canonicalWineId =>
      (origin as FriendRatingsForCanonicalWineProvider).canonicalWineId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
