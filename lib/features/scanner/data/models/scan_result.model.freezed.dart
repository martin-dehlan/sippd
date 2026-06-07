// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_result.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScanResponseModel _$ScanResponseModelFromJson(Map<String, dynamic> json) {
  return _ScanResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ScanResponseModel {
  ScanResultModel get result => throw _privateConstructorUsedError;
  ScanQuotaModel get quota => throw _privateConstructorUsedError;
  bool get mock => throw _privateConstructorUsedError;

  /// Create a copy of ScanResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanResponseModelCopyWith<ScanResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanResponseModelCopyWith<$Res> {
  factory $ScanResponseModelCopyWith(
    ScanResponseModel value,
    $Res Function(ScanResponseModel) then,
  ) = _$ScanResponseModelCopyWithImpl<$Res, ScanResponseModel>;
  @useResult
  $Res call({ScanResultModel result, ScanQuotaModel quota, bool mock});

  $ScanResultModelCopyWith<$Res> get result;
  $ScanQuotaModelCopyWith<$Res> get quota;
}

/// @nodoc
class _$ScanResponseModelCopyWithImpl<$Res, $Val extends ScanResponseModel>
    implements $ScanResponseModelCopyWith<$Res> {
  _$ScanResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? quota = null,
    Object? mock = null,
  }) {
    return _then(
      _value.copyWith(
            result: null == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as ScanResultModel,
            quota: null == quota
                ? _value.quota
                : quota // ignore: cast_nullable_to_non_nullable
                      as ScanQuotaModel,
            mock: null == mock
                ? _value.mock
                : mock // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ScanResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScanResultModelCopyWith<$Res> get result {
    return $ScanResultModelCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }

  /// Create a copy of ScanResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScanQuotaModelCopyWith<$Res> get quota {
    return $ScanQuotaModelCopyWith<$Res>(_value.quota, (value) {
      return _then(_value.copyWith(quota: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScanResponseModelImplCopyWith<$Res>
    implements $ScanResponseModelCopyWith<$Res> {
  factory _$$ScanResponseModelImplCopyWith(
    _$ScanResponseModelImpl value,
    $Res Function(_$ScanResponseModelImpl) then,
  ) = __$$ScanResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ScanResultModel result, ScanQuotaModel quota, bool mock});

  @override
  $ScanResultModelCopyWith<$Res> get result;
  @override
  $ScanQuotaModelCopyWith<$Res> get quota;
}

/// @nodoc
class __$$ScanResponseModelImplCopyWithImpl<$Res>
    extends _$ScanResponseModelCopyWithImpl<$Res, _$ScanResponseModelImpl>
    implements _$$ScanResponseModelImplCopyWith<$Res> {
  __$$ScanResponseModelImplCopyWithImpl(
    _$ScanResponseModelImpl _value,
    $Res Function(_$ScanResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? quota = null,
    Object? mock = null,
  }) {
    return _then(
      _$ScanResponseModelImpl(
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as ScanResultModel,
        quota: null == quota
            ? _value.quota
            : quota // ignore: cast_nullable_to_non_nullable
                  as ScanQuotaModel,
        mock: null == mock
            ? _value.mock
            : mock // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(createToJson: false)
class _$ScanResponseModelImpl implements _ScanResponseModel {
  const _$ScanResponseModelImpl({
    required this.result,
    required this.quota,
    this.mock = false,
  });

  factory _$ScanResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanResponseModelImplFromJson(json);

  @override
  final ScanResultModel result;
  @override
  final ScanQuotaModel quota;
  @override
  @JsonKey()
  final bool mock;

  @override
  String toString() {
    return 'ScanResponseModel(result: $result, quota: $quota, mock: $mock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanResponseModelImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.quota, quota) || other.quota == quota) &&
            (identical(other.mock, mock) || other.mock == mock));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, result, quota, mock);

  /// Create a copy of ScanResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanResponseModelImplCopyWith<_$ScanResponseModelImpl> get copyWith =>
      __$$ScanResponseModelImplCopyWithImpl<_$ScanResponseModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ScanResponseModel implements ScanResponseModel {
  const factory _ScanResponseModel({
    required final ScanResultModel result,
    required final ScanQuotaModel quota,
    final bool mock,
  }) = _$ScanResponseModelImpl;

  factory _ScanResponseModel.fromJson(Map<String, dynamic> json) =
      _$ScanResponseModelImpl.fromJson;

  @override
  ScanResultModel get result;
  @override
  ScanQuotaModel get quota;
  @override
  bool get mock;

  /// Create a copy of ScanResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanResponseModelImplCopyWith<_$ScanResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScanResultModel _$ScanResultModelFromJson(Map<String, dynamic> json) {
  return _ScanResultModel.fromJson(json);
}

/// @nodoc
mixin _$ScanResultModel {
  String? get producer => throw _privateConstructorUsedError;
  String? get wineName => throw _privateConstructorUsedError;
  int? get vintage => throw _privateConstructorUsedError;
  String? get appellation => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  List<String> get grapes => throw _privateConstructorUsedError;
  String? get tastingNotes => throw _privateConstructorUsedError;
  int? get servingTempC => throw _privateConstructorUsedError;
  int? get decantMinutes => throw _privateConstructorUsedError;
  List<String> get foodPairings => throw _privateConstructorUsedError;
  String? get wineType => throw _privateConstructorUsedError;

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanResultModelCopyWith<ScanResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanResultModelCopyWith<$Res> {
  factory $ScanResultModelCopyWith(
    ScanResultModel value,
    $Res Function(ScanResultModel) then,
  ) = _$ScanResultModelCopyWithImpl<$Res, ScanResultModel>;
  @useResult
  $Res call({
    String? producer,
    String? wineName,
    int? vintage,
    String? appellation,
    String? country,
    String? region,
    List<String> grapes,
    String? tastingNotes,
    int? servingTempC,
    int? decantMinutes,
    List<String> foodPairings,
    String? wineType,
  });
}

/// @nodoc
class _$ScanResultModelCopyWithImpl<$Res, $Val extends ScanResultModel>
    implements $ScanResultModelCopyWith<$Res> {
  _$ScanResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? producer = freezed,
    Object? wineName = freezed,
    Object? vintage = freezed,
    Object? appellation = freezed,
    Object? country = freezed,
    Object? region = freezed,
    Object? grapes = null,
    Object? tastingNotes = freezed,
    Object? servingTempC = freezed,
    Object? decantMinutes = freezed,
    Object? foodPairings = null,
    Object? wineType = freezed,
  }) {
    return _then(
      _value.copyWith(
            producer: freezed == producer
                ? _value.producer
                : producer // ignore: cast_nullable_to_non_nullable
                      as String?,
            wineName: freezed == wineName
                ? _value.wineName
                : wineName // ignore: cast_nullable_to_non_nullable
                      as String?,
            vintage: freezed == vintage
                ? _value.vintage
                : vintage // ignore: cast_nullable_to_non_nullable
                      as int?,
            appellation: freezed == appellation
                ? _value.appellation
                : appellation // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            region: freezed == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String?,
            grapes: null == grapes
                ? _value.grapes
                : grapes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tastingNotes: freezed == tastingNotes
                ? _value.tastingNotes
                : tastingNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            servingTempC: freezed == servingTempC
                ? _value.servingTempC
                : servingTempC // ignore: cast_nullable_to_non_nullable
                      as int?,
            decantMinutes: freezed == decantMinutes
                ? _value.decantMinutes
                : decantMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            foodPairings: null == foodPairings
                ? _value.foodPairings
                : foodPairings // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            wineType: freezed == wineType
                ? _value.wineType
                : wineType // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScanResultModelImplCopyWith<$Res>
    implements $ScanResultModelCopyWith<$Res> {
  factory _$$ScanResultModelImplCopyWith(
    _$ScanResultModelImpl value,
    $Res Function(_$ScanResultModelImpl) then,
  ) = __$$ScanResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? producer,
    String? wineName,
    int? vintage,
    String? appellation,
    String? country,
    String? region,
    List<String> grapes,
    String? tastingNotes,
    int? servingTempC,
    int? decantMinutes,
    List<String> foodPairings,
    String? wineType,
  });
}

/// @nodoc
class __$$ScanResultModelImplCopyWithImpl<$Res>
    extends _$ScanResultModelCopyWithImpl<$Res, _$ScanResultModelImpl>
    implements _$$ScanResultModelImplCopyWith<$Res> {
  __$$ScanResultModelImplCopyWithImpl(
    _$ScanResultModelImpl _value,
    $Res Function(_$ScanResultModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? producer = freezed,
    Object? wineName = freezed,
    Object? vintage = freezed,
    Object? appellation = freezed,
    Object? country = freezed,
    Object? region = freezed,
    Object? grapes = null,
    Object? tastingNotes = freezed,
    Object? servingTempC = freezed,
    Object? decantMinutes = freezed,
    Object? foodPairings = null,
    Object? wineType = freezed,
  }) {
    return _then(
      _$ScanResultModelImpl(
        producer: freezed == producer
            ? _value.producer
            : producer // ignore: cast_nullable_to_non_nullable
                  as String?,
        wineName: freezed == wineName
            ? _value.wineName
            : wineName // ignore: cast_nullable_to_non_nullable
                  as String?,
        vintage: freezed == vintage
            ? _value.vintage
            : vintage // ignore: cast_nullable_to_non_nullable
                  as int?,
        appellation: freezed == appellation
            ? _value.appellation
            : appellation // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        region: freezed == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String?,
        grapes: null == grapes
            ? _value._grapes
            : grapes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tastingNotes: freezed == tastingNotes
            ? _value.tastingNotes
            : tastingNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        servingTempC: freezed == servingTempC
            ? _value.servingTempC
            : servingTempC // ignore: cast_nullable_to_non_nullable
                  as int?,
        decantMinutes: freezed == decantMinutes
            ? _value.decantMinutes
            : decantMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        foodPairings: null == foodPairings
            ? _value._foodPairings
            : foodPairings // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        wineType: freezed == wineType
            ? _value.wineType
            : wineType // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(createToJson: false)
class _$ScanResultModelImpl implements _ScanResultModel {
  const _$ScanResultModelImpl({
    this.producer,
    this.wineName,
    this.vintage,
    this.appellation,
    this.country,
    this.region,
    final List<String> grapes = const <String>[],
    this.tastingNotes,
    this.servingTempC,
    this.decantMinutes,
    final List<String> foodPairings = const <String>[],
    this.wineType,
  }) : _grapes = grapes,
       _foodPairings = foodPairings;

  factory _$ScanResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanResultModelImplFromJson(json);

  @override
  final String? producer;
  @override
  final String? wineName;
  @override
  final int? vintage;
  @override
  final String? appellation;
  @override
  final String? country;
  @override
  final String? region;
  final List<String> _grapes;
  @override
  @JsonKey()
  List<String> get grapes {
    if (_grapes is EqualUnmodifiableListView) return _grapes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grapes);
  }

  @override
  final String? tastingNotes;
  @override
  final int? servingTempC;
  @override
  final int? decantMinutes;
  final List<String> _foodPairings;
  @override
  @JsonKey()
  List<String> get foodPairings {
    if (_foodPairings is EqualUnmodifiableListView) return _foodPairings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodPairings);
  }

  @override
  final String? wineType;

  @override
  String toString() {
    return 'ScanResultModel(producer: $producer, wineName: $wineName, vintage: $vintage, appellation: $appellation, country: $country, region: $region, grapes: $grapes, tastingNotes: $tastingNotes, servingTempC: $servingTempC, decantMinutes: $decantMinutes, foodPairings: $foodPairings, wineType: $wineType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanResultModelImpl &&
            (identical(other.producer, producer) ||
                other.producer == producer) &&
            (identical(other.wineName, wineName) ||
                other.wineName == wineName) &&
            (identical(other.vintage, vintage) || other.vintage == vintage) &&
            (identical(other.appellation, appellation) ||
                other.appellation == appellation) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.region, region) || other.region == region) &&
            const DeepCollectionEquality().equals(other._grapes, _grapes) &&
            (identical(other.tastingNotes, tastingNotes) ||
                other.tastingNotes == tastingNotes) &&
            (identical(other.servingTempC, servingTempC) ||
                other.servingTempC == servingTempC) &&
            (identical(other.decantMinutes, decantMinutes) ||
                other.decantMinutes == decantMinutes) &&
            const DeepCollectionEquality().equals(
              other._foodPairings,
              _foodPairings,
            ) &&
            (identical(other.wineType, wineType) ||
                other.wineType == wineType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    producer,
    wineName,
    vintage,
    appellation,
    country,
    region,
    const DeepCollectionEquality().hash(_grapes),
    tastingNotes,
    servingTempC,
    decantMinutes,
    const DeepCollectionEquality().hash(_foodPairings),
    wineType,
  );

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanResultModelImplCopyWith<_$ScanResultModelImpl> get copyWith =>
      __$$ScanResultModelImplCopyWithImpl<_$ScanResultModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ScanResultModel implements ScanResultModel {
  const factory _ScanResultModel({
    final String? producer,
    final String? wineName,
    final int? vintage,
    final String? appellation,
    final String? country,
    final String? region,
    final List<String> grapes,
    final String? tastingNotes,
    final int? servingTempC,
    final int? decantMinutes,
    final List<String> foodPairings,
    final String? wineType,
  }) = _$ScanResultModelImpl;

  factory _ScanResultModel.fromJson(Map<String, dynamic> json) =
      _$ScanResultModelImpl.fromJson;

  @override
  String? get producer;
  @override
  String? get wineName;
  @override
  int? get vintage;
  @override
  String? get appellation;
  @override
  String? get country;
  @override
  String? get region;
  @override
  List<String> get grapes;
  @override
  String? get tastingNotes;
  @override
  int? get servingTempC;
  @override
  int? get decantMinutes;
  @override
  List<String> get foodPairings;
  @override
  String? get wineType;

  /// Create a copy of ScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanResultModelImplCopyWith<_$ScanResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScanQuotaModel _$ScanQuotaModelFromJson(Map<String, dynamic> json) {
  return _ScanQuotaModel.fromJson(json);
}

/// @nodoc
mixin _$ScanQuotaModel {
  int get used => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get remaining => throw _privateConstructorUsedError;

  /// Create a copy of ScanQuotaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanQuotaModelCopyWith<ScanQuotaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanQuotaModelCopyWith<$Res> {
  factory $ScanQuotaModelCopyWith(
    ScanQuotaModel value,
    $Res Function(ScanQuotaModel) then,
  ) = _$ScanQuotaModelCopyWithImpl<$Res, ScanQuotaModel>;
  @useResult
  $Res call({int used, int limit, int remaining});
}

/// @nodoc
class _$ScanQuotaModelCopyWithImpl<$Res, $Val extends ScanQuotaModel>
    implements $ScanQuotaModelCopyWith<$Res> {
  _$ScanQuotaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanQuotaModel
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
abstract class _$$ScanQuotaModelImplCopyWith<$Res>
    implements $ScanQuotaModelCopyWith<$Res> {
  factory _$$ScanQuotaModelImplCopyWith(
    _$ScanQuotaModelImpl value,
    $Res Function(_$ScanQuotaModelImpl) then,
  ) = __$$ScanQuotaModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int used, int limit, int remaining});
}

/// @nodoc
class __$$ScanQuotaModelImplCopyWithImpl<$Res>
    extends _$ScanQuotaModelCopyWithImpl<$Res, _$ScanQuotaModelImpl>
    implements _$$ScanQuotaModelImplCopyWith<$Res> {
  __$$ScanQuotaModelImplCopyWithImpl(
    _$ScanQuotaModelImpl _value,
    $Res Function(_$ScanQuotaModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanQuotaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? used = null,
    Object? limit = null,
    Object? remaining = null,
  }) {
    return _then(
      _$ScanQuotaModelImpl(
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
@JsonSerializable(createToJson: false)
class _$ScanQuotaModelImpl implements _ScanQuotaModel {
  const _$ScanQuotaModelImpl({
    this.used = 0,
    this.limit = 0,
    this.remaining = 0,
  });

  factory _$ScanQuotaModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanQuotaModelImplFromJson(json);

  @override
  @JsonKey()
  final int used;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int remaining;

  @override
  String toString() {
    return 'ScanQuotaModel(used: $used, limit: $limit, remaining: $remaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanQuotaModelImpl &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, used, limit, remaining);

  /// Create a copy of ScanQuotaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanQuotaModelImplCopyWith<_$ScanQuotaModelImpl> get copyWith =>
      __$$ScanQuotaModelImplCopyWithImpl<_$ScanQuotaModelImpl>(
        this,
        _$identity,
      );
}

abstract class _ScanQuotaModel implements ScanQuotaModel {
  const factory _ScanQuotaModel({
    final int used,
    final int limit,
    final int remaining,
  }) = _$ScanQuotaModelImpl;

  factory _ScanQuotaModel.fromJson(Map<String, dynamic> json) =
      _$ScanQuotaModelImpl.fromJson;

  @override
  int get used;
  @override
  int get limit;
  @override
  int get remaining;

  /// Create a copy of ScanQuotaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanQuotaModelImplCopyWith<_$ScanQuotaModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
