// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_invitation.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GroupInvitationEntity {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get inviterId => throw _privateConstructorUsedError;
  String get inviteeId => throw _privateConstructorUsedError;
  GroupInvitationStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;

  /// Create a copy of GroupInvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupInvitationEntityCopyWith<GroupInvitationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupInvitationEntityCopyWith<$Res> {
  factory $GroupInvitationEntityCopyWith(
    GroupInvitationEntity value,
    $Res Function(GroupInvitationEntity) then,
  ) = _$GroupInvitationEntityCopyWithImpl<$Res, GroupInvitationEntity>;
  @useResult
  $Res call({
    String id,
    String groupId,
    String inviterId,
    String inviteeId,
    GroupInvitationStatus status,
    DateTime createdAt,
    DateTime? respondedAt,
  });
}

/// @nodoc
class _$GroupInvitationEntityCopyWithImpl<
  $Res,
  $Val extends GroupInvitationEntity
>
    implements $GroupInvitationEntityCopyWith<$Res> {
  _$GroupInvitationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupInvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? inviterId = null,
    Object? inviteeId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            groupId: null == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String,
            inviterId: null == inviterId
                ? _value.inviterId
                : inviterId // ignore: cast_nullable_to_non_nullable
                      as String,
            inviteeId: null == inviteeId
                ? _value.inviteeId
                : inviteeId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GroupInvitationStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupInvitationEntityImplCopyWith<$Res>
    implements $GroupInvitationEntityCopyWith<$Res> {
  factory _$$GroupInvitationEntityImplCopyWith(
    _$GroupInvitationEntityImpl value,
    $Res Function(_$GroupInvitationEntityImpl) then,
  ) = __$$GroupInvitationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String groupId,
    String inviterId,
    String inviteeId,
    GroupInvitationStatus status,
    DateTime createdAt,
    DateTime? respondedAt,
  });
}

