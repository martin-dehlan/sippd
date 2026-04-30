import '../../../../common/database/daos/canonical_grape.dao.dart';
import '../../domain/entities/canonical_grape.entity.dart';
import '../../domain/repositories/canonical_grape.repository.dart';
import '../data_sources/canonical_grape_supabase.api.dart';
import '../models/canonical_grape.model.dart';

class CanonicalGrapeRepositoryImpl implements CanonicalGrapeRepository {
  final CanonicalGrapeDao _dao;
  final CanonicalGrapeSupabaseApi? _api;

  CanonicalGrapeRepositoryImpl(this._dao, [this._api]);

  @override
  Future<List<CanonicalGrapeEntity>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map((r) => r.toEntity()).toList();
  }

  @override
  Future<CanonicalGrapeEntity?> getById(String id) async {
    final row = await _dao.getById(id);
    return row?.toEntity();
  }

  @override
  Future<void> syncFromRemote() async {
    if (_api == null) return;
    try {
      final models = await _api.fetchAll();
      final tableData = models.map((m) => m.toTableData()).toList();
      await _dao.replaceAll(tableData);
    } catch (_) {
      // Network failure: keep whatever we already mirrored locally.
    }
  }

  @override
  Future<List<CanonicalGrapeEntity>> search(String query) async {
    final all = await getAll();
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return all;

    final matches = all.where((g) {
      final name = g.name.toLowerCase();
      if (name.contains(q)) return true;
      return g.aliases.any((a) => a.contains(q));
    }).toList();

    matches.sort((a, b) {
      final aStarts = a.name.toLowerCase().startsWith(q);
      final bStarts = b.name.toLowerCase().startsWith(q);
      if (aStarts != bStarts) return aStarts ? -1 : 1;
      return a.name.compareTo(b.name);
    });

    return matches;
  }
}
