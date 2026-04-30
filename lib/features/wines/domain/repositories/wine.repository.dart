import '../entities/wine.entity.dart';

abstract class WineRepository {
  Future<List<WineEntity>> getWines();
  Future<WineEntity?> getWineById(String id);
  Future<void> addWine(WineEntity wine);
  Future<void> updateWine(WineEntity wine);
  Future<void> deleteWine(String id);
  Stream<List<WineEntity>> watchWines();
  Future<List<WineEntity>> getWinesByType(WineType type);

  /// Re-uploads any wines whose local writes never reached Supabase
  /// (offline / network errors). Returns the number of wines still
  /// unsynced after the attempt — 0 means everything is backed up.
  Future<int> flushPendingSyncs();
}
