// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_rating.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FriendRatingEntity {
  String get userId => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  DateTime get ratedAt => throw _privateConstructorUsedError;

  /// Create a copy of FriendRatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRatingEntityCopyWith<FriendRatingEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRatingEntityCopyWith<$Res> {
  factory $FriendRatingEntityCopyWith(
    FriendRatingEntity value,
    $Res Function(FriendRatingEntity) then,
  ) = _$FriendRatingEntityCopyWithImpl<$Res, FriendRatingEntity>;
  @useResult
  $Res call({
    String userId,
    String? displayName,
    String? username,
    String? avatarUrl,
    double rating,
    DateTime ratedAt,
  });
}

/// @nodoc
class _$FriendRatingEntityCopyWithImpl<$Res, $Val extends FriendRatingEntity>
    implements $FriendRatingEntityCopyWith<$Res> {
  _$FriendRatingEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = freezed,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? rating = null,
    Object? ratedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            ratedAt: null == ratedAt
                ? _value.ratedAt
                : ratedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendRatingEntityImplCopyWith<$Res>
    implements $FriendRatingEntityCopyWith<$Res> {
  factory _$$FriendRatingEntityImplCopyWith(
    _$FriendRatingEntityImpl value,
    $Res Function(_$FriendRatingEntityImpl) then,
  ) = __$$FriendRatingEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String? displayName,
    String? username,
    String? avatarUrl,
    double rating,
    DateTime ratedAt,
  });
}

/// @nodoc
class __$$FriendRatingEntityImplCopyWithImpl<$Res>
    extends _$FriendRatingEntityCopyWithImpl<$Res, _$FriendRatingEntityImpl>
    implements _$$FriendRatingEntityImplCopyWith<$Res> {
  __$$FriendRatingEntityImplCopyWithImpl(
    _$FriendRatingEntityImpl _value,
    $Res Function(_$FriendRatingEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendRatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = freezed,
    Object? username = freezed,
    Object? avatarUrl = freezed,
    Object? rating = null,
    Object? ratedAt = null,
  }) {
    return _then(
      _$FriendRatingEntityImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        ratedAt: null == ratedAt
            ? _value.ratedAt
            : ratedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$FriendRatingEntityImpl implements _FriendRatingEntity {
  const _$FriendRatingEntityImpl({
    required this.userId,
    this.displayName,
    this.username,
    this.avatarUrl,
    required this.rating,
    required this.ratedAt,
  });

  @override
  final String userId;
  @override
  final String? displayName;
  @override
  final String? username;
  @override
  final String? avatarUrl;
  @override
  final double rating;
  @override
  final DateTime ratedAt;

  @override
  String toString() {
    return 'FriendRatingEntity(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, rating: $rating, ratedAt: $ratedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRatingEntityImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.ratedAt, ratedAt) || other.ratedAt == ratedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    displayName,
    username,
    avatarUrl,
    rating,
    ratedAt,
  );

  /// Create a copy of FriendRatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRatingEntityImplCopyWith<_$FriendRatingEntityImpl> get copyWith =>
      __$$FriendRatingEntityImplCopyWithImpl<_$FriendRatingEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _FriendRatingEntity implements FriendRatingEntity {
  const factory _FriendRatingEntity({
    required final String userId,
    final String? displayName,
    final String? username,
    final String? avatarUrl,
    required final double rating,
    required final DateTime ratedAt,
  }) = _$FriendRatingEntityImpl;

  @override
  String get userId;
  @override
  String? get displayName;
  @override
  String? get username;
  @override
  String? get avatarUrl;
  @override
  double get rating;
  @override
  DateTime get ratedAt;

  /// Create a copy of FriendRatingEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRatingEntityImplCopyWith<_$FriendRatingEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
