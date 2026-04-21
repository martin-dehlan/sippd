// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_invitation.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupInvitationModel _$GroupInvitationModelFromJson(Map<String, dynamic> json) {
  return _GroupInvitationModel.fromJson(json);
}

/// @nodoc
mixin _$GroupInvitationModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'inviter_id')
  String get inviterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'invitee_id')
  String get inviteeId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'responded_at')
  DateTime? get respondedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupInvitationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupInvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupInvitationModelCopyWith<GroupInvitationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupInvitationModelCopyWith<$Res> {
  factory $GroupInvitationModelCopyWith(
    GroupInvitationModel value,
    $Res Function(GroupInvitationModel) then,
  ) = _$GroupInvitationModelCopyWithImpl<$Res, GroupInvitationModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'group_id') String groupId,
    @JsonKey(name: 'inviter_id') String inviterId,
    @JsonKey(name: 'invitee_id') String inviteeId,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
  });
}

/// @nodoc
class _$GroupInvitationModelCopyWithImpl<
  $Res,
  $Val extends GroupInvitationModel
>
    implements $GroupInvitationModelCopyWith<$Res> {
  _$GroupInvitationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupInvitationModel
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
                      as String,
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
abstract class _$$GroupInvitationModelImplCopyWith<$Res>
    implements $GroupInvitationModelCopyWith<$Res> {
  factory _$$GroupInvitationModelImplCopyWith(
    _$GroupInvitationModelImpl value,
    $Res Function(_$GroupInvitationModelImpl) then,
  ) = __$$GroupInvitationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'group_id') String groupId,
    @JsonKey(name: 'inviter_id') String inviterId,
    @JsonKey(name: 'invitee_id') String inviteeId,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
  });
}

/// @nodoc
class __$$GroupInvitationModelImplCopyWithImpl<$Res>
    extends _$GroupInvitationModelCopyWithImpl<$Res, _$GroupInvitationModelImpl>
    implements _$$GroupInvitationModelImplCopyWith<$Res> {
  __$$GroupInvitationModelImplCopyWithImpl(
    _$GroupInvitationModelImpl _value,
    $Res Function(_$GroupInvitationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupInvitationModel
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
      _$GroupInvitationModelImpl(
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
                  as String,
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
@JsonSerializable()
class _$GroupInvitationModelImpl implements _GroupInvitationModel {
  const _$GroupInvitationModelImpl({
    required this.id,
    @JsonKey(name: 'group_id') required this.groupId,
    @JsonKey(name: 'inviter_id') required this.inviterId,
    @JsonKey(name: 'invitee_id') required this.inviteeId,
    required this.status,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'responded_at') this.respondedAt,
  });

  factory _$GroupInvitationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupInvitationModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(name: 'inviter_id')
  final String inviterId;
  @override
  @JsonKey(name: 'invitee_id')
  final String inviteeId;
  @override
  final String status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'responded_at')
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'GroupInvitationModel(id: $id, groupId: $groupId, inviterId: $inviterId, inviteeId: $inviteeId, status: $status, createdAt: $createdAt, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupInvitationModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of GroupInvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupInvitationModelImplCopyWith<_$GroupInvitationModelImpl>
  get copyWith =>
      __$$GroupInvitationModelImplCopyWithImpl<_$GroupInvitationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupInvitationModelImplToJson(this);
  }
}

abstract class _GroupInvitationModel implements GroupInvitationModel {
  const factory _GroupInvitationModel({
    required final String id,
    @JsonKey(name: 'group_id') required final String groupId,
    @JsonKey(name: 'inviter_id') required final String inviterId,
    @JsonKey(name: 'invitee_id') required final String inviteeId,
    required final String status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'responded_at') final DateTime? respondedAt,
  }) = _$GroupInvitationModelImpl;

  factory _GroupInvitationModel.fromJson(Map<String, dynamic> json) =
      _$GroupInvitationModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  @JsonKey(name: 'inviter_id')
  String get inviterId;
  @override
  @JsonKey(name: 'invitee_id')
  String get inviteeId;
  @override
  String get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'responded_at')
  DateTime? get respondedAt;

  /// Create a copy of GroupInvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupInvitationModelImplCopyWith<_$GroupInvitationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
