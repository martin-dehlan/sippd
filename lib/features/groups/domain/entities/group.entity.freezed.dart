// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GroupEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get inviteCode => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  int get wineCount => throw _privateConstructorUsedError;

  /// Create a copy of GroupEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupEntityCopyWith<GroupEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupEntityCopyWith<$Res> {
  factory $GroupEntityCopyWith(
    GroupEntity value,
    $Res Function(GroupEntity) then,
  ) = _$GroupEntityCopyWithImpl<$Res, GroupEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String inviteCode,
    String createdBy,
    DateTime createdAt,
    int memberCount,
    int wineCount,
  });
}

/// @nodoc
class _$GroupEntityCopyWithImpl<$Res, $Val extends GroupEntity>
    implements $GroupEntityCopyWith<$Res> {
  _$GroupEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? inviteCode = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? memberCount = null,
    Object? wineCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            inviteCode: null == inviteCode
                ? _value.inviteCode
                : inviteCode // ignore: cast_nullable_to_non_nullable
                      as String,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            memberCount: null == memberCount
                ? _value.memberCount
                : memberCount // ignore: cast_nullable_to_non_nullable
                      as int,
            wineCount: null == wineCount
                ? _value.wineCount
                : wineCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupEntityImplCopyWith<$Res>
    implements $GroupEntityCopyWith<$Res> {
  factory _$$GroupEntityImplCopyWith(
    _$GroupEntityImpl value,
    $Res Function(_$GroupEntityImpl) then,
  ) = __$$GroupEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String inviteCode,
    String createdBy,
    DateTime createdAt,
    int memberCount,
    int wineCount,
  });
}

/// @nodoc
class __$$GroupEntityImplCopyWithImpl<$Res>
    extends _$GroupEntityCopyWithImpl<$Res, _$GroupEntityImpl>
    implements _$$GroupEntityImplCopyWith<$Res> {
  __$$GroupEntityImplCopyWithImpl(
    _$GroupEntityImpl _value,
    $Res Function(_$GroupEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? inviteCode = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? memberCount = null,
    Object? wineCount = null,
  }) {
    return _then(
      _$GroupEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviteCode: null == inviteCode
            ? _value.inviteCode
            : inviteCode // ignore: cast_nullable_to_non_nullable
                  as String,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        memberCount: null == memberCount
            ? _value.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as int,
        wineCount: null == wineCount
            ? _value.wineCount
            : wineCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$GroupEntityImpl implements _GroupEntity {
  const _$GroupEntityImpl({
    required this.id,
    required this.name,
    this.description,
    required this.inviteCode,
    required this.createdBy,
    required this.createdAt,
    this.memberCount = 0,
    this.wineCount = 0,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String inviteCode;
  @override
  final String createdBy;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int memberCount;
  @override
  @JsonKey()
  final int wineCount;

  @override
  String toString() {
    return 'GroupEntity(id: $id, name: $name, description: $description, inviteCode: $inviteCode, createdBy: $createdBy, createdAt: $createdAt, memberCount: $memberCount, wineCount: $wineCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.wineCount, wineCount) ||
                other.wineCount == wineCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    inviteCode,
    createdBy,
    createdAt,
    memberCount,
    wineCount,
  );

  /// Create a copy of GroupEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupEntityImplCopyWith<_$GroupEntityImpl> get copyWith =>
      __$$GroupEntityImplCopyWithImpl<_$GroupEntityImpl>(this, _$identity);
}

abstract class _GroupEntity implements GroupEntity {
  const factory _GroupEntity({
    required final String id,
    required final String name,
    final String? description,
    required final String inviteCode,
    required final String createdBy,
    required final DateTime createdAt,
    final int memberCount,
    final int wineCount,
  }) = _$GroupEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get inviteCode;
  @override
  String get createdBy;
  @override
  DateTime get createdAt;
  @override
  int get memberCount;
  @override
  int get wineCount;

  /// Create a copy of GroupEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupEntityImplCopyWith<_$GroupEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GroupMemberEntity {
  String get groupId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Create a copy of GroupMemberEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupMemberEntityCopyWith<GroupMemberEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupMemberEntityCopyWith<$Res> {
  factory $GroupMemberEntityCopyWith(
    GroupMemberEntity value,
    $Res Function(GroupMemberEntity) then,
  ) = _$GroupMemberEntityCopyWithImpl<$Res, GroupMemberEntity>;
  @useResult
  $Res call({
    String groupId,
    String userId,
    String role,
    String? displayName,
    DateTime joinedAt,
  });
}

/// @nodoc
class _$GroupMemberEntityCopyWithImpl<$Res, $Val extends GroupMemberEntity>
    implements $GroupMemberEntityCopyWith<$Res> {
  _$GroupMemberEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupMemberEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
    Object? displayName = freezed,
    Object? joinedAt = null,
  }) {
    return _then(
      _value.copyWith(
            groupId: null == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            joinedAt: null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupMemberEntityImplCopyWith<$Res>
    implements $GroupMemberEntityCopyWith<$Res> {
  factory _$$GroupMemberEntityImplCopyWith(
    _$GroupMemberEntityImpl value,
    $Res Function(_$GroupMemberEntityImpl) then,
  ) = __$$GroupMemberEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String groupId,
    String userId,
    String role,
    String? displayName,
    DateTime joinedAt,
  });
}

/// @nodoc
class __$$GroupMemberEntityImplCopyWithImpl<$Res>
    extends _$GroupMemberEntityCopyWithImpl<$Res, _$GroupMemberEntityImpl>
    implements _$$GroupMemberEntityImplCopyWith<$Res> {
  __$$GroupMemberEntityImplCopyWithImpl(
    _$GroupMemberEntityImpl _value,
    $Res Function(_$GroupMemberEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupMemberEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
    Object? displayName = freezed,
    Object? joinedAt = null,
  }) {
    return _then(
      _$GroupMemberEntityImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        joinedAt: null == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$GroupMemberEntityImpl implements _GroupMemberEntity {
  const _$GroupMemberEntityImpl({
    required this.groupId,
    required this.userId,
    required this.role,
    this.displayName,
    required this.joinedAt,
  });

  @override
  final String groupId;
  @override
  final String userId;
  @override
  final String role;
  @override
  final String? displayName;
  @override
  final DateTime joinedAt;

  @override
  String toString() {
    return 'GroupMemberEntity(groupId: $groupId, userId: $userId, role: $role, displayName: $displayName, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupMemberEntityImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, groupId, userId, role, displayName, joinedAt);

  /// Create a copy of GroupMemberEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupMemberEntityImplCopyWith<_$GroupMemberEntityImpl> get copyWith =>
      __$$GroupMemberEntityImplCopyWithImpl<_$GroupMemberEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _GroupMemberEntity implements GroupMemberEntity {
  const factory _GroupMemberEntity({
    required final String groupId,
    required final String userId,
    required final String role,
    final String? displayName,
    required final DateTime joinedAt,
  }) = _$GroupMemberEntityImpl;

  @override
  String get groupId;
  @override
  String get userId;
  @override
  String get role;
  @override
  String? get displayName;
  @override
  DateTime get joinedAt;

  /// Create a copy of GroupMemberEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupMemberEntityImplCopyWith<_$GroupMemberEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
