import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/wine.entity.dart';
import '../../../../common/database/tables/wines.table.dart';

part 'wine.model.freezed.dart';
part 'wine.model.g.dart';

@freezed
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
    String? notes,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path') String? localImagePath,
    int? vintage,
    String? grape,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _WineModel;

  factory WineModel.fromJson(Map<String, dynamic> json) =>
      _$WineModelFromJson(json);
}

extension WineModelX on WineModel {
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
        notes: notes,
        imageUrl: imageUrl,
        localImagePath: localImagePath,
        vintage: vintage,
        grape: grape,
        userId: userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  WineTableData toTableData() => WineTableData(
        id: id,
        name: name,
        rating: rating,
        type: type,
        price: price,
        currency: currency,
        country: country,
        location: location,
        notes: notes,
        imageUrl: imageUrl,
        localImagePath: localImagePath,
        vintage: vintage,
        grape: grape,
        userId: userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension WineTableDataX on WineTableData {
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
        notes: notes,
        imageUrl: imageUrl,
        localImagePath: localImagePath,
        vintage: vintage,
        grape: grape,
        userId: userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension WineEntityX on WineEntity {
  WineModel toModel() => WineModel(
        id: id,
        name: name,
        rating: rating,
        type: type.name,
        price: price,
        currency: currency,
        country: country,
        location: location,
        notes: notes,
        imageUrl: imageUrl,
        localImagePath: localImagePath,
        vintage: vintage,
        grape: grape,
        userId: userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  WineTableData toTableData() => WineTableData(
        id: id,
        name: name,
        rating: rating,
        type: type.name,
        price: price,
        currency: currency,
        country: country,
        location: location,
        notes: notes,
        imageUrl: imageUrl,
        localImagePath: localImagePath,
        vintage: vintage,
        grape: grape,
        userId: userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
