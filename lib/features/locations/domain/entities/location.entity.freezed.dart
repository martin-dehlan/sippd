// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LocationEntity {
  double? get lat => throw _privateConstructorUsedError;
  double? get lng => throw _privateConstructorUsedError;
  String get locationName => throw _privateConstructorUsedError;
  String get road => throw _privateConstructorUsedError;
  String get houseNumber => throw _privateConstructorUsedError;
  String get postcode => throw _privateConstructorUsedError;
  String get borough => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationEntityCopyWith<LocationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationEntityCopyWith<$Res> {
  factory $LocationEntityCopyWith(
    LocationEntity value,
    $Res Function(LocationEntity) then,
  ) = _$LocationEntityCopyWithImpl<$Res, LocationEntity>;
  @useResult
  $Res call({
    double? lat,
    double? lng,
    String locationName,
    String road,
    String houseNumber,
    String postcode,
    String borough,
    String city,
    String country,
  });
}

/// @nodoc
class _$LocationEntityCopyWithImpl<$Res, $Val extends LocationEntity>
    implements $LocationEntityCopyWith<$Res> {
  _$LocationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
    Object? locationName = null,
    Object? road = null,
    Object? houseNumber = null,
    Object? postcode = null,
    Object? borough = null,
    Object? city = null,
    Object? country = null,
  }) {
    return _then(
      _value.copyWith(
            lat: freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double?,
            lng: freezed == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double?,
            locationName: null == locationName
                ? _value.locationName
                : locationName // ignore: cast_nullable_to_non_nullable
                      as String,
            road: null == road
                ? _value.road
                : road // ignore: cast_nullable_to_non_nullable
                      as String,
            houseNumber: null == houseNumber
                ? _value.houseNumber
                : houseNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            postcode: null == postcode
                ? _value.postcode
                : postcode // ignore: cast_nullable_to_non_nullable
                      as String,
            borough: null == borough
                ? _value.borough
                : borough // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationEntityImplCopyWith<$Res>
    implements $LocationEntityCopyWith<$Res> {
  factory _$$LocationEntityImplCopyWith(
    _$LocationEntityImpl value,
    $Res Function(_$LocationEntityImpl) then,
  ) = __$$LocationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double? lat,
    double? lng,
    String locationName,
    String road,
    String houseNumber,
    String postcode,
    String borough,
    String city,
    String country,
  });
}

/// @nodoc
class __$$LocationEntityImplCopyWithImpl<$Res>
    extends _$LocationEntityCopyWithImpl<$Res, _$LocationEntityImpl>
    implements _$$LocationEntityImplCopyWith<$Res> {
  __$$LocationEntityImplCopyWithImpl(
    _$LocationEntityImpl _value,
    $Res Function(_$LocationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
    Object? locationName = null,
    Object? road = null,
    Object? houseNumber = null,
    Object? postcode = null,
    Object? borough = null,
    Object? city = null,
    Object? country = null,
  }) {
    return _then(
      _$LocationEntityImpl(
        lat: freezed == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double?,
        lng: freezed == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double?,
        locationName: null == locationName
            ? _value.locationName
            : locationName // ignore: cast_nullable_to_non_nullable
                  as String,
        road: null == road
            ? _value.road
            : road // ignore: cast_nullable_to_non_nullable
                  as String,
        houseNumber: null == houseNumber
            ? _value.houseNumber
            : houseNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        postcode: null == postcode
            ? _value.postcode
            : postcode // ignore: cast_nullable_to_non_nullable
                  as String,
        borough: null == borough
            ? _value.borough
            : borough // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LocationEntityImpl implements _LocationEntity {
  const _$LocationEntityImpl({
    this.lat,
    this.lng,
    this.locationName = '',
    this.road = '',
    this.houseNumber = '',
    this.postcode = '',
    this.borough = '',
    this.city = '',
    this.country = '',
  });

  @override
  final double? lat;
  @override
  final double? lng;
  @override
  @JsonKey()
  final String locationName;
  @override
  @JsonKey()
  final String road;
  @override
  @JsonKey()
  final String houseNumber;
  @override
  @JsonKey()
  final String postcode;
  @override
  @JsonKey()
  final String borough;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String country;

  @override
  String toString() {
    return 'LocationEntity(lat: $lat, lng: $lng, locationName: $locationName, road: $road, houseNumber: $houseNumber, postcode: $postcode, borough: $borough, city: $city, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationEntityImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.road, road) || other.road == road) &&
            (identical(other.houseNumber, houseNumber) ||
                other.houseNumber == houseNumber) &&
            (identical(other.postcode, postcode) ||
                other.postcode == postcode) &&
            (identical(other.borough, borough) || other.borough == borough) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    lat,
    lng,
    locationName,
    road,
    houseNumber,
    postcode,
    borough,
    city,
    country,
  );

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationEntityImplCopyWith<_$LocationEntityImpl> get copyWith =>
      __$$LocationEntityImplCopyWithImpl<_$LocationEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _LocationEntity implements LocationEntity {
  const factory _LocationEntity({
    final double? lat,
    final double? lng,
    final String locationName,
    final String road,
    final String houseNumber,
    final String postcode,
    final String borough,
    final String city,
    final String country,
  }) = _$LocationEntityImpl;

  @override
  double? get lat;
  @override
  double? get lng;
  @override
  String get locationName;
  @override
  String get road;
  @override
  String get houseNumber;
  @override
  String get postcode;
  @override
  String get borough;
  @override
  String get city;
  @override
  String get country;

  /// Create a copy of LocationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationEntityImplCopyWith<_$LocationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
