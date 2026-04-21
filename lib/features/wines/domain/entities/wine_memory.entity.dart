import 'package:freezed_annotation/freezed_annotation.dart';

part 'wine_memory.entity.freezed.dart';

@freezed
class WineMemoryEntity with _$WineMemoryEntity {
  const factory WineMemoryEntity({
    required String id,
    required String wineId,
    required String userId,
    String? imageUrl,
    String? localImagePath,
    required DateTime createdAt,
  }) = _WineMemoryEntity;
}
