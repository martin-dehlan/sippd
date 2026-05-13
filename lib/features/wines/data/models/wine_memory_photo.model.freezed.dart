// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine_memory_photo.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WineMemoryPhotoModel _$WineMemoryPhotoModelFromJson(Map<String, dynamic> json) {
  return _WineMemoryPhotoModel.fromJson(json);
}

/// @nodoc
mixin _$WineMemoryPhotoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'memory_id')
  String get memoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_path')
  String get storagePath => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WineMemoryPhotoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WineMemoryPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineMemoryPhotoModelCopyWith<WineMemoryPhotoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineMemoryPhotoModelCopyWith<$Res> {
  factory $WineMemoryPhotoModelCopyWith(
    WineMemoryPhotoModel value,
    $Res Function(WineMemoryPhotoModel) then,
  ) = _$WineMemoryPhotoModelCopyWithImpl<$Res, WineMemoryPhotoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'memory_id') String memoryId,
    @JsonKey(name: 'storage_path') String storagePath,
    int position,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$WineMemoryPhotoModelCopyWithImpl<
  $Res,
  $Val extends WineMemoryPhotoModel
>
    implements $WineMemoryPhotoModelCopyWith<$Res> {
  _$WineMemoryPhotoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineMemoryPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memoryId = null,
    Object? storagePath = null,
    Object? position = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            memoryId: null == memoryId
                ? _value.memoryId
                : memoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            storagePath: null == storagePath
                ? _value.storagePath
                : storagePath // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$WineMemoryPhotoModelImplCopyWith<$Res>
    implements $WineMemoryPhotoModelCopyWith<$Res> {
  factory _$$WineMemoryPhotoModelImplCopyWith(
    _$WineMemoryPhotoModelImpl value,
    $Res Function(_$WineMemoryPhotoModelImpl) then,
  ) = __$$WineMemoryPhotoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'memory_id') String memoryId,
    @JsonKey(name: 'storage_path') String storagePath,
    int position,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$WineMemoryPhotoModelImplCopyWithImpl<$Res>
    extends _$WineMemoryPhotoModelCopyWithImpl<$Res, _$WineMemoryPhotoModelImpl>
    implements _$$WineMemoryPhotoModelImplCopyWith<$Res> {
  __$$WineMemoryPhotoModelImplCopyWithImpl(
    _$WineMemoryPhotoModelImpl _value,
    $Res Function(_$WineMemoryPhotoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineMemoryPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? memoryId = null,
    Object? storagePath = null,
    Object? position = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$WineMemoryPhotoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        memoryId: null == memoryId
            ? _value.memoryId
            : memoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        storagePath: null == storagePath
            ? _value.storagePath
            : storagePath // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$WineMemoryPhotoModelImpl implements _WineMemoryPhotoModel {
  const _$WineMemoryPhotoModelImpl({
    required this.id,
    @JsonKey(name: 'memory_id') required this.memoryId,
    @JsonKey(name: 'storage_path') required this.storagePath,
    this.position = 0,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$WineMemoryPhotoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WineMemoryPhotoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'memory_id')
  final String memoryId;
  @override
  @JsonKey(name: 'storage_path')
  final String storagePath;
  @override
  @JsonKey()
  final int position;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'WineMemoryPhotoModel(id: $id, memoryId: $memoryId, storagePath: $storagePath, position: $position, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineMemoryPhotoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memoryId, memoryId) ||
                other.memoryId == memoryId) &&
            (identical(other.storagePath, storagePath) ||
                other.storagePath == storagePath) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, memoryId, storagePath, position, createdAt);

  /// Create a copy of WineMemoryPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineMemoryPhotoModelImplCopyWith<_$WineMemoryPhotoModelImpl>
  get copyWith =>
      __$$WineMemoryPhotoModelImplCopyWithImpl<_$WineMemoryPhotoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WineMemoryPhotoModelImplToJson(this);
  }
}

abstract class _WineMemoryPhotoModel implements WineMemoryPhotoModel {
  const factory _WineMemoryPhotoModel({
    required final String id,
    @JsonKey(name: 'memory_id') required final String memoryId,
    @JsonKey(name: 'storage_path') required final String storagePath,
    final int position,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$WineMemoryPhotoModelImpl;

  factory _WineMemoryPhotoModel.fromJson(Map<String, dynamic> json) =
      _$WineMemoryPhotoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'memory_id')
  String get memoryId;
  @override
  @JsonKey(name: 'storage_path')
  String get storagePath;
  @override
  int get position;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of WineMemoryPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineMemoryPhotoModelImplCopyWith<_$WineMemoryPhotoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
