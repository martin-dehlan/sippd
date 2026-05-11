// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_summary.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RatingSummaryModel _$RatingSummaryModelFromJson(Map<String, dynamic> json) {
  return _RatingSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$RatingSummaryModel {
  @JsonKey(name: 'distinct_wine_count')
  int get distinctWineCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_rating', fromJson: _nullableDouble)
  double? get avgRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'personal_count')
  int get personalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_count')
  int get groupCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasting_count')
  int get tastingCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'by_type')
  List<RatingTypeBucketModel> get byType => throw _privateConstructorUsedError;
  @JsonKey(name: 'by_month')
  List<RatingMonthBucketModel> get byMonth =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'by_country')
  List<RatingRegionBucketModel> get byCountry =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'by_region')
  List<RatingRegionBucketModel> get byRegion =>
      throw _privateConstructorUsedError;

  /// Serializes this RatingSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingSummaryModelCopyWith<RatingSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingSummaryModelCopyWith<$Res> {
  factory $RatingSummaryModelCopyWith(
    RatingSummaryModel value,
    $Res Function(RatingSummaryModel) then,
  ) = _$RatingSummaryModelCopyWithImpl<$Res, RatingSummaryModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'distinct_wine_count') int distinctWineCount,
    @JsonKey(name: 'avg_rating', fromJson: _nullableDouble) double? avgRating,
    @JsonKey(name: 'personal_count') int personalCount,
    @JsonKey(name: 'group_count') int groupCount,
    @JsonKey(name: 'tasting_count') int tastingCount,
    @JsonKey(name: 'by_type') List<RatingTypeBucketModel> byType,
    @JsonKey(name: 'by_month') List<RatingMonthBucketModel> byMonth,
    @JsonKey(name: 'by_country') List<RatingRegionBucketModel> byCountry,
    @JsonKey(name: 'by_region') List<RatingRegionBucketModel> byRegion,
  });
}

/// @nodoc
class _$RatingSummaryModelCopyWithImpl<$Res, $Val extends RatingSummaryModel>
    implements $RatingSummaryModelCopyWith<$Res> {
  _$RatingSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distinctWineCount = null,
    Object? avgRating = freezed,
    Object? personalCount = null,
    Object? groupCount = null,
    Object? tastingCount = null,
    Object? byType = null,
    Object? byMonth = null,
    Object? byCountry = null,
    Object? byRegion = null,
  }) {
    return _then(
      _value.copyWith(
            distinctWineCount: null == distinctWineCount
                ? _value.distinctWineCount
                : distinctWineCount // ignore: cast_nullable_to_non_nullable
                      as int,
            avgRating: freezed == avgRating
                ? _value.avgRating
                : avgRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            personalCount: null == personalCount
                ? _value.personalCount
                : personalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            groupCount: null == groupCount
                ? _value.groupCount
                : groupCount // ignore: cast_nullable_to_non_nullable
                      as int,
            tastingCount: null == tastingCount
                ? _value.tastingCount
                : tastingCount // ignore: cast_nullable_to_non_nullable
                      as int,
            byType: null == byType
                ? _value.byType
                : byType // ignore: cast_nullable_to_non_nullable
                      as List<RatingTypeBucketModel>,
            byMonth: null == byMonth
                ? _value.byMonth
                : byMonth // ignore: cast_nullable_to_non_nullable
                      as List<RatingMonthBucketModel>,
            byCountry: null == byCountry
                ? _value.byCountry
                : byCountry // ignore: cast_nullable_to_non_nullable
                      as List<RatingRegionBucketModel>,
            byRegion: null == byRegion
                ? _value.byRegion
                : byRegion // ignore: cast_nullable_to_non_nullable
                      as List<RatingRegionBucketModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RatingSummaryModelImplCopyWith<$Res>
    implements $RatingSummaryModelCopyWith<$Res> {
  factory _$$RatingSummaryModelImplCopyWith(
    _$RatingSummaryModelImpl value,
    $Res Function(_$RatingSummaryModelImpl) then,
  ) = __$$RatingSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'distinct_wine_count') int distinctWineCount,
    @JsonKey(name: 'avg_rating', fromJson: _nullableDouble) double? avgRating,
    @JsonKey(name: 'personal_count') int personalCount,
    @JsonKey(name: 'group_count') int groupCount,
    @JsonKey(name: 'tasting_count') int tastingCount,
    @JsonKey(name: 'by_type') List<RatingTypeBucketModel> byType,
    @JsonKey(name: 'by_month') List<RatingMonthBucketModel> byMonth,
    @JsonKey(name: 'by_country') List<RatingRegionBucketModel> byCountry,
    @JsonKey(name: 'by_region') List<RatingRegionBucketModel> byRegion,
  });
}

