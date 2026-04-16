import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/wine.entity.dart';

part 'wine.model.freezed.dart';
part 'wine.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class WineModel with _$WineModel {
  const factory WineModel({
    required String id,
    required String name,
    required double rating,
    required String type,
    double? price,
    @Default('EUR') String currency,
    String? country,
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path') String? localImagePath,
    @JsonKey(name: 'memory_image_url') String? memoryImageUrl,
    @JsonKey(name: 'memory_local_image_path') String? memoryLocalImagePath,
    int? vintage,
    String? grape,
    @JsonKey(name: 'user_id') required String userId,
    @Default('friends') String visibility,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _WineModel;

  factory WineModel.fromJson(Map<String, dynamic> json) =>
      _$WineModelFromJson(json);
}

extension WineModelToEntity on WineModel {
  WineEntity toEntity() => WineEntity(
        id: id,
        name: name,
        rating: rating,
        type: WineType.values.firstWhere(
          (t) => t.name == type,
          orElse: () => WineType.red,
        ),
        price: price,
        currency: currency,
        country: country,
        location: location,
        latitude: latitude,
        longitude: longitude,
        notes: notes,
        imageUrl: imageUrl,
        localImagePath: localImagePath,
        memoryImageUrl: memoryImageUrl,
        memoryLocalImagePath: memoryLocalImagePath,
        vintage: vintage,
        grape: grape,
        userId: userId,
        visibility: visibility,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension WineEntityToModel on WineEntity {
  WineModel toModel() => WineModel(
        id: id,
        name: name,
        rating: rating,
        type: type.name,
        price: price,
        currency: currency,
        country: country,
        location: location,
        latitude: latitude,
        longitude: longitude,
        notes: notes,
        imageUrl: imageUrl,
        localImagePath: localImagePath,
        memoryImageUrl: memoryImageUrl,
        memoryLocalImagePath: memoryLocalImagePath,
        vintage: vintage,
        grape: grape,
        userId: userId,
        visibility: visibility,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
