// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine_memory.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WineMemoryModel _$WineMemoryModelFromJson(Map<String, dynamic> json) {
  return _WineMemoryModel.fromJson(json);
}

/// @nodoc
mixin _$WineMemoryModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'wine_id')
  String get wineId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_image_path')
  String? get localImagePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WineMemoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineMemoryModelCopyWith<WineMemoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineMemoryModelCopyWith<$Res> {
  factory $WineMemoryModelCopyWith(
    WineMemoryModel value,
    $Res Function(WineMemoryModel) then,
  ) = _$WineMemoryModelCopyWithImpl<$Res, WineMemoryModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'wine_id') String wineId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path') String? localImagePath,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$WineMemoryModelCopyWithImpl<$Res, $Val extends WineMemoryModel>
    implements $WineMemoryModelCopyWith<$Res> {
  _$WineMemoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wineId = null,
    Object? userId = null,
    Object? imageUrl = freezed,
    Object? localImagePath = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            wineId: null == wineId
                ? _value.wineId
                : wineId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            localImagePath: freezed == localImagePath
                ? _value.localImagePath
                : localImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WineMemoryModelImplCopyWith<$Res>
    implements $WineMemoryModelCopyWith<$Res> {
  factory _$$WineMemoryModelImplCopyWith(
    _$WineMemoryModelImpl value,
    $Res Function(_$WineMemoryModelImpl) then,
  ) = __$$WineMemoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'wine_id') String wineId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path') String? localImagePath,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$WineMemoryModelImplCopyWithImpl<$Res>
    extends _$WineMemoryModelCopyWithImpl<$Res, _$WineMemoryModelImpl>
    implements _$$WineMemoryModelImplCopyWith<$Res> {
  __$$WineMemoryModelImplCopyWithImpl(
    _$WineMemoryModelImpl _value,
    $Res Function(_$WineMemoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wineId = null,
    Object? userId = null,
    Object? imageUrl = freezed,
    Object? localImagePath = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$WineMemoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        wineId: null == wineId
            ? _value.wineId
            : wineId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        localImagePath: freezed == localImagePath
            ? _value.localImagePath
            : localImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WineMemoryModelImpl implements _WineMemoryModel {
  const _$WineMemoryModelImpl({
    required this.id,
    @JsonKey(name: 'wine_id') required this.wineId,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'local_image_path') this.localImagePath,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$WineMemoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WineMemoryModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'wine_id')
  final String wineId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'local_image_path')
  final String? localImagePath;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'WineMemoryModel(id: $id, wineId: $wineId, userId: $userId, imageUrl: $imageUrl, localImagePath: $localImagePath, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineMemoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wineId, wineId) || other.wineId == wineId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.localImagePath, localImagePath) ||
                other.localImagePath == localImagePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    wineId,
    userId,
    imageUrl,
    localImagePath,
    createdAt,
  );

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineMemoryModelImplCopyWith<_$WineMemoryModelImpl> get copyWith =>
      __$$WineMemoryModelImplCopyWithImpl<_$WineMemoryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WineMemoryModelImplToJson(this);
  }
}

abstract class _WineMemoryModel implements WineMemoryModel {
  const factory _WineMemoryModel({
    required final String id,
    @JsonKey(name: 'wine_id') required final String wineId,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'local_image_path') final String? localImagePath,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$WineMemoryModelImpl;

  factory _WineMemoryModel.fromJson(Map<String, dynamic> json) =
      _$WineMemoryModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'wine_id')
  String get wineId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'local_image_path')
  String? get localImagePath;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineMemoryModelImplCopyWith<_$WineMemoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
