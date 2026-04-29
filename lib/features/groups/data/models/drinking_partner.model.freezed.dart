// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drinking_partner.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DrinkingPartnerModel _$DrinkingPartnerModelFromJson(Map<String, dynamic> json) {
  return _DrinkingPartnerModel.fromJson(json);
}

/// @nodoc
mixin _$DrinkingPartnerModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'shared_wines')
  int get sharedWines => throw _privateConstructorUsedError;

  /// Serializes this DrinkingPartnerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DrinkingPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrinkingPartnerModelCopyWith<DrinkingPartnerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrinkingPartnerModelCopyWith<$Res> {
  factory $DrinkingPartnerModelCopyWith(
    DrinkingPartnerModel value,
    $Res Function(DrinkingPartnerModel) then,
  ) = _$DrinkingPartnerModelCopyWithImpl<$Res, DrinkingPartnerModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'shared_wines') int sharedWines,
  });
}

/// @nodoc
class _$DrinkingPartnerModelCopyWithImpl<
  $Res,
  $Val extends DrinkingPartnerModel
>
    implements $DrinkingPartnerModelCopyWith<$Res> {
  _$DrinkingPartnerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrinkingPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? sharedWines = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            sharedWines: null == sharedWines
                ? _value.sharedWines
                : sharedWines // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DrinkingPartnerModelImplCopyWith<$Res>
    implements $DrinkingPartnerModelCopyWith<$Res> {
  factory _$$DrinkingPartnerModelImplCopyWith(
    _$DrinkingPartnerModelImpl value,
    $Res Function(_$DrinkingPartnerModelImpl) then,
  ) = __$$DrinkingPartnerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'shared_wines') int sharedWines,
  });
}

/// @nodoc
class __$$DrinkingPartnerModelImplCopyWithImpl<$Res>
    extends _$DrinkingPartnerModelCopyWithImpl<$Res, _$DrinkingPartnerModelImpl>
    implements _$$DrinkingPartnerModelImplCopyWith<$Res> {
  __$$DrinkingPartnerModelImplCopyWithImpl(
    _$DrinkingPartnerModelImpl _value,
    $Res Function(_$DrinkingPartnerModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrinkingPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? sharedWines = null,
  }) {
    return _then(
      _$DrinkingPartnerModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        sharedWines: null == sharedWines
            ? _value.sharedWines
            : sharedWines // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DrinkingPartnerModelImpl implements _DrinkingPartnerModel {
  const _$DrinkingPartnerModelImpl({
    @JsonKey(name: 'user_id') required this.userId,
    this.username,
    @JsonKey(name: 'display_name') this.displayName,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'shared_wines') required this.sharedWines,
  });

  factory _$DrinkingPartnerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrinkingPartnerModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String? username;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'shared_wines')
  final int sharedWines;

  @override
  String toString() {
    return 'DrinkingPartnerModel(userId: $userId, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, sharedWines: $sharedWines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrinkingPartnerModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.sharedWines, sharedWines) ||
                other.sharedWines == sharedWines));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    username,
    displayName,
    avatarUrl,
    sharedWines,
  );

  /// Create a copy of DrinkingPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrinkingPartnerModelImplCopyWith<_$DrinkingPartnerModelImpl>
  get copyWith =>
      __$$DrinkingPartnerModelImplCopyWithImpl<_$DrinkingPartnerModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DrinkingPartnerModelImplToJson(this);
  }
}

abstract class _DrinkingPartnerModel implements DrinkingPartnerModel {
  const factory _DrinkingPartnerModel({
    @JsonKey(name: 'user_id') required final String userId,
    final String? username,
    @JsonKey(name: 'display_name') final String? displayName,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'shared_wines') required final int sharedWines,
  }) = _$DrinkingPartnerModelImpl;

  factory _DrinkingPartnerModel.fromJson(Map<String, dynamic> json) =
      _$DrinkingPartnerModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String? get username;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'shared_wines')
  int get sharedWines;

  /// Create a copy of DrinkingPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrinkingPartnerModelImplCopyWith<_$DrinkingPartnerModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
