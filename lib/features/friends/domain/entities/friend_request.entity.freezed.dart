// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FriendRequestEntity {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  FriendRequestStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  FriendProfileEntity? get senderProfile => throw _privateConstructorUsedError;
  FriendProfileEntity? get receiverProfile =>
      throw _privateConstructorUsedError;

  /// Create a copy of FriendRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRequestEntityCopyWith<FriendRequestEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRequestEntityCopyWith<$Res> {
  factory $FriendRequestEntityCopyWith(
    FriendRequestEntity value,
    $Res Function(FriendRequestEntity) then,
  ) = _$FriendRequestEntityCopyWithImpl<$Res, FriendRequestEntity>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String receiverId,
    FriendRequestStatus status,
    DateTime createdAt,
    FriendProfileEntity? senderProfile,
    FriendProfileEntity? receiverProfile,
  });

  $FriendProfileEntityCopyWith<$Res>? get senderProfile;
  $FriendProfileEntityCopyWith<$Res>? get receiverProfile;
}

/// @nodoc
class _$FriendRequestEntityCopyWithImpl<$Res, $Val extends FriendRequestEntity>
    implements $FriendRequestEntityCopyWith<$Res> {
  _$FriendRequestEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? senderProfile = freezed,
    Object? receiverProfile = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverId: null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as FriendRequestStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            senderProfile: freezed == senderProfile
                ? _value.senderProfile
                : senderProfile // ignore: cast_nullable_to_non_nullable
                      as FriendProfileEntity?,
            receiverProfile: freezed == receiverProfile
                ? _value.receiverProfile
                : receiverProfile // ignore: cast_nullable_to_non_nullable
                      as FriendProfileEntity?,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendProfileEntityCopyWith<$Res>? get senderProfile {
    if (_value.senderProfile == null) {
      return null;
    }

    return $FriendProfileEntityCopyWith<$Res>(_value.senderProfile!, (value) {
      return _then(_value.copyWith(senderProfile: value) as $Val);
    });
  }

  /// Create a copy of FriendRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendProfileEntityCopyWith<$Res>? get receiverProfile {
    if (_value.receiverProfile == null) {
      return null;
    }

    return $FriendProfileEntityCopyWith<$Res>(_value.receiverProfile!, (value) {
      return _then(_value.copyWith(receiverProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendRequestEntityImplCopyWith<$Res>
    implements $FriendRequestEntityCopyWith<$Res> {
  factory _$$FriendRequestEntityImplCopyWith(
    _$FriendRequestEntityImpl value,
    $Res Function(_$FriendRequestEntityImpl) then,
  ) = __$$FriendRequestEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String receiverId,
    FriendRequestStatus status,
    DateTime createdAt,
    FriendProfileEntity? senderProfile,
    FriendProfileEntity? receiverProfile,
  });

  @override
  $FriendProfileEntityCopyWith<$Res>? get senderProfile;
  @override
  $FriendProfileEntityCopyWith<$Res>? get receiverProfile;
}

/// @nodoc
class __$$FriendRequestEntityImplCopyWithImpl<$Res>
    extends _$FriendRequestEntityCopyWithImpl<$Res, _$FriendRequestEntityImpl>
    implements _$$FriendRequestEntityImplCopyWith<$Res> {
  __$$FriendRequestEntityImplCopyWithImpl(
    _$FriendRequestEntityImpl _value,
    $Res Function(_$FriendRequestEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? senderProfile = freezed,
    Object? receiverProfile = freezed,
  }) {
    return _then(
      _$FriendRequestEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverId: null == receiverId
            ? _value.receiverId
            : receiverId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as FriendRequestStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        senderProfile: freezed == senderProfile
            ? _value.senderProfile
            : senderProfile // ignore: cast_nullable_to_non_nullable
                  as FriendProfileEntity?,
        receiverProfile: freezed == receiverProfile
            ? _value.receiverProfile
            : receiverProfile // ignore: cast_nullable_to_non_nullable
                  as FriendProfileEntity?,
      ),
    );
  }
}

/// @nodoc

class _$FriendRequestEntityImpl implements _FriendRequestEntity {
  const _$FriendRequestEntityImpl({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.status,
    required this.createdAt,
    this.senderProfile,
    this.receiverProfile,
  });

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String receiverId;
  @override
  final FriendRequestStatus status;
  @override
  final DateTime createdAt;
  @override
  final FriendProfileEntity? senderProfile;
  @override
  final FriendProfileEntity? receiverProfile;

  @override
  String toString() {
    return 'FriendRequestEntity(id: $id, senderId: $senderId, receiverId: $receiverId, status: $status, createdAt: $createdAt, senderProfile: $senderProfile, receiverProfile: $receiverProfile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRequestEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.senderProfile, senderProfile) ||
                other.senderProfile == senderProfile) &&
            (identical(other.receiverProfile, receiverProfile) ||
                other.receiverProfile == receiverProfile));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    receiverId,
    status,
    createdAt,
    senderProfile,
    receiverProfile,
  );

  /// Create a copy of FriendRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRequestEntityImplCopyWith<_$FriendRequestEntityImpl> get copyWith =>
      __$$FriendRequestEntityImplCopyWithImpl<_$FriendRequestEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _FriendRequestEntity implements FriendRequestEntity {
  const factory _FriendRequestEntity({
    required final String id,
    required final String senderId,
    required final String receiverId,
    required final FriendRequestStatus status,
    required final DateTime createdAt,
    final FriendProfileEntity? senderProfile,
    final FriendProfileEntity? receiverProfile,
  }) = _$FriendRequestEntityImpl;

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get receiverId;
  @override
  FriendRequestStatus get status;
  @override
  DateTime get createdAt;
  @override
  FriendProfileEntity? get senderProfile;
  @override
  FriendProfileEntity? get receiverProfile;

  /// Create a copy of FriendRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRequestEntityImplCopyWith<_$FriendRequestEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
