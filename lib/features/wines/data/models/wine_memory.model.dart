import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../common/database/database.dart';
import '../../domain/entities/wine_memory.entity.dart';

part 'wine_memory.model.freezed.dart';
part 'wine_memory.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class WineMemoryModel with _$WineMemoryModel {
  const factory WineMemoryModel({
    required String id,
    @JsonKey(name: 'wine_id') required String wineId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path') String? localImagePath,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _WineMemoryModel;

  factory WineMemoryModel.fromJson(Map<String, dynamic> json) =>
      _$WineMemoryModelFromJson(json);
}

extension WineMemoryModelToEntity on WineMemoryModel {
  WineMemoryEntity toEntity() => WineMemoryEntity(
    id: id,
    wineId: wineId,
    userId: userId,
    imageUrl: imageUrl,
    localImagePath: localImagePath,
    createdAt: createdAt,
  );
}

extension WineMemoryEntityToModel on WineMemoryEntity {
  WineMemoryModel toModel() => WineMemoryModel(
    id: id,
    wineId: wineId,
    userId: userId,
    imageUrl: imageUrl,
    localImagePath: localImagePath,
    createdAt: createdAt,
  );

  WineMemoryTableData toTableData() => WineMemoryTableData(
    id: id,
    wineId: wineId,
    userId: userId,
    imageUrl: imageUrl,
    localImagePath: localImagePath,
    createdAt: createdAt,
  );
}

extension WineMemoryTableDataToEntity on WineMemoryTableData {
  WineMemoryEntity toEntity() => WineMemoryEntity(
    id: id,
    wineId: wineId,
    userId: userId,
    imageUrl: imageUrl,
    localImagePath: localImagePath,
    createdAt: createdAt,
  );
}
