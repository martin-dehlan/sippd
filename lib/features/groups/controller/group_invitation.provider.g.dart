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

String _$myGroupInvitationsHash() =>
    r'6df929ec2b87d827d1d3ea0dd5b619007f3b8f66';

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
    r'190208e23459cafe9afa3edee99f5d06351f182a';

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
