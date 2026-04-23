// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine_alias.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WineAliasModel _$WineAliasModelFromJson(Map<String, dynamic> json) {
  return _WineAliasModel.fromJson(json);
}

/// @nodoc
mixin _$WineAliasModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_wine_id')
  String get localWineId => throw _privateConstructorUsedError;
  @JsonKey(name: 'canonical_wine_id')
  String get canonicalWineId => throw _privateConstructorUsedError;
  @JsonKey(name: 'source')
  String get source => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WineAliasModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WineAliasModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineAliasModelCopyWith<WineAliasModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineAliasModelCopyWith<$Res> {
  factory $WineAliasModelCopyWith(
    WineAliasModel value,
    $Res Function(WineAliasModel) then,
  ) = _$WineAliasModelCopyWithImpl<$Res, WineAliasModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'local_wine_id') String localWineId,
    @JsonKey(name: 'canonical_wine_id') String canonicalWineId,
    @JsonKey(name: 'source') String source,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$WineAliasModelCopyWithImpl<$Res, $Val extends WineAliasModel>
    implements $WineAliasModelCopyWith<$Res> {
  _$WineAliasModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineAliasModel
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
                      as String,
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
abstract class _$$WineAliasModelImplCopyWith<$Res>
    implements $WineAliasModelCopyWith<$Res> {
  factory _$$WineAliasModelImplCopyWith(
    _$WineAliasModelImpl value,
    $Res Function(_$WineAliasModelImpl) then,
  ) = __$$WineAliasModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'local_wine_id') String localWineId,
    @JsonKey(name: 'canonical_wine_id') String canonicalWineId,
    @JsonKey(name: 'source') String source,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$WineAliasModelImplCopyWithImpl<$Res>
    extends _$WineAliasModelCopyWithImpl<$Res, _$WineAliasModelImpl>
    implements _$$WineAliasModelImplCopyWith<$Res> {
  __$$WineAliasModelImplCopyWithImpl(
    _$WineAliasModelImpl _value,
    $Res Function(_$WineAliasModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineAliasModel
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
      _$WineAliasModelImpl(
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
                  as String,
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
class _$WineAliasModelImpl implements _WineAliasModel {
  const _$WineAliasModelImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'local_wine_id') required this.localWineId,
    @JsonKey(name: 'canonical_wine_id') required this.canonicalWineId,
    @JsonKey(name: 'source') this.source = 'share_match',
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$WineAliasModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WineAliasModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'local_wine_id')
  final String localWineId;
  @override
  @JsonKey(name: 'canonical_wine_id')
  final String canonicalWineId;
  @override
  @JsonKey(name: 'source')
  final String source;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'WineAliasModel(userId: $userId, localWineId: $localWineId, canonicalWineId: $canonicalWineId, source: $source, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineAliasModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.localWineId, localWineId) ||
                other.localWineId == localWineId) &&
            (identical(other.canonicalWineId, canonicalWineId) ||
                other.canonicalWineId == canonicalWineId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    localWineId,
    canonicalWineId,
    source,
    createdAt,
  );

  /// Create a copy of WineAliasModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineAliasModelImplCopyWith<_$WineAliasModelImpl> get copyWith =>
      __$$WineAliasModelImplCopyWithImpl<_$WineAliasModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WineAliasModelImplToJson(this);
  }
}

abstract class _WineAliasModel implements WineAliasModel {
  const factory _WineAliasModel({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'local_wine_id') required final String localWineId,
    @JsonKey(name: 'canonical_wine_id') required final String canonicalWineId,
    @JsonKey(name: 'source') final String source,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$WineAliasModelImpl;

  factory _WineAliasModel.fromJson(Map<String, dynamic> json) =
      _$WineAliasModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'local_wine_id')
  String get localWineId;
  @override
  @JsonKey(name: 'canonical_wine_id')
  String get canonicalWineId;
  @override
  @JsonKey(name: 'source')
  String get source;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of WineAliasModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineAliasModelImplCopyWith<_$WineAliasModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
