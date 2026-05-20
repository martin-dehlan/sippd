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

  /// Share a wine identity with a friend so the wine appears in their
  /// personal list. Server-side RPC handles ownership + friendship
  /// checks and is a no-op if the friend already has the same
  /// canonical wine. Returns the friend's wine_id.
  Future<String> shareToFriend({
    required String friendId,
    required String wineId,
  });
}
