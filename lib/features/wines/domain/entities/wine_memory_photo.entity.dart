import 'package:freezed_annotation/freezed_annotation.dart';

part 'wine_memory_photo.entity.freezed.dart';

/// Single photo inside a wine moment. A moment can hold up to 10
/// photos (server-enforced via trigger). `position` controls display
/// order; first one is the cover shown in the moment card.
@freezed
class WineMemoryPhotoEntity with _$WineMemoryPhotoEntity {
  const factory WineMemoryPhotoEntity({
    required String id,
    required String memoryId,
    required String storagePath,
    @Default(0) int position,
    required DateTime createdAt,
  }) = _WineMemoryPhotoEntity;
}
