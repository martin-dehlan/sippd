// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine_alias.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WineAliasEntity {
  String get userId => throw _privateConstructorUsedError;
  String get localWineId => throw _privateConstructorUsedError;
  String get canonicalWineId => throw _privateConstructorUsedError;
  WineAliasSource get source => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of WineAliasEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineAliasEntityCopyWith<WineAliasEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineAliasEntityCopyWith<$Res> {
  factory $WineAliasEntityCopyWith(
    WineAliasEntity value,
    $Res Function(WineAliasEntity) then,
  ) = _$WineAliasEntityCopyWithImpl<$Res, WineAliasEntity>;
  @useResult
  $Res call({
    String userId,
    String localWineId,
    String canonicalWineId,
    WineAliasSource source,
    DateTime createdAt,
  });
}

/// @nodoc
class _$WineAliasEntityCopyWithImpl<$Res, $Val extends WineAliasEntity>
    implements $WineAliasEntityCopyWith<$Res> {
  _$WineAliasEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineAliasEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? localWineId = null,
    Object? canonicalWineId = null,
    Object? source = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            localWineId: null == localWineId
                ? _value.localWineId
                : localWineId // ignore: cast_nullable_to_non_nullable
                      as String,
            canonicalWineId: null == canonicalWineId
                ? _value.canonicalWineId
                : canonicalWineId // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as WineAliasSource,
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
abstract class _$$WineAliasEntityImplCopyWith<$Res>
    implements $WineAliasEntityCopyWith<$Res> {
  factory _$$WineAliasEntityImplCopyWith(
    _$WineAliasEntityImpl value,
    $Res Function(_$WineAliasEntityImpl) then,
  ) = __$$WineAliasEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String localWineId,
    String canonicalWineId,
    WineAliasSource source,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$WineAliasEntityImplCopyWithImpl<$Res>
    extends _$WineAliasEntityCopyWithImpl<$Res, _$WineAliasEntityImpl>
    implements _$$WineAliasEntityImplCopyWith<$Res> {
  __$$WineAliasEntityImplCopyWithImpl(
    _$WineAliasEntityImpl _value,
    $Res Function(_$WineAliasEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineAliasEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? localWineId = null,
    Object? canonicalWineId = null,
    Object? source = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$WineAliasEntityImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        localWineId: null == localWineId
            ? _value.localWineId
            : localWineId // ignore: cast_nullable_to_non_nullable
                  as String,
        canonicalWineId: null == canonicalWineId
            ? _value.canonicalWineId
            : canonicalWineId // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as WineAliasSource,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$WineAliasEntityImpl implements _WineAliasEntity {
  const _$WineAliasEntityImpl({
    required this.userId,
    required this.localWineId,
    required this.canonicalWineId,
    this.source = WineAliasSource.shareMatch,
    required this.createdAt,
  });

  @override
  final String userId;
  @override
  final String localWineId;
  @override
  final String canonicalWineId;
  @override
  @JsonKey()
  final WineAliasSource source;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'WineAliasEntity(userId: $userId, localWineId: $localWineId, canonicalWineId: $canonicalWineId, source: $source, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineAliasEntityImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.localWineId, localWineId) ||
                other.localWineId == localWineId) &&
            (identical(other.canonicalWineId, canonicalWineId) ||
                other.canonicalWineId == canonicalWineId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    localWineId,
    canonicalWineId,
    source,
    createdAt,
  );

  /// Create a copy of WineAliasEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineAliasEntityImplCopyWith<_$WineAliasEntityImpl> get copyWith =>
      __$$WineAliasEntityImplCopyWithImpl<_$WineAliasEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _WineAliasEntity implements WineAliasEntity {
  const factory _WineAliasEntity({
    required final String userId,
    required final String localWineId,
    required final String canonicalWineId,
    final WineAliasSource source,
    required final DateTime createdAt,
  }) = _$WineAliasEntityImpl;

  @override
  String get userId;
  @override
  String get localWineId;
  @override
  String get canonicalWineId;
  @override
  WineAliasSource get source;
  @override
  DateTime get createdAt;

  /// Create a copy of WineAliasEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineAliasEntityImplCopyWith<_$WineAliasEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
