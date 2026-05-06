// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_rating.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FriendRatingModel _$FriendRatingModelFromJson(Map<String, dynamic> json) {
  return _FriendRatingModel.fromJson(json);
}

/// @nodoc
mixin _$FriendRatingModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'rated_at')
  DateTime get ratedAt => throw _privateConstructorUsedError;

  /// Serializes this FriendRatingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRatingModelCopyWith<FriendRatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRatingModelCopyWith<$Res> {
  factory $FriendRatingModelCopyWith(
    FriendRatingModel value,
    $Res Function(FriendRatingModel) then,
  ) = _$FriendRatingModelCopyWithImpl<$Res, FriendRatingModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'display_name') String? displayName,
    String? username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    double rating,
    @JsonKey(name: 'rated_at') DateTime ratedAt,
  });
}

/// @nodoc
class _$FriendRatingModelCopyWithImpl<$Res, $Val extends FriendRatingModel>
    implements $FriendRatingModelCopyWith<$Res> {
  _$FriendRatingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRatingModel
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
abstract class _$$FriendRatingModelImplCopyWith<$Res>
    implements $FriendRatingModelCopyWith<$Res> {
  factory _$$FriendRatingModelImplCopyWith(
    _$FriendRatingModelImpl value,
    $Res Function(_$FriendRatingModelImpl) then,
  ) = __$$FriendRatingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'display_name') String? displayName,
    String? username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    double rating,
    @JsonKey(name: 'rated_at') DateTime ratedAt,
  });
}

/// @nodoc
class __$$FriendRatingModelImplCopyWithImpl<$Res>
    extends _$FriendRatingModelCopyWithImpl<$Res, _$FriendRatingModelImpl>
    implements _$$FriendRatingModelImplCopyWith<$Res> {
  __$$FriendRatingModelImplCopyWithImpl(
    _$FriendRatingModelImpl _value,
    $Res Function(_$FriendRatingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendRatingModel
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
      _$FriendRatingModelImpl(
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
@JsonSerializable()
class _$FriendRatingModelImpl implements _FriendRatingModel {
  const _$FriendRatingModelImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'display_name') this.displayName,
    this.username,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    required this.rating,
    @JsonKey(name: 'rated_at') required this.ratedAt,
  });

  factory _$FriendRatingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendRatingModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  final String? username;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  final double rating;
  @override
  @JsonKey(name: 'rated_at')
  final DateTime ratedAt;

  @override
  String toString() {
    return 'FriendRatingModel(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, rating: $rating, ratedAt: $ratedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRatingModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of FriendRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRatingModelImplCopyWith<_$FriendRatingModelImpl> get copyWith =>
      __$$FriendRatingModelImplCopyWithImpl<_$FriendRatingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendRatingModelImplToJson(this);
  }
}

abstract class _FriendRatingModel implements FriendRatingModel {
  const factory _FriendRatingModel({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'display_name') final String? displayName,
    final String? username,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    required final double rating,
    @JsonKey(name: 'rated_at') required final DateTime ratedAt,
  }) = _$FriendRatingModelImpl;

  factory _FriendRatingModel.fromJson(Map<String, dynamic> json) =
      _$FriendRatingModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  String? get username;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  double get rating;
  @override
  @JsonKey(name: 'rated_at')
  DateTime get ratedAt;

  /// Create a copy of FriendRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRatingModelImplCopyWith<_$FriendRatingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
