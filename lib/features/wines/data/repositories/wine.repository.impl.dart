import '../../domain/entities/wine.entity.dart';
import '../../domain/repositories/wine.repository.dart';
import '../../../../common/database/daos/wines.dao.dart';
import '../models/wine.mapper.dart';

class WineRepositoryImpl implements WineRepository {
  final WinesDao _dao;

  WineRepositoryImpl(this._dao);

  // TODO: Add Supabase client for sync

  @override
  Future<List<WineEntity>> getWines() async {
    final localData = await _dao.getAllWines();
    return localData.map((td) => td.toEntity()).toList();
  }

  @override
  Future<WineEntity?> getWineById(String id) async {
    final data = await _dao.getWineById(id);
    return data?.toEntity();
  }

  @override
  Future<void> addWine(WineEntity wine) async {
    await _dao.insertWine(wine.toTableData());
    // TODO: Sync to Supabase
  }

  @override
  Future<void> updateWine(WineEntity wine) async {
    await _dao.updateWine(wine.toTableData());
    // TODO: Sync to Supabase
  }

  @override
  Future<void> deleteWine(String id) async {
    await _dao.deleteWine(id);
    // TODO: Sync to Supabase
  }

  @override
  Stream<List<WineEntity>> watchWines() {
    return _dao.watchAllWines().map(
          (list) => list.map((td) => td.toEntity()).toList(),
        );
  }

  @override
  Future<List<WineEntity>> getWinesByType(WineType type) async {
    final data = await _dao.getWinesByType(type.name);
    return data.map((td) => td.toEntity()).toList();
  }
}
