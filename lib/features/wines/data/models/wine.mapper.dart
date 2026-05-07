import '../../../../common/database/database.dart';
import '../../domain/entities/wine.entity.dart';

extension WineTableDataToEntity on WineTableData {
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

extension WineEntityToTableData on WineEntity {
  WineTableData toTableData() => WineTableData(
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
