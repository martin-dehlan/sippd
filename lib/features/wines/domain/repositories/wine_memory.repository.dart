import '../entities/wine_memory.entity.dart';

abstract class WineMemoryRepository {
  Future<List<WineMemoryEntity>> getByWine(String wineId);
  Stream<List<WineMemoryEntity>> watchByWine(String wineId);
  Future<void> addMemory(WineMemoryEntity memory);
  Future<void> deleteMemory(String id);
  Future<void> deleteByWine(String wineId);

  /// Moments where the current user and [otherUserId] are both
  /// involved (owner + tagged-companion in either direction).
  /// Server-only — no Drift cache, since these aren't yours to own.
  Future<List<WineMemoryEntity>> getShared(String otherUserId);
}
