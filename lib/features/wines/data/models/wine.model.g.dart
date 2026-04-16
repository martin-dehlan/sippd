// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WineModelImpl _$$WineModelImplFromJson(Map<String, dynamic> json) =>
    _$WineModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      type: json['type'] as String,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'EUR',
      country: json['country'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      imageUrl: json['image_url'] as String?,
      localImagePath: json['local_image_path'] as String?,
      memoryImageUrl: json['memory_image_url'] as String?,
      memoryLocalImagePath: json['memory_local_image_path'] as String?,
      vintage: (json['vintage'] as num?)?.toInt(),
      grape: json['grape'] as String?,
      userId: json['user_id'] as String,
      visibility: json['visibility'] as String? ?? 'friends',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$WineModelImplToJson(_$WineModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'type': instance.type,
      'price': instance.price,
      'currency': instance.currency,
      'country': instance.country,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'notes': instance.notes,
      'image_url': instance.imageUrl,
      'local_image_path': instance.localImagePath,
      'memory_image_url': instance.memoryImageUrl,
      'memory_local_image_path': instance.memoryLocalImagePath,
      'vintage': instance.vintage,
      'grape': instance.grape,
      'user_id': instance.userId,
      'visibility': instance.visibility,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
