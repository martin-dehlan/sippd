// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WineEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  WineType get type => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get localImagePath => throw _privateConstructorUsedError;
  int? get vintage => throw _privateConstructorUsedError;
  String? get grape => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of WineEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineEntityCopyWith<WineEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineEntityCopyWith<$Res> {
  factory $WineEntityCopyWith(
    WineEntity value,
    $Res Function(WineEntity) then,
  ) = _$WineEntityCopyWithImpl<$Res, WineEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    double rating,
    WineType type,
    double? price,
    String currency,
    String? country,
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    String? imageUrl,
    String? localImagePath,
    int? vintage,
    String? grape,
    String userId,
    String visibility,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$WineEntityCopyWithImpl<$Res, $Val extends WineEntity>
    implements $WineEntityCopyWith<$Res> {
  _$WineEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rating = null,
    Object? type = null,
    Object? price = freezed,
    Object? currency = null,
    Object? country = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? notes = freezed,
    Object? imageUrl = freezed,
    Object? localImagePath = freezed,
    Object? vintage = freezed,
    Object? grape = freezed,
    Object? userId = null,
    Object? visibility = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as WineType,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            localImagePath: freezed == localImagePath
                ? _value.localImagePath
                : localImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            vintage: freezed == vintage
                ? _value.vintage
                : vintage // ignore: cast_nullable_to_non_nullable
                      as int?,
            grape: freezed == grape
                ? _value.grape
                : grape // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            visibility: null == visibility
                ? _value.visibility
                : visibility // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WineEntityImplCopyWith<$Res>
    implements $WineEntityCopyWith<$Res> {
  factory _$$WineEntityImplCopyWith(
    _$WineEntityImpl value,
    $Res Function(_$WineEntityImpl) then,
  ) = __$$WineEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double rating,
    WineType type,
    double? price,
    String currency,
    String? country,
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    String? imageUrl,
    String? localImagePath,
    int? vintage,
    String? grape,
    String userId,
    String visibility,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$WineEntityImplCopyWithImpl<$Res>
    extends _$WineEntityCopyWithImpl<$Res, _$WineEntityImpl>
    implements _$$WineEntityImplCopyWith<$Res> {
  __$$WineEntityImplCopyWithImpl(
    _$WineEntityImpl _value,
    $Res Function(_$WineEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rating = null,
    Object? type = null,
    Object? price = freezed,
    Object? currency = null,
    Object? country = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? notes = freezed,
    Object? imageUrl = freezed,
    Object? localImagePath = freezed,
    Object? vintage = freezed,
    Object? grape = freezed,
    Object? userId = null,
    Object? visibility = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$WineEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as WineType,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        localImagePath: freezed == localImagePath
            ? _value.localImagePath
            : localImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        vintage: freezed == vintage
            ? _value.vintage
            : vintage // ignore: cast_nullable_to_non_nullable
                  as int?,
        grape: freezed == grape
            ? _value.grape
            : grape // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        visibility: null == visibility
            ? _value.visibility
            : visibility // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$WineEntityImpl implements _WineEntity {
  const _$WineEntityImpl({
    required this.id,
    required this.name,
    required this.rating,
    required this.type,
    this.price,
    this.currency = 'EUR',
    this.country,
    this.location,
    this.latitude,
    this.longitude,
    this.notes,
    this.imageUrl,
    this.localImagePath,
    this.vintage,
    this.grape,
    required this.userId,
    this.visibility = 'friends',
    required this.createdAt,
    this.updatedAt,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final double rating;
  @override
  final WineType type;
  @override
  final double? price;
  @override
  @JsonKey()
  final String currency;
  @override
  final String? country;
  @override
  final String? location;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? notes;
  @override
  final String? imageUrl;
  @override
  final String? localImagePath;
  @override
  final int? vintage;
  @override
  final String? grape;
  @override
  final String userId;
  @override
  @JsonKey()
  final String visibility;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WineEntity(id: $id, name: $name, rating: $rating, type: $type, price: $price, currency: $currency, country: $country, location: $location, latitude: $latitude, longitude: $longitude, notes: $notes, imageUrl: $imageUrl, localImagePath: $localImagePath, vintage: $vintage, grape: $grape, userId: $userId, visibility: $visibility, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.localImagePath, localImagePath) ||
                other.localImagePath == localImagePath) &&
            (identical(other.vintage, vintage) || other.vintage == vintage) &&
            (identical(other.grape, grape) || other.grape == grape) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    rating,
    type,
    price,
    currency,
    country,
    location,
    latitude,
    longitude,
    notes,
    imageUrl,
    localImagePath,
    vintage,
    grape,
    userId,
    visibility,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of WineEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineEntityImplCopyWith<_$WineEntityImpl> get copyWith =>
      __$$WineEntityImplCopyWithImpl<_$WineEntityImpl>(this, _$identity);
}

abstract class _WineEntity implements WineEntity {
  const factory _WineEntity({
    required final String id,
    required final String name,
    required final double rating,
    required final WineType type,
    final double? price,
    final String currency,
    final String? country,
    final String? location,
    final double? latitude,
    final double? longitude,
    final String? notes,
    final String? imageUrl,
    final String? localImagePath,
    final int? vintage,
    final String? grape,
    required final String userId,
    final String visibility,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$WineEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get rating;
  @override
  WineType get type;
  @override
  double? get price;
  @override
  String get currency;
  @override
  String? get country;
  @override
  String? get location;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get notes;
  @override
  String? get imageUrl;
  @override
  String? get localImagePath;
  @override
  int? get vintage;
  @override
  String? get grape;
  @override
  String get userId;
  @override
  String get visibility;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of WineEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineEntityImplCopyWith<_$WineEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
