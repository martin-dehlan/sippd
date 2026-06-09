// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badges.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$badgesApiHash() => r'7f9105d6f8afda816318b340db906726131057a3';

/// See also [badgesApi].
@ProviderFor(badgesApi)
final badgesApiProvider = AutoDisposeProvider<BadgesApi>.internal(
  badgesApi,
  name: r'badgesApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$badgesApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BadgesApiRef = AutoDisposeProviderRef<BadgesApi>;
String _$badgesRepositoryHash() => r'75ef240c84b1afc3329a33838ce1ad0b147f2e75';

/// See also [badgesRepository].
@ProviderFor(badgesRepository)
final badgesRepositoryProvider = AutoDisposeProvider<BadgesRepository>.internal(
  badgesRepository,
  name: r'badgesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$badgesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BadgesRepositoryRef = AutoDisposeProviderRef<BadgesRepository>;
String _$earnedBadgesHash() => r'137de30d16656cd996bc00e6dd307a48149a39ca';

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

/// Earned badges for any profile (own or a friend) — drives the showcase.
///
/// Copied from [earnedBadges].
@ProviderFor(earnedBadges)
const earnedBadgesProvider = EarnedBadgesFamily();

/// Earned badges for any profile (own or a friend) — drives the showcase.
///
/// Copied from [earnedBadges].
class EarnedBadgesFamily extends Family<AsyncValue<List<BadgeEntity>>> {
  /// Earned badges for any profile (own or a friend) — drives the showcase.
  ///
  /// Copied from [earnedBadges].
  const EarnedBadgesFamily();

  /// Earned badges for any profile (own or a friend) — drives the showcase.
  ///
  /// Copied from [earnedBadges].
  EarnedBadgesProvider call(String userId) {
    return EarnedBadgesProvider(userId);
  }

  @override
  EarnedBadgesProvider getProviderOverride(
    covariant EarnedBadgesProvider provider,
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
  String? get name => r'earnedBadgesProvider';
}

/// Earned badges for any profile (own or a friend) — drives the showcase.
///
/// Copied from [earnedBadges].
class EarnedBadgesProvider
    extends AutoDisposeFutureProvider<List<BadgeEntity>> {
  /// Earned badges for any profile (own or a friend) — drives the showcase.
  ///
  /// Copied from [earnedBadges].
  EarnedBadgesProvider(String userId)
    : this._internal(
        (ref) => earnedBadges(ref as EarnedBadgesRef, userId),
        from: earnedBadgesProvider,
        name: r'earnedBadgesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$earnedBadgesHash,
        dependencies: EarnedBadgesFamily._dependencies,
        allTransitiveDependencies:
            EarnedBadgesFamily._allTransitiveDependencies,
        userId: userId,
      );

  EarnedBadgesProvider._internal(
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
    FutureOr<List<BadgeEntity>> Function(EarnedBadgesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EarnedBadgesProvider._internal(
        (ref) => create(ref as EarnedBadgesRef),
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
  AutoDisposeFutureProviderElement<List<BadgeEntity>> createElement() {
    return _EarnedBadgesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EarnedBadgesProvider && other.userId == userId;
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
mixin EarnedBadgesRef on AutoDisposeFutureProviderRef<List<BadgeEntity>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _EarnedBadgesProviderElement
    extends AutoDisposeFutureProviderElement<List<BadgeEntity>>
    with EarnedBadgesRef {
  _EarnedBadgesProviderElement(super.provider);

  @override
  String get userId => (origin as EarnedBadgesProvider).userId;
}

String _$myBadgesHash() => r'949e18250f3282706691399b9ea17e417c91d516';

/// The signed-in user's full badge grid (earned + locked w/ progress).
///
/// Copied from [MyBadges].
@ProviderFor(MyBadges)
final myBadgesProvider =
    AutoDisposeAsyncNotifierProvider<MyBadges, List<BadgeEntity>>.internal(
      MyBadges.new,
      name: r'myBadgesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myBadgesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MyBadges = AutoDisposeAsyncNotifier<List<BadgeEntity>>;
String _$badgeUnlocksHash() => r'40608faf19b526411a455b7060a1463a868920e3';

/// Newly-unlocked badges not yet celebrated. MainShell watches this and pops
/// the unlock overlay; dismissing calls [markSeen].
///
/// Copied from [BadgeUnlocks].
@ProviderFor(BadgeUnlocks)
final badgeUnlocksProvider =
    AutoDisposeAsyncNotifierProvider<BadgeUnlocks, List<BadgeEntity>>.internal(
      BadgeUnlocks.new,
      name: r'badgeUnlocksProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$badgeUnlocksHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BadgeUnlocks = AutoDisposeAsyncNotifier<List<BadgeEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
