// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taste_compass.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CompassBucket {
  String get label => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get avgRating => throw _privateConstructorUsedError;

  /// Create a copy of CompassBucket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompassBucketCopyWith<CompassBucket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompassBucketCopyWith<$Res> {
  factory $CompassBucketCopyWith(
    CompassBucket value,
    $Res Function(CompassBucket) then,
  ) = _$CompassBucketCopyWithImpl<$Res, CompassBucket>;
  @useResult
  $Res call({String label, int count, double avgRating});
}

/// @nodoc
class _$CompassBucketCopyWithImpl<$Res, $Val extends CompassBucket>
    implements $CompassBucketCopyWith<$Res> {
  _$CompassBucketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompassBucket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? count = null,
    Object? avgRating = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            avgRating: null == avgRating
                ? _value.avgRating
                : avgRating // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CompassBucketImplCopyWith<$Res>
    implements $CompassBucketCopyWith<$Res> {
  factory _$$CompassBucketImplCopyWith(
    _$CompassBucketImpl value,
    $Res Function(_$CompassBucketImpl) then,
  ) = __$$CompassBucketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, int count, double avgRating});
}

/// @nodoc
class __$$CompassBucketImplCopyWithImpl<$Res>
    extends _$CompassBucketCopyWithImpl<$Res, _$CompassBucketImpl>
    implements _$$CompassBucketImplCopyWith<$Res> {
  __$$CompassBucketImplCopyWithImpl(
    _$CompassBucketImpl _value,
    $Res Function(_$CompassBucketImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompassBucket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? count = null,
    Object? avgRating = null,
  }) {
    return _then(
      _$CompassBucketImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        avgRating: null == avgRating
            ? _value.avgRating
            : avgRating // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$CompassBucketImpl implements _CompassBucket {
  const _$CompassBucketImpl({
    required this.label,
    required this.count,
    required this.avgRating,
  });

  @override
  final String label;
  @override
  final int count;
  @override
  final double avgRating;

  @override
  String toString() {
    return 'CompassBucket(label: $label, count: $count, avgRating: $avgRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompassBucketImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.avgRating, avgRating) ||
                other.avgRating == avgRating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, count, avgRating);

  /// Create a copy of CompassBucket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompassBucketImplCopyWith<_$CompassBucketImpl> get copyWith =>
      __$$CompassBucketImplCopyWithImpl<_$CompassBucketImpl>(this, _$identity);
}

abstract class _CompassBucket implements CompassBucket {
  const factory _CompassBucket({
    required final String label,
    required final int count,
    required final double avgRating,
  }) = _$CompassBucketImpl;

  @override
  String get label;
  @override
  int get count;
  @override
  double get avgRating;

  /// Create a copy of CompassBucket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompassBucketImplCopyWith<_$CompassBucketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TasteCompassEntity {
  int get totalCount => throw _privateConstructorUsedError;
  double? get overallAvg => throw _privateConstructorUsedError;
  List<CompassBucket> get topRegions => throw _privateConstructorUsedError;
  List<CompassBucket> get topCountries => throw _privateConstructorUsedError;
  List<CompassBucket> get typeBreakdown => throw _privateConstructorUsedError;

  /// Create a copy of TasteCompassEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TasteCompassEntityCopyWith<TasteCompassEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasteCompassEntityCopyWith<$Res> {
  factory $TasteCompassEntityCopyWith(
    TasteCompassEntity value,
    $Res Function(TasteCompassEntity) then,
  ) = _$TasteCompassEntityCopyWithImpl<$Res, TasteCompassEntity>;
  @useResult
  $Res call({
    int totalCount,
    double? overallAvg,
    List<CompassBucket> topRegions,
    List<CompassBucket> topCountries,
    List<CompassBucket> typeBreakdown,
  });
}

/// @nodoc
class _$TasteCompassEntityCopyWithImpl<$Res, $Val extends TasteCompassEntity>
    implements $TasteCompassEntityCopyWith<$Res> {
  _$TasteCompassEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TasteCompassEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? overallAvg = freezed,
    Object? topRegions = null,
    Object? topCountries = null,
    Object? typeBreakdown = null,
  }) {
    return _then(
      _value.copyWith(
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            overallAvg: freezed == overallAvg
                ? _value.overallAvg
                : overallAvg // ignore: cast_nullable_to_non_nullable
                      as double?,
            topRegions: null == topRegions
                ? _value.topRegions
                : topRegions // ignore: cast_nullable_to_non_nullable
                      as List<CompassBucket>,
            topCountries: null == topCountries
                ? _value.topCountries
                : topCountries // ignore: cast_nullable_to_non_nullable
                      as List<CompassBucket>,
            typeBreakdown: null == typeBreakdown
                ? _value.typeBreakdown
                : typeBreakdown // ignore: cast_nullable_to_non_nullable
                      as List<CompassBucket>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TasteCompassEntityImplCopyWith<$Res>
    implements $TasteCompassEntityCopyWith<$Res> {
  factory _$$TasteCompassEntityImplCopyWith(
    _$TasteCompassEntityImpl value,
    $Res Function(_$TasteCompassEntityImpl) then,
  ) = __$$TasteCompassEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalCount,
    double? overallAvg,
    List<CompassBucket> topRegions,
    List<CompassBucket> topCountries,
    List<CompassBucket> typeBreakdown,
  });
}

/// @nodoc
class __$$TasteCompassEntityImplCopyWithImpl<$Res>
    extends _$TasteCompassEntityCopyWithImpl<$Res, _$TasteCompassEntityImpl>
    implements _$$TasteCompassEntityImplCopyWith<$Res> {
  __$$TasteCompassEntityImplCopyWithImpl(
    _$TasteCompassEntityImpl _value,
    $Res Function(_$TasteCompassEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TasteCompassEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? overallAvg = freezed,
    Object? topRegions = null,
    Object? topCountries = null,
    Object? typeBreakdown = null,
  }) {
    return _then(
      _$TasteCompassEntityImpl(
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        overallAvg: freezed == overallAvg
            ? _value.overallAvg
            : overallAvg // ignore: cast_nullable_to_non_nullable
                  as double?,
        topRegions: null == topRegions
            ? _value._topRegions
            : topRegions // ignore: cast_nullable_to_non_nullable
                  as List<CompassBucket>,
        topCountries: null == topCountries
            ? _value._topCountries
            : topCountries // ignore: cast_nullable_to_non_nullable
                  as List<CompassBucket>,
        typeBreakdown: null == typeBreakdown
            ? _value._typeBreakdown
            : typeBreakdown // ignore: cast_nullable_to_non_nullable
                  as List<CompassBucket>,
      ),
    );
  }
}

/// @nodoc

class _$TasteCompassEntityImpl extends _TasteCompassEntity {
  const _$TasteCompassEntityImpl({
    required this.totalCount,
    this.overallAvg,
    final List<CompassBucket> topRegions = const [],
    final List<CompassBucket> topCountries = const [],
    final List<CompassBucket> typeBreakdown = const [],
  }) : _topRegions = topRegions,
       _topCountries = topCountries,
       _typeBreakdown = typeBreakdown,
       super._();

  @override
  final int totalCount;
  @override
  final double? overallAvg;
  final List<CompassBucket> _topRegions;
  @override
  @JsonKey()
  List<CompassBucket> get topRegions {
    if (_topRegions is EqualUnmodifiableListView) return _topRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topRegions);
  }

  final List<CompassBucket> _topCountries;
  @override
  @JsonKey()
  List<CompassBucket> get topCountries {
    if (_topCountries is EqualUnmodifiableListView) return _topCountries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topCountries);
  }

  final List<CompassBucket> _typeBreakdown;
  @override
  @JsonKey()
  List<CompassBucket> get typeBreakdown {
    if (_typeBreakdown is EqualUnmodifiableListView) return _typeBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeBreakdown);
  }

  @override
  String toString() {
    return 'TasteCompassEntity(totalCount: $totalCount, overallAvg: $overallAvg, topRegions: $topRegions, topCountries: $topCountries, typeBreakdown: $typeBreakdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasteCompassEntityImpl &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.overallAvg, overallAvg) ||
                other.overallAvg == overallAvg) &&
            const DeepCollectionEquality().equals(
              other._topRegions,
              _topRegions,
            ) &&
            const DeepCollectionEquality().equals(
              other._topCountries,
              _topCountries,
            ) &&
            const DeepCollectionEquality().equals(
              other._typeBreakdown,
              _typeBreakdown,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalCount,
    overallAvg,
    const DeepCollectionEquality().hash(_topRegions),
    const DeepCollectionEquality().hash(_topCountries),
    const DeepCollectionEquality().hash(_typeBreakdown),
  );

  /// Create a copy of TasteCompassEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasteCompassEntityImplCopyWith<_$TasteCompassEntityImpl> get copyWith =>
      __$$TasteCompassEntityImplCopyWithImpl<_$TasteCompassEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _TasteCompassEntity extends TasteCompassEntity {
  const factory _TasteCompassEntity({
    required final int totalCount,
    final double? overallAvg,
    final List<CompassBucket> topRegions,
    final List<CompassBucket> topCountries,
    final List<CompassBucket> typeBreakdown,
  }) = _$TasteCompassEntityImpl;
  const _TasteCompassEntity._() : super._();

  @override
  int get totalCount;
  @override
  double? get overallAvg;
  @override
  List<CompassBucket> get topRegions;
  @override
  List<CompassBucket> get topCountries;
  @override
  List<CompassBucket> get typeBreakdown;

  /// Create a copy of TasteCompassEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasteCompassEntityImplCopyWith<_$TasteCompassEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
