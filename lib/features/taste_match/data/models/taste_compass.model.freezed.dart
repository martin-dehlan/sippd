// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taste_compass.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CompassBucketModel _$CompassBucketModelFromJson(Map<String, dynamic> json) {
  return _CompassBucketModel.fromJson(json);
}

/// @nodoc
mixin _$CompassBucketModel {
  @JsonKey(name: 'region')
  String? get region => throw _privateConstructorUsedError;
  @JsonKey(name: 'country')
  String? get country => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_rating')
  double get avgRating => throw _privateConstructorUsedError;

  /// Serializes this CompassBucketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompassBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompassBucketModelCopyWith<CompassBucketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompassBucketModelCopyWith<$Res> {
  factory $CompassBucketModelCopyWith(
    CompassBucketModel value,
    $Res Function(CompassBucketModel) then,
  ) = _$CompassBucketModelCopyWithImpl<$Res, CompassBucketModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'region') String? region,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'type') String? type,
    int count,
    @JsonKey(name: 'avg_rating') double avgRating,
  });
}

/// @nodoc
class _$CompassBucketModelCopyWithImpl<$Res, $Val extends CompassBucketModel>
    implements $CompassBucketModelCopyWith<$Res> {
  _$CompassBucketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompassBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = freezed,
    Object? country = freezed,
    Object? type = freezed,
    Object? count = null,
    Object? avgRating = null,
  }) {
    return _then(
      _value.copyWith(
            region: freezed == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$CompassBucketModelImplCopyWith<$Res>
    implements $CompassBucketModelCopyWith<$Res> {
  factory _$$CompassBucketModelImplCopyWith(
    _$CompassBucketModelImpl value,
    $Res Function(_$CompassBucketModelImpl) then,
  ) = __$$CompassBucketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'region') String? region,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'type') String? type,
    int count,
    @JsonKey(name: 'avg_rating') double avgRating,
  });
}

