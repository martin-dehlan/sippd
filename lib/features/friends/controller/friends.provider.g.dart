// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$friendsRepositoryHash() => r'ac60c67ed00f919e917fe8a502958a439b84df69';

/// See also [friendsRepository].
@ProviderFor(friendsRepository)
final friendsRepositoryProvider =
    AutoDisposeProvider<FriendsRepository?>.internal(
      friendsRepository,
      name: r'friendsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$friendsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FriendsRepositoryRef = AutoDisposeProviderRef<FriendsRepository?>;
String _$friendsListHash() => r'25536ec44fa271d085fd53d71e9952a970bd9834';

/// See also [friendsList].
@ProviderFor(friendsList)
final friendsListProvider =
    AutoDisposeStreamProvider<List<FriendProfileEntity>>.internal(
      friendsList,
      name: r'friendsListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$friendsListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FriendsListRef =
    AutoDisposeStreamProviderRef<List<FriendProfileEntity>>;
String _$incomingFriendRequestsHash() =>
    r'87493116e8a2c986e157b544dcde5b83c1870016';

/// See also [incomingFriendRequests].
@ProviderFor(incomingFriendRequests)
final incomingFriendRequestsProvider =
    AutoDisposeStreamProvider<List<FriendRequestEntity>>.internal(
      incomingFriendRequests,
      name: r'incomingFriendRequestsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$incomingFriendRequestsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IncomingFriendRequestsRef =
    AutoDisposeStreamProviderRef<List<FriendRequestEntity>>;
String _$outgoingFriendRequestsHash() =>
    r'4172bcaaa46b6b2a65268ebfc9a9b3c99204f55f';

/// See also [outgoingFriendRequests].
@ProviderFor(outgoingFriendRequests)
final outgoingFriendRequestsProvider =
    AutoDisposeStreamProvider<List<FriendRequestEntity>>.internal(
      outgoingFriendRequests,
      name: r'outgoingFriendRequestsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$outgoingFriendRequestsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OutgoingFriendRequestsRef =
    AutoDisposeStreamProviderRef<List<FriendRequestEntity>>;
String _$friendWinesApiHash() => r'44dfe4290ade04ca689fc5816f16af8c2f4596d4';

/// See also [friendWinesApi].
@ProviderFor(friendWinesApi)
final friendWinesApiProvider = AutoDisposeProvider<FriendWinesApi?>.internal(
  friendWinesApi,
  name: r'friendWinesApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$friendWinesApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FriendWinesApiRef = AutoDisposeProviderRef<FriendWinesApi?>;
String _$friendWinesHash() => r'890d0d27e9a54c5bf853570d6950a97d2b6e0226';

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

/// See also [friendWines].
@ProviderFor(friendWines)
const friendWinesProvider = FriendWinesFamily();

/// See also [friendWines].
class FriendWinesFamily extends Family<AsyncValue<List<WineEntity>>> {
  /// See also [friendWines].
  const FriendWinesFamily();

  /// See also [friendWines].
  FriendWinesProvider call(String friendId) {
    return FriendWinesProvider(friendId);
  }

  @override
  FriendWinesProvider getProviderOverride(
    covariant FriendWinesProvider provider,
  ) {
    return call(provider.friendId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'friendWinesProvider';
}

/// See also [friendWines].
class FriendWinesProvider extends AutoDisposeFutureProvider<List<WineEntity>> {
  /// See also [friendWines].
  FriendWinesProvider(String friendId)
    : this._internal(
        (ref) => friendWines(ref as FriendWinesRef, friendId),
        from: friendWinesProvider,
        name: r'friendWinesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$friendWinesHash,
        dependencies: FriendWinesFamily._dependencies,
        allTransitiveDependencies: FriendWinesFamily._allTransitiveDependencies,
        friendId: friendId,
      );

  FriendWinesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.friendId,
  }) : super.internal();

  final String friendId;

  @override
  Override overrideWith(
    FutureOr<List<WineEntity>> Function(FriendWinesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FriendWinesProvider._internal(
        (ref) => create(ref as FriendWinesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        friendId: friendId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WineEntity>> createElement() {
    return _FriendWinesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendWinesProvider && other.friendId == friendId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, friendId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FriendWinesRef on AutoDisposeFutureProviderRef<List<WineEntity>> {
  /// The parameter `friendId` of this provider.
  String get friendId;
}

class _FriendWinesProviderElement
    extends AutoDisposeFutureProviderElement<List<WineEntity>>
    with FriendWinesRef {
  _FriendWinesProviderElement(super.provider);

  @override
  String get friendId => (origin as FriendWinesProvider).friendId;
}

String _$activityApiHash() => r'91514b9a29f8f9ece6042f8000caa83362750405';

/// See also [activityApi].
@ProviderFor(activityApi)
final activityApiProvider = AutoDisposeProvider<ActivityApi?>.internal(
  activityApi,
  name: r'activityApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activityApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActivityApiRef = AutoDisposeProviderRef<ActivityApi?>;
String _$activityFeedHash() => r'b1977880a268e2ae0d1e5021738093aabc513251';

/// See also [activityFeed].
@ProviderFor(activityFeed)
final activityFeedProvider =
    AutoDisposeFutureProvider<List<ActivityItemEntity>>.internal(
      activityFeed,
      name: r'activityFeedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activityFeedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActivityFeedRef =
    AutoDisposeFutureProviderRef<List<ActivityItemEntity>>;
String _$friendProfileHash() => r'66e1cf653e9a63301eeed9b3cd317b0416d514e0';

/// See also [friendProfile].
@ProviderFor(friendProfile)
const friendProfileProvider = FriendProfileFamily();

/// See also [friendProfile].
class FriendProfileFamily extends Family<AsyncValue<FriendProfileEntity?>> {
  /// See also [friendProfile].
  const FriendProfileFamily();

  /// See also [friendProfile].
  FriendProfileProvider call(String friendId) {
    return FriendProfileProvider(friendId);
  }

  @override
  FriendProfileProvider getProviderOverride(
    covariant FriendProfileProvider provider,
  ) {
    return call(provider.friendId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'friendProfileProvider';
}

/// See also [friendProfile].
class FriendProfileProvider
    extends AutoDisposeFutureProvider<FriendProfileEntity?> {
  /// See also [friendProfile].
  FriendProfileProvider(String friendId)
    : this._internal(
        (ref) => friendProfile(ref as FriendProfileRef, friendId),
        from: friendProfileProvider,
        name: r'friendProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$friendProfileHash,
        dependencies: FriendProfileFamily._dependencies,
        allTransitiveDependencies:
            FriendProfileFamily._allTransitiveDependencies,
        friendId: friendId,
      );

  FriendProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.friendId,
  }) : super.internal();

  final String friendId;

  @override
  Override overrideWith(
    FutureOr<FriendProfileEntity?> Function(FriendProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FriendProfileProvider._internal(
        (ref) => create(ref as FriendProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        friendId: friendId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FriendProfileEntity?> createElement() {
    return _FriendProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FriendProfileProvider && other.friendId == friendId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, friendId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FriendProfileRef on AutoDisposeFutureProviderRef<FriendProfileEntity?> {
  /// The parameter `friendId` of this provider.
  String get friendId;
}

class _FriendProfileProviderElement
    extends AutoDisposeFutureProviderElement<FriendProfileEntity?>
    with FriendProfileRef {
  _FriendProfileProviderElement(super.provider);

  @override
  String get friendId => (origin as FriendProfileProvider).friendId;
}

String _$friendSearchControllerHash() =>
    r'169607c274c65bfd2850b8cca2c4a1132d4260e4';

/// See also [FriendSearchController].
@ProviderFor(FriendSearchController)
final friendSearchControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      FriendSearchController,
      List<FriendProfileEntity>
    >.internal(
      FriendSearchController.new,
      name: r'friendSearchControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$friendSearchControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FriendSearchController =
    AutoDisposeAsyncNotifier<List<FriendProfileEntity>>;
String _$friendsControllerHash() => r'da95ecad091a8df7a99583bf095f556f550a9b9d';

/// See also [FriendsController].
@ProviderFor(FriendsController)
final friendsControllerProvider =
    AutoDisposeAsyncNotifierProvider<FriendsController, void>.internal(
      FriendsController.new,
      name: r'friendsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$friendsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FriendsController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
