// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine_memory.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WineMemoryEntity {
  String get id => throw _privateConstructorUsedError;
  String get wineId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get localImagePath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of WineMemoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineMemoryEntityCopyWith<WineMemoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineMemoryEntityCopyWith<$Res> {
  factory $WineMemoryEntityCopyWith(
    WineMemoryEntity value,
    $Res Function(WineMemoryEntity) then,
  ) = _$WineMemoryEntityCopyWithImpl<$Res, WineMemoryEntity>;
  @useResult
  $Res call({
    String id,
    String wineId,
    String userId,
    String? imageUrl,
    String? localImagePath,
    DateTime createdAt,
  });
}

/// @nodoc
class _$WineMemoryEntityCopyWithImpl<$Res, $Val extends WineMemoryEntity>
    implements $WineMemoryEntityCopyWith<$Res> {
  _$WineMemoryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineMemoryEntity
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
abstract class _$$WineMemoryEntityImplCopyWith<$Res>
    implements $WineMemoryEntityCopyWith<$Res> {
  factory _$$WineMemoryEntityImplCopyWith(
    _$WineMemoryEntityImpl value,
    $Res Function(_$WineMemoryEntityImpl) then,
  ) = __$$WineMemoryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String wineId,
    String userId,
    String? imageUrl,
    String? localImagePath,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$WineMemoryEntityImplCopyWithImpl<$Res>
    extends _$WineMemoryEntityCopyWithImpl<$Res, _$WineMemoryEntityImpl>
    implements _$$WineMemoryEntityImplCopyWith<$Res> {
  __$$WineMemoryEntityImplCopyWithImpl(
    _$WineMemoryEntityImpl _value,
    $Res Function(_$WineMemoryEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineMemoryEntity
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
      _$WineMemoryEntityImpl(
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

class _$WineMemoryEntityImpl implements _WineMemoryEntity {
  const _$WineMemoryEntityImpl({
    required this.id,
    required this.wineId,
    required this.userId,
    this.imageUrl,
    this.localImagePath,
    required this.createdAt,
  });

  @override
  final String id;
  @override
  final String wineId;
  @override
  final String userId;
  @override
  final String? imageUrl;
  @override
  final String? localImagePath;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'WineMemoryEntity(id: $id, wineId: $wineId, userId: $userId, imageUrl: $imageUrl, localImagePath: $localImagePath, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineMemoryEntityImpl &&
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

  /// Create a copy of WineMemoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineMemoryEntityImplCopyWith<_$WineMemoryEntityImpl> get copyWith =>
      __$$WineMemoryEntityImplCopyWithImpl<_$WineMemoryEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _WineMemoryEntity implements WineMemoryEntity {
  const factory _WineMemoryEntity({
    required final String id,
    required final String wineId,
    required final String userId,
    final String? imageUrl,
    final String? localImagePath,
    required final DateTime createdAt,
  }) = _$WineMemoryEntityImpl;

  @override
  String get id;
  @override
  String get wineId;
  @override
  String get userId;
  @override
  String? get imageUrl;
  @override
  String? get localImagePath;
  @override
  DateTime get createdAt;

  /// Create a copy of WineMemoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineMemoryEntityImplCopyWith<_$WineMemoryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
