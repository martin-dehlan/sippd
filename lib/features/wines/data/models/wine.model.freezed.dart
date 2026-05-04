// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WineModel _$WineModelFromJson(Map<String, dynamic> json) {
  return _WineModel.fromJson(json);
}

/// @nodoc
mixin _$WineModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError; // Local-only — never written to Supabase. Stays on the originating
  // device until the upload completes and `imageUrl` takes over.
  @JsonKey(name: 'local_image_path', includeToJson: false)
  String? get localImagePath => throw _privateConstructorUsedError;
  int? get vintage => throw _privateConstructorUsedError;
  String? get grape => throw _privateConstructorUsedError;
  @JsonKey(name: 'canonical_grape_id')
  String? get canonicalGrapeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'grape_freetext')
  String? get grapeFreetext => throw _privateConstructorUsedError;
  @JsonKey(name: 'canonical_wine_id')
  String? get canonicalWineId => throw _privateConstructorUsedError;
  String? get winery => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_norm')
  String? get nameNorm => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WineModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WineModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineModelCopyWith<WineModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineModelCopyWith<$Res> {
  factory $WineModelCopyWith(WineModel value, $Res Function(WineModel) then) =
      _$WineModelCopyWithImpl<$Res, WineModel>;
  @useResult
  $Res call({
    String id,
    String name,
    double rating,
    String type,
    double? price,
    String currency,
    String? country,
    String? region,
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path', includeToJson: false)
    String? localImagePath,
    int? vintage,
    String? grape,
    @JsonKey(name: 'canonical_grape_id') String? canonicalGrapeId,
    @JsonKey(name: 'grape_freetext') String? grapeFreetext,
    @JsonKey(name: 'canonical_wine_id') String? canonicalWineId,
    String? winery,
    @JsonKey(name: 'name_norm') String? nameNorm,
    @JsonKey(name: 'user_id') String userId,
    String visibility,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$WineModelCopyWithImpl<$Res, $Val extends WineModel>
    implements $WineModelCopyWith<$Res> {
  _$WineModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineModel
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
    Object? region = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? notes = freezed,
    Object? imageUrl = freezed,
    Object? localImagePath = freezed,
    Object? vintage = freezed,
    Object? grape = freezed,
    Object? canonicalGrapeId = freezed,
    Object? grapeFreetext = freezed,
    Object? canonicalWineId = freezed,
    Object? winery = freezed,
    Object? nameNorm = freezed,
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
                      as String,
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
            region: freezed == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
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
            canonicalGrapeId: freezed == canonicalGrapeId
                ? _value.canonicalGrapeId
                : canonicalGrapeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            grapeFreetext: freezed == grapeFreetext
                ? _value.grapeFreetext
                : grapeFreetext // ignore: cast_nullable_to_non_nullable
                      as String?,
            canonicalWineId: freezed == canonicalWineId
                ? _value.canonicalWineId
                : canonicalWineId // ignore: cast_nullable_to_non_nullable
                      as String?,
            winery: freezed == winery
                ? _value.winery
                : winery // ignore: cast_nullable_to_non_nullable
                      as String?,
            nameNorm: freezed == nameNorm
                ? _value.nameNorm
                : nameNorm // ignore: cast_nullable_to_non_nullable
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
abstract class _$$WineModelImplCopyWith<$Res>
    implements $WineModelCopyWith<$Res> {
  factory _$$WineModelImplCopyWith(
    _$WineModelImpl value,
    $Res Function(_$WineModelImpl) then,
  ) = __$$WineModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double rating,
    String type,
    double? price,
    String currency,
    String? country,
    String? region,
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path', includeToJson: false)
    String? localImagePath,
    int? vintage,
    String? grape,
    @JsonKey(name: 'canonical_grape_id') String? canonicalGrapeId,
    @JsonKey(name: 'grape_freetext') String? grapeFreetext,
    @JsonKey(name: 'canonical_wine_id') String? canonicalWineId,
    String? winery,
    @JsonKey(name: 'name_norm') String? nameNorm,
    @JsonKey(name: 'user_id') String userId,
    String visibility,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$WineModelImplCopyWithImpl<$Res>
    extends _$WineModelCopyWithImpl<$Res, _$WineModelImpl>
    implements _$$WineModelImplCopyWith<$Res> {
  __$$WineModelImplCopyWithImpl(
    _$WineModelImpl _value,
    $Res Function(_$WineModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineModel
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
    Object? region = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? notes = freezed,
    Object? imageUrl = freezed,
    Object? localImagePath = freezed,
    Object? vintage = freezed,
    Object? grape = freezed,
    Object? canonicalGrapeId = freezed,
    Object? grapeFreetext = freezed,
    Object? canonicalWineId = freezed,
    Object? winery = freezed,
    Object? nameNorm = freezed,
    Object? userId = null,
    Object? visibility = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$WineModelImpl(
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
                  as String,
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
        region: freezed == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
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
        canonicalGrapeId: freezed == canonicalGrapeId
            ? _value.canonicalGrapeId
            : canonicalGrapeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        grapeFreetext: freezed == grapeFreetext
            ? _value.grapeFreetext
            : grapeFreetext // ignore: cast_nullable_to_non_nullable
                  as String?,
        canonicalWineId: freezed == canonicalWineId
            ? _value.canonicalWineId
            : canonicalWineId // ignore: cast_nullable_to_non_nullable
                  as String?,
        winery: freezed == winery
            ? _value.winery
            : winery // ignore: cast_nullable_to_non_nullable
                  as String?,
        nameNorm: freezed == nameNorm
            ? _value.nameNorm
            : nameNorm // ignore: cast_nullable_to_non_nullable
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
@JsonSerializable()
class _$WineModelImpl implements _WineModel {
  const _$WineModelImpl({
    required this.id,
    required this.name,
    required this.rating,
    required this.type,
    this.price,
    this.currency = 'EUR',
    this.country,
    this.region,
    this.location,
    this.latitude,
    this.longitude,
    this.notes,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'local_image_path', includeToJson: false)
    this.localImagePath,
    this.vintage,
    this.grape,
    @JsonKey(name: 'canonical_grape_id') this.canonicalGrapeId,
    @JsonKey(name: 'grape_freetext') this.grapeFreetext,
    @JsonKey(name: 'canonical_wine_id') this.canonicalWineId,
    this.winery,
    @JsonKey(name: 'name_norm') this.nameNorm,
    @JsonKey(name: 'user_id') required this.userId,
    this.visibility = 'friends',
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$WineModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WineModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double rating;
  @override
  final String type;
  @override
  final double? price;
  @override
  @JsonKey()
  final String currency;
  @override
  final String? country;
  @override
  final String? region;
  @override
  final String? location;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  // Local-only — never written to Supabase. Stays on the originating
  // device until the upload completes and `imageUrl` takes over.
  @override
  @JsonKey(name: 'local_image_path', includeToJson: false)
  final String? localImagePath;
  @override
  final int? vintage;
  @override
  final String? grape;
  @override
  @JsonKey(name: 'canonical_grape_id')
  final String? canonicalGrapeId;
  @override
  @JsonKey(name: 'grape_freetext')
  final String? grapeFreetext;
  @override
  @JsonKey(name: 'canonical_wine_id')
  final String? canonicalWineId;
  @override
  final String? winery;
  @override
  @JsonKey(name: 'name_norm')
  final String? nameNorm;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String visibility;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WineModel(id: $id, name: $name, rating: $rating, type: $type, price: $price, currency: $currency, country: $country, region: $region, location: $location, latitude: $latitude, longitude: $longitude, notes: $notes, imageUrl: $imageUrl, localImagePath: $localImagePath, vintage: $vintage, grape: $grape, canonicalGrapeId: $canonicalGrapeId, grapeFreetext: $grapeFreetext, canonicalWineId: $canonicalWineId, winery: $winery, nameNorm: $nameNorm, userId: $userId, visibility: $visibility, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.region, region) || other.region == region) &&
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
            (identical(other.canonicalGrapeId, canonicalGrapeId) ||
                other.canonicalGrapeId == canonicalGrapeId) &&
            (identical(other.grapeFreetext, grapeFreetext) ||
                other.grapeFreetext == grapeFreetext) &&
            (identical(other.canonicalWineId, canonicalWineId) ||
                other.canonicalWineId == canonicalWineId) &&
            (identical(other.winery, winery) || other.winery == winery) &&
            (identical(other.nameNorm, nameNorm) ||
                other.nameNorm == nameNorm) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    region,
    location,
    latitude,
    longitude,
    notes,
    imageUrl,
    localImagePath,
    vintage,
    grape,
    canonicalGrapeId,
    grapeFreetext,
    canonicalWineId,
    winery,
    nameNorm,
    userId,
    visibility,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of WineModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineModelImplCopyWith<_$WineModelImpl> get copyWith =>
      __$$WineModelImplCopyWithImpl<_$WineModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WineModelImplToJson(this);
  }
}

abstract class _WineModel implements WineModel {
  const factory _WineModel({
    required final String id,
    required final String name,
    required final double rating,
    required final String type,
    final double? price,
    final String currency,
    final String? country,
    final String? region,
    final String? location,
    final double? latitude,
    final double? longitude,
    final String? notes,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'local_image_path', includeToJson: false)
    final String? localImagePath,
    final int? vintage,
    final String? grape,
    @JsonKey(name: 'canonical_grape_id') final String? canonicalGrapeId,
    @JsonKey(name: 'grape_freetext') final String? grapeFreetext,
    @JsonKey(name: 'canonical_wine_id') final String? canonicalWineId,
    final String? winery,
    @JsonKey(name: 'name_norm') final String? nameNorm,
    @JsonKey(name: 'user_id') required final String userId,
    final String visibility,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$WineModelImpl;

  factory _WineModel.fromJson(Map<String, dynamic> json) =
      _$WineModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get rating;
  @override
  String get type;
  @override
  double? get price;
  @override
  String get currency;
  @override
  String? get country;
  @override
  String? get region;
  @override
  String? get location;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl; // Local-only — never written to Supabase. Stays on the originating
  // device until the upload completes and `imageUrl` takes over.
  @override
  @JsonKey(name: 'local_image_path', includeToJson: false)
  String? get localImagePath;
  @override
  int? get vintage;
  @override
  String? get grape;
  @override
  @JsonKey(name: 'canonical_grape_id')
  String? get canonicalGrapeId;
  @override
  @JsonKey(name: 'grape_freetext')
  String? get grapeFreetext;
  @override
  @JsonKey(name: 'canonical_wine_id')
  String? get canonicalWineId;
  @override
  String? get winery;
  @override
  @JsonKey(name: 'name_norm')
  String? get nameNorm;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get visibility;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of WineModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineModelImplCopyWith<_$WineModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
