// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_profile.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FriendProfileModel _$FriendProfileModelFromJson(Map<String, dynamic> json) {
  return _FriendProfileModel.fromJson(json);
}

/// @nodoc
mixin _$FriendProfileModel {
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this FriendProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendProfileModelCopyWith<FriendProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendProfileModelCopyWith<$Res> {
  factory $FriendProfileModelCopyWith(
    FriendProfileModel value,
    $Res Function(FriendProfileModel) then,
  ) = _$FriendProfileModelCopyWithImpl<$Res, FriendProfileModel>;
  @useResult
  $Res call({
    String id,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class _$FriendProfileModelCopyWithImpl<$Res, $Val extends FriendProfileModel>
    implements $FriendProfileModelCopyWith<$Res> {
  _$FriendProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendProfileModel
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
abstract class _$$FriendProfileModelImplCopyWith<$Res>
    implements $FriendProfileModelCopyWith<$Res> {
  factory _$$FriendProfileModelImplCopyWith(
    _$FriendProfileModelImpl value,
    $Res Function(_$FriendProfileModelImpl) then,
  ) = __$$FriendProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class __$$FriendProfileModelImplCopyWithImpl<$Res>
    extends _$FriendProfileModelCopyWithImpl<$Res, _$FriendProfileModelImpl>
    implements _$$FriendProfileModelImplCopyWith<$Res> {
  __$$FriendProfileModelImplCopyWithImpl(
    _$FriendProfileModelImpl _value,
    $Res Function(_$FriendProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendProfileModel
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
      _$FriendProfileModelImpl(
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
@JsonSerializable()
class _$FriendProfileModelImpl implements _FriendProfileModel {
  const _$FriendProfileModelImpl({
    required this.id,
    this.username,
    @JsonKey(name: 'display_name') this.displayName,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
  });

  factory _$FriendProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? username;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @override
  String toString() {
    return 'FriendProfileModel(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, displayName, avatarUrl);

  /// Create a copy of FriendProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendProfileModelImplCopyWith<_$FriendProfileModelImpl> get copyWith =>
      __$$FriendProfileModelImplCopyWithImpl<_$FriendProfileModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendProfileModelImplToJson(this);
  }
}

abstract class _FriendProfileModel implements FriendProfileModel {
  const factory _FriendProfileModel({
    required final String id,
    final String? username,
    @JsonKey(name: 'display_name') final String? displayName,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
  }) = _$FriendProfileModelImpl;

  factory _FriendProfileModel.fromJson(Map<String, dynamic> json) =
      _$FriendProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get username;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;

  /// Create a copy of FriendProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendProfileModelImplCopyWith<_$FriendProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
