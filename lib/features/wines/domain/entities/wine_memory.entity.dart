import 'package:freezed_annotation/freezed_annotation.dart';

part 'wine_memory.entity.freezed.dart';

/// Wine moment (DB name: wine_memories). One row = one journal event
/// tied to a wine. Photos live in a sibling collection — see
/// [WineMemoryPhotoEntity]. The legacy `imageUrl` / `localImagePath`
/// cols still serve single-photo moments through phase 2 of the Wine
/// Moments rollout; phase 3 migrates them into the photos table.
@freezed
class WineMemoryEntity with _$WineMemoryEntity {
  const factory WineMemoryEntity({
    required String id,
    required String wineId,
    required String userId,
    String? imageUrl,
    String? localImagePath,
    String? caption,
    required DateTime createdAt,
    DateTime? occurredAt,
    String? occasion,
    String? placeName,
    double? placeLat,
    double? placeLng,
    String? foodPaired,
    @Default(<String>[]) List<String> companionUserIds,
    String? note,
    @Default('friends') String visibility,
    DateTime? updatedAt,
  }) = _WineMemoryEntity;
}
