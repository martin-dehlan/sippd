import '../entities/wine_memory_photo.entity.dart';

/// Photos sub-collection of a wine moment. Lives in its own table on
/// the server (`wine_memory_photos`) and mirrored locally via Drift.
/// Server enforces a 10-photo cap per parent moment.
abstract class WineMemoryPhotoRepository {
  Future<List<WineMemoryPhotoEntity>> getByMemory(String memoryId);
  Stream<List<WineMemoryPhotoEntity>> watchByMemory(String memoryId);
  Future<void> addPhoto(WineMemoryPhotoEntity photo);
  Future<void> addPhotos(List<WineMemoryPhotoEntity> photos);
  Future<void> deletePhoto(String id);
  Future<void> deleteByMemory(String memoryId);

  /// Persist a re-ordered list of photo ids; positions become list
  /// indices. Caller is responsible for passing the photos in the
  /// final display order.
  Future<void> reorder(String memoryId, List<String> photoIdsInOrder);
}
