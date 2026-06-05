// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_result.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScanResultEntity {
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

  /// Quota state after this scan was consumed.
  ScanQuotaEntity get quota => throw _privateConstructorUsedError;

  /// True when the Edge Function returned a deterministic stand-in
  /// (no FastCork key configured yet). Lets the UI flag mock data in
  /// debug without changing the happy path.
  bool get isMock => throw _privateConstructorUsedError;

  /// Create a copy of ScanResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanResultEntityCopyWith<ScanResultEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanResultEntityCopyWith<$Res> {
  factory $ScanResultEntityCopyWith(
    ScanResultEntity value,
    $Res Function(ScanResultEntity) then,
  ) = _$ScanResultEntityCopyWithImpl<$Res, ScanResultEntity>;
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
    ScanQuotaEntity quota,
    bool isMock,
  });

  $ScanQuotaEntityCopyWith<$Res> get quota;
}

/// @nodoc
class _$ScanResultEntityCopyWithImpl<$Res, $Val extends ScanResultEntity>
    implements $ScanResultEntityCopyWith<$Res> {
  _$ScanResultEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanResultEntity
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
    Object? quota = null,
    Object? isMock = null,
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
            quota: null == quota
                ? _value.quota
                : quota // ignore: cast_nullable_to_non_nullable
                      as ScanQuotaEntity,
            isMock: null == isMock
                ? _value.isMock
                : isMock // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ScanResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScanQuotaEntityCopyWith<$Res> get quota {
    return $ScanQuotaEntityCopyWith<$Res>(_value.quota, (value) {
      return _then(_value.copyWith(quota: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScanResultEntityImplCopyWith<$Res>
    implements $ScanResultEntityCopyWith<$Res> {
  factory _$$ScanResultEntityImplCopyWith(
    _$ScanResultEntityImpl value,
    $Res Function(_$ScanResultEntityImpl) then,
  ) = __$$ScanResultEntityImplCopyWithImpl<$Res>;
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
    ScanQuotaEntity quota,
    bool isMock,
  });

  @override
  $ScanQuotaEntityCopyWith<$Res> get quota;
}

/// @nodoc
class __$$ScanResultEntityImplCopyWithImpl<$Res>
    extends _$ScanResultEntityCopyWithImpl<$Res, _$ScanResultEntityImpl>
    implements _$$ScanResultEntityImplCopyWith<$Res> {
  __$$ScanResultEntityImplCopyWithImpl(
    _$ScanResultEntityImpl _value,
    $Res Function(_$ScanResultEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanResultEntity
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
    Object? quota = null,
    Object? isMock = null,
  }) {
    return _then(
      _$ScanResultEntityImpl(
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
        quota: null == quota
            ? _value.quota
            : quota // ignore: cast_nullable_to_non_nullable
                  as ScanQuotaEntity,
        isMock: null == isMock
            ? _value.isMock
            : isMock // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ScanResultEntityImpl extends _ScanResultEntity {
  const _$ScanResultEntityImpl({
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
    required this.quota,
    this.isMock = false,
  }) : _grapes = grapes,
       _foodPairings = foodPairings,
       super._();

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

  /// Quota state after this scan was consumed.
  @override
  final ScanQuotaEntity quota;

  /// True when the Edge Function returned a deterministic stand-in
  /// (no FastCork key configured yet). Lets the UI flag mock data in
  /// debug without changing the happy path.
  @override
  @JsonKey()
  final bool isMock;

  @override
  String toString() {
    return 'ScanResultEntity(producer: $producer, wineName: $wineName, vintage: $vintage, appellation: $appellation, country: $country, region: $region, grapes: $grapes, tastingNotes: $tastingNotes, servingTempC: $servingTempC, decantMinutes: $decantMinutes, foodPairings: $foodPairings, quota: $quota, isMock: $isMock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanResultEntityImpl &&
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
            (identical(other.quota, quota) || other.quota == quota) &&
            (identical(other.isMock, isMock) || other.isMock == isMock));
  }

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
    quota,
    isMock,
  );

  /// Create a copy of ScanResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanResultEntityImplCopyWith<_$ScanResultEntityImpl> get copyWith =>
      __$$ScanResultEntityImplCopyWithImpl<_$ScanResultEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ScanResultEntity extends ScanResultEntity {
  const factory _ScanResultEntity({
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
    required final ScanQuotaEntity quota,
    final bool isMock,
  }) = _$ScanResultEntityImpl;
  const _ScanResultEntity._() : super._();

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

  /// Quota state after this scan was consumed.
  @override
  ScanQuotaEntity get quota;

  /// True when the Edge Function returned a deterministic stand-in
  /// (no FastCork key configured yet). Lets the UI flag mock data in
  /// debug without changing the happy path.
  @override
  bool get isMock;

  /// Create a copy of ScanResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanResultEntityImplCopyWith<_$ScanResultEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