/// @nodoc
class __$$GroupInvitationEntityImplCopyWithImpl<$Res>
    extends
        _$GroupInvitationEntityCopyWithImpl<$Res, _$GroupInvitationEntityImpl>
    implements _$$GroupInvitationEntityImplCopyWith<$Res> {
  __$$GroupInvitationEntityImplCopyWithImpl(
    _$GroupInvitationEntityImpl _value,
    $Res Function(_$GroupInvitationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupInvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? inviterId = null,
    Object? inviteeId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _$GroupInvitationEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        inviterId: null == inviterId
            ? _value.inviterId
            : inviterId // ignore: cast_nullable_to_non_nullable
                  as String,
        inviteeId: null == inviteeId
            ? _value.inviteeId
            : inviteeId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GroupInvitationStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$GroupInvitationEntityImpl implements _GroupInvitationEntity {
  const _$GroupInvitationEntityImpl({
    required this.id,
    required this.groupId,
    required this.inviterId,
    required this.inviteeId,
    required this.status,
    required this.createdAt,
    this.respondedAt,
  });

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String inviterId;
  @override
  final String inviteeId;
  @override
  final GroupInvitationStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'GroupInvitationEntity(id: $id, groupId: $groupId, inviterId: $inviterId, inviteeId: $inviteeId, status: $status, createdAt: $createdAt, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupInvitationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.inviterId, inviterId) ||
                other.inviterId == inviterId) &&
            (identical(other.inviteeId, inviteeId) ||
                other.inviteeId == inviteeId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    groupId,
    inviterId,
    inviteeId,
    status,
    createdAt,
    respondedAt,
  );

  /// Create a copy of GroupInvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupInvitationEntityImplCopyWith<_$GroupInvitationEntityImpl>
  get copyWith =>
      __$$GroupInvitationEntityImplCopyWithImpl<_$GroupInvitationEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _GroupInvitationEntity implements GroupInvitationEntity {
  const factory _GroupInvitationEntity({
    required final String id,
    required final String groupId,
    required final String inviterId,
    required final String inviteeId,
    required final GroupInvitationStatus status,
    required final DateTime createdAt,
    final DateTime? respondedAt,
  }) = _$GroupInvitationEntityImpl;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get inviterId;
  @override
  String get inviteeId;
  @override
  GroupInvitationStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get respondedAt;

  /// Create a copy of GroupInvitationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupInvitationEntityImplCopyWith<_$GroupInvitationEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GroupInvitationInboxItem {
  GroupInvitationEntity get invitation => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;
  String? get groupImageUrl => throw _privateConstructorUsedError;
  String? get inviterDisplayName => throw _privateConstructorUsedError;
  String? get inviterUsername => throw _privateConstructorUsedError;
  String? get inviterAvatarUrl => throw _privateConstructorUsedError;

  /// Create a copy of GroupInvitationInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupInvitationInboxItemCopyWith<GroupInvitationInboxItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupInvitationInboxItemCopyWith<$Res> {
  factory $GroupInvitationInboxItemCopyWith(
    GroupInvitationInboxItem value,
    $Res Function(GroupInvitationInboxItem) then,
  ) = _$GroupInvitationInboxItemCopyWithImpl<$Res, GroupInvitationInboxItem>;
  @useResult
  $Res call({
    GroupInvitationEntity invitation,
    String groupName,
    String? groupImageUrl,
    String? inviterDisplayName,
    String? inviterUsername,
    String? inviterAvatarUrl,
  });

  $GroupInvitationEntityCopyWith<$Res> get invitation;
}

/// @nodoc
class _$GroupInvitationInboxItemCopyWithImpl<
  $Res,
  $Val extends GroupInvitationInboxItem
>
    implements $GroupInvitationInboxItemCopyWith<$Res> {
  _$GroupInvitationInboxItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupInvitationInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitation = null,
    Object? groupName = null,
    Object? groupImageUrl = freezed,
    Object? inviterDisplayName = freezed,
    Object? inviterUsername = freezed,
    Object? inviterAvatarUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            invitation: null == invitation
                ? _value.invitation
                : invitation // ignore: cast_nullable_to_non_nullable
                      as GroupInvitationEntity,
            groupName: null == groupName
                ? _value.groupName
                : groupName // ignore: cast_nullable_to_non_nullable
                      as String,
            groupImageUrl: freezed == groupImageUrl
                ? _value.groupImageUrl
                : groupImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviterDisplayName: freezed == inviterDisplayName
                ? _value.inviterDisplayName
                : inviterDisplayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviterUsername: freezed == inviterUsername
                ? _value.inviterUsername
                : inviterUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviterAvatarUrl: freezed == inviterAvatarUrl
                ? _value.inviterAvatarUrl
                : inviterAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupInvitationInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupInvitationEntityCopyWith<$Res> get invitation {
    return $GroupInvitationEntityCopyWith<$Res>(_value.invitation, (value) {
      return _then(_value.copyWith(invitation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupInvitationInboxItemImplCopyWith<$Res>
    implements $GroupInvitationInboxItemCopyWith<$Res> {
  factory _$$GroupInvitationInboxItemImplCopyWith(
    _$GroupInvitationInboxItemImpl value,
    $Res Function(_$GroupInvitationInboxItemImpl) then,
  ) = __$$GroupInvitationInboxItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GroupInvitationEntity invitation,
    String groupName,
    String? groupImageUrl,
    String? inviterDisplayName,
    String? inviterUsername,
    String? inviterAvatarUrl,
  });

  @override
  $GroupInvitationEntityCopyWith<$Res> get invitation;
}

/// @nodoc
class __$$GroupInvitationInboxItemImplCopyWithImpl<$Res>
    extends
        _$GroupInvitationInboxItemCopyWithImpl<
          $Res,
          _$GroupInvitationInboxItemImpl
        >
    implements _$$GroupInvitationInboxItemImplCopyWith<$Res> {
  __$$GroupInvitationInboxItemImplCopyWithImpl(
    _$GroupInvitationInboxItemImpl _value,
    $Res Function(_$GroupInvitationInboxItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupInvitationInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitation = null,
    Object? groupName = null,
    Object? groupImageUrl = freezed,
    Object? inviterDisplayName = freezed,
    Object? inviterUsername = freezed,
    Object? inviterAvatarUrl = freezed,
  }) {
    return _then(
      _$GroupInvitationInboxItemImpl(
        invitation: null == invitation
            ? _value.invitation
            : invitation // ignore: cast_nullable_to_non_nullable
                  as GroupInvitationEntity,
        groupName: null == groupName
            ? _value.groupName
            : groupName // ignore: cast_nullable_to_non_nullable
                  as String,
        groupImageUrl: freezed == groupImageUrl
            ? _value.groupImageUrl
            : groupImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviterDisplayName: freezed == inviterDisplayName
            ? _value.inviterDisplayName
            : inviterDisplayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviterUsername: freezed == inviterUsername
            ? _value.inviterUsername
            : inviterUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviterAvatarUrl: freezed == inviterAvatarUrl
            ? _value.inviterAvatarUrl
            : inviterAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$GroupInvitationInboxItemImpl implements _GroupInvitationInboxItem {
  const _$GroupInvitationInboxItemImpl({
    required this.invitation,
    required this.groupName,
    this.groupImageUrl,
    this.inviterDisplayName,
    this.inviterUsername,
    this.inviterAvatarUrl,
  });

  @override
  final GroupInvitationEntity invitation;
  @override
  final String groupName;
  @override
  final String? groupImageUrl;
  @override
  final String? inviterDisplayName;
  @override
  final String? inviterUsername;
  @override
  final String? inviterAvatarUrl;

  @override
  String toString() {
    return 'GroupInvitationInboxItem(invitation: $invitation, groupName: $groupName, groupImageUrl: $groupImageUrl, inviterDisplayName: $inviterDisplayName, inviterUsername: $inviterUsername, inviterAvatarUrl: $inviterAvatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupInvitationInboxItemImpl &&
            (identical(other.invitation, invitation) ||
                other.invitation == invitation) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.groupImageUrl, groupImageUrl) ||
                other.groupImageUrl == groupImageUrl) &&
            (identical(other.inviterDisplayName, inviterDisplayName) ||
                other.inviterDisplayName == inviterDisplayName) &&
            (identical(other.inviterUsername, inviterUsername) ||
                other.inviterUsername == inviterUsername) &&
            (identical(other.inviterAvatarUrl, inviterAvatarUrl) ||
                other.inviterAvatarUrl == inviterAvatarUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    invitation,
    groupName,
    groupImageUrl,
    inviterDisplayName,
    inviterUsername,
    inviterAvatarUrl,
  );

  /// Create a copy of GroupInvitationInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupInvitationInboxItemImplCopyWith<_$GroupInvitationInboxItemImpl>
  get copyWith =>
      __$$GroupInvitationInboxItemImplCopyWithImpl<
        _$GroupInvitationInboxItemImpl
      >(this, _$identity);
}

abstract class _GroupInvitationInboxItem implements GroupInvitationInboxItem {
  const factory _GroupInvitationInboxItem({
    required final GroupInvitationEntity invitation,
    required final String groupName,
    final String? groupImageUrl,
    final String? inviterDisplayName,
    final String? inviterUsername,
    final String? inviterAvatarUrl,
  }) = _$GroupInvitationInboxItemImpl;

  @override
  GroupInvitationEntity get invitation;
  @override
  String get groupName;
  @override
  String? get groupImageUrl;
  @override
  String? get inviterDisplayName;
  @override
  String? get inviterUsername;
  @override
  String? get inviterAvatarUrl;

  /// Create a copy of GroupInvitationInboxItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupInvitationInboxItemImplCopyWith<_$GroupInvitationInboxItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}
