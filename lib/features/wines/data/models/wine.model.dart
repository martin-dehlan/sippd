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
    String? region,
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    @JsonKey(name: 'image_url') String? imageUrl,
    // Local-only — never written to Supabase. Stays on the originating
    // device until the upload completes and `imageUrl` takes over.
    @JsonKey(name: 'local_image_path', includeToJson: false)
    String? localImagePath,
    int? vintage,
    String? grape,
    @JsonKey(name: 'canonical_grape_id') String? canonicalGrapeId,
    @JsonKey(name: 'grape_freetext') String? grapeFreetext,
    @JsonKey(name: 'canonical_wine_id') String? canonicalWineId,
    String? winery,
    @JsonKey(name: 'name_norm') String? nameNorm,
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
      );
}