/// @nodoc
class __$$RatingSummaryModelImplCopyWithImpl<$Res>
    extends _$RatingSummaryModelCopyWithImpl<$Res, _$RatingSummaryModelImpl>
    implements _$$RatingSummaryModelImplCopyWith<$Res> {
  __$$RatingSummaryModelImplCopyWithImpl(
    _$RatingSummaryModelImpl _value,
    $Res Function(_$RatingSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distinctWineCount = null,
    Object? avgRating = freezed,
    Object? personalCount = null,
    Object? groupCount = null,
    Object? tastingCount = null,
    Object? byType = null,
    Object? byMonth = null,
    Object? byCountry = null,
    Object? byRegion = null,
  }) {
    return _then(
      _$RatingSummaryModelImpl(
        distinctWineCount: null == distinctWineCount
            ? _value.distinctWineCount
            : distinctWineCount // ignore: cast_nullable_to_non_nullable
                  as int,
        avgRating: freezed == avgRating
            ? _value.avgRating
            : avgRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        personalCount: null == personalCount
            ? _value.personalCount
            : personalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        groupCount: null == groupCount
            ? _value.groupCount
            : groupCount // ignore: cast_nullable_to_non_nullable
                  as int,
        tastingCount: null == tastingCount
            ? _value.tastingCount
            : tastingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        byType: null == byType
            ? _value._byType
            : byType // ignore: cast_nullable_to_non_nullable
                  as List<RatingTypeBucketModel>,
        byMonth: null == byMonth
            ? _value._byMonth
            : byMonth // ignore: cast_nullable_to_non_nullable
                  as List<RatingMonthBucketModel>,
        byCountry: null == byCountry
            ? _value._byCountry
            : byCountry // ignore: cast_nullable_to_non_nullable
                  as List<RatingRegionBucketModel>,
        byRegion: null == byRegion
            ? _value._byRegion
            : byRegion // ignore: cast_nullable_to_non_nullable
                  as List<RatingRegionBucketModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingSummaryModelImpl implements _RatingSummaryModel {
  const _$RatingSummaryModelImpl({
    @JsonKey(name: 'distinct_wine_count') this.distinctWineCount = 0,
    @JsonKey(name: 'avg_rating', fromJson: _nullableDouble) this.avgRating,
    @JsonKey(name: 'personal_count') this.personalCount = 0,
    @JsonKey(name: 'group_count') this.groupCount = 0,
    @JsonKey(name: 'tasting_count') this.tastingCount = 0,
    @JsonKey(name: 'by_type')
    final List<RatingTypeBucketModel> byType = const [],
    @JsonKey(name: 'by_month')
    final List<RatingMonthBucketModel> byMonth = const [],
    @JsonKey(name: 'by_country')
    final List<RatingRegionBucketModel> byCountry = const [],
    @JsonKey(name: 'by_region')
    final List<RatingRegionBucketModel> byRegion = const [],
  }) : _byType = byType,
       _byMonth = byMonth,
       _byCountry = byCountry,
       _byRegion = byRegion;

  factory _$RatingSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'distinct_wine_count')
  final int distinctWineCount;
  @override
  @JsonKey(name: 'avg_rating', fromJson: _nullableDouble)
  final double? avgRating;
  @override
  @JsonKey(name: 'personal_count')
  final int personalCount;
  @override
  @JsonKey(name: 'group_count')
  final int groupCount;
  @override
  @JsonKey(name: 'tasting_count')
  final int tastingCount;
  final List<RatingTypeBucketModel> _byType;
  @override
  @JsonKey(name: 'by_type')
  List<RatingTypeBucketModel> get byType {
    if (_byType is EqualUnmodifiableListView) return _byType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byType);
  }

  final List<RatingMonthBucketModel> _byMonth;
  @override
  @JsonKey(name: 'by_month')
  List<RatingMonthBucketModel> get byMonth {
    if (_byMonth is EqualUnmodifiableListView) return _byMonth;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byMonth);
  }

  final List<RatingRegionBucketModel> _byCountry;
  @override
  @JsonKey(name: 'by_country')
  List<RatingRegionBucketModel> get byCountry {
    if (_byCountry is EqualUnmodifiableListView) return _byCountry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byCountry);
  }

  final List<RatingRegionBucketModel> _byRegion;
  @override
  @JsonKey(name: 'by_region')
  List<RatingRegionBucketModel> get byRegion {
    if (_byRegion is EqualUnmodifiableListView) return _byRegion;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_byRegion);
  }

  @override
  String toString() {
    return 'RatingSummaryModel(distinctWineCount: $distinctWineCount, avgRating: $avgRating, personalCount: $personalCount, groupCount: $groupCount, tastingCount: $tastingCount, byType: $byType, byMonth: $byMonth, byCountry: $byCountry, byRegion: $byRegion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingSummaryModelImpl &&
            (identical(other.distinctWineCount, distinctWineCount) ||
                other.distinctWineCount == distinctWineCount) &&
            (identical(other.avgRating, avgRating) ||
                other.avgRating == avgRating) &&
            (identical(other.personalCount, personalCount) ||
                other.personalCount == personalCount) &&
            (identical(other.groupCount, groupCount) ||
                other.groupCount == groupCount) &&
            (identical(other.tastingCount, tastingCount) ||
                other.tastingCount == tastingCount) &&
            const DeepCollectionEquality().equals(other._byType, _byType) &&
            const DeepCollectionEquality().equals(other._byMonth, _byMonth) &&
            const DeepCollectionEquality().equals(
              other._byCountry,
              _byCountry,
            ) &&
            const DeepCollectionEquality().equals(other._byRegion, _byRegion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    distinctWineCount,
    avgRating,
    personalCount,
    groupCount,
    tastingCount,
    const DeepCollectionEquality().hash(_byType),
    const DeepCollectionEquality().hash(_byMonth),
    const DeepCollectionEquality().hash(_byCountry),
    const DeepCollectionEquality().hash(_byRegion),
  );

  /// Create a copy of RatingSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingSummaryModelImplCopyWith<_$RatingSummaryModelImpl> get copyWith =>
      __$$RatingSummaryModelImplCopyWithImpl<_$RatingSummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingSummaryModelImplToJson(this);
  }
}

