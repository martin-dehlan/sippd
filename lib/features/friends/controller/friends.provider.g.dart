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
String _$friendsListHash() => r'7f5f3e294b916da3de2f33c070973fbd23f5adb5';

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
    r'8a24d8cfc3ed4b740fe8e1ba05d86971f66027fa';

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
String _$friendsControllerHash() => r'24b9b3d8dfc8aa36d6a8028f531f26cb2b17f71b';

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
