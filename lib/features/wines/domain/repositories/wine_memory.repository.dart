import '../entities/wine_memory.entity.dart';

abstract class WineMemoryRepository {
  Future<List<WineMemoryEntity>> getByWine(String wineId);
  Stream<List<WineMemoryEntity>> watchByWine(String wineId);
  Future<void> addMemory(WineMemoryEntity memory);
  Future<void> deleteMemory(String id);
  Future<void> deleteByWine(String wineId);
}
