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
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
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
  static const VerificationMeta _canonicalGrapeIdMeta = const VerificationMeta(
    'canonicalGrapeId',
  );
  @override
  late final GeneratedColumn<String> canonicalGrapeId = GeneratedColumn<String>(
    'canonical_grape_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grapeFreetextMeta = const VerificationMeta(
    'grapeFreetext',
  );
  @override
  late final GeneratedColumn<String> grapeFreetext = GeneratedColumn<String>(
    'grape_freetext',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canonicalWineIdMeta = const VerificationMeta(
    'canonicalWineId',
  );
  @override
  late final GeneratedColumn<String> canonicalWineId = GeneratedColumn<String>(
    'canonical_wine_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wineryMeta = const VerificationMeta('winery');
  @override
  late final GeneratedColumn<String> winery = GeneratedColumn<String>(
    'winery',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameNormMeta = const VerificationMeta(
    'nameNorm',
  );
  @override
  late final GeneratedColumn<String> nameNorm = GeneratedColumn<String>(
    'name_norm',
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
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
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
    if (data.containsKey('canonical_grape_id')) {
      context.handle(
        _canonicalGrapeIdMeta,
        canonicalGrapeId.isAcceptableOrUnknown(
          data['canonical_grape_id']!,
          _canonicalGrapeIdMeta,
        ),
      );
    }
    if (data.containsKey('grape_freetext')) {
      context.handle(
        _grapeFreetextMeta,
        grapeFreetext.isAcceptableOrUnknown(
          data['grape_freetext']!,
          _grapeFreetextMeta,
        ),
      );
    }
    if (data.containsKey('canonical_wine_id')) {
      context.handle(
        _canonicalWineIdMeta,
        canonicalWineId.isAcceptableOrUnknown(
          data['canonical_wine_id']!,
          _canonicalWineIdMeta,
        ),
      );
    }
    if (data.containsKey('winery')) {
      context.handle(
        _wineryMeta,
        winery.isAcceptableOrUnknown(data['winery']!, _wineryMeta),
      );
    }
    if (data.containsKey('name_norm')) {
      context.handle(
        _nameNormMeta,
        nameNorm.isAcceptableOrUnknown(data['name_norm']!, _nameNormMeta),
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
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
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
      canonicalGrapeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_grape_id'],
      ),
      grapeFreetext: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grape_freetext'],
      ),
      canonicalWineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_wine_id'],
      ),
      winery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}winery'],
      ),
      nameNorm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_norm'],
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
  final String? region;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final String? imageUrl;
  final String? localImagePath;
  final int? vintage;
  final String? grape;
  final String? canonicalGrapeId;
  final String? grapeFreetext;
  final String? canonicalWineId;
  final String? winery;
  final String? nameNorm;
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
    this.region,
    this.location,
    this.latitude,
    this.longitude,
    this.notes,
    this.imageUrl,
    this.localImagePath,
    this.vintage,
    this.grape,
    this.canonicalGrapeId,
    this.grapeFreetext,
    this.canonicalWineId,
    this.winery,
    this.nameNorm,
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
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
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
    if (!nullToAbsent || canonicalGrapeId != null) {
      map['canonical_grape_id'] = Variable<String>(canonicalGrapeId);
    }
    if (!nullToAbsent || grapeFreetext != null) {
      map['grape_freetext'] = Variable<String>(grapeFreetext);
    }
    if (!nullToAbsent || canonicalWineId != null) {
      map['canonical_wine_id'] = Variable<String>(canonicalWineId);
    }
    if (!nullToAbsent || winery != null) {
      map['winery'] = Variable<String>(winery);
    }
    if (!nullToAbsent || nameNorm != null) {
      map['name_norm'] = Variable<String>(nameNorm);
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
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
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
      canonicalGrapeId: canonicalGrapeId == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalGrapeId),
      grapeFreetext: grapeFreetext == null && nullToAbsent
          ? const Value.absent()
          : Value(grapeFreetext),
      canonicalWineId: canonicalWineId == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalWineId),
      winery: winery == null && nullToAbsent
          ? const Value.absent()
          : Value(winery),
      nameNorm: nameNorm == null && nullToAbsent
          ? const Value.absent()
          : Value(nameNorm),
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
      region: serializer.fromJson<String?>(json['region']),
      location: serializer.fromJson<String?>(json['location']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      notes: serializer.fromJson<String?>(json['notes']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      vintage: serializer.fromJson<int?>(json['vintage']),
      grape: serializer.fromJson<String?>(json['grape']),
      canonicalGrapeId: serializer.fromJson<String?>(json['canonicalGrapeId']),
      grapeFreetext: serializer.fromJson<String?>(json['grapeFreetext']),
      canonicalWineId: serializer.fromJson<String?>(json['canonicalWineId']),
      winery: serializer.fromJson<String?>(json['winery']),
      nameNorm: serializer.fromJson<String?>(json['nameNorm']),
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
      'region': serializer.toJson<String?>(region),
      'location': serializer.toJson<String?>(location),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'notes': serializer.toJson<String?>(notes),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'vintage': serializer.toJson<int?>(vintage),
      'grape': serializer.toJson<String?>(grape),
      'canonicalGrapeId': serializer.toJson<String?>(canonicalGrapeId),
      'grapeFreetext': serializer.toJson<String?>(grapeFreetext),
      'canonicalWineId': serializer.toJson<String?>(canonicalWineId),
      'winery': serializer.toJson<String?>(winery),
      'nameNorm': serializer.toJson<String?>(nameNorm),
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
    Value<String?> region = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    Value<int?> vintage = const Value.absent(),
    Value<String?> grape = const Value.absent(),
    Value<String?> canonicalGrapeId = const Value.absent(),
    Value<String?> grapeFreetext = const Value.absent(),
    Value<String?> canonicalWineId = const Value.absent(),
    Value<String?> winery = const Value.absent(),
    Value<String?> nameNorm = const Value.absent(),
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
    region: region.present ? region.value : this.region,
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
    canonicalGrapeId: canonicalGrapeId.present
        ? canonicalGrapeId.value
        : this.canonicalGrapeId,
    grapeFreetext: grapeFreetext.present
        ? grapeFreetext.value
        : this.grapeFreetext,
    canonicalWineId: canonicalWineId.present
        ? canonicalWineId.value
        : this.canonicalWineId,
    winery: winery.present ? winery.value : this.winery,
    nameNorm: nameNorm.present ? nameNorm.value : this.nameNorm,
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
      region: data.region.present ? data.region.value : this.region,
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
      canonicalGrapeId: data.canonicalGrapeId.present
          ? data.canonicalGrapeId.value
          : this.canonicalGrapeId,
      grapeFreetext: data.grapeFreetext.present
          ? data.grapeFreetext.value
          : this.grapeFreetext,
      canonicalWineId: data.canonicalWineId.present
          ? data.canonicalWineId.value
          : this.canonicalWineId,
      winery: data.winery.present ? data.winery.value : this.winery,
      nameNorm: data.nameNorm.present ? data.nameNorm.value : this.nameNorm,
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
          ..write('region: $region, ')
          ..write('location: $location, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('notes: $notes, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('vintage: $vintage, ')
          ..write('grape: $grape, ')
          ..write('canonicalGrapeId: $canonicalGrapeId, ')
          ..write('grapeFreetext: $grapeFreetext, ')
          ..write('canonicalWineId: $canonicalWineId, ')
          ..write('winery: $winery, ')
          ..write('nameNorm: $nameNorm, ')
          ..write('userId: $userId, ')
          ..write('visibility: $visibility, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
          other.region == this.region &&
          other.location == this.location &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.notes == this.notes &&
          other.imageUrl == this.imageUrl &&
          other.localImagePath == this.localImagePath &&
          other.vintage == this.vintage &&
          other.grape == this.grape &&
          other.canonicalGrapeId == this.canonicalGrapeId &&
          other.grapeFreetext == this.grapeFreetext &&
          other.canonicalWineId == this.canonicalWineId &&
          other.winery == this.winery &&
          other.nameNorm == this.nameNorm &&
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
  final Value<String?> region;
  final Value<String?> location;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> notes;
  final Value<String?> imageUrl;
  final Value<String?> localImagePath;
  final Value<int?> vintage;
  final Value<String?> grape;
  final Value<String?> canonicalGrapeId;
  final Value<String?> grapeFreetext;
  final Value<String?> canonicalWineId;
  final Value<String?> winery;
  final Value<String?> nameNorm;
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
    this.region = const Value.absent(),
    this.location = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.notes = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.vintage = const Value.absent(),
    this.grape = const Value.absent(),
    this.canonicalGrapeId = const Value.absent(),
    this.grapeFreetext = const Value.absent(),
    this.canonicalWineId = const Value.absent(),
    this.winery = const Value.absent(),
    this.nameNorm = const Value.absent(),
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
    this.region = const Value.absent(),
    this.location = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.notes = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.vintage = const Value.absent(),
    this.grape = const Value.absent(),
    this.canonicalGrapeId = const Value.absent(),
    this.grapeFreetext = const Value.absent(),
    this.canonicalWineId = const Value.absent(),
    this.winery = const Value.absent(),
    this.nameNorm = const Value.absent(),
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
    Expression<String>? region,
    Expression<String>? location,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? notes,
    Expression<String>? imageUrl,
    Expression<String>? localImagePath,
    Expression<int>? vintage,
    Expression<String>? grape,
    Expression<String>? canonicalGrapeId,
    Expression<String>? grapeFreetext,
    Expression<String>? canonicalWineId,
    Expression<String>? winery,
    Expression<String>? nameNorm,
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
      if (region != null) 'region': region,
      if (location != null) 'location': location,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (notes != null) 'notes': notes,
      if (imageUrl != null) 'image_url': imageUrl,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (vintage != null) 'vintage': vintage,
      if (grape != null) 'grape': grape,
      if (canonicalGrapeId != null) 'canonical_grape_id': canonicalGrapeId,
      if (grapeFreetext != null) 'grape_freetext': grapeFreetext,
      if (canonicalWineId != null) 'canonical_wine_id': canonicalWineId,
      if (winery != null) 'winery': winery,
      if (nameNorm != null) 'name_norm': nameNorm,
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
    Value<String?>? region,
    Value<String?>? location,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? notes,
    Value<String?>? imageUrl,
    Value<String?>? localImagePath,
    Value<int?>? vintage,
    Value<String?>? grape,
    Value<String?>? canonicalGrapeId,
    Value<String?>? grapeFreetext,
    Value<String?>? canonicalWineId,
    Value<String?>? winery,
    Value<String?>? nameNorm,
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
      region: region ?? this.region,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      notes: notes ?? this.notes,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      vintage: vintage ?? this.vintage,
      grape: grape ?? this.grape,
      canonicalGrapeId: canonicalGrapeId ?? this.canonicalGrapeId,
      grapeFreetext: grapeFreetext ?? this.grapeFreetext,
      canonicalWineId: canonicalWineId ?? this.canonicalWineId,
      winery: winery ?? this.winery,
      nameNorm: nameNorm ?? this.nameNorm,
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
    if (region.present) {
      map['region'] = Variable<String>(region.value);
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
    if (canonicalGrapeId.present) {
      map['canonical_grape_id'] = Variable<String>(canonicalGrapeId.value);
    }
    if (grapeFreetext.present) {
      map['grape_freetext'] = Variable<String>(grapeFreetext.value);
    }
    if (canonicalWineId.present) {
      map['canonical_wine_id'] = Variable<String>(canonicalWineId.value);
    }
    if (winery.present) {
      map['winery'] = Variable<String>(winery.value);
    }
    if (nameNorm.present) {
      map['name_norm'] = Variable<String>(nameNorm.value);
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
          ..write('region: $region, ')
          ..write('location: $location, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('notes: $notes, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('vintage: $vintage, ')
          ..write('grape: $grape, ')
          ..write('canonicalGrapeId: $canonicalGrapeId, ')
          ..write('grapeFreetext: $grapeFreetext, ')
          ..write('canonicalWineId: $canonicalWineId, ')
          ..write('winery: $winery, ')
          ..write('nameNorm: $nameNorm, ')
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
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
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
    caption,
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
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
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
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
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
  final String? caption;
  final DateTime createdAt;
  const WineMemoryTableData({
    required this.id,
    required this.wineId,
    required this.userId,
    this.imageUrl,
    this.localImagePath,
    this.caption,
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
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
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
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
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
      caption: serializer.fromJson<String?>(json['caption']),
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
      'caption': serializer.toJson<String?>(caption),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WineMemoryTableData copyWith({
    String? id,
    String? wineId,
    String? userId,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    Value<String?> caption = const Value.absent(),
    DateTime? createdAt,
  }) => WineMemoryTableData(
    id: id ?? this.id,
    wineId: wineId ?? this.wineId,
    userId: userId ?? this.userId,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    caption: caption.present ? caption.value : this.caption,
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
      caption: data.caption.present ? data.caption.value : this.caption,
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
          ..write('caption: $caption, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    wineId,
    userId,
    imageUrl,
    localImagePath,
    caption,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineMemoryTableData &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.userId == this.userId &&
          other.imageUrl == this.imageUrl &&
          other.localImagePath == this.localImagePath &&
          other.caption == this.caption &&
          other.createdAt == this.createdAt);
}

class WineMemoriesTableCompanion extends UpdateCompanion<WineMemoryTableData> {
  final Value<String> id;
  final Value<String> wineId;
  final Value<String> userId;
  final Value<String?> imageUrl;
  final Value<String?> localImagePath;
  final Value<String?> caption;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WineMemoriesTableCompanion({
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.userId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.caption = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WineMemoriesTableCompanion.insert({
    required String id,
    required String wineId,
    required String userId,
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.caption = const Value.absent(),
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
    Expression<String>? caption,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (userId != null) 'user_id': userId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (caption != null) 'caption': caption,
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
    Value<String?>? caption,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WineMemoriesTableCompanion(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      caption: caption ?? this.caption,
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
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
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
          ..write('caption: $caption, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WineAliasesTableTable extends WineAliasesTable
    with TableInfo<$WineAliasesTableTable, WineAliasTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WineAliasesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localWineIdMeta = const VerificationMeta(
    'localWineId',
  );
  @override
  late final GeneratedColumn<String> localWineId = GeneratedColumn<String>(
    'local_wine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _canonicalWineIdMeta = const VerificationMeta(
    'canonicalWineId',
  );
  @override
  late final GeneratedColumn<String> canonicalWineId = GeneratedColumn<String>(
    'canonical_wine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('share_match'),
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
    userId,
    localWineId,
    canonicalWineId,
    source,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wine_aliases';
  @override
  VerificationContext validateIntegrity(
    Insertable<WineAliasTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('local_wine_id')) {
      context.handle(
        _localWineIdMeta,
        localWineId.isAcceptableOrUnknown(
          data['local_wine_id']!,
          _localWineIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localWineIdMeta);
    }
    if (data.containsKey('canonical_wine_id')) {
      context.handle(
        _canonicalWineIdMeta,
        canonicalWineId.isAcceptableOrUnknown(
          data['canonical_wine_id']!,
          _canonicalWineIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalWineIdMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
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
  Set<GeneratedColumn> get $primaryKey => {userId, localWineId};
  @override
  WineAliasTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineAliasTableData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      localWineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_wine_id'],
      )!,
      canonicalWineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_wine_id'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WineAliasesTableTable createAlias(String alias) {
    return $WineAliasesTableTable(attachedDatabase, alias);
  }
}

class WineAliasTableData extends DataClass
    implements Insertable<WineAliasTableData> {
  final String userId;
  final String localWineId;
  final String canonicalWineId;
  final String source;
  final DateTime createdAt;
  const WineAliasTableData({
    required this.userId,
    required this.localWineId,
    required this.canonicalWineId,
    required this.source,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['local_wine_id'] = Variable<String>(localWineId);
    map['canonical_wine_id'] = Variable<String>(canonicalWineId);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WineAliasesTableCompanion toCompanion(bool nullToAbsent) {
    return WineAliasesTableCompanion(
      userId: Value(userId),
      localWineId: Value(localWineId),
      canonicalWineId: Value(canonicalWineId),
      source: Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory WineAliasTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineAliasTableData(
      userId: serializer.fromJson<String>(json['userId']),
      localWineId: serializer.fromJson<String>(json['localWineId']),
      canonicalWineId: serializer.fromJson<String>(json['canonicalWineId']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'localWineId': serializer.toJson<String>(localWineId),
      'canonicalWineId': serializer.toJson<String>(canonicalWineId),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WineAliasTableData copyWith({
    String? userId,
    String? localWineId,
    String? canonicalWineId,
    String? source,
    DateTime? createdAt,
  }) => WineAliasTableData(
    userId: userId ?? this.userId,
    localWineId: localWineId ?? this.localWineId,
    canonicalWineId: canonicalWineId ?? this.canonicalWineId,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  WineAliasTableData copyWithCompanion(WineAliasesTableCompanion data) {
    return WineAliasTableData(
      userId: data.userId.present ? data.userId.value : this.userId,
      localWineId: data.localWineId.present
          ? data.localWineId.value
          : this.localWineId,
      canonicalWineId: data.canonicalWineId.present
          ? data.canonicalWineId.value
          : this.canonicalWineId,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineAliasTableData(')
          ..write('userId: $userId, ')
          ..write('localWineId: $localWineId, ')
          ..write('canonicalWineId: $canonicalWineId, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, localWineId, canonicalWineId, source, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineAliasTableData &&
          other.userId == this.userId &&
          other.localWineId == this.localWineId &&
          other.canonicalWineId == this.canonicalWineId &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class WineAliasesTableCompanion extends UpdateCompanion<WineAliasTableData> {
  final Value<String> userId;
  final Value<String> localWineId;
  final Value<String> canonicalWineId;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WineAliasesTableCompanion({
    this.userId = const Value.absent(),
    this.localWineId = const Value.absent(),
    this.canonicalWineId = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WineAliasesTableCompanion.insert({
    required String userId,
    required String localWineId,
    required String canonicalWineId,
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       localWineId = Value(localWineId),
       canonicalWineId = Value(canonicalWineId);
  static Insertable<WineAliasTableData> custom({
    Expression<String>? userId,
    Expression<String>? localWineId,
    Expression<String>? canonicalWineId,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (localWineId != null) 'local_wine_id': localWineId,
      if (canonicalWineId != null) 'canonical_wine_id': canonicalWineId,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WineAliasesTableCompanion copyWith({
    Value<String>? userId,
    Value<String>? localWineId,
    Value<String>? canonicalWineId,
    Value<String>? source,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WineAliasesTableCompanion(
      userId: userId ?? this.userId,
      localWineId: localWineId ?? this.localWineId,
      canonicalWineId: canonicalWineId ?? this.canonicalWineId,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (localWineId.present) {
      map['local_wine_id'] = Variable<String>(localWineId.value);
    }
    if (canonicalWineId.present) {
      map['canonical_wine_id'] = Variable<String>(canonicalWineId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
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
    return (StringBuffer('WineAliasesTableCompanion(')
          ..write('userId: $userId, ')
          ..write('localWineId: $localWineId, ')
          ..write('canonicalWineId: $canonicalWineId, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationPrefsTableTable extends NotificationPrefsTable
    with TableInfo<$NotificationPrefsTableTable, NotificationPrefsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPrefsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tastingRemindersMeta = const VerificationMeta(
    'tastingReminders',
  );
  @override
  late final GeneratedColumn<bool> tastingReminders = GeneratedColumn<bool>(
    'tasting_reminders',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tasting_reminders" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _tastingReminderHoursMeta =
      const VerificationMeta('tastingReminderHours');
  @override
  late final GeneratedColumn<int> tastingReminderHours = GeneratedColumn<int>(
    'tasting_reminder_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _friendActivityMeta = const VerificationMeta(
    'friendActivity',
  );
  @override
  late final GeneratedColumn<bool> friendActivity = GeneratedColumn<bool>(
    'friend_activity',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("friend_activity" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _groupActivityMeta = const VerificationMeta(
    'groupActivity',
  );
  @override
  late final GeneratedColumn<bool> groupActivity = GeneratedColumn<bool>(
    'group_activity',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("group_activity" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _groupWineSharedMeta = const VerificationMeta(
    'groupWineShared',
  );
  @override
  late final GeneratedColumn<bool> groupWineShared = GeneratedColumn<bool>(
    'group_wine_shared',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("group_wine_shared" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    tastingReminders,
    tastingReminderHours,
    friendActivity,
    groupActivity,
    groupWineShared,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_prefs';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationPrefsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('tasting_reminders')) {
      context.handle(
        _tastingRemindersMeta,
        tastingReminders.isAcceptableOrUnknown(
          data['tasting_reminders']!,
          _tastingRemindersMeta,
        ),
      );
    }
    if (data.containsKey('tasting_reminder_hours')) {
      context.handle(
        _tastingReminderHoursMeta,
        tastingReminderHours.isAcceptableOrUnknown(
          data['tasting_reminder_hours']!,
          _tastingReminderHoursMeta,
        ),
      );
    }
    if (data.containsKey('friend_activity')) {
      context.handle(
        _friendActivityMeta,
        friendActivity.isAcceptableOrUnknown(
          data['friend_activity']!,
          _friendActivityMeta,
        ),
      );
    }
    if (data.containsKey('group_activity')) {
      context.handle(
        _groupActivityMeta,
        groupActivity.isAcceptableOrUnknown(
          data['group_activity']!,
          _groupActivityMeta,
        ),
      );
    }
    if (data.containsKey('group_wine_shared')) {
      context.handle(
        _groupWineSharedMeta,
        groupWineShared.isAcceptableOrUnknown(
          data['group_wine_shared']!,
          _groupWineSharedMeta,
        ),
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
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  NotificationPrefsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPrefsTableData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      tastingReminders: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tasting_reminders'],
      )!,
      tastingReminderHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tasting_reminder_hours'],
      )!,
      friendActivity: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}friend_activity'],
      )!,
      groupActivity: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}group_activity'],
      )!,
      groupWineShared: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}group_wine_shared'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationPrefsTableTable createAlias(String alias) {
    return $NotificationPrefsTableTable(attachedDatabase, alias);
  }
}

class NotificationPrefsTableData extends DataClass
    implements Insertable<NotificationPrefsTableData> {
  final String userId;
  final bool tastingReminders;
  final int tastingReminderHours;
  final bool friendActivity;
  final bool groupActivity;
  final bool groupWineShared;
  final DateTime updatedAt;
  const NotificationPrefsTableData({
    required this.userId,
    required this.tastingReminders,
    required this.tastingReminderHours,
    required this.friendActivity,
    required this.groupActivity,
    required this.groupWineShared,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['tasting_reminders'] = Variable<bool>(tastingReminders);
    map['tasting_reminder_hours'] = Variable<int>(tastingReminderHours);
    map['friend_activity'] = Variable<bool>(friendActivity);
    map['group_activity'] = Variable<bool>(groupActivity);
    map['group_wine_shared'] = Variable<bool>(groupWineShared);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotificationPrefsTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationPrefsTableCompanion(
      userId: Value(userId),
      tastingReminders: Value(tastingReminders),
      tastingReminderHours: Value(tastingReminderHours),
      friendActivity: Value(friendActivity),
      groupActivity: Value(groupActivity),
      groupWineShared: Value(groupWineShared),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationPrefsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPrefsTableData(
      userId: serializer.fromJson<String>(json['userId']),
      tastingReminders: serializer.fromJson<bool>(json['tastingReminders']),
      tastingReminderHours: serializer.fromJson<int>(
        json['tastingReminderHours'],
      ),
      friendActivity: serializer.fromJson<bool>(json['friendActivity']),
      groupActivity: serializer.fromJson<bool>(json['groupActivity']),
      groupWineShared: serializer.fromJson<bool>(json['groupWineShared']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'tastingReminders': serializer.toJson<bool>(tastingReminders),
      'tastingReminderHours': serializer.toJson<int>(tastingReminderHours),
      'friendActivity': serializer.toJson<bool>(friendActivity),
      'groupActivity': serializer.toJson<bool>(groupActivity),
      'groupWineShared': serializer.toJson<bool>(groupWineShared),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NotificationPrefsTableData copyWith({
    String? userId,
    bool? tastingReminders,
    int? tastingReminderHours,
    bool? friendActivity,
    bool? groupActivity,
    bool? groupWineShared,
    DateTime? updatedAt,
  }) => NotificationPrefsTableData(
    userId: userId ?? this.userId,
    tastingReminders: tastingReminders ?? this.tastingReminders,
    tastingReminderHours: tastingReminderHours ?? this.tastingReminderHours,
    friendActivity: friendActivity ?? this.friendActivity,
    groupActivity: groupActivity ?? this.groupActivity,
    groupWineShared: groupWineShared ?? this.groupWineShared,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationPrefsTableData copyWithCompanion(
    NotificationPrefsTableCompanion data,
  ) {
    return NotificationPrefsTableData(
      userId: data.userId.present ? data.userId.value : this.userId,
      tastingReminders: data.tastingReminders.present
          ? data.tastingReminders.value
          : this.tastingReminders,
      tastingReminderHours: data.tastingReminderHours.present
          ? data.tastingReminderHours.value
          : this.tastingReminderHours,
      friendActivity: data.friendActivity.present
          ? data.friendActivity.value
          : this.friendActivity,
      groupActivity: data.groupActivity.present
          ? data.groupActivity.value
          : this.groupActivity,
      groupWineShared: data.groupWineShared.present
          ? data.groupWineShared.value
          : this.groupWineShared,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPrefsTableData(')
          ..write('userId: $userId, ')
          ..write('tastingReminders: $tastingReminders, ')
          ..write('tastingReminderHours: $tastingReminderHours, ')
          ..write('friendActivity: $friendActivity, ')
          ..write('groupActivity: $groupActivity, ')
          ..write('groupWineShared: $groupWineShared, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    tastingReminders,
    tastingReminderHours,
    friendActivity,
    groupActivity,
    groupWineShared,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPrefsTableData &&
          other.userId == this.userId &&
          other.tastingReminders == this.tastingReminders &&
          other.tastingReminderHours == this.tastingReminderHours &&
          other.friendActivity == this.friendActivity &&
          other.groupActivity == this.groupActivity &&
          other.groupWineShared == this.groupWineShared &&
          other.updatedAt == this.updatedAt);
}

class NotificationPrefsTableCompanion
    extends UpdateCompanion<NotificationPrefsTableData> {
  final Value<String> userId;
  final Value<bool> tastingReminders;
  final Value<int> tastingReminderHours;
  final Value<bool> friendActivity;
  final Value<bool> groupActivity;
  final Value<bool> groupWineShared;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NotificationPrefsTableCompanion({
    this.userId = const Value.absent(),
    this.tastingReminders = const Value.absent(),
    this.tastingReminderHours = const Value.absent(),
    this.friendActivity = const Value.absent(),
    this.groupActivity = const Value.absent(),
    this.groupWineShared = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationPrefsTableCompanion.insert({
    required String userId,
    this.tastingReminders = const Value.absent(),
    this.tastingReminderHours = const Value.absent(),
    this.friendActivity = const Value.absent(),
    this.groupActivity = const Value.absent(),
    this.groupWineShared = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<NotificationPrefsTableData> custom({
    Expression<String>? userId,
    Expression<bool>? tastingReminders,
    Expression<int>? tastingReminderHours,
    Expression<bool>? friendActivity,
    Expression<bool>? groupActivity,
    Expression<bool>? groupWineShared,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (tastingReminders != null) 'tasting_reminders': tastingReminders,
      if (tastingReminderHours != null)
        'tasting_reminder_hours': tastingReminderHours,
      if (friendActivity != null) 'friend_activity': friendActivity,
      if (groupActivity != null) 'group_activity': groupActivity,
      if (groupWineShared != null) 'group_wine_shared': groupWineShared,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationPrefsTableCompanion copyWith({
    Value<String>? userId,
    Value<bool>? tastingReminders,
    Value<int>? tastingReminderHours,
    Value<bool>? friendActivity,
    Value<bool>? groupActivity,
    Value<bool>? groupWineShared,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationPrefsTableCompanion(
      userId: userId ?? this.userId,
      tastingReminders: tastingReminders ?? this.tastingReminders,
      tastingReminderHours: tastingReminderHours ?? this.tastingReminderHours,
      friendActivity: friendActivity ?? this.friendActivity,
      groupActivity: groupActivity ?? this.groupActivity,
      groupWineShared: groupWineShared ?? this.groupWineShared,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (tastingReminders.present) {
      map['tasting_reminders'] = Variable<bool>(tastingReminders.value);
    }
    if (tastingReminderHours.present) {
      map['tasting_reminder_hours'] = Variable<int>(tastingReminderHours.value);
    }
    if (friendActivity.present) {
      map['friend_activity'] = Variable<bool>(friendActivity.value);
    }
    if (groupActivity.present) {
      map['group_activity'] = Variable<bool>(groupActivity.value);
    }
    if (groupWineShared.present) {
      map['group_wine_shared'] = Variable<bool>(groupWineShared.value);
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
    return (StringBuffer('NotificationPrefsTableCompanion(')
          ..write('userId: $userId, ')
          ..write('tastingReminders: $tastingReminders, ')
          ..write('tastingReminderHours: $tastingReminderHours, ')
          ..write('friendActivity: $friendActivity, ')
          ..write('groupActivity: $groupActivity, ')
          ..write('groupWineShared: $groupWineShared, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CanonicalGrapeTableTable extends CanonicalGrapeTable
    with TableInfo<$CanonicalGrapeTableTable, CanonicalGrapeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CanonicalGrapeTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> aliases =
      GeneratedColumn<String>(
        'aliases',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      ).withConverter<List<String>>(
        $CanonicalGrapeTableTable.$converteraliases,
      );
  @override
  List<GeneratedColumn> get $columns => [id, name, color, aliases];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'canonical_grape';
  @override
  VerificationContext validateIntegrity(
    Insertable<CanonicalGrapeTableData> instance, {
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
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CanonicalGrapeTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CanonicalGrapeTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      aliases: $CanonicalGrapeTableTable.$converteraliases.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}aliases'],
        )!,
      ),
    );
  }

  @override
  $CanonicalGrapeTableTable createAlias(String alias) {
    return $CanonicalGrapeTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converteraliases =
      const AliasesConverter();
}

class CanonicalGrapeTableData extends DataClass
    implements Insertable<CanonicalGrapeTableData> {
  final String id;
  final String name;
  final String color;
  final List<String> aliases;
  const CanonicalGrapeTableData({
    required this.id,
    required this.name,
    required this.color,
    required this.aliases,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    {
      map['aliases'] = Variable<String>(
        $CanonicalGrapeTableTable.$converteraliases.toSql(aliases),
      );
    }
    return map;
  }

  CanonicalGrapeTableCompanion toCompanion(bool nullToAbsent) {
    return CanonicalGrapeTableCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      aliases: Value(aliases),
    );
  }

  factory CanonicalGrapeTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CanonicalGrapeTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      aliases: serializer.fromJson<List<String>>(json['aliases']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'aliases': serializer.toJson<List<String>>(aliases),
    };
  }

  CanonicalGrapeTableData copyWith({
    String? id,
    String? name,
    String? color,
    List<String>? aliases,
  }) => CanonicalGrapeTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    aliases: aliases ?? this.aliases,
  );
  CanonicalGrapeTableData copyWithCompanion(CanonicalGrapeTableCompanion data) {
    return CanonicalGrapeTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      aliases: data.aliases.present ? data.aliases.value : this.aliases,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CanonicalGrapeTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('aliases: $aliases')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, aliases);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CanonicalGrapeTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.aliases == this.aliases);
}

class CanonicalGrapeTableCompanion
    extends UpdateCompanion<CanonicalGrapeTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> color;
  final Value<List<String>> aliases;
  final Value<int> rowid;
  const CanonicalGrapeTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.aliases = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CanonicalGrapeTableCompanion.insert({
    required String id,
    required String name,
    required String color,
    this.aliases = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       color = Value(color);
  static Insertable<CanonicalGrapeTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? aliases,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (aliases != null) 'aliases': aliases,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CanonicalGrapeTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? color,
    Value<List<String>>? aliases,
    Value<int>? rowid,
  }) {
    return CanonicalGrapeTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      aliases: aliases ?? this.aliases,
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
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (aliases.present) {
      map['aliases'] = Variable<String>(
        $CanonicalGrapeTableTable.$converteraliases.toSql(aliases.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CanonicalGrapeTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('aliases: $aliases, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTableTable extends ProfilesTable
    with TableInfo<$ProfilesTableTable, ProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tasteLevelMeta = const VerificationMeta(
    'tasteLevel',
  );
  @override
  late final GeneratedColumn<String> tasteLevel = GeneratedColumn<String>(
    'taste_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalsCsvMeta = const VerificationMeta(
    'goalsCsv',
  );
  @override
  late final GeneratedColumn<String> goalsCsv = GeneratedColumn<String>(
    'goals_csv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _stylesCsvMeta = const VerificationMeta(
    'stylesCsv',
  );
  @override
  late final GeneratedColumn<String> stylesCsv = GeneratedColumn<String>(
    'styles_csv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _drinkFrequencyMeta = const VerificationMeta(
    'drinkFrequency',
  );
  @override
  late final GeneratedColumn<String> drinkFrequency = GeneratedColumn<String>(
    'drink_frequency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tasteEmojiMeta = const VerificationMeta(
    'tasteEmoji',
  );
  @override
  late final GeneratedColumn<String> tasteEmoji = GeneratedColumn<String>(
    'taste_emoji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    displayName,
    avatarUrl,
    onboardingCompleted,
    tasteLevel,
    goalsCsv,
    stylesCsv,
    drinkFrequency,
    tasteEmoji,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('taste_level')) {
      context.handle(
        _tasteLevelMeta,
        tasteLevel.isAcceptableOrUnknown(data['taste_level']!, _tasteLevelMeta),
      );
    }
    if (data.containsKey('goals_csv')) {
      context.handle(
        _goalsCsvMeta,
        goalsCsv.isAcceptableOrUnknown(data['goals_csv']!, _goalsCsvMeta),
      );
    }
    if (data.containsKey('styles_csv')) {
      context.handle(
        _stylesCsvMeta,
        stylesCsv.isAcceptableOrUnknown(data['styles_csv']!, _stylesCsvMeta),
      );
    }
    if (data.containsKey('drink_frequency')) {
      context.handle(
        _drinkFrequencyMeta,
        drinkFrequency.isAcceptableOrUnknown(
          data['drink_frequency']!,
          _drinkFrequencyMeta,
        ),
      );
    }
    if (data.containsKey('taste_emoji')) {
      context.handle(
        _tasteEmojiMeta,
        tasteEmoji.isAcceptableOrUnknown(data['taste_emoji']!, _tasteEmojiMeta),
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
  ProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      tasteLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}taste_level'],
      ),
      goalsCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goals_csv'],
      )!,
      stylesCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}styles_csv'],
      )!,
      drinkFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}drink_frequency'],
      ),
      tasteEmoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}taste_emoji'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProfilesTableTable createAlias(String alias) {
    return $ProfilesTableTable(attachedDatabase, alias);
  }
}

class ProfileTableData extends DataClass
    implements Insertable<ProfileTableData> {
  final String id;
  final String? username;
  final String? displayName;
  final String? avatarUrl;
  final bool onboardingCompleted;
  final String? tasteLevel;
  final String goalsCsv;
  final String stylesCsv;
  final String? drinkFrequency;
  final String? tasteEmoji;
  final DateTime updatedAt;
  const ProfileTableData({
    required this.id,
    this.username,
    this.displayName,
    this.avatarUrl,
    required this.onboardingCompleted,
    this.tasteLevel,
    required this.goalsCsv,
    required this.stylesCsv,
    this.drinkFrequency,
    this.tasteEmoji,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    if (!nullToAbsent || tasteLevel != null) {
      map['taste_level'] = Variable<String>(tasteLevel);
    }
    map['goals_csv'] = Variable<String>(goalsCsv);
    map['styles_csv'] = Variable<String>(stylesCsv);
    if (!nullToAbsent || drinkFrequency != null) {
      map['drink_frequency'] = Variable<String>(drinkFrequency);
    }
    if (!nullToAbsent || tasteEmoji != null) {
      map['taste_emoji'] = Variable<String>(tasteEmoji);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesTableCompanion toCompanion(bool nullToAbsent) {
    return ProfilesTableCompanion(
      id: Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      onboardingCompleted: Value(onboardingCompleted),
      tasteLevel: tasteLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(tasteLevel),
      goalsCsv: Value(goalsCsv),
      stylesCsv: Value(stylesCsv),
      drinkFrequency: drinkFrequency == null && nullToAbsent
          ? const Value.absent()
          : Value(drinkFrequency),
      tasteEmoji: tasteEmoji == null && nullToAbsent
          ? const Value.absent()
          : Value(tasteEmoji),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileTableData(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String?>(json['username']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      tasteLevel: serializer.fromJson<String?>(json['tasteLevel']),
      goalsCsv: serializer.fromJson<String>(json['goalsCsv']),
      stylesCsv: serializer.fromJson<String>(json['stylesCsv']),
      drinkFrequency: serializer.fromJson<String?>(json['drinkFrequency']),
      tasteEmoji: serializer.fromJson<String?>(json['tasteEmoji']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String?>(username),
      'displayName': serializer.toJson<String?>(displayName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'tasteLevel': serializer.toJson<String?>(tasteLevel),
      'goalsCsv': serializer.toJson<String>(goalsCsv),
      'stylesCsv': serializer.toJson<String>(stylesCsv),
      'drinkFrequency': serializer.toJson<String?>(drinkFrequency),
      'tasteEmoji': serializer.toJson<String?>(tasteEmoji),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProfileTableData copyWith({
    String? id,
    Value<String?> username = const Value.absent(),
    Value<String?> displayName = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    bool? onboardingCompleted,
    Value<String?> tasteLevel = const Value.absent(),
    String? goalsCsv,
    String? stylesCsv,
    Value<String?> drinkFrequency = const Value.absent(),
    Value<String?> tasteEmoji = const Value.absent(),
    DateTime? updatedAt,
  }) => ProfileTableData(
    id: id ?? this.id,
    username: username.present ? username.value : this.username,
    displayName: displayName.present ? displayName.value : this.displayName,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    tasteLevel: tasteLevel.present ? tasteLevel.value : this.tasteLevel,
    goalsCsv: goalsCsv ?? this.goalsCsv,
    stylesCsv: stylesCsv ?? this.stylesCsv,
    drinkFrequency: drinkFrequency.present
        ? drinkFrequency.value
        : this.drinkFrequency,
    tasteEmoji: tasteEmoji.present ? tasteEmoji.value : this.tasteEmoji,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProfileTableData copyWithCompanion(ProfilesTableCompanion data) {
    return ProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      tasteLevel: data.tasteLevel.present
          ? data.tasteLevel.value
          : this.tasteLevel,
      goalsCsv: data.goalsCsv.present ? data.goalsCsv.value : this.goalsCsv,
      stylesCsv: data.stylesCsv.present ? data.stylesCsv.value : this.stylesCsv,
      drinkFrequency: data.drinkFrequency.present
          ? data.drinkFrequency.value
          : this.drinkFrequency,
      tasteEmoji: data.tasteEmoji.present
          ? data.tasteEmoji.value
          : this.tasteEmoji,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileTableData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('tasteLevel: $tasteLevel, ')
          ..write('goalsCsv: $goalsCsv, ')
          ..write('stylesCsv: $stylesCsv, ')
          ..write('drinkFrequency: $drinkFrequency, ')
          ..write('tasteEmoji: $tasteEmoji, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    displayName,
    avatarUrl,
    onboardingCompleted,
    tasteLevel,
    goalsCsv,
    stylesCsv,
    drinkFrequency,
    tasteEmoji,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileTableData &&
          other.id == this.id &&
          other.username == this.username &&
          other.displayName == this.displayName &&
          other.avatarUrl == this.avatarUrl &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.tasteLevel == this.tasteLevel &&
          other.goalsCsv == this.goalsCsv &&
          other.stylesCsv == this.stylesCsv &&
          other.drinkFrequency == this.drinkFrequency &&
          other.tasteEmoji == this.tasteEmoji &&
          other.updatedAt == this.updatedAt);
}

class ProfilesTableCompanion extends UpdateCompanion<ProfileTableData> {
  final Value<String> id;
  final Value<String?> username;
  final Value<String?> displayName;
  final Value<String?> avatarUrl;
  final Value<bool> onboardingCompleted;
  final Value<String?> tasteLevel;
  final Value<String> goalsCsv;
  final Value<String> stylesCsv;
  final Value<String?> drinkFrequency;
  final Value<String?> tasteEmoji;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProfilesTableCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.tasteLevel = const Value.absent(),
    this.goalsCsv = const Value.absent(),
    this.stylesCsv = const Value.absent(),
    this.drinkFrequency = const Value.absent(),
    this.tasteEmoji = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesTableCompanion.insert({
    required String id,
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.tasteLevel = const Value.absent(),
    this.goalsCsv = const Value.absent(),
    this.stylesCsv = const Value.absent(),
    this.drinkFrequency = const Value.absent(),
    this.tasteEmoji = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ProfileTableData> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? displayName,
    Expression<String>? avatarUrl,
    Expression<bool>? onboardingCompleted,
    Expression<String>? tasteLevel,
    Expression<String>? goalsCsv,
    Expression<String>? stylesCsv,
    Expression<String>? drinkFrequency,
    Expression<String>? tasteEmoji,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (tasteLevel != null) 'taste_level': tasteLevel,
      if (goalsCsv != null) 'goals_csv': goalsCsv,
      if (stylesCsv != null) 'styles_csv': stylesCsv,
      if (drinkFrequency != null) 'drink_frequency': drinkFrequency,
      if (tasteEmoji != null) 'taste_emoji': tasteEmoji,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? username,
    Value<String?>? displayName,
    Value<String?>? avatarUrl,
    Value<bool>? onboardingCompleted,
    Value<String?>? tasteLevel,
    Value<String>? goalsCsv,
    Value<String>? stylesCsv,
    Value<String?>? drinkFrequency,
    Value<String?>? tasteEmoji,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProfilesTableCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      tasteLevel: tasteLevel ?? this.tasteLevel,
      goalsCsv: goalsCsv ?? this.goalsCsv,
      stylesCsv: stylesCsv ?? this.stylesCsv,
      drinkFrequency: drinkFrequency ?? this.drinkFrequency,
      tasteEmoji: tasteEmoji ?? this.tasteEmoji,
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
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (tasteLevel.present) {
      map['taste_level'] = Variable<String>(tasteLevel.value);
    }
    if (goalsCsv.present) {
      map['goals_csv'] = Variable<String>(goalsCsv.value);
    }
    if (stylesCsv.present) {
      map['styles_csv'] = Variable<String>(stylesCsv.value);
    }
    if (drinkFrequency.present) {
      map['drink_frequency'] = Variable<String>(drinkFrequency.value);
    }
    if (tasteEmoji.present) {
      map['taste_emoji'] = Variable<String>(tasteEmoji.value);
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
    return (StringBuffer('ProfilesTableCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('tasteLevel: $tasteLevel, ')
          ..write('goalsCsv: $goalsCsv, ')
          ..write('stylesCsv: $stylesCsv, ')
          ..write('drinkFrequency: $drinkFrequency, ')
          ..write('tasteEmoji: $tasteEmoji, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingImageUploadsTableTable extends PendingImageUploadsTable
    with TableInfo<$PendingImageUploadsTableTable, PendingImageUploadData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingImageUploadsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<String> wineId = GeneratedColumn<String>(
    'wine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorAtMeta = const VerificationMeta(
    'lastErrorAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastErrorAt = GeneratedColumn<DateTime>(
    'last_error_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _queuedAtMeta = const VerificationMeta(
    'queuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> queuedAt = GeneratedColumn<DateTime>(
    'queued_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    wineId,
    localPath,
    attempts,
    lastErrorAt,
    queuedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_image_uploads';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingImageUploadData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('wine_id')) {
      context.handle(
        _wineIdMeta,
        wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error_at')) {
      context.handle(
        _lastErrorAtMeta,
        lastErrorAt.isAcceptableOrUnknown(
          data['last_error_at']!,
          _lastErrorAtMeta,
        ),
      );
    }
    if (data.containsKey('queued_at')) {
      context.handle(
        _queuedAtMeta,
        queuedAt.isAcceptableOrUnknown(data['queued_at']!, _queuedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wineId};
  @override
  PendingImageUploadData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingImageUploadData(
      wineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wine_id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastErrorAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_error_at'],
      ),
      queuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}queued_at'],
      )!,
    );
  }

  @override
  $PendingImageUploadsTableTable createAlias(String alias) {
    return $PendingImageUploadsTableTable(attachedDatabase, alias);
  }
}

class PendingImageUploadData extends DataClass
    implements Insertable<PendingImageUploadData> {
  final String wineId;
  final String localPath;
  final int attempts;
  final DateTime? lastErrorAt;
  final DateTime queuedAt;
  const PendingImageUploadData({
    required this.wineId,
    required this.localPath,
    required this.attempts,
    this.lastErrorAt,
    required this.queuedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['wine_id'] = Variable<String>(wineId);
    map['local_path'] = Variable<String>(localPath);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastErrorAt != null) {
      map['last_error_at'] = Variable<DateTime>(lastErrorAt);
    }
    map['queued_at'] = Variable<DateTime>(queuedAt);
    return map;
  }

  PendingImageUploadsTableCompanion toCompanion(bool nullToAbsent) {
    return PendingImageUploadsTableCompanion(
      wineId: Value(wineId),
      localPath: Value(localPath),
      attempts: Value(attempts),
      lastErrorAt: lastErrorAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorAt),
      queuedAt: Value(queuedAt),
    );
  }

  factory PendingImageUploadData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingImageUploadData(
      wineId: serializer.fromJson<String>(json['wineId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastErrorAt: serializer.fromJson<DateTime?>(json['lastErrorAt']),
      queuedAt: serializer.fromJson<DateTime>(json['queuedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wineId': serializer.toJson<String>(wineId),
      'localPath': serializer.toJson<String>(localPath),
      'attempts': serializer.toJson<int>(attempts),
      'lastErrorAt': serializer.toJson<DateTime?>(lastErrorAt),
      'queuedAt': serializer.toJson<DateTime>(queuedAt),
    };
  }

  PendingImageUploadData copyWith({
    String? wineId,
    String? localPath,
    int? attempts,
    Value<DateTime?> lastErrorAt = const Value.absent(),
    DateTime? queuedAt,
  }) => PendingImageUploadData(
    wineId: wineId ?? this.wineId,
    localPath: localPath ?? this.localPath,
    attempts: attempts ?? this.attempts,
    lastErrorAt: lastErrorAt.present ? lastErrorAt.value : this.lastErrorAt,
    queuedAt: queuedAt ?? this.queuedAt,
  );
  PendingImageUploadData copyWithCompanion(
    PendingImageUploadsTableCompanion data,
  ) {
    return PendingImageUploadData(
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastErrorAt: data.lastErrorAt.present
          ? data.lastErrorAt.value
          : this.lastErrorAt,
      queuedAt: data.queuedAt.present ? data.queuedAt.value : this.queuedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingImageUploadData(')
          ..write('wineId: $wineId, ')
          ..write('localPath: $localPath, ')
          ..write('attempts: $attempts, ')
          ..write('lastErrorAt: $lastErrorAt, ')
          ..write('queuedAt: $queuedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(wineId, localPath, attempts, lastErrorAt, queuedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingImageUploadData &&
          other.wineId == this.wineId &&
          other.localPath == this.localPath &&
          other.attempts == this.attempts &&
          other.lastErrorAt == this.lastErrorAt &&
          other.queuedAt == this.queuedAt);
}

class PendingImageUploadsTableCompanion
    extends UpdateCompanion<PendingImageUploadData> {
  final Value<String> wineId;
  final Value<String> localPath;
  final Value<int> attempts;
  final Value<DateTime?> lastErrorAt;
  final Value<DateTime> queuedAt;
  final Value<int> rowid;
  const PendingImageUploadsTableCompanion({
    this.wineId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastErrorAt = const Value.absent(),
    this.queuedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingImageUploadsTableCompanion.insert({
    required String wineId,
    required String localPath,
    this.attempts = const Value.absent(),
    this.lastErrorAt = const Value.absent(),
    this.queuedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : wineId = Value(wineId),
       localPath = Value(localPath);
  static Insertable<PendingImageUploadData> custom({
    Expression<String>? wineId,
    Expression<String>? localPath,
    Expression<int>? attempts,
    Expression<DateTime>? lastErrorAt,
    Expression<DateTime>? queuedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wineId != null) 'wine_id': wineId,
      if (localPath != null) 'local_path': localPath,
      if (attempts != null) 'attempts': attempts,
      if (lastErrorAt != null) 'last_error_at': lastErrorAt,
      if (queuedAt != null) 'queued_at': queuedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingImageUploadsTableCompanion copyWith({
    Value<String>? wineId,
    Value<String>? localPath,
    Value<int>? attempts,
    Value<DateTime?>? lastErrorAt,
    Value<DateTime>? queuedAt,
    Value<int>? rowid,
  }) {
    return PendingImageUploadsTableCompanion(
      wineId: wineId ?? this.wineId,
      localPath: localPath ?? this.localPath,
      attempts: attempts ?? this.attempts,
      lastErrorAt: lastErrorAt ?? this.lastErrorAt,
      queuedAt: queuedAt ?? this.queuedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastErrorAt.present) {
      map['last_error_at'] = Variable<DateTime>(lastErrorAt.value);
    }
    if (queuedAt.present) {
      map['queued_at'] = Variable<DateTime>(queuedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingImageUploadsTableCompanion(')
          ..write('wineId: $wineId, ')
          ..write('localPath: $localPath, ')
          ..write('attempts: $attempts, ')
          ..write('lastErrorAt: $lastErrorAt, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RatingSummaryCacheTableTable extends RatingSummaryCacheTable
    with TableInfo<$RatingSummaryCacheTableTable, RatingSummaryCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RatingSummaryCacheTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [userId, payload, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rating_summary_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<RatingSummaryCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  RatingSummaryCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RatingSummaryCacheData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $RatingSummaryCacheTableTable createAlias(String alias) {
    return $RatingSummaryCacheTableTable(attachedDatabase, alias);
  }
}

class RatingSummaryCacheData extends DataClass
    implements Insertable<RatingSummaryCacheData> {
  final String userId;
  final String payload;
  final DateTime fetchedAt;
  const RatingSummaryCacheData({
    required this.userId,
    required this.payload,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['payload'] = Variable<String>(payload);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  RatingSummaryCacheTableCompanion toCompanion(bool nullToAbsent) {
    return RatingSummaryCacheTableCompanion(
      userId: Value(userId),
      payload: Value(payload),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory RatingSummaryCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RatingSummaryCacheData(
      userId: serializer.fromJson<String>(json['userId']),
      payload: serializer.fromJson<String>(json['payload']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'payload': serializer.toJson<String>(payload),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  RatingSummaryCacheData copyWith({
    String? userId,
    String? payload,
    DateTime? fetchedAt,
  }) => RatingSummaryCacheData(
    userId: userId ?? this.userId,
    payload: payload ?? this.payload,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  RatingSummaryCacheData copyWithCompanion(
    RatingSummaryCacheTableCompanion data,
  ) {
    return RatingSummaryCacheData(
      userId: data.userId.present ? data.userId.value : this.userId,
      payload: data.payload.present ? data.payload.value : this.payload,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RatingSummaryCacheData(')
          ..write('userId: $userId, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, payload, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RatingSummaryCacheData &&
          other.userId == this.userId &&
          other.payload == this.payload &&
          other.fetchedAt == this.fetchedAt);
}

class RatingSummaryCacheTableCompanion
    extends UpdateCompanion<RatingSummaryCacheData> {
  final Value<String> userId;
  final Value<String> payload;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const RatingSummaryCacheTableCompanion({
    this.userId = const Value.absent(),
    this.payload = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RatingSummaryCacheTableCompanion.insert({
    required String userId,
    required String payload,
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       payload = Value(payload),
       fetchedAt = Value(fetchedAt);
  static Insertable<RatingSummaryCacheData> custom({
    Expression<String>? userId,
    Expression<String>? payload,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (payload != null) 'payload': payload,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RatingSummaryCacheTableCompanion copyWith({
    Value<String>? userId,
    Value<String>? payload,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return RatingSummaryCacheTableCompanion(
      userId: userId ?? this.userId,
      payload: payload ?? this.payload,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RatingSummaryCacheTableCompanion(')
          ..write('userId: $userId, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt, ')
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
  late final $WineAliasesTableTable wineAliasesTable = $WineAliasesTableTable(
    this,
  );
  late final $NotificationPrefsTableTable notificationPrefsTable =
      $NotificationPrefsTableTable(this);
  late final $CanonicalGrapeTableTable canonicalGrapeTable =
      $CanonicalGrapeTableTable(this);
  late final $ProfilesTableTable profilesTable = $ProfilesTableTable(this);
  late final $PendingImageUploadsTableTable pendingImageUploadsTable =
      $PendingImageUploadsTableTable(this);
  late final $RatingSummaryCacheTableTable ratingSummaryCacheTable =
      $RatingSummaryCacheTableTable(this);
  late final WinesDao winesDao = WinesDao(this as AppDatabase);
  late final WineMemoriesDao wineMemoriesDao = WineMemoriesDao(
    this as AppDatabase,
  );
  late final WineAliasesDao wineAliasesDao = WineAliasesDao(
    this as AppDatabase,
  );
  late final NotificationPrefsDao notificationPrefsDao = NotificationPrefsDao(
    this as AppDatabase,
  );
  late final CanonicalGrapeDao canonicalGrapeDao = CanonicalGrapeDao(
    this as AppDatabase,
  );
  late final ProfilesDao profilesDao = ProfilesDao(this as AppDatabase);
  late final PendingImageUploadsDao pendingImageUploadsDao =
      PendingImageUploadsDao(this as AppDatabase);
  late final RatingSummaryCacheDao ratingSummaryCacheDao =
      RatingSummaryCacheDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    winesTable,
    wineMemoriesTable,
    wineAliasesTable,
    notificationPrefsTable,
    canonicalGrapeTable,
    profilesTable,
    pendingImageUploadsTable,
    ratingSummaryCacheTable,
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
      Value<String?> region,
      Value<String?> location,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> notes,
      Value<String?> imageUrl,
      Value<String?> localImagePath,
      Value<int?> vintage,
      Value<String?> grape,
      Value<String?> canonicalGrapeId,
      Value<String?> grapeFreetext,
      Value<String?> canonicalWineId,
      Value<String?> winery,
      Value<String?> nameNorm,
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
      Value<String?> region,
      Value<String?> location,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> notes,
      Value<String?> imageUrl,
      Value<String?> localImagePath,
      Value<int?> vintage,
      Value<String?> grape,
      Value<String?> canonicalGrapeId,
      Value<String?> grapeFreetext,
      Value<String?> canonicalWineId,
      Value<String?> winery,
      Value<String?> nameNorm,
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

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
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

  ColumnFilters<String> get canonicalGrapeId => $composableBuilder(
    column: $table.canonicalGrapeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grapeFreetext => $composableBuilder(
    column: $table.grapeFreetext,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalWineId => $composableBuilder(
    column: $table.canonicalWineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get winery => $composableBuilder(
    column: $table.winery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameNorm => $composableBuilder(
    column: $table.nameNorm,
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

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
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

  ColumnOrderings<String> get canonicalGrapeId => $composableBuilder(
    column: $table.canonicalGrapeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grapeFreetext => $composableBuilder(
    column: $table.grapeFreetext,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalWineId => $composableBuilder(
    column: $table.canonicalWineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get winery => $composableBuilder(
    column: $table.winery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameNorm => $composableBuilder(
    column: $table.nameNorm,
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

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

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

  GeneratedColumn<String> get canonicalGrapeId => $composableBuilder(
    column: $table.canonicalGrapeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grapeFreetext => $composableBuilder(
    column: $table.grapeFreetext,
    builder: (column) => column,
  );

  GeneratedColumn<String> get canonicalWineId => $composableBuilder(
    column: $table.canonicalWineId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get winery =>
      $composableBuilder(column: $table.winery, builder: (column) => column);

  GeneratedColumn<String> get nameNorm =>
      $composableBuilder(column: $table.nameNorm, builder: (column) => column);

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
                Value<String?> region = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<int?> vintage = const Value.absent(),
                Value<String?> grape = const Value.absent(),
                Value<String?> canonicalGrapeId = const Value.absent(),
                Value<String?> grapeFreetext = const Value.absent(),
                Value<String?> canonicalWineId = const Value.absent(),
                Value<String?> winery = const Value.absent(),
                Value<String?> nameNorm = const Value.absent(),
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
                region: region,
                location: location,
                latitude: latitude,
                longitude: longitude,
                notes: notes,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                vintage: vintage,
                grape: grape,
                canonicalGrapeId: canonicalGrapeId,
                grapeFreetext: grapeFreetext,
                canonicalWineId: canonicalWineId,
                winery: winery,
                nameNorm: nameNorm,
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
                Value<String?> region = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<int?> vintage = const Value.absent(),
                Value<String?> grape = const Value.absent(),
                Value<String?> canonicalGrapeId = const Value.absent(),
                Value<String?> grapeFreetext = const Value.absent(),
                Value<String?> canonicalWineId = const Value.absent(),
                Value<String?> winery = const Value.absent(),
                Value<String?> nameNorm = const Value.absent(),
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
                region: region,
                location: location,
                latitude: latitude,
                longitude: longitude,
                notes: notes,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                vintage: vintage,
                grape: grape,
                canonicalGrapeId: canonicalGrapeId,
                grapeFreetext: grapeFreetext,
                canonicalWineId: canonicalWineId,
                winery: winery,
                nameNorm: nameNorm,
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
      Value<String?> caption,
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
      Value<String?> caption,
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

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
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

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
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

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

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
                Value<String?> caption = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WineMemoriesTableCompanion(
                id: id,
                wineId: wineId,
                userId: userId,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                caption: caption,
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
                Value<String?> caption = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WineMemoriesTableCompanion.insert(
                id: id,
                wineId: wineId,
                userId: userId,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                caption: caption,
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
typedef $$WineAliasesTableTableCreateCompanionBuilder =
    WineAliasesTableCompanion Function({
      required String userId,
      required String localWineId,
      required String canonicalWineId,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WineAliasesTableTableUpdateCompanionBuilder =
    WineAliasesTableCompanion Function({
      Value<String> userId,
      Value<String> localWineId,
      Value<String> canonicalWineId,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$WineAliasesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WineAliasesTableTable> {
  $$WineAliasesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localWineId => $composableBuilder(
    column: $table.localWineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalWineId => $composableBuilder(
    column: $table.canonicalWineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WineAliasesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WineAliasesTableTable> {
  $$WineAliasesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localWineId => $composableBuilder(
    column: $table.localWineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalWineId => $composableBuilder(
    column: $table.canonicalWineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WineAliasesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WineAliasesTableTable> {
  $$WineAliasesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get localWineId => $composableBuilder(
    column: $table.localWineId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get canonicalWineId => $composableBuilder(
    column: $table.canonicalWineId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WineAliasesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WineAliasesTableTable,
          WineAliasTableData,
          $$WineAliasesTableTableFilterComposer,
          $$WineAliasesTableTableOrderingComposer,
          $$WineAliasesTableTableAnnotationComposer,
          $$WineAliasesTableTableCreateCompanionBuilder,
          $$WineAliasesTableTableUpdateCompanionBuilder,
          (
            WineAliasTableData,
            BaseReferences<
              _$AppDatabase,
              $WineAliasesTableTable,
              WineAliasTableData
            >,
          ),
          WineAliasTableData,
          PrefetchHooks Function()
        > {
  $$WineAliasesTableTableTableManager(
    _$AppDatabase db,
    $WineAliasesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WineAliasesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WineAliasesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WineAliasesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> localWineId = const Value.absent(),
                Value<String> canonicalWineId = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WineAliasesTableCompanion(
                userId: userId,
                localWineId: localWineId,
                canonicalWineId: canonicalWineId,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String localWineId,
                required String canonicalWineId,
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WineAliasesTableCompanion.insert(
                userId: userId,
                localWineId: localWineId,
                canonicalWineId: canonicalWineId,
                source: source,
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

typedef $$WineAliasesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WineAliasesTableTable,
      WineAliasTableData,
      $$WineAliasesTableTableFilterComposer,
      $$WineAliasesTableTableOrderingComposer,
      $$WineAliasesTableTableAnnotationComposer,
      $$WineAliasesTableTableCreateCompanionBuilder,
      $$WineAliasesTableTableUpdateCompanionBuilder,
      (
        WineAliasTableData,
        BaseReferences<
          _$AppDatabase,
          $WineAliasesTableTable,
          WineAliasTableData
        >,
      ),
      WineAliasTableData,
      PrefetchHooks Function()
    >;
typedef $$NotificationPrefsTableTableCreateCompanionBuilder =
    NotificationPrefsTableCompanion Function({
      required String userId,
      Value<bool> tastingReminders,
      Value<int> tastingReminderHours,
      Value<bool> friendActivity,
      Value<bool> groupActivity,
      Value<bool> groupWineShared,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationPrefsTableTableUpdateCompanionBuilder =
    NotificationPrefsTableCompanion Function({
      Value<String> userId,
      Value<bool> tastingReminders,
      Value<int> tastingReminderHours,
      Value<bool> friendActivity,
      Value<bool> groupActivity,
      Value<bool> groupWineShared,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$NotificationPrefsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTableTable> {
  $$NotificationPrefsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get tastingReminders => $composableBuilder(
    column: $table.tastingReminders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tastingReminderHours => $composableBuilder(
    column: $table.tastingReminderHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get friendActivity => $composableBuilder(
    column: $table.friendActivity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get groupActivity => $composableBuilder(
    column: $table.groupActivity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get groupWineShared => $composableBuilder(
    column: $table.groupWineShared,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationPrefsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTableTable> {
  $$NotificationPrefsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get tastingReminders => $composableBuilder(
    column: $table.tastingReminders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tastingReminderHours => $composableBuilder(
    column: $table.tastingReminderHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get friendActivity => $composableBuilder(
    column: $table.friendActivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get groupActivity => $composableBuilder(
    column: $table.groupActivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get groupWineShared => $composableBuilder(
    column: $table.groupWineShared,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationPrefsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTableTable> {
  $$NotificationPrefsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<bool> get tastingReminders => $composableBuilder(
    column: $table.tastingReminders,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tastingReminderHours => $composableBuilder(
    column: $table.tastingReminderHours,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get friendActivity => $composableBuilder(
    column: $table.friendActivity,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get groupActivity => $composableBuilder(
    column: $table.groupActivity,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get groupWineShared => $composableBuilder(
    column: $table.groupWineShared,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationPrefsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationPrefsTableTable,
          NotificationPrefsTableData,
          $$NotificationPrefsTableTableFilterComposer,
          $$NotificationPrefsTableTableOrderingComposer,
          $$NotificationPrefsTableTableAnnotationComposer,
          $$NotificationPrefsTableTableCreateCompanionBuilder,
          $$NotificationPrefsTableTableUpdateCompanionBuilder,
          (
            NotificationPrefsTableData,
            BaseReferences<
              _$AppDatabase,
              $NotificationPrefsTableTable,
              NotificationPrefsTableData
            >,
          ),
          NotificationPrefsTableData,
          PrefetchHooks Function()
        > {
  $$NotificationPrefsTableTableTableManager(
    _$AppDatabase db,
    $NotificationPrefsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPrefsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NotificationPrefsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationPrefsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<bool> tastingReminders = const Value.absent(),
                Value<int> tastingReminderHours = const Value.absent(),
                Value<bool> friendActivity = const Value.absent(),
                Value<bool> groupActivity = const Value.absent(),
                Value<bool> groupWineShared = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationPrefsTableCompanion(
                userId: userId,
                tastingReminders: tastingReminders,
                tastingReminderHours: tastingReminderHours,
                friendActivity: friendActivity,
                groupActivity: groupActivity,
                groupWineShared: groupWineShared,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<bool> tastingReminders = const Value.absent(),
                Value<int> tastingReminderHours = const Value.absent(),
                Value<bool> friendActivity = const Value.absent(),
                Value<bool> groupActivity = const Value.absent(),
                Value<bool> groupWineShared = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationPrefsTableCompanion.insert(
                userId: userId,
                tastingReminders: tastingReminders,
                tastingReminderHours: tastingReminderHours,
                friendActivity: friendActivity,
                groupActivity: groupActivity,
                groupWineShared: groupWineShared,
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

typedef $$NotificationPrefsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationPrefsTableTable,
      NotificationPrefsTableData,
      $$NotificationPrefsTableTableFilterComposer,
      $$NotificationPrefsTableTableOrderingComposer,
      $$NotificationPrefsTableTableAnnotationComposer,
      $$NotificationPrefsTableTableCreateCompanionBuilder,
      $$NotificationPrefsTableTableUpdateCompanionBuilder,
      (
        NotificationPrefsTableData,
        BaseReferences<
          _$AppDatabase,
          $NotificationPrefsTableTable,
          NotificationPrefsTableData
        >,
      ),
      NotificationPrefsTableData,
      PrefetchHooks Function()
    >;
typedef $$CanonicalGrapeTableTableCreateCompanionBuilder =
    CanonicalGrapeTableCompanion Function({
      required String id,
      required String name,
      required String color,
      Value<List<String>> aliases,
      Value<int> rowid,
    });
typedef $$CanonicalGrapeTableTableUpdateCompanionBuilder =
    CanonicalGrapeTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> color,
      Value<List<String>> aliases,
      Value<int> rowid,
    });

class $$CanonicalGrapeTableTableFilterComposer
    extends Composer<_$AppDatabase, $CanonicalGrapeTableTable> {
  $$CanonicalGrapeTableTableFilterComposer({
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

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get aliases => $composableBuilder(
    column: $table.aliases,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$CanonicalGrapeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CanonicalGrapeTableTable> {
  $$CanonicalGrapeTableTableOrderingComposer({
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

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aliases => $composableBuilder(
    column: $table.aliases,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CanonicalGrapeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CanonicalGrapeTableTable> {
  $$CanonicalGrapeTableTableAnnotationComposer({
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

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get aliases =>
      $composableBuilder(column: $table.aliases, builder: (column) => column);
}

class $$CanonicalGrapeTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CanonicalGrapeTableTable,
          CanonicalGrapeTableData,
          $$CanonicalGrapeTableTableFilterComposer,
          $$CanonicalGrapeTableTableOrderingComposer,
          $$CanonicalGrapeTableTableAnnotationComposer,
          $$CanonicalGrapeTableTableCreateCompanionBuilder,
          $$CanonicalGrapeTableTableUpdateCompanionBuilder,
          (
            CanonicalGrapeTableData,
            BaseReferences<
              _$AppDatabase,
              $CanonicalGrapeTableTable,
              CanonicalGrapeTableData
            >,
          ),
          CanonicalGrapeTableData,
          PrefetchHooks Function()
        > {
  $$CanonicalGrapeTableTableTableManager(
    _$AppDatabase db,
    $CanonicalGrapeTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CanonicalGrapeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CanonicalGrapeTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CanonicalGrapeTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<List<String>> aliases = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CanonicalGrapeTableCompanion(
                id: id,
                name: name,
                color: color,
                aliases: aliases,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String color,
                Value<List<String>> aliases = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CanonicalGrapeTableCompanion.insert(
                id: id,
                name: name,
                color: color,
                aliases: aliases,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CanonicalGrapeTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CanonicalGrapeTableTable,
      CanonicalGrapeTableData,
      $$CanonicalGrapeTableTableFilterComposer,
      $$CanonicalGrapeTableTableOrderingComposer,
      $$CanonicalGrapeTableTableAnnotationComposer,
      $$CanonicalGrapeTableTableCreateCompanionBuilder,
      $$CanonicalGrapeTableTableUpdateCompanionBuilder,
      (
        CanonicalGrapeTableData,
        BaseReferences<
          _$AppDatabase,
          $CanonicalGrapeTableTable,
          CanonicalGrapeTableData
        >,
      ),
      CanonicalGrapeTableData,
      PrefetchHooks Function()
    >;
typedef $$ProfilesTableTableCreateCompanionBuilder =
    ProfilesTableCompanion Function({
      required String id,
      Value<String?> username,
      Value<String?> displayName,
      Value<String?> avatarUrl,
      Value<bool> onboardingCompleted,
      Value<String?> tasteLevel,
      Value<String> goalsCsv,
      Value<String> stylesCsv,
      Value<String?> drinkFrequency,
      Value<String?> tasteEmoji,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ProfilesTableTableUpdateCompanionBuilder =
    ProfilesTableCompanion Function({
      Value<String> id,
      Value<String?> username,
      Value<String?> displayName,
      Value<String?> avatarUrl,
      Value<bool> onboardingCompleted,
      Value<String?> tasteLevel,
      Value<String> goalsCsv,
      Value<String> stylesCsv,
      Value<String?> drinkFrequency,
      Value<String?> tasteEmoji,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProfilesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableFilterComposer({
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

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tasteLevel => $composableBuilder(
    column: $table.tasteLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalsCsv => $composableBuilder(
    column: $table.goalsCsv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stylesCsv => $composableBuilder(
    column: $table.stylesCsv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get drinkFrequency => $composableBuilder(
    column: $table.drinkFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tasteEmoji => $composableBuilder(
    column: $table.tasteEmoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableOrderingComposer({
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

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tasteLevel => $composableBuilder(
    column: $table.tasteLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalsCsv => $composableBuilder(
    column: $table.goalsCsv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stylesCsv => $composableBuilder(
    column: $table.stylesCsv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get drinkFrequency => $composableBuilder(
    column: $table.drinkFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tasteEmoji => $composableBuilder(
    column: $table.tasteEmoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTableTable> {
  $$ProfilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tasteLevel => $composableBuilder(
    column: $table.tasteLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalsCsv =>
      $composableBuilder(column: $table.goalsCsv, builder: (column) => column);

  GeneratedColumn<String> get stylesCsv =>
      $composableBuilder(column: $table.stylesCsv, builder: (column) => column);

  GeneratedColumn<String> get drinkFrequency => $composableBuilder(
    column: $table.drinkFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tasteEmoji => $composableBuilder(
    column: $table.tasteEmoji,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfilesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTableTable,
          ProfileTableData,
          $$ProfilesTableTableFilterComposer,
          $$ProfilesTableTableOrderingComposer,
          $$ProfilesTableTableAnnotationComposer,
          $$ProfilesTableTableCreateCompanionBuilder,
          $$ProfilesTableTableUpdateCompanionBuilder,
          (
            ProfileTableData,
            BaseReferences<
              _$AppDatabase,
              $ProfilesTableTable,
              ProfileTableData
            >,
          ),
          ProfileTableData,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableTableManager(_$AppDatabase db, $ProfilesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<String?> tasteLevel = const Value.absent(),
                Value<String> goalsCsv = const Value.absent(),
                Value<String> stylesCsv = const Value.absent(),
                Value<String?> drinkFrequency = const Value.absent(),
                Value<String?> tasteEmoji = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesTableCompanion(
                id: id,
                username: username,
                displayName: displayName,
                avatarUrl: avatarUrl,
                onboardingCompleted: onboardingCompleted,
                tasteLevel: tasteLevel,
                goalsCsv: goalsCsv,
                stylesCsv: stylesCsv,
                drinkFrequency: drinkFrequency,
                tasteEmoji: tasteEmoji,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> username = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<String?> tasteLevel = const Value.absent(),
                Value<String> goalsCsv = const Value.absent(),
                Value<String> stylesCsv = const Value.absent(),
                Value<String?> drinkFrequency = const Value.absent(),
                Value<String?> tasteEmoji = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesTableCompanion.insert(
                id: id,
                username: username,
                displayName: displayName,
                avatarUrl: avatarUrl,
                onboardingCompleted: onboardingCompleted,
                tasteLevel: tasteLevel,
                goalsCsv: goalsCsv,
                stylesCsv: stylesCsv,
                drinkFrequency: drinkFrequency,
                tasteEmoji: tasteEmoji,
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

typedef $$ProfilesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTableTable,
      ProfileTableData,
      $$ProfilesTableTableFilterComposer,
      $$ProfilesTableTableOrderingComposer,
      $$ProfilesTableTableAnnotationComposer,
      $$ProfilesTableTableCreateCompanionBuilder,
      $$ProfilesTableTableUpdateCompanionBuilder,
      (
        ProfileTableData,
        BaseReferences<_$AppDatabase, $ProfilesTableTable, ProfileTableData>,
      ),
      ProfileTableData,
      PrefetchHooks Function()
    >;
typedef $$PendingImageUploadsTableTableCreateCompanionBuilder =
    PendingImageUploadsTableCompanion Function({
      required String wineId,
      required String localPath,
      Value<int> attempts,
      Value<DateTime?> lastErrorAt,
      Value<DateTime> queuedAt,
      Value<int> rowid,
    });
typedef $$PendingImageUploadsTableTableUpdateCompanionBuilder =
    PendingImageUploadsTableCompanion Function({
      Value<String> wineId,
      Value<String> localPath,
      Value<int> attempts,
      Value<DateTime?> lastErrorAt,
      Value<DateTime> queuedAt,
      Value<int> rowid,
    });

class $$PendingImageUploadsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PendingImageUploadsTableTable> {
  $$PendingImageUploadsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get wineId => $composableBuilder(
    column: $table.wineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastErrorAt => $composableBuilder(
    column: $table.lastErrorAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get queuedAt => $composableBuilder(
    column: $table.queuedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingImageUploadsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingImageUploadsTableTable> {
  $$PendingImageUploadsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get wineId => $composableBuilder(
    column: $table.wineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastErrorAt => $composableBuilder(
    column: $table.lastErrorAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get queuedAt => $composableBuilder(
    column: $table.queuedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingImageUploadsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingImageUploadsTableTable> {
  $$PendingImageUploadsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get wineId =>
      $composableBuilder(column: $table.wineId, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get lastErrorAt => $composableBuilder(
    column: $table.lastErrorAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get queuedAt =>
      $composableBuilder(column: $table.queuedAt, builder: (column) => column);
}

class $$PendingImageUploadsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingImageUploadsTableTable,
          PendingImageUploadData,
          $$PendingImageUploadsTableTableFilterComposer,
          $$PendingImageUploadsTableTableOrderingComposer,
          $$PendingImageUploadsTableTableAnnotationComposer,
          $$PendingImageUploadsTableTableCreateCompanionBuilder,
          $$PendingImageUploadsTableTableUpdateCompanionBuilder,
          (
            PendingImageUploadData,
            BaseReferences<
              _$AppDatabase,
              $PendingImageUploadsTableTable,
              PendingImageUploadData
            >,
          ),
          PendingImageUploadData,
          PrefetchHooks Function()
        > {
  $$PendingImageUploadsTableTableTableManager(
    _$AppDatabase db,
    $PendingImageUploadsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingImageUploadsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PendingImageUploadsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PendingImageUploadsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> wineId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<DateTime?> lastErrorAt = const Value.absent(),
                Value<DateTime> queuedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingImageUploadsTableCompanion(
                wineId: wineId,
                localPath: localPath,
                attempts: attempts,
                lastErrorAt: lastErrorAt,
                queuedAt: queuedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String wineId,
                required String localPath,
                Value<int> attempts = const Value.absent(),
                Value<DateTime?> lastErrorAt = const Value.absent(),
                Value<DateTime> queuedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingImageUploadsTableCompanion.insert(
                wineId: wineId,
                localPath: localPath,
                attempts: attempts,
                lastErrorAt: lastErrorAt,
                queuedAt: queuedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingImageUploadsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingImageUploadsTableTable,
      PendingImageUploadData,
      $$PendingImageUploadsTableTableFilterComposer,
      $$PendingImageUploadsTableTableOrderingComposer,
      $$PendingImageUploadsTableTableAnnotationComposer,
      $$PendingImageUploadsTableTableCreateCompanionBuilder,
      $$PendingImageUploadsTableTableUpdateCompanionBuilder,
      (
        PendingImageUploadData,
        BaseReferences<
          _$AppDatabase,
          $PendingImageUploadsTableTable,
          PendingImageUploadData
        >,
      ),
      PendingImageUploadData,
      PrefetchHooks Function()
    >;
typedef $$RatingSummaryCacheTableTableCreateCompanionBuilder =
    RatingSummaryCacheTableCompanion Function({
      required String userId,
      required String payload,
      required DateTime fetchedAt,
      Value<int> rowid,
    });
typedef $$RatingSummaryCacheTableTableUpdateCompanionBuilder =
    RatingSummaryCacheTableCompanion Function({
      Value<String> userId,
      Value<String> payload,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

class $$RatingSummaryCacheTableTableFilterComposer
    extends Composer<_$AppDatabase, $RatingSummaryCacheTableTable> {
  $$RatingSummaryCacheTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RatingSummaryCacheTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RatingSummaryCacheTableTable> {
  $$RatingSummaryCacheTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RatingSummaryCacheTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RatingSummaryCacheTableTable> {
  $$RatingSummaryCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$RatingSummaryCacheTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RatingSummaryCacheTableTable,
          RatingSummaryCacheData,
          $$RatingSummaryCacheTableTableFilterComposer,
          $$RatingSummaryCacheTableTableOrderingComposer,
          $$RatingSummaryCacheTableTableAnnotationComposer,
          $$RatingSummaryCacheTableTableCreateCompanionBuilder,
          $$RatingSummaryCacheTableTableUpdateCompanionBuilder,
          (
            RatingSummaryCacheData,
            BaseReferences<
              _$AppDatabase,
              $RatingSummaryCacheTableTable,
              RatingSummaryCacheData
            >,
          ),
          RatingSummaryCacheData,
          PrefetchHooks Function()
        > {
  $$RatingSummaryCacheTableTableTableManager(
    _$AppDatabase db,
    $RatingSummaryCacheTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RatingSummaryCacheTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$RatingSummaryCacheTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RatingSummaryCacheTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RatingSummaryCacheTableCompanion(
                userId: userId,
                payload: payload,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String payload,
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => RatingSummaryCacheTableCompanion.insert(
                userId: userId,
                payload: payload,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RatingSummaryCacheTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RatingSummaryCacheTableTable,
      RatingSummaryCacheData,
      $$RatingSummaryCacheTableTableFilterComposer,
      $$RatingSummaryCacheTableTableOrderingComposer,
      $$RatingSummaryCacheTableTableAnnotationComposer,
      $$RatingSummaryCacheTableTableCreateCompanionBuilder,
      $$RatingSummaryCacheTableTableUpdateCompanionBuilder,
      (
        RatingSummaryCacheData,
        BaseReferences<
          _$AppDatabase,
          $RatingSummaryCacheTableTable,
          RatingSummaryCacheData
        >,
      ),
      RatingSummaryCacheData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WinesTableTableTableManager get winesTable =>
      $$WinesTableTableTableManager(_db, _db.winesTable);
  $$WineMemoriesTableTableTableManager get wineMemoriesTable =>
      $$WineMemoriesTableTableTableManager(_db, _db.wineMemoriesTable);
  $$WineAliasesTableTableTableManager get wineAliasesTable =>
      $$WineAliasesTableTableTableManager(_db, _db.wineAliasesTable);
  $$NotificationPrefsTableTableTableManager get notificationPrefsTable =>
      $$NotificationPrefsTableTableTableManager(
        _db,
        _db.notificationPrefsTable,
      );
  $$CanonicalGrapeTableTableTableManager get canonicalGrapeTable =>
      $$CanonicalGrapeTableTableTableManager(_db, _db.canonicalGrapeTable);
  $$ProfilesTableTableTableManager get profilesTable =>
      $$ProfilesTableTableTableManager(_db, _db.profilesTable);
  $$PendingImageUploadsTableTableTableManager get pendingImageUploadsTable =>
      $$PendingImageUploadsTableTableTableManager(
        _db,
        _db.pendingImageUploadsTable,
      );
  $$RatingSummaryCacheTableTableTableManager get ratingSummaryCacheTable =>
      $$RatingSummaryCacheTableTableTableManager(
        _db,
        _db.ratingSummaryCacheTable,
      );
}
