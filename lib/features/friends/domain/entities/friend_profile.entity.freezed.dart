// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_profile.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FriendProfileEntity {
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Create a copy of FriendProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendProfileEntityCopyWith<FriendProfileEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendProfileEntityCopyWith<$Res> {
  factory $FriendProfileEntityCopyWith(
    FriendProfileEntity value,
    $Res Function(FriendProfileEntity) then,
  ) = _$FriendProfileEntityCopyWithImpl<$Res, FriendProfileEntity>;
  @useResult
  $Res call({
    String id,
    String? username,
    String? displayName,
    String? avatarUrl,
  });
}

/// @nodoc
class _$FriendProfileEntityCopyWithImpl<$Res, $Val extends FriendProfileEntity>
    implements $FriendProfileEntityCopyWith<$Res> {
  _$FriendProfileEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendProfileEntityImplCopyWith<$Res>
    implements $FriendProfileEntityCopyWith<$Res> {
  factory _$$FriendProfileEntityImplCopyWith(
    _$FriendProfileEntityImpl value,
    $Res Function(_$FriendProfileEntityImpl) then,
  ) = __$$FriendProfileEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? username,
    String? displayName,
    String? avatarUrl,
  });
}

/// @nodoc
class __$$FriendProfileEntityImplCopyWithImpl<$Res>
    extends _$FriendProfileEntityCopyWithImpl<$Res, _$FriendProfileEntityImpl>
    implements _$$FriendProfileEntityImplCopyWith<$Res> {
  __$$FriendProfileEntityImplCopyWithImpl(
    _$FriendProfileEntityImpl _value,
    $Res Function(_$FriendProfileEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _$FriendProfileEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc

class _$FriendProfileEntityImpl implements _FriendProfileEntity {
  const _$FriendProfileEntityImpl({
    required this.id,
    this.username,
    this.displayName,
    this.avatarUrl,
  });

  @override
  final String id;
  @override
  final String? username;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'FriendProfileEntity(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendProfileEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, displayName, avatarUrl);

  /// Create a copy of FriendProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendProfileEntityImplCopyWith<_$FriendProfileEntityImpl> get copyWith =>
      __$$FriendProfileEntityImplCopyWithImpl<_$FriendProfileEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _FriendProfileEntity implements FriendProfileEntity {
  const factory _FriendProfileEntity({
    required final String id,
    final String? username,
    final String? displayName,
    final String? avatarUrl,
  }) = _$FriendProfileEntityImpl;

  @override
  String get id;
  @override
  String? get username;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;

  /// Create a copy of FriendProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendProfileEntityImplCopyWith<_$FriendProfileEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
