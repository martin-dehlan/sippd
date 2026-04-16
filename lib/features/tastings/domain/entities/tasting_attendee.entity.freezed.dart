// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasting_attendee.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TastingAttendeeEntity {
  String get tastingId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  RsvpStatus get status => throw _privateConstructorUsedError;
  FriendProfileEntity? get profile => throw _privateConstructorUsedError;

  /// Create a copy of TastingAttendeeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TastingAttendeeEntityCopyWith<TastingAttendeeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TastingAttendeeEntityCopyWith<$Res> {
  factory $TastingAttendeeEntityCopyWith(
    TastingAttendeeEntity value,
    $Res Function(TastingAttendeeEntity) then,
  ) = _$TastingAttendeeEntityCopyWithImpl<$Res, TastingAttendeeEntity>;
  @useResult
  $Res call({
    String tastingId,
    String userId,
    RsvpStatus status,
    FriendProfileEntity? profile,
  });

  $FriendProfileEntityCopyWith<$Res>? get profile;
}

/// @nodoc
class _$TastingAttendeeEntityCopyWithImpl<
  $Res,
  $Val extends TastingAttendeeEntity
>
    implements $TastingAttendeeEntityCopyWith<$Res> {
  _$TastingAttendeeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TastingAttendeeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tastingId = null,
    Object? userId = null,
    Object? status = null,
    Object? profile = freezed,
  }) {
    return _then(
      _value.copyWith(
            tastingId: null == tastingId
                ? _value.tastingId
                : tastingId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RsvpStatus,
            profile: freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as FriendProfileEntity?,
          )
          as $Val,
    );
  }

  /// Create a copy of TastingAttendeeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendProfileEntityCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $FriendProfileEntityCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TastingAttendeeEntityImplCopyWith<$Res>
    implements $TastingAttendeeEntityCopyWith<$Res> {
  factory _$$TastingAttendeeEntityImplCopyWith(
    _$TastingAttendeeEntityImpl value,
    $Res Function(_$TastingAttendeeEntityImpl) then,
  ) = __$$TastingAttendeeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String tastingId,
    String userId,
    RsvpStatus status,
    FriendProfileEntity? profile,
  });

  @override
  $FriendProfileEntityCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$TastingAttendeeEntityImplCopyWithImpl<$Res>
    extends
        _$TastingAttendeeEntityCopyWithImpl<$Res, _$TastingAttendeeEntityImpl>
    implements _$$TastingAttendeeEntityImplCopyWith<$Res> {
  __$$TastingAttendeeEntityImplCopyWithImpl(
    _$TastingAttendeeEntityImpl _value,
    $Res Function(_$TastingAttendeeEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TastingAttendeeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tastingId = null,
    Object? userId = null,
    Object? status = null,
    Object? profile = freezed,
  }) {
    return _then(
      _$TastingAttendeeEntityImpl(
        tastingId: null == tastingId
            ? _value.tastingId
            : tastingId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RsvpStatus,
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as FriendProfileEntity?,
      ),
    );
  }
}

/// @nodoc

class _$TastingAttendeeEntityImpl implements _TastingAttendeeEntity {
  const _$TastingAttendeeEntityImpl({
    required this.tastingId,
    required this.userId,
    required this.status,
    this.profile,
  });

  @override
  final String tastingId;
  @override
  final String userId;
  @override
  final RsvpStatus status;
  @override
  final FriendProfileEntity? profile;

  @override
  String toString() {
    return 'TastingAttendeeEntity(tastingId: $tastingId, userId: $userId, status: $status, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TastingAttendeeEntityImpl &&
            (identical(other.tastingId, tastingId) ||
                other.tastingId == tastingId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tastingId, userId, status, profile);

  /// Create a copy of TastingAttendeeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TastingAttendeeEntityImplCopyWith<_$TastingAttendeeEntityImpl>
  get copyWith =>
      __$$TastingAttendeeEntityImplCopyWithImpl<_$TastingAttendeeEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _TastingAttendeeEntity implements TastingAttendeeEntity {
  const factory _TastingAttendeeEntity({
    required final String tastingId,
    required final String userId,
    required final RsvpStatus status,
    final FriendProfileEntity? profile,
  }) = _$TastingAttendeeEntityImpl;

  @override
  String get tastingId;
  @override
  String get userId;
  @override
  RsvpStatus get status;
  @override
  FriendProfileEntity? get profile;

  /// Create a copy of TastingAttendeeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TastingAttendeeEntityImplCopyWith<_$TastingAttendeeEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