/// @nodoc
class __$$CompassBucketModelImplCopyWithImpl<$Res>
    extends _$CompassBucketModelCopyWithImpl<$Res, _$CompassBucketModelImpl>
    implements _$$CompassBucketModelImplCopyWith<$Res> {
  __$$CompassBucketModelImplCopyWithImpl(
    _$CompassBucketModelImpl _value,
    $Res Function(_$CompassBucketModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompassBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = freezed,
    Object? country = freezed,
    Object? type = freezed,
    Object? count = null,
    Object? avgRating = null,
  }) {
    return _then(
      _$CompassBucketModelImpl(
        region: freezed == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
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
@JsonSerializable()
class _$CompassBucketModelImpl implements _CompassBucketModel {
  const _$CompassBucketModelImpl({
    @JsonKey(name: 'region') this.region,
    @JsonKey(name: 'country') this.country,
    @JsonKey(name: 'type') this.type,
    required this.count,
    @JsonKey(name: 'avg_rating') required this.avgRating,
  });

  factory _$CompassBucketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompassBucketModelImplFromJson(json);

  @override
  @JsonKey(name: 'region')
  final String? region;
  @override
  @JsonKey(name: 'country')
  final String? country;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  final int count;
  @override
  @JsonKey(name: 'avg_rating')
  final double avgRating;

  @override
  String toString() {
    return 'CompassBucketModel(region: $region, country: $country, type: $type, count: $count, avgRating: $avgRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompassBucketModelImpl &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.avgRating, avgRating) ||
                other.avgRating == avgRating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, region, country, type, count, avgRating);

  /// Create a copy of CompassBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompassBucketModelImplCopyWith<_$CompassBucketModelImpl> get copyWith =>
      __$$CompassBucketModelImplCopyWithImpl<_$CompassBucketModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CompassBucketModelImplToJson(this);
  }
}

abstract class _CompassBucketModel implements CompassBucketModel {
  const factory _CompassBucketModel({
    @JsonKey(name: 'region') final String? region,
    @JsonKey(name: 'country') final String? country,
    @JsonKey(name: 'type') final String? type,
    required final int count,
    @JsonKey(name: 'avg_rating') required final double avgRating,
  }) = _$CompassBucketModelImpl;

  factory _CompassBucketModel.fromJson(Map<String, dynamic> json) =
      _$CompassBucketModelImpl.fromJson;

  @override
  @JsonKey(name: 'region')
  String? get region;
  @override
  @JsonKey(name: 'country')
  String? get country;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  int get count;
  @override
  @JsonKey(name: 'avg_rating')
  double get avgRating;

  /// Create a copy of CompassBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompassBucketModelImplCopyWith<_$CompassBucketModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TasteCompassModel _$TasteCompassModelFromJson(Map<String, dynamic> json) {
  return _TasteCompassModel.fromJson(json);
}

/// @nodoc
mixin _$TasteCompassModel {
  @JsonKey(name: 'total_count')
  int get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'overall_avg')
  double? get overallAvg => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_regions')
  List<CompassBucketModel> get topRegions => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_countries')
  List<CompassBucketModel> get topCountries =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'type_breakdown')
  List<CompassBucketModel> get typeBreakdown =>
      throw _privateConstructorUsedError;

  /// Serializes this TasteCompassModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TasteCompassModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TasteCompassModelCopyWith<TasteCompassModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasteCompassModelCopyWith<$Res> {
  factory $TasteCompassModelCopyWith(
    TasteCompassModel value,
    $Res Function(TasteCompassModel) then,
  ) = _$TasteCompassModelCopyWithImpl<$Res, TasteCompassModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_count') int totalCount,
    @JsonKey(name: 'overall_avg') double? overallAvg,
    @JsonKey(name: 'top_regions') List<CompassBucketModel> topRegions,
    @JsonKey(name: 'top_countries') List<CompassBucketModel> topCountries,
    @JsonKey(name: 'type_breakdown') List<CompassBucketModel> typeBreakdown,
  });
}

/// @nodoc
class _$TasteCompassModelCopyWithImpl<$Res, $Val extends TasteCompassModel>
    implements $TasteCompassModelCopyWith<$Res> {
  _$TasteCompassModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TasteCompassModel
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
                      as List<CompassBucketModel>,
            topCountries: null == topCountries
                ? _value.topCountries
                : topCountries // ignore: cast_nullable_to_non_nullable
                      as List<CompassBucketModel>,
            typeBreakdown: null == typeBreakdown
                ? _value.typeBreakdown
                : typeBreakdown // ignore: cast_nullable_to_non_nullable
                      as List<CompassBucketModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TasteCompassModelImplCopyWith<$Res>
    implements $TasteCompassModelCopyWith<$Res> {
  factory _$$TasteCompassModelImplCopyWith(
    _$TasteCompassModelImpl value,
    $Res Function(_$TasteCompassModelImpl) then,
  ) = __$$TasteCompassModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_count') int totalCount,
    @JsonKey(name: 'overall_avg') double? overallAvg,
    @JsonKey(name: 'top_regions') List<CompassBucketModel> topRegions,
    @JsonKey(name: 'top_countries') List<CompassBucketModel> topCountries,
    @JsonKey(name: 'type_breakdown') List<CompassBucketModel> typeBreakdown,
  });
}