abstract class _RatingSummaryModel implements RatingSummaryModel {
  const factory _RatingSummaryModel({
    @JsonKey(name: 'distinct_wine_count') final int distinctWineCount,
    @JsonKey(name: 'avg_rating', fromJson: _nullableDouble)
    final double? avgRating,
    @JsonKey(name: 'personal_count') final int personalCount,
    @JsonKey(name: 'group_count') final int groupCount,
    @JsonKey(name: 'tasting_count') final int tastingCount,
    @JsonKey(name: 'by_type') final List<RatingTypeBucketModel> byType,
    @JsonKey(name: 'by_month') final List<RatingMonthBucketModel> byMonth,
    @JsonKey(name: 'by_country') final List<RatingRegionBucketModel> byCountry,
    @JsonKey(name: 'by_region') final List<RatingRegionBucketModel> byRegion,
  }) = _$RatingSummaryModelImpl;

  factory _RatingSummaryModel.fromJson(Map<String, dynamic> json) =
      _$RatingSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'distinct_wine_count')
  int get distinctWineCount;
  @override
  @JsonKey(name: 'avg_rating', fromJson: _nullableDouble)
  double? get avgRating;
  @override
  @JsonKey(name: 'personal_count')
  int get personalCount;
  @override
  @JsonKey(name: 'group_count')
  int get groupCount;
  @override
  @JsonKey(name: 'tasting_count')
  int get tastingCount;
  @override
  @JsonKey(name: 'by_type')
  List<RatingTypeBucketModel> get byType;
  @override
  @JsonKey(name: 'by_month')
  List<RatingMonthBucketModel> get byMonth;
  @override
  @JsonKey(name: 'by_country')
  List<RatingRegionBucketModel> get byCountry;
  @override
  @JsonKey(name: 'by_region')
  List<RatingRegionBucketModel> get byRegion;

  /// Create a copy of RatingSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingSummaryModelImplCopyWith<_$RatingSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RatingTypeBucketModel _$RatingTypeBucketModelFromJson(
  Map<String, dynamic> json,
) {
  return _RatingTypeBucketModel.fromJson(json);
}

