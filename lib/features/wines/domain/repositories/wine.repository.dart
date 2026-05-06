import '../entities/wine.entity.dart';

abstract class WineRepository {
  Future<List<WineEntity>> getWines();
  Future<WineEntity?> getWineById(String id);
  Future<void> addWine(WineEntity wine);
  Future<void> updateWine(WineEntity wine);
  Future<void> deleteWine(String id);
  Stream<List<WineEntity>> watchWines();
  Future<List<WineEntity>> getWinesByType(WineType type);

  /// Force-flush a pending debounced remote sync for [wineId]. Call when
  /// the user navigates away from an autosave surface to guarantee the
  /// latest local state reaches Supabase before the timer would have
  /// fired naturally.
  Future<void> flushPendingSync(String wineId);
}