/// @nodoc
class __$$TasteCompassModelImplCopyWithImpl<$Res>
    extends _$TasteCompassModelCopyWithImpl<$Res, _$TasteCompassModelImpl>
    implements _$$TasteCompassModelImplCopyWith<$Res> {
  __$$TasteCompassModelImplCopyWithImpl(
    _$TasteCompassModelImpl _value,
    $Res Function(_$TasteCompassModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TasteCompassModel
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
      _$TasteCompassModelImpl(
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
                  as List<CompassBucketModel>,
        topCountries: null == topCountries
            ? _value._topCountries
            : topCountries // ignore: cast_nullable_to_non_nullable
                  as List<CompassBucketModel>,
        typeBreakdown: null == typeBreakdown
            ? _value._typeBreakdown
            : typeBreakdown // ignore: cast_nullable_to_non_nullable
                  as List<CompassBucketModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TasteCompassModelImpl implements _TasteCompassModel {
  const _$TasteCompassModelImpl({
    @JsonKey(name: 'total_count') required this.totalCount,
    @JsonKey(name: 'overall_avg') this.overallAvg,
    @JsonKey(name: 'top_regions')
    final List<CompassBucketModel> topRegions = const [],
    @JsonKey(name: 'top_countries')
    final List<CompassBucketModel> topCountries = const [],
    @JsonKey(name: 'type_breakdown')
    final List<CompassBucketModel> typeBreakdown = const [],
  }) : _topRegions = topRegions,
       _topCountries = topCountries,
       _typeBreakdown = typeBreakdown;

  factory _$TasteCompassModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TasteCompassModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_count')
  final int totalCount;
  @override
  @JsonKey(name: 'overall_avg')
  final double? overallAvg;
  final List<CompassBucketModel> _topRegions;
  @override
  @JsonKey(name: 'top_regions')
  List<CompassBucketModel> get topRegions {
    if (_topRegions is EqualUnmodifiableListView) return _topRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topRegions);
  }

  final List<CompassBucketModel> _topCountries;
  @override
  @JsonKey(name: 'top_countries')
  List<CompassBucketModel> get topCountries {
    if (_topCountries is EqualUnmodifiableListView) return _topCountries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topCountries);
  }

  final List<CompassBucketModel> _typeBreakdown;
  @override
  @JsonKey(name: 'type_breakdown')
  List<CompassBucketModel> get typeBreakdown {
    if (_typeBreakdown is EqualUnmodifiableListView) return _typeBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeBreakdown);
  }

  @override
  String toString() {
    return 'TasteCompassModel(totalCount: $totalCount, overallAvg: $overallAvg, topRegions: $topRegions, topCountries: $topCountries, typeBreakdown: $typeBreakdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasteCompassModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalCount,
    overallAvg,
    const DeepCollectionEquality().hash(_topRegions),
    const DeepCollectionEquality().hash(_topCountries),
    const DeepCollectionEquality().hash(_typeBreakdown),
  );

  /// Create a copy of TasteCompassModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasteCompassModelImplCopyWith<_$TasteCompassModelImpl> get copyWith =>
      __$$TasteCompassModelImplCopyWithImpl<_$TasteCompassModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TasteCompassModelImplToJson(this);
  }
}

abstract class _TasteCompassModel implements TasteCompassModel {
  const factory _TasteCompassModel({
    @JsonKey(name: 'total_count') required final int totalCount,
    @JsonKey(name: 'overall_avg') final double? overallAvg,
    @JsonKey(name: 'top_regions') final List<CompassBucketModel> topRegions,
    @JsonKey(name: 'top_countries') final List<CompassBucketModel> topCountries,
    @JsonKey(name: 'type_breakdown')
    final List<CompassBucketModel> typeBreakdown,
  }) = _$TasteCompassModelImpl;

  factory _TasteCompassModel.fromJson(Map<String, dynamic> json) =
      _$TasteCompassModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_count')
  int get totalCount;
  @override
  @JsonKey(name: 'overall_avg')
  double? get overallAvg;
  @override
  @JsonKey(name: 'top_regions')
  List<CompassBucketModel> get topRegions;
  @override
  @JsonKey(name: 'top_countries')
  List<CompassBucketModel> get topCountries;
  @override
  @JsonKey(name: 'type_breakdown')
  List<CompassBucketModel> get typeBreakdown;

  /// Create a copy of TasteCompassModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasteCompassModelImplCopyWith<_$TasteCompassModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
