// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WinesTableTable extends WinesTable
    with TableInfo<$WinesTableTable, WineTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WinesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('EUR'),
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localImagePathMeta = const VerificationMeta(
    'localImagePath',
  );
  @override
  late final GeneratedColumn<String> localImagePath = GeneratedColumn<String>(
    'local_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vintageMeta = const VerificationMeta(
    'vintage',
  );
  @override
  late final GeneratedColumn<int> vintage = GeneratedColumn<int>(
    'vintage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grapeMeta = const VerificationMeta('grape');
  @override
  late final GeneratedColumn<String> grape = GeneratedColumn<String>(
    'grape',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visibilityMeta = const VerificationMeta(
    'visibility',
  );
  @override
  late final GeneratedColumn<String> visibility = GeneratedColumn<String>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('friends'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wines';
  @override
  VerificationContext validateIntegrity(
    Insertable<WineTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('local_image_path')) {
      context.handle(
        _localImagePathMeta,
        localImagePath.isAcceptableOrUnknown(
          data['local_image_path']!,
          _localImagePathMeta,
        ),
      );
    }
    if (data.containsKey('vintage')) {
      context.handle(
        _vintageMeta,
        vintage.isAcceptableOrUnknown(data['vintage']!, _vintageMeta),
      );
    }
    if (data.containsKey('grape')) {
      context.handle(
        _grapeMeta,
        grape.isAcceptableOrUnknown(data['grape']!, _grapeMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('visibility')) {
      context.handle(
        _visibilityMeta,
        visibility.isAcceptableOrUnknown(data['visibility']!, _visibilityMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WineTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      localImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_path'],
      ),
      vintage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vintage'],
      ),
      grape: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grape'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      visibility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visibility'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $WinesTableTable createAlias(String alias) {
    return $WinesTableTable(attachedDatabase, alias);
  }
}

class WineTableData extends DataClass implements Insertable<WineTableData> {
  final String id;
  final String name;
  final double rating;
  final String type;
  final double? price;
  final String currency;
  final String? country;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final String? imageUrl;
  final String? localImagePath;
  final int? vintage;
  final String? grape;
  final String userId;
  final String visibility;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const WineTableData({
    required this.id,
    required this.name,
    required this.rating,
    required this.type,
    this.price,
    required this.currency,
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
    required this.visibility,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['rating'] = Variable<double>(rating);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    if (!nullToAbsent || vintage != null) {
      map['vintage'] = Variable<int>(vintage);
    }
    if (!nullToAbsent || grape != null) {
      map['grape'] = Variable<String>(grape);
    }
    map['user_id'] = Variable<String>(userId);
    map['visibility'] = Variable<String>(visibility);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  WinesTableCompanion toCompanion(bool nullToAbsent) {
    return WinesTableCompanion(
      id: Value(id),
      name: Value(name),
      rating: Value(rating),
      type: Value(type),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      currency: Value(currency),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      vintage: vintage == null && nullToAbsent
          ? const Value.absent()
          : Value(vintage),
      grape: grape == null && nullToAbsent
          ? const Value.absent()
          : Value(grape),
      userId: Value(userId),
      visibility: Value(visibility),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory WineTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      rating: serializer.fromJson<double>(json['rating']),
      type: serializer.fromJson<String>(json['type']),
      price: serializer.fromJson<double?>(json['price']),
      currency: serializer.fromJson<String>(json['currency']),
      country: serializer.fromJson<String?>(json['country']),
      location: serializer.fromJson<String?>(json['location']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      notes: serializer.fromJson<String?>(json['notes']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      vintage: serializer.fromJson<int?>(json['vintage']),
      grape: serializer.fromJson<String?>(json['grape']),
      userId: serializer.fromJson<String>(json['userId']),
      visibility: serializer.fromJson<String>(json['visibility']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'rating': serializer.toJson<double>(rating),
      'type': serializer.toJson<String>(type),
      'price': serializer.toJson<double?>(price),
      'currency': serializer.toJson<String>(currency),
      'country': serializer.toJson<String?>(country),
      'location': serializer.toJson<String?>(location),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'notes': serializer.toJson<String?>(notes),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'vintage': serializer.toJson<int?>(vintage),
      'grape': serializer.toJson<String?>(grape),
      'userId': serializer.toJson<String>(userId),
      'visibility': serializer.toJson<String>(visibility),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  WineTableData copyWith({
    String? id,
    String? name,
    double? rating,
    String? type,
    Value<double?> price = const Value.absent(),
    String? currency,
    Value<String?> country = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    Value<int?> vintage = const Value.absent(),
    Value<String?> grape = const Value.absent(),
    String? userId,
    String? visibility,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => WineTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    rating: rating ?? this.rating,
    type: type ?? this.type,
    price: price.present ? price.value : this.price,
    currency: currency ?? this.currency,
    country: country.present ? country.value : this.country,
    location: location.present ? location.value : this.location,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    notes: notes.present ? notes.value : this.notes,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    vintage: vintage.present ? vintage.value : this.vintage,
    grape: grape.present ? grape.value : this.grape,
    userId: userId ?? this.userId,
    visibility: visibility ?? this.visibility,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  WineTableData copyWithCompanion(WinesTableCompanion data) {
    return WineTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      rating: data.rating.present ? data.rating.value : this.rating,
      type: data.type.present ? data.type.value : this.type,
      price: data.price.present ? data.price.value : this.price,
      currency: data.currency.present ? data.currency.value : this.currency,
      country: data.country.present ? data.country.value : this.country,
      location: data.location.present ? data.location.value : this.location,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      notes: data.notes.present ? data.notes.value : this.notes,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      localImagePath: data.localImagePath.present
          ? data.localImagePath.value
          : this.localImagePath,
      vintage: data.vintage.present ? data.vintage.value : this.vintage,
      grape: data.grape.present ? data.grape.value : this.grape,
      userId: data.userId.present ? data.userId.value : this.userId,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rating: $rating, ')
          ..write('type: $type, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('country: $country, ')
          ..write('location: $location, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('notes: $notes, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('vintage: $vintage, ')
          ..write('grape: $grape, ')
          ..write('userId: $userId, ')
          ..write('visibility: $visibility, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.rating == this.rating &&
          other.type == this.type &&
          other.price == this.price &&
          other.currency == this.currency &&
          other.country == this.country &&
          other.location == this.location &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.notes == this.notes &&
          other.imageUrl == this.imageUrl &&
          other.localImagePath == this.localImagePath &&
          other.vintage == this.vintage &&
          other.grape == this.grape &&
          other.userId == this.userId &&
          other.visibility == this.visibility &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WinesTableCompanion extends UpdateCompanion<WineTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> rating;
  final Value<String> type;
  final Value<double?> price;
  final Value<String> currency;
  final Value<String?> country;
  final Value<String?> location;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> notes;
  final Value<String?> imageUrl;
  final Value<String?> localImagePath;
  final Value<int?> vintage;
  final Value<String?> grape;
  final Value<String> userId;
  final Value<String> visibility;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const WinesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rating = const Value.absent(),
    this.type = const Value.absent(),
    this.price = const Value.absent(),
    this.currency = const Value.absent(),
    this.country = const Value.absent(),
    this.location = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.notes = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.vintage = const Value.absent(),
    this.grape = const Value.absent(),
    this.userId = const Value.absent(),
    this.visibility = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WinesTableCompanion.insert({
    required String id,
    required String name,
    required double rating,
    required String type,
    this.price = const Value.absent(),
    this.currency = const Value.absent(),
    this.country = const Value.absent(),
    this.location = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.notes = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.vintage = const Value.absent(),
    this.grape = const Value.absent(),
    required String userId,
    this.visibility = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       rating = Value(rating),
       type = Value(type),
       userId = Value(userId);
  static Insertable<WineTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? rating,
    Expression<String>? type,
    Expression<double>? price,
    Expression<String>? currency,
    Expression<String>? country,
    Expression<String>? location,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? notes,
    Expression<String>? imageUrl,
    Expression<String>? localImagePath,
    Expression<int>? vintage,
    Expression<String>? grape,
    Expression<String>? userId,
    Expression<String>? visibility,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rating != null) 'rating': rating,
      if (type != null) 'type': type,
      if (price != null) 'price': price,
      if (currency != null) 'currency': currency,
      if (country != null) 'country': country,
      if (location != null) 'location': location,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (notes != null) 'notes': notes,
      if (imageUrl != null) 'image_url': imageUrl,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (vintage != null) 'vintage': vintage,
      if (grape != null) 'grape': grape,
      if (userId != null) 'user_id': userId,
      if (visibility != null) 'visibility': visibility,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WinesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? rating,
    Value<String>? type,
    Value<double?>? price,
    Value<String>? currency,
    Value<String?>? country,
    Value<String?>? location,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? notes,
    Value<String?>? imageUrl,
    Value<String?>? localImagePath,
    Value<int?>? vintage,
    Value<String?>? grape,
    Value<String>? userId,
    Value<String>? visibility,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return WinesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      country: country ?? this.country,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      notes: notes ?? this.notes,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      vintage: vintage ?? this.vintage,
      grape: grape ?? this.grape,
      userId: userId ?? this.userId,
      visibility: visibility ?? this.visibility,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
    }
    if (vintage.present) {
      map['vintage'] = Variable<int>(vintage.value);
    }
    if (grape.present) {
      map['grape'] = Variable<String>(grape.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<String>(visibility.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WinesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rating: $rating, ')
          ..write('type: $type, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('country: $country, ')
          ..write('location: $location, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('notes: $notes, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('vintage: $vintage, ')
          ..write('grape: $grape, ')
          ..write('userId: $userId, ')
          ..write('visibility: $visibility, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WineMemoriesTableTable extends WineMemoriesTable
    with TableInfo<$WineMemoriesTableTable, WineMemoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WineMemoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<String> wineId = GeneratedColumn<String>(
    'wine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localImagePathMeta = const VerificationMeta(
    'localImagePath',
  );
  @override
  late final GeneratedColumn<String> localImagePath = GeneratedColumn<String>(
    'local_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wineId,
    userId,
    imageUrl,
    localImagePath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wine_memories';
  @override
  VerificationContext validateIntegrity(
    Insertable<WineMemoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('wine_id')) {
      context.handle(
        _wineIdMeta,
        wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('local_image_path')) {
      context.handle(
        _localImagePathMeta,
        localImagePath.isAcceptableOrUnknown(
          data['local_image_path']!,
          _localImagePathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WineMemoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineMemoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      wineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wine_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      localImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WineMemoriesTableTable createAlias(String alias) {
    return $WineMemoriesTableTable(attachedDatabase, alias);
  }
}

class WineMemoryTableData extends DataClass
    implements Insertable<WineMemoryTableData> {
  final String id;
  final String wineId;
  final String userId;
  final String? imageUrl;
  final String? localImagePath;
  final DateTime createdAt;
  const WineMemoryTableData({
    required this.id,
    required this.wineId,
    required this.userId,
    this.imageUrl,
    this.localImagePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['wine_id'] = Variable<String>(wineId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WineMemoriesTableCompanion toCompanion(bool nullToAbsent) {
    return WineMemoriesTableCompanion(
      id: Value(id),
      wineId: Value(wineId),
      userId: Value(userId),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      createdAt: Value(createdAt),
    );
  }

  factory WineMemoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineMemoryTableData(
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      userId: serializer.fromJson<String>(json['userId']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'userId': serializer.toJson<String>(userId),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WineMemoryTableData copyWith({
    String? id,
    String? wineId,
    String? userId,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    DateTime? createdAt,
  }) => WineMemoryTableData(
    id: id ?? this.id,
    wineId: wineId ?? this.wineId,
    userId: userId ?? this.userId,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    createdAt: createdAt ?? this.createdAt,
  );
  WineMemoryTableData copyWithCompanion(WineMemoriesTableCompanion data) {
    return WineMemoryTableData(
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      userId: data.userId.present ? data.userId.value : this.userId,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      localImagePath: data.localImagePath.present
          ? data.localImagePath.value
          : this.localImagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineMemoryTableData(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('userId: $userId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, wineId, userId, imageUrl, localImagePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineMemoryTableData &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.userId == this.userId &&
          other.imageUrl == this.imageUrl &&
          other.localImagePath == this.localImagePath &&
          other.createdAt == this.createdAt);
}

class WineMemoriesTableCompanion extends UpdateCompanion<WineMemoryTableData> {
  final Value<String> id;
  final Value<String> wineId;
  final Value<String> userId;
  final Value<String?> imageUrl;
  final Value<String?> localImagePath;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WineMemoriesTableCompanion({
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.userId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WineMemoriesTableCompanion.insert({
    required String id,
    required String wineId,
    required String userId,
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       wineId = Value(wineId),
       userId = Value(userId);
  static Insertable<WineMemoryTableData> custom({
    Expression<String>? id,
    Expression<String>? wineId,
    Expression<String>? userId,
    Expression<String>? imageUrl,
    Expression<String>? localImagePath,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (userId != null) 'user_id': userId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WineMemoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? wineId,
    Value<String>? userId,
    Value<String?>? imageUrl,
    Value<String?>? localImagePath,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WineMemoriesTableCompanion(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WineMemoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('userId: $userId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WinesTableTable winesTable = $WinesTableTable(this);
  late final $WineMemoriesTableTable wineMemoriesTable =
      $WineMemoriesTableTable(this);
  late final WinesDao winesDao = WinesDao(this as AppDatabase);
  late final WineMemoriesDao wineMemoriesDao = WineMemoriesDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    winesTable,
    wineMemoriesTable,
  ];
}

typedef $$WinesTableTableCreateCompanionBuilder =
    WinesTableCompanion Function({
      required String id,
      required String name,
      required double rating,
      required String type,
      Value<double?> price,
      Value<String> currency,
      Value<String?> country,
      Value<String?> location,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> notes,
      Value<String?> imageUrl,
      Value<String?> localImagePath,
      Value<int?> vintage,
      Value<String?> grape,
      required String userId,
      Value<String> visibility,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$WinesTableTableUpdateCompanionBuilder =
    WinesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> rating,
      Value<String> type,
      Value<double?> price,
      Value<String> currency,
      Value<String?> country,
      Value<String?> location,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> notes,
      Value<String?> imageUrl,
      Value<String?> localImagePath,
      Value<int?> vintage,
      Value<String?> grape,
      Value<String> userId,
      Value<String> visibility,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$WinesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WinesTableTable> {
  $$WinesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vintage => $composableBuilder(
    column: $table.vintage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grape => $composableBuilder(
    column: $table.grape,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WinesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WinesTableTable> {
  $$WinesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vintage => $composableBuilder(
    column: $table.vintage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grape => $composableBuilder(
    column: $table.grape,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WinesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WinesTableTable> {
  $$WinesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vintage =>
      $composableBuilder(column: $table.vintage, builder: (column) => column);

  GeneratedColumn<String> get grape =>
      $composableBuilder(column: $table.grape, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WinesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WinesTableTable,
          WineTableData,
          $$WinesTableTableFilterComposer,
          $$WinesTableTableOrderingComposer,
          $$WinesTableTableAnnotationComposer,
          $$WinesTableTableCreateCompanionBuilder,
          $$WinesTableTableUpdateCompanionBuilder,
          (
            WineTableData,
            BaseReferences<_$AppDatabase, $WinesTableTable, WineTableData>,
          ),
          WineTableData,
          PrefetchHooks Function()
        > {
  $$WinesTableTableTableManager(_$AppDatabase db, $WinesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WinesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WinesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WinesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<int?> vintage = const Value.absent(),
                Value<String?> grape = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WinesTableCompanion(
                id: id,
                name: name,
                rating: rating,
                type: type,
                price: price,
                currency: currency,
                country: country,
                location: location,
                latitude: latitude,
                longitude: longitude,
                notes: notes,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                vintage: vintage,
                grape: grape,
                userId: userId,
                visibility: visibility,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double rating,
                required String type,
                Value<double?> price = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<int?> vintage = const Value.absent(),
                Value<String?> grape = const Value.absent(),
                required String userId,
                Value<String> visibility = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WinesTableCompanion.insert(
                id: id,
                name: name,
                rating: rating,
                type: type,
                price: price,
                currency: currency,
                country: country,
                location: location,
                latitude: latitude,
                longitude: longitude,
                notes: notes,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                vintage: vintage,
                grape: grape,
                userId: userId,
                visibility: visibility,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WinesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WinesTableTable,
      WineTableData,
      $$WinesTableTableFilterComposer,
      $$WinesTableTableOrderingComposer,
      $$WinesTableTableAnnotationComposer,
      $$WinesTableTableCreateCompanionBuilder,
      $$WinesTableTableUpdateCompanionBuilder,
      (
        WineTableData,
        BaseReferences<_$AppDatabase, $WinesTableTable, WineTableData>,
      ),
      WineTableData,
      PrefetchHooks Function()
    >;
typedef $$WineMemoriesTableTableCreateCompanionBuilder =
    WineMemoriesTableCompanion Function({
      required String id,
      required String wineId,
      required String userId,
      Value<String?> imageUrl,
      Value<String?> localImagePath,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WineMemoriesTableTableUpdateCompanionBuilder =
    WineMemoriesTableCompanion Function({
      Value<String> id,
      Value<String> wineId,
      Value<String> userId,
      Value<String?> imageUrl,
      Value<String?> localImagePath,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$WineMemoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WineMemoriesTableTable> {
  $$WineMemoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wineId => $composableBuilder(
    column: $table.wineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WineMemoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WineMemoriesTableTable> {
  $$WineMemoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wineId => $composableBuilder(
    column: $table.wineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WineMemoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WineMemoriesTableTable> {
  $$WineMemoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get wineId =>
      $composableBuilder(column: $table.wineId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WineMemoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WineMemoriesTableTable,
          WineMemoryTableData,
          $$WineMemoriesTableTableFilterComposer,
          $$WineMemoriesTableTableOrderingComposer,
          $$WineMemoriesTableTableAnnotationComposer,
          $$WineMemoriesTableTableCreateCompanionBuilder,
          $$WineMemoriesTableTableUpdateCompanionBuilder,
          (
            WineMemoryTableData,
            BaseReferences<
              _$AppDatabase,
              $WineMemoriesTableTable,
              WineMemoryTableData
            >,
          ),
          WineMemoryTableData,
          PrefetchHooks Function()
        > {
  $$WineMemoriesTableTableTableManager(
    _$AppDatabase db,
    $WineMemoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WineMemoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WineMemoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WineMemoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> wineId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WineMemoriesTableCompanion(
                id: id,
                wineId: wineId,
                userId: userId,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String wineId,
                required String userId,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WineMemoriesTableCompanion.insert(
                id: id,
                wineId: wineId,
                userId: userId,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WineMemoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WineMemoriesTableTable,
      WineMemoryTableData,
      $$WineMemoriesTableTableFilterComposer,
      $$WineMemoriesTableTableOrderingComposer,
      $$WineMemoriesTableTableAnnotationComposer,
      $$WineMemoriesTableTableCreateCompanionBuilder,
      $$WineMemoriesTableTableUpdateCompanionBuilder,
      (
        WineMemoryTableData,
        BaseReferences<
          _$AppDatabase,
          $WineMemoriesTableTable,
          WineMemoryTableData
        >,
      ),
      WineMemoryTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WinesTableTableTableManager get winesTable =>
      $$WinesTableTableTableManager(_db, _db.winesTable);
  $$WineMemoriesTableTableTableManager get wineMemoriesTable =>
      $$WineMemoriesTableTableTableManager(_db, _db.wineMemoriesTable);
}