/// @nodoc
mixin _$RatingTypeBucketModel {
  String get type => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get avg => throw _privateConstructorUsedError;

  /// Serializes this RatingTypeBucketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingTypeBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingTypeBucketModelCopyWith<RatingTypeBucketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingTypeBucketModelCopyWith<$Res> {
  factory $RatingTypeBucketModelCopyWith(
    RatingTypeBucketModel value,
    $Res Function(RatingTypeBucketModel) then,
  ) = _$RatingTypeBucketModelCopyWithImpl<$Res, RatingTypeBucketModel>;
  @useResult
  $Res call({String type, int count, @JsonKey(fromJson: _toDouble) double avg});
}

/// @nodoc
class _$RatingTypeBucketModelCopyWithImpl<
  $Res,
  $Val extends RatingTypeBucketModel
>
    implements $RatingTypeBucketModelCopyWith<$Res> {
  _$RatingTypeBucketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingTypeBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? count = null, Object? avg = null}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            avg: null == avg
                ? _value.avg
                : avg // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RatingTypeBucketModelImplCopyWith<$Res>
    implements $RatingTypeBucketModelCopyWith<$Res> {
  factory _$$RatingTypeBucketModelImplCopyWith(
    _$RatingTypeBucketModelImpl value,
    $Res Function(_$RatingTypeBucketModelImpl) then,
  ) = __$$RatingTypeBucketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, int count, @JsonKey(fromJson: _toDouble) double avg});
}

/// @nodoc
class __$$RatingTypeBucketModelImplCopyWithImpl<$Res>
    extends
        _$RatingTypeBucketModelCopyWithImpl<$Res, _$RatingTypeBucketModelImpl>
    implements _$$RatingTypeBucketModelImplCopyWith<$Res> {
  __$$RatingTypeBucketModelImplCopyWithImpl(
    _$RatingTypeBucketModelImpl _value,
    $Res Function(_$RatingTypeBucketModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingTypeBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? count = null, Object? avg = null}) {
    return _then(
      _$RatingTypeBucketModelImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        avg: null == avg
            ? _value.avg
            : avg // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingTypeBucketModelImpl implements _RatingTypeBucketModel {
  const _$RatingTypeBucketModelImpl({
    required this.type,
    required this.count,
    @JsonKey(fromJson: _toDouble) required this.avg,
  });

  factory _$RatingTypeBucketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingTypeBucketModelImplFromJson(json);

  @override
  final String type;
  @override
  final int count;
  @override
  @JsonKey(fromJson: _toDouble)
  final double avg;

  @override
  String toString() {
    return 'RatingTypeBucketModel(type: $type, count: $count, avg: $avg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingTypeBucketModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.avg, avg) || other.avg == avg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, count, avg);

  /// Create a copy of RatingTypeBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingTypeBucketModelImplCopyWith<_$RatingTypeBucketModelImpl>
  get copyWith =>
      __$$RatingTypeBucketModelImplCopyWithImpl<_$RatingTypeBucketModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingTypeBucketModelImplToJson(this);
  }
}

abstract class _RatingTypeBucketModel implements RatingTypeBucketModel {
  const factory _RatingTypeBucketModel({
    required final String type,
    required final int count,
    @JsonKey(fromJson: _toDouble) required final double avg,
  }) = _$RatingTypeBucketModelImpl;

  factory _RatingTypeBucketModel.fromJson(Map<String, dynamic> json) =
      _$RatingTypeBucketModelImpl.fromJson;

  @override
  String get type;
  @override
  int get count;
  @override
  @JsonKey(fromJson: _toDouble)
  double get avg;

  /// Create a copy of RatingTypeBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingTypeBucketModelImplCopyWith<_$RatingTypeBucketModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RatingMonthBucketModel _$RatingMonthBucketModelFromJson(
  Map<String, dynamic> json,
) {
  return _RatingMonthBucketModel.fromJson(json);
}

/// @nodoc
mixin _$RatingMonthBucketModel {
  String get month => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get avg => throw _privateConstructorUsedError;

  /// Serializes this RatingMonthBucketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingMonthBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingMonthBucketModelCopyWith<RatingMonthBucketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingMonthBucketModelCopyWith<$Res> {
  factory $RatingMonthBucketModelCopyWith(
    RatingMonthBucketModel value,
    $Res Function(RatingMonthBucketModel) then,
  ) = _$RatingMonthBucketModelCopyWithImpl<$Res, RatingMonthBucketModel>;
  @useResult
  $Res call({
    String month,
    int count,
    @JsonKey(fromJson: _toDouble) double avg,
  });
}

/// @nodoc
class _$RatingMonthBucketModelCopyWithImpl<
  $Res,
  $Val extends RatingMonthBucketModel
>
    implements $RatingMonthBucketModelCopyWith<$Res> {
  _$RatingMonthBucketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingMonthBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? month = null, Object? count = null, Object? avg = null}) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            avg: null == avg
                ? _value.avg
                : avg // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RatingMonthBucketModelImplCopyWith<$Res>
    implements $RatingMonthBucketModelCopyWith<$Res> {
  factory _$$RatingMonthBucketModelImplCopyWith(
    _$RatingMonthBucketModelImpl value,
    $Res Function(_$RatingMonthBucketModelImpl) then,
  ) = __$$RatingMonthBucketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String month,
    int count,
    @JsonKey(fromJson: _toDouble) double avg,
  });
}

