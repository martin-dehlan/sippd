// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invitation.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invitableGroupsForFriendHash() =>
    r'25c15dcee33a63f74cccf41816510e16704b1b14';

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

/// Groups the current user can invite a friend to:
/// groups they're a member of, minus the ones the friend already joined
/// or already has a pending invite for.
///
/// Copied from [invitableGroupsForFriend].
@ProviderFor(invitableGroupsForFriend)
const invitableGroupsForFriendProvider = InvitableGroupsForFriendFamily();

/// Groups the current user can invite a friend to:
/// groups they're a member of, minus the ones the friend already joined
/// or already has a pending invite for.
///
/// Copied from [invitableGroupsForFriend].
class InvitableGroupsForFriendFamily
    extends
        Family<
          AsyncValue<List<({String groupId, String name, String? imageUrl})>>
        > {
  /// Groups the current user can invite a friend to:
  /// groups they're a member of, minus the ones the friend already joined
  /// or already has a pending invite for.
  ///
  /// Copied from [invitableGroupsForFriend].
  const InvitableGroupsForFriendFamily();

  /// Groups the current user can invite a friend to:
  /// groups they're a member of, minus the ones the friend already joined
  /// or already has a pending invite for.
  ///
  /// Copied from [invitableGroupsForFriend].
  InvitableGroupsForFriendProvider call(String friendId) {
    return InvitableGroupsForFriendProvider(friendId);
  }

  @override
  InvitableGroupsForFriendProvider getProviderOverride(
    covariant InvitableGroupsForFriendProvider provider,
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
  String? get name => r'invitableGroupsForFriendProvider';
}

/// Groups the current user can invite a friend to:
/// groups they're a member of, minus the ones the friend already joined
/// or already has a pending invite for.
///
/// Copied from [invitableGroupsForFriend].
class InvitableGroupsForFriendProvider
    extends
        AutoDisposeFutureProvider<
          List<({String groupId, String name, String? imageUrl})>
        > {
  /// Groups the current user can invite a friend to:
  /// groups they're a member of, minus the ones the friend already joined
  /// or already has a pending invite for.
  ///
  /// Copied from [invitableGroupsForFriend].
  InvitableGroupsForFriendProvider(String friendId)
    : this._internal(
        (ref) => invitableGroupsForFriend(
          ref as InvitableGroupsForFriendRef,
          friendId,
        ),
        from: invitableGroupsForFriendProvider,
        name: r'invitableGroupsForFriendProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$invitableGroupsForFriendHash,
        dependencies: InvitableGroupsForFriendFamily._dependencies,
        allTransitiveDependencies:
            InvitableGroupsForFriendFamily._allTransitiveDependencies,
        friendId: friendId,
      );

  InvitableGroupsForFriendProvider._internal(
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
    FutureOr<List<({String groupId, String name, String? imageUrl})>> Function(
      InvitableGroupsForFriendRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvitableGroupsForFriendProvider._internal(
        (ref) => create(ref as InvitableGroupsForFriendRef),
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
  AutoDisposeFutureProviderElement<
    List<({String groupId, String name, String? imageUrl})>
  >
  createElement() {
    return _InvitableGroupsForFriendProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvitableGroupsForFriendProvider &&
        other.friendId == friendId;
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
mixin InvitableGroupsForFriendRef
    on
        AutoDisposeFutureProviderRef<
          List<({String groupId, String name, String? imageUrl})>
        > {
  /// The parameter `friendId` of this provider.
  String get friendId;
}

class _InvitableGroupsForFriendProviderElement
    extends
        AutoDisposeFutureProviderElement<
          List<({String groupId, String name, String? imageUrl})>
        >
    with InvitableGroupsForFriendRef {
  _InvitableGroupsForFriendProviderElement(super.provider);

  @override
  String get friendId => (origin as InvitableGroupsForFriendProvider).friendId;
}

String _$invitableFriendsForGroupHash() =>
    r'397875879e0cfc69fa2756d9d50855f38d59c12f';

/// Friends of the current user who are not yet in the group and don't
/// already have a pending invite. Used by the group members sheet to
/// offer an "Invite friends" flow.
///
/// Copied from [invitableFriendsForGroup].
@ProviderFor(invitableFriendsForGroup)
const invitableFriendsForGroupProvider = InvitableFriendsForGroupFamily();

/// Friends of the current user who are not yet in the group and don't
/// already have a pending invite. Used by the group members sheet to
/// offer an "Invite friends" flow.
///
/// Copied from [invitableFriendsForGroup].
class InvitableFriendsForGroupFamily
    extends Family<AsyncValue<List<FriendProfileEntity>>> {
  /// Friends of the current user who are not yet in the group and don't
  /// already have a pending invite. Used by the group members sheet to
  /// offer an "Invite friends" flow.
  ///
  /// Copied from [invitableFriendsForGroup].
  const InvitableFriendsForGroupFamily();

  /// Friends of the current user who are not yet in the group and don't
  /// already have a pending invite. Used by the group members sheet to
  /// offer an "Invite friends" flow.
  ///
  /// Copied from [invitableFriendsForGroup].
  InvitableFriendsForGroupProvider call(String groupId) {
    return InvitableFriendsForGroupProvider(groupId);
  }

  @override
  InvitableFriendsForGroupProvider getProviderOverride(
    covariant InvitableFriendsForGroupProvider provider,
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
  String? get name => r'invitableFriendsForGroupProvider';
}

/// Friends of the current user who are not yet in the group and don't
/// already have a pending invite. Used by the group members sheet to
/// offer an "Invite friends" flow.
///
/// Copied from [invitableFriendsForGroup].
class InvitableFriendsForGroupProvider
    extends AutoDisposeFutureProvider<List<FriendProfileEntity>> {
  /// Friends of the current user who are not yet in the group and don't
  /// already have a pending invite. Used by the group members sheet to
  /// offer an "Invite friends" flow.
  ///
  /// Copied from [invitableFriendsForGroup].
  InvitableFriendsForGroupProvider(String groupId)
    : this._internal(
        (ref) => invitableFriendsForGroup(
          ref as InvitableFriendsForGroupRef,
          groupId,
        ),
        from: invitableFriendsForGroupProvider,
        name: r'invitableFriendsForGroupProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$invitableFriendsForGroupHash,
        dependencies: InvitableFriendsForGroupFamily._dependencies,
        allTransitiveDependencies:
            InvitableFriendsForGroupFamily._allTransitiveDependencies,
        groupId: groupId,
      );

  InvitableFriendsForGroupProvider._internal(
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
    FutureOr<List<FriendProfileEntity>> Function(
      InvitableFriendsForGroupRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvitableFriendsForGroupProvider._internal(
        (ref) => create(ref as InvitableFriendsForGroupRef),
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
  AutoDisposeFutureProviderElement<List<FriendProfileEntity>> createElement() {
    return _InvitableFriendsForGroupProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvitableFriendsForGroupProvider &&
        other.groupId == groupId;
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
mixin InvitableFriendsForGroupRef
    on AutoDisposeFutureProviderRef<List<FriendProfileEntity>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _InvitableFriendsForGroupProviderElement
    extends AutoDisposeFutureProviderElement<List<FriendProfileEntity>>
    with InvitableFriendsForGroupRef {
  _InvitableFriendsForGroupProviderElement(super.provider);

  @override
  String get groupId => (origin as InvitableFriendsForGroupProvider).groupId;
}

String _$myGroupInvitationsHash() =>
    r'147d6eeb4e60912c28a72c388c687e4803fcda97';

/// Pending invitations addressed to the current user, enriched with
/// group + inviter info for display in the inbox.
///
/// Copied from [myGroupInvitations].
@ProviderFor(myGroupInvitations)
final myGroupInvitationsProvider =
    AutoDisposeFutureProvider<List<GroupInvitationInboxItem>>.internal(
      myGroupInvitations,
      name: r'myGroupInvitationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myGroupInvitationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyGroupInvitationsRef =
    AutoDisposeFutureProviderRef<List<GroupInvitationInboxItem>>;
String _$groupInvitationControllerHash() =>
    r'153d54f18de534f42ff1b955de40d10a9257c382';

/// See also [GroupInvitationController].
@ProviderFor(GroupInvitationController)
final groupInvitationControllerProvider =
    AutoDisposeNotifierProvider<GroupInvitationController, void>.internal(
      GroupInvitationController.new,
      name: r'groupInvitationControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$groupInvitationControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GroupInvitationController = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
