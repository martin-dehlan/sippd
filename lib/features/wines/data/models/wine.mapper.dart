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

extension WineEntityToTableData on WineEntity {
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
