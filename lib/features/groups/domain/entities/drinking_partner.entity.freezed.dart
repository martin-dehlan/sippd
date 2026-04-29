// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drinking_partner.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DrinkingPartnerEntity {
  String get userId => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  int get sharedWines => throw _privateConstructorUsedError;

  /// Create a copy of DrinkingPartnerEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DrinkingPartnerEntityCopyWith<DrinkingPartnerEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrinkingPartnerEntityCopyWith<$Res> {
  factory $DrinkingPartnerEntityCopyWith(
    DrinkingPartnerEntity value,
    $Res Function(DrinkingPartnerEntity) then,
  ) = _$DrinkingPartnerEntityCopyWithImpl<$Res, DrinkingPartnerEntity>;
  @useResult
  $Res call({
    String userId,
    String? username,
    String? displayName,
    String? avatarUrl,
    int sharedWines,
  });
}

/// @nodoc
class _$DrinkingPartnerEntityCopyWithImpl<
  $Res,
  $Val extends DrinkingPartnerEntity
>
    implements $DrinkingPartnerEntityCopyWith<$Res> {
  _$DrinkingPartnerEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrinkingPartnerEntity
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
abstract class _$$DrinkingPartnerEntityImplCopyWith<$Res>
    implements $DrinkingPartnerEntityCopyWith<$Res> {
  factory _$$DrinkingPartnerEntityImplCopyWith(
    _$DrinkingPartnerEntityImpl value,
    $Res Function(_$DrinkingPartnerEntityImpl) then,
  ) = __$$DrinkingPartnerEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String? username,
    String? displayName,
    String? avatarUrl,
    int sharedWines,
  });
}

/// @nodoc
class __$$DrinkingPartnerEntityImplCopyWithImpl<$Res>
    extends
        _$DrinkingPartnerEntityCopyWithImpl<$Res, _$DrinkingPartnerEntityImpl>
    implements _$$DrinkingPartnerEntityImplCopyWith<$Res> {
  __$$DrinkingPartnerEntityImplCopyWithImpl(
    _$DrinkingPartnerEntityImpl _value,
    $Res Function(_$DrinkingPartnerEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrinkingPartnerEntity
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
      _$DrinkingPartnerEntityImpl(
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

class _$DrinkingPartnerEntityImpl implements _DrinkingPartnerEntity {
  const _$DrinkingPartnerEntityImpl({
    required this.userId,
    this.username,
    this.displayName,
    this.avatarUrl,
    required this.sharedWines,
  });

  @override
  final String userId;
  @override
  final String? username;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  final int sharedWines;

  @override
  String toString() {
    return 'DrinkingPartnerEntity(userId: $userId, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, sharedWines: $sharedWines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrinkingPartnerEntityImpl &&
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

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    username,
    displayName,
    avatarUrl,
    sharedWines,
  );

  /// Create a copy of DrinkingPartnerEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrinkingPartnerEntityImplCopyWith<_$DrinkingPartnerEntityImpl>
  get copyWith =>
      __$$DrinkingPartnerEntityImplCopyWithImpl<_$DrinkingPartnerEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _DrinkingPartnerEntity implements DrinkingPartnerEntity {
  const factory _DrinkingPartnerEntity({
    required final String userId,
    final String? username,
    final String? displayName,
    final String? avatarUrl,
    required final int sharedWines,
  }) = _$DrinkingPartnerEntityImpl;

  @override
  String get userId;
  @override
  String? get username;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  int get sharedWines;

  /// Create a copy of DrinkingPartnerEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrinkingPartnerEntityImplCopyWith<_$DrinkingPartnerEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
