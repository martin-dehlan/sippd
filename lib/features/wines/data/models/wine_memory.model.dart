import 'dart:convert';

import 'package:drift/drift.dart' show Value;
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
    String? caption,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'occurred_at') DateTime? occurredAt,
    String? occasion,
    @JsonKey(name: 'place_name') String? placeName,
    @JsonKey(name: 'place_lat') double? placeLat,
    @JsonKey(name: 'place_lng') double? placeLng,
    @JsonKey(name: 'food_paired') String? foodPaired,
    @JsonKey(name: 'companion_user_ids')
    @Default(<String>[])
    List<String> companionUserIds,
    String? note,
    @Default('friends') String visibility,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
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
    caption: caption,
    createdAt: createdAt,
    occurredAt: occurredAt,
    occasion: occasion,
    placeName: placeName,
    placeLat: placeLat,
    placeLng: placeLng,
    foodPaired: foodPaired,
    companionUserIds: companionUserIds,
    note: note,
    visibility: visibility,
    updatedAt: updatedAt,
  );
}

extension WineMemoryEntityToModel on WineMemoryEntity {
  WineMemoryModel toModel() => WineMemoryModel(
    id: id,
    wineId: wineId,
    userId: userId,
    imageUrl: imageUrl,
    localImagePath: localImagePath,
    caption: caption,
    createdAt: createdAt,
    occurredAt: occurredAt,
    occasion: occasion,
    placeName: placeName,
    placeLat: placeLat,
    placeLng: placeLng,
    foodPaired: foodPaired,
    companionUserIds: companionUserIds,
    note: note,
    visibility: visibility,
    updatedAt: updatedAt,
  );

  WineMemoryTableData toTableData() => WineMemoryTableData(
    id: id,
    wineId: wineId,
    userId: userId,
    imageUrl: imageUrl,
    localImagePath: localImagePath,
    caption: caption,
    createdAt: createdAt,
    occurredAt: occurredAt ?? createdAt,
    occasion: occasion,
    placeName: placeName,
    placeLat: placeLat,
    placeLng: placeLng,
    foodPaired: foodPaired,
    companionUserIds: jsonEncode(companionUserIds),
    note: note,
    visibility: visibility,
    updatedAt: updatedAt ?? createdAt,
  );

  WineMemoriesTableCompanion toCompanion({bool isSynced = true}) =>
      WineMemoriesTableCompanion(
        id: Value(id),
        wineId: Value(wineId),
        userId: Value(userId),
        imageUrl: Value(imageUrl),
        localImagePath: Value(localImagePath),
        caption: Value(caption),
        createdAt: Value(createdAt),
        occurredAt: Value(occurredAt ?? createdAt),
        occasion: Value(occasion),
        placeName: Value(placeName),
        placeLat: Value(placeLat),
        placeLng: Value(placeLng),
        foodPaired: Value(foodPaired),
        companionUserIds: Value(jsonEncode(companionUserIds)),
        note: Value(note),
        visibility: Value(visibility),
        updatedAt: Value(updatedAt ?? createdAt),
      );
}

extension WineMemoryTableDataToEntity on WineMemoryTableData {
  WineMemoryEntity toEntity() {
    List<String> decoded;
    try {
      final raw = jsonDecode(companionUserIds);
      decoded = raw is List ? raw.cast<String>() : const <String>[];
    } catch (_) {
      decoded = const <String>[];
    }
    return WineMemoryEntity(
      id: id,
      wineId: wineId,
      userId: userId,
      imageUrl: imageUrl,
      localImagePath: localImagePath,
      caption: caption,
      createdAt: createdAt,
      occurredAt: occurredAt,
      occasion: occasion,
      placeName: placeName,
      placeLat: placeLat,
      placeLng: placeLng,
      foodPaired: foodPaired,
      companionUserIds: decoded,
      note: note,
      visibility: visibility,
      updatedAt: updatedAt,
    );
  }
}
