import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/wine_memory_photos.table.dart';

part 'wine_memory_photos.dao.g.dart';

@DriftAccessor(tables: [WineMemoryPhotosTable])
class WineMemoryPhotosDao extends DatabaseAccessor<AppDatabase>
    with _$WineMemoryPhotosDaoMixin {
  WineMemoryPhotosDao(super.db);

  Future<List<WineMemoryPhotoTableData>> getByMemory(String memoryId) {
    return (select(wineMemoryPhotosTable)
          ..where((p) => p.memoryId.equals(memoryId))
          ..orderBy([(p) => OrderingTerm.asc(p.position)]))
        .get();
  }

  Stream<List<WineMemoryPhotoTableData>> watchByMemory(String memoryId) {
    return (select(wineMemoryPhotosTable)
          ..where((p) => p.memoryId.equals(memoryId))
          ..orderBy([(p) => OrderingTerm.asc(p.position)]))
        .watch();
  }

  Future<void> insertPhoto(WineMemoryPhotoTableData photo) {
    return into(wineMemoryPhotosTable).insertOnConflictUpdate(photo);
  }

  Future<void> insertPhotos(List<WineMemoryPhotoTableData> photos) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(wineMemoryPhotosTable, photos);
    });
  }

  Future<void> deletePhoto(String id) {
    return (delete(wineMemoryPhotosTable)..where((p) => p.id.equals(id))).go();
  }

  Future<void> deleteByMemory(String memoryId) {
    return (delete(
      wineMemoryPhotosTable,
    )..where((p) => p.memoryId.equals(memoryId))).go();
  }

  /// Re-position all photos for a memory in one batch. Caller passes
  /// the final ordering as a list of photo ids; positions become the
  /// list indices. Use after drag-reorder in the edit sheet.
  Future<void> reorder(String memoryId, List<String> photoIdsInOrder) async {
    await batch((b) {
      for (var i = 0; i < photoIdsInOrder.length; i++) {
        b.update(
          wineMemoryPhotosTable,
          WineMemoryPhotosTableCompanion(position: Value(i)),
          where: (p) => p.id.equals(photoIdsInOrder[i]),
        );
      }
    });
  }
}