/// @nodoc
class __$$RatingMonthBucketModelImplCopyWithImpl<$Res>
    extends
        _$RatingMonthBucketModelCopyWithImpl<$Res, _$RatingMonthBucketModelImpl>
    implements _$$RatingMonthBucketModelImplCopyWith<$Res> {
  __$$RatingMonthBucketModelImplCopyWithImpl(
    _$RatingMonthBucketModelImpl _value,
    $Res Function(_$RatingMonthBucketModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingMonthBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? month = null, Object? count = null, Object? avg = null}) {
    return _then(
      _$RatingMonthBucketModelImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        avg: null == avg
            ? _value.avg
            : avg // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingMonthBucketModelImpl implements _RatingMonthBucketModel {
  const _$RatingMonthBucketModelImpl({
    required this.month,
    required this.count,
    @JsonKey(fromJson: _toDouble) required this.avg,
  });

  factory _$RatingMonthBucketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingMonthBucketModelImplFromJson(json);

  @override
  final String month;
  @override
  final int count;
  @override
  @JsonKey(fromJson: _toDouble)
  final double avg;

  @override
  String toString() {
    return 'RatingMonthBucketModel(month: $month, count: $count, avg: $avg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingMonthBucketModelImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.avg, avg) || other.avg == avg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, count, avg);

  /// Create a copy of RatingMonthBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingMonthBucketModelImplCopyWith<_$RatingMonthBucketModelImpl>
  get copyWith =>
      __$$RatingMonthBucketModelImplCopyWithImpl<_$RatingMonthBucketModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingMonthBucketModelImplToJson(this);
  }
}

abstract class _RatingMonthBucketModel implements RatingMonthBucketModel {
  const factory _RatingMonthBucketModel({
    required final String month,
    required final int count,
    @JsonKey(fromJson: _toDouble) required final double avg,
  }) = _$RatingMonthBucketModelImpl;

  factory _RatingMonthBucketModel.fromJson(Map<String, dynamic> json) =
      _$RatingMonthBucketModelImpl.fromJson;

  @override
  String get month;
  @override
  int get count;
  @override
  @JsonKey(fromJson: _toDouble)
  double get avg;

  /// Create a copy of RatingMonthBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingMonthBucketModelImplCopyWith<_$RatingMonthBucketModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RatingRegionBucketModel _$RatingRegionBucketModelFromJson(
  Map<String, dynamic> json,
) {
  return _RatingRegionBucketModel.fromJson(json);
}

/// @nodoc
mixin _$RatingRegionBucketModel {
  String? get region => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get avg => throw _privateConstructorUsedError;

  /// Serializes this RatingRegionBucketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingRegionBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingRegionBucketModelCopyWith<RatingRegionBucketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingRegionBucketModelCopyWith<$Res> {
  factory $RatingRegionBucketModelCopyWith(
    RatingRegionBucketModel value,
    $Res Function(RatingRegionBucketModel) then,
  ) = _$RatingRegionBucketModelCopyWithImpl<$Res, RatingRegionBucketModel>;
  @useResult
  $Res call({
    String? region,
    String? country,
    int count,
    @JsonKey(fromJson: _toDouble) double avg,
  });
}

/// @nodoc
class _$RatingRegionBucketModelCopyWithImpl<
  $Res,
  $Val extends RatingRegionBucketModel
>
    implements $RatingRegionBucketModelCopyWith<$Res> {
  _$RatingRegionBucketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingRegionBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = freezed,
    Object? country = freezed,
    Object? count = null,
    Object? avg = null,
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
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            avg: null == avg
                ? _value.avg
                : avg // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RatingRegionBucketModelImplCopyWith<$Res>
    implements $RatingRegionBucketModelCopyWith<$Res> {
  factory _$$RatingRegionBucketModelImplCopyWith(
    _$RatingRegionBucketModelImpl value,
    $Res Function(_$RatingRegionBucketModelImpl) then,
  ) = __$$RatingRegionBucketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? region,
    String? country,
    int count,
    @JsonKey(fromJson: _toDouble) double avg,
  });
}

/// @nodoc
class __$$RatingRegionBucketModelImplCopyWithImpl<$Res>
    extends
        _$RatingRegionBucketModelCopyWithImpl<
          $Res,
          _$RatingRegionBucketModelImpl
        >
    implements _$$RatingRegionBucketModelImplCopyWith<$Res> {
  __$$RatingRegionBucketModelImplCopyWithImpl(
    _$RatingRegionBucketModelImpl _value,
    $Res Function(_$RatingRegionBucketModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingRegionBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = freezed,
    Object? country = freezed,
    Object? count = null,
    Object? avg = null,
  }) {
    return _then(
      _$RatingRegionBucketModelImpl(
        region: freezed == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        avg: null == avg
            ? _value.avg
            : avg // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingRegionBucketModelImpl implements _RatingRegionBucketModel {
  const _$RatingRegionBucketModelImpl({
    this.region,
    this.country,
    required this.count,
    @JsonKey(fromJson: _toDouble) required this.avg,
  });

  factory _$RatingRegionBucketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingRegionBucketModelImplFromJson(json);

  @override
  final String? region;
  @override
  final String? country;
  @override
  final int count;
  @override
  @JsonKey(fromJson: _toDouble)
  final double avg;

  @override
  String toString() {
    return 'RatingRegionBucketModel(region: $region, country: $country, count: $count, avg: $avg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingRegionBucketModelImpl &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.avg, avg) || other.avg == avg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, region, country, count, avg);

  /// Create a copy of RatingRegionBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingRegionBucketModelImplCopyWith<_$RatingRegionBucketModelImpl>
  get copyWith =>
      __$$RatingRegionBucketModelImplCopyWithImpl<
        _$RatingRegionBucketModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingRegionBucketModelImplToJson(this);
  }
}

abstract class _RatingRegionBucketModel implements RatingRegionBucketModel {
  const factory _RatingRegionBucketModel({
    final String? region,
    final String? country,
    required final int count,
    @JsonKey(fromJson: _toDouble) required final double avg,
  }) = _$RatingRegionBucketModelImpl;

  factory _RatingRegionBucketModel.fromJson(Map<String, dynamic> json) =
      _$RatingRegionBucketModelImpl.fromJson;

  @override
  String? get region;
  @override
  String? get country;
  @override
  int get count;
  @override
  @JsonKey(fromJson: _toDouble)
  double get avg;

  /// Create a copy of RatingRegionBucketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingRegionBucketModelImplCopyWith<_$RatingRegionBucketModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
