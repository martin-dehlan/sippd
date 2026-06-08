// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_quota.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScanQuotaEntity {
  int get used => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get remaining => throw _privateConstructorUsedError;

  /// Create a copy of ScanQuotaEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanQuotaEntityCopyWith<ScanQuotaEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanQuotaEntityCopyWith<$Res> {
  factory $ScanQuotaEntityCopyWith(
    ScanQuotaEntity value,
    $Res Function(ScanQuotaEntity) then,
  ) = _$ScanQuotaEntityCopyWithImpl<$Res, ScanQuotaEntity>;
  @useResult
  $Res call({int used, int limit, int remaining});
}

/// @nodoc
class _$ScanQuotaEntityCopyWithImpl<$Res, $Val extends ScanQuotaEntity>
    implements $ScanQuotaEntityCopyWith<$Res> {
  _$ScanQuotaEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanQuotaEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? used = null,
    Object? limit = null,
    Object? remaining = null,
  }) {
    return _then(
      _value.copyWith(
            used: null == used
                ? _value.used
                : used // ignore: cast_nullable_to_non_nullable
                      as int,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            remaining: null == remaining
                ? _value.remaining
                : remaining // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScanQuotaEntityImplCopyWith<$Res>
    implements $ScanQuotaEntityCopyWith<$Res> {
  factory _$$ScanQuotaEntityImplCopyWith(
    _$ScanQuotaEntityImpl value,
    $Res Function(_$ScanQuotaEntityImpl) then,
  ) = __$$ScanQuotaEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int used, int limit, int remaining});
}

/// @nodoc
class __$$ScanQuotaEntityImplCopyWithImpl<$Res>
    extends _$ScanQuotaEntityCopyWithImpl<$Res, _$ScanQuotaEntityImpl>
    implements _$$ScanQuotaEntityImplCopyWith<$Res> {
  __$$ScanQuotaEntityImplCopyWithImpl(
    _$ScanQuotaEntityImpl _value,
    $Res Function(_$ScanQuotaEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanQuotaEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? used = null,
    Object? limit = null,
    Object? remaining = null,
  }) {
    return _then(
      _$ScanQuotaEntityImpl(
        used: null == used
            ? _value.used
            : used // ignore: cast_nullable_to_non_nullable
                  as int,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        remaining: null == remaining
            ? _value.remaining
            : remaining // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ScanQuotaEntityImpl extends _ScanQuotaEntity {
  const _$ScanQuotaEntityImpl({
    required this.used,
    required this.limit,
    required this.remaining,
  }) : super._();

  @override
  final int used;
  @override
  final int limit;
  @override
  final int remaining;

  @override
  String toString() {
    return 'ScanQuotaEntity(used: $used, limit: $limit, remaining: $remaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanQuotaEntityImpl &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining));
  }

  @override
  int get hashCode => Object.hash(runtimeType, used, limit, remaining);

  /// Create a copy of ScanQuotaEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanQuotaEntityImplCopyWith<_$ScanQuotaEntityImpl> get copyWith =>
      __$$ScanQuotaEntityImplCopyWithImpl<_$ScanQuotaEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ScanQuotaEntity extends ScanQuotaEntity {
  const factory _ScanQuotaEntity({
    required final int used,
    required final int limit,
    required final int remaining,
  }) = _$ScanQuotaEntityImpl;
  const _ScanQuotaEntity._() : super._();

  @override
  int get used;
  @override
  int get limit;
  @override
  int get remaining;

  /// Create a copy of ScanQuotaEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanQuotaEntityImplCopyWith<_$ScanQuotaEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
