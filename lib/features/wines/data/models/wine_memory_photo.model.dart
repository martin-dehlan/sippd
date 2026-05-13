import 'package:drift/drift.dart' show Value;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/database/database.dart';
import '../../domain/entities/wine_memory_photo.entity.dart';

part 'wine_memory_photo.model.freezed.dart';
part 'wine_memory_photo.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class WineMemoryPhotoModel with _$WineMemoryPhotoModel {
  const factory WineMemoryPhotoModel({
    required String id,
    @JsonKey(name: 'memory_id') required String memoryId,
    @JsonKey(name: 'storage_path') required String storagePath,
    @Default(0) int position,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _WineMemoryPhotoModel;

  factory WineMemoryPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$WineMemoryPhotoModelFromJson(json);
}

extension WineMemoryPhotoModelToEntity on WineMemoryPhotoModel {
  WineMemoryPhotoEntity toEntity() => WineMemoryPhotoEntity(
    id: id,
    memoryId: memoryId,
    storagePath: storagePath,
    position: position,
    createdAt: createdAt,
  );
}

extension WineMemoryPhotoEntityToModel on WineMemoryPhotoEntity {
  WineMemoryPhotoModel toModel() => WineMemoryPhotoModel(
    id: id,
    memoryId: memoryId,
    storagePath: storagePath,
    position: position,
    createdAt: createdAt,
  );

  WineMemoryPhotoTableData toTableData() => WineMemoryPhotoTableData(
    id: id,
    memoryId: memoryId,
    storagePath: storagePath,
    position: position,
    createdAt: createdAt,
  );

  WineMemoryPhotosTableCompanion toCompanion() =>
      WineMemoryPhotosTableCompanion(
        id: Value(id),
        memoryId: Value(memoryId),
        storagePath: Value(storagePath),
        position: Value(position),
        createdAt: Value(createdAt),
      );
}

extension WineMemoryPhotoTableDataToEntity on WineMemoryPhotoTableData {
  WineMemoryPhotoEntity toEntity() => WineMemoryPhotoEntity(
    id: id,
    memoryId: memoryId,
    storagePath: storagePath,
    position: position,
    createdAt: createdAt,
  );
}
