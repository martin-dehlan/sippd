// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expert_tasting.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expertTastingApiHash() => r'2b799dbb8420d1bf67e098a22766ba413a07fb84';

/// See also [expertTastingApi].
@ProviderFor(expertTastingApi)
final expertTastingApiProvider = AutoDisposeProvider<ExpertTastingApi>.internal(
  expertTastingApi,
  name: r'expertTastingApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expertTastingApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExpertTastingApiRef = AutoDisposeProviderRef<ExpertTastingApi>;
String _$myExpertTastingHash() => r'5ab95e1578db665f7f6af1358e1c132099dad81f';

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

/// Authenticated user's personal expert tasting for a single canonical
/// wine. Returns null if there is no row, or the wine has never received
/// dimensions. Family by canonical id so each wine detail page subscribes
/// to its own state and edits in the rating sheet propagate via
/// `ref.invalidate(myExpertTastingProvider(canonicalId))` from the caller.
///
/// Copied from [myExpertTasting].
@ProviderFor(myExpertTasting)
const myExpertTastingProvider = MyExpertTastingFamily();

/// Authenticated user's personal expert tasting for a single canonical
/// wine. Returns null if there is no row, or the wine has never received
/// dimensions. Family by canonical id so each wine detail page subscribes
/// to its own state and edits in the rating sheet propagate via
/// `ref.invalidate(myExpertTastingProvider(canonicalId))` from the caller.
///
/// Copied from [myExpertTasting].
class MyExpertTastingFamily extends Family<AsyncValue<ExpertTastingEntity?>> {
  /// Authenticated user's personal expert tasting for a single canonical
  /// wine. Returns null if there is no row, or the wine has never received
  /// dimensions. Family by canonical id so each wine detail page subscribes
  /// to its own state and edits in the rating sheet propagate via
  /// `ref.invalidate(myExpertTastingProvider(canonicalId))` from the caller.
  ///
  /// Copied from [myExpertTasting].
  const MyExpertTastingFamily();

  /// Authenticated user's personal expert tasting for a single canonical
  /// wine. Returns null if there is no row, or the wine has never received
  /// dimensions. Family by canonical id so each wine detail page subscribes
  /// to its own state and edits in the rating sheet propagate via
  /// `ref.invalidate(myExpertTastingProvider(canonicalId))` from the caller.
  ///
  /// Copied from [myExpertTasting].
  MyExpertTastingProvider call(String canonicalWineId) {
    return MyExpertTastingProvider(canonicalWineId);
  }

  @override
  MyExpertTastingProvider getProviderOverride(
    covariant MyExpertTastingProvider provider,
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
  String? get name => r'myExpertTastingProvider';
}

/// Authenticated user's personal expert tasting for a single canonical
/// wine. Returns null if there is no row, or the wine has never received
/// dimensions. Family by canonical id so each wine detail page subscribes
/// to its own state and edits in the rating sheet propagate via
/// `ref.invalidate(myExpertTastingProvider(canonicalId))` from the caller.
///
/// Copied from [myExpertTasting].
class MyExpertTastingProvider
    extends AutoDisposeFutureProvider<ExpertTastingEntity?> {
  /// Authenticated user's personal expert tasting for a single canonical
  /// wine. Returns null if there is no row, or the wine has never received
  /// dimensions. Family by canonical id so each wine detail page subscribes
  /// to its own state and edits in the rating sheet propagate via
  /// `ref.invalidate(myExpertTastingProvider(canonicalId))` from the caller.
  ///
  /// Copied from [myExpertTasting].
  MyExpertTastingProvider(String canonicalWineId)
    : this._internal(
        (ref) => myExpertTasting(ref as MyExpertTastingRef, canonicalWineId),
        from: myExpertTastingProvider,
        name: r'myExpertTastingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$myExpertTastingHash,
        dependencies: MyExpertTastingFamily._dependencies,
        allTransitiveDependencies:
            MyExpertTastingFamily._allTransitiveDependencies,
        canonicalWineId: canonicalWineId,
      );

  MyExpertTastingProvider._internal(
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
    FutureOr<ExpertTastingEntity?> Function(MyExpertTastingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyExpertTastingProvider._internal(
        (ref) => create(ref as MyExpertTastingRef),
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
  AutoDisposeFutureProviderElement<ExpertTastingEntity?> createElement() {
    return _MyExpertTastingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyExpertTastingProvider &&
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
mixin MyExpertTastingRef on AutoDisposeFutureProviderRef<ExpertTastingEntity?> {
  /// The parameter `canonicalWineId` of this provider.
  String get canonicalWineId;
}

class _MyExpertTastingProviderElement
    extends AutoDisposeFutureProviderElement<ExpertTastingEntity?>
    with MyExpertTastingRef {
  _MyExpertTastingProviderElement(super.provider);

  @override
  String get canonicalWineId =>
      (origin as MyExpertTastingProvider).canonicalWineId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
