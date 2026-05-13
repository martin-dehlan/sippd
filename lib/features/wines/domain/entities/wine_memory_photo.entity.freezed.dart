// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine_memory_photo.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WineMemoryPhotoEntity {
  String get id => throw _privateConstructorUsedError;
  String get memoryId => throw _privateConstructorUsedError;
  String get storagePath => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of WineMemoryPhotoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineMemoryPhotoEntityCopyWith<WineMemoryPhotoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineMemoryPhotoEntityCopyWith<$Res> {
  factory $WineMemoryPhotoEntityCopyWith(
    WineMemoryPhotoEntity value,
    $Res Function(WineMemoryPhotoEntity) then,
  ) = _$WineMemoryPhotoEntityCopyWithImpl<$Res, WineMemoryPhotoEntity>;
  @useResult
  $Res call({
    String id,
    String memoryId,
    String storagePath,
    int position,
    DateTime createdAt,
  });
}

/// @nodoc
class _$WineMemoryPhotoEntityCopyWithImpl<
  $Res,
  $Val extends WineMemoryPhotoEntity
>
    implements $WineMemoryPhotoEntityCopyWith<$Res> {
  _$WineMemoryPhotoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineMemoryPhotoEntity
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
abstract class _$$WineMemoryPhotoEntityImplCopyWith<$Res>
    implements $WineMemoryPhotoEntityCopyWith<$Res> {
  factory _$$WineMemoryPhotoEntityImplCopyWith(
    _$WineMemoryPhotoEntityImpl value,
    $Res Function(_$WineMemoryPhotoEntityImpl) then,
  ) = __$$WineMemoryPhotoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String memoryId,
    String storagePath,
    int position,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$WineMemoryPhotoEntityImplCopyWithImpl<$Res>
    extends
        _$WineMemoryPhotoEntityCopyWithImpl<$Res, _$WineMemoryPhotoEntityImpl>
    implements _$$WineMemoryPhotoEntityImplCopyWith<$Res> {
  __$$WineMemoryPhotoEntityImplCopyWithImpl(
    _$WineMemoryPhotoEntityImpl _value,
    $Res Function(_$WineMemoryPhotoEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineMemoryPhotoEntity
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
      _$WineMemoryPhotoEntityImpl(
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

class _$WineMemoryPhotoEntityImpl implements _WineMemoryPhotoEntity {
  const _$WineMemoryPhotoEntityImpl({
    required this.id,
    required this.memoryId,
    required this.storagePath,
    this.position = 0,
    required this.createdAt,
  });

  @override
  final String id;
  @override
  final String memoryId;
  @override
  final String storagePath;
  @override
  @JsonKey()
  final int position;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'WineMemoryPhotoEntity(id: $id, memoryId: $memoryId, storagePath: $storagePath, position: $position, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineMemoryPhotoEntityImpl &&
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

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, memoryId, storagePath, position, createdAt);

  /// Create a copy of WineMemoryPhotoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineMemoryPhotoEntityImplCopyWith<_$WineMemoryPhotoEntityImpl>
  get copyWith =>
      __$$WineMemoryPhotoEntityImplCopyWithImpl<_$WineMemoryPhotoEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _WineMemoryPhotoEntity implements WineMemoryPhotoEntity {
  const factory _WineMemoryPhotoEntity({
    required final String id,
    required final String memoryId,
    required final String storagePath,
    final int position,
    required final DateTime createdAt,
  }) = _$WineMemoryPhotoEntityImpl;

  @override
  String get id;
  @override
  String get memoryId;
  @override
  String get storagePath;
  @override
  int get position;
  @override
  DateTime get createdAt;

  /// Create a copy of WineMemoryPhotoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineMemoryPhotoEntityImplCopyWith<_$WineMemoryPhotoEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}
