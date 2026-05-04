import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/canonical_grape.table.dart';

part 'canonical_grape.dao.g.dart';

@DriftAccessor(tables: [CanonicalGrapeTable])
class CanonicalGrapeDao extends DatabaseAccessor<AppDatabase>
    with _$CanonicalGrapeDaoMixin {
  CanonicalGrapeDao(super.db);

  Future<List<CanonicalGrapeTableData>> getAll() {
    return (select(canonicalGrapeTable)
          ..orderBy([(g) => OrderingTerm.asc(g.name)]))
        .get();
  }

  Future<CanonicalGrapeTableData?> getById(String id) {
    return (select(canonicalGrapeTable)..where((g) => g.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> count() async {
    final rows = await select(canonicalGrapeTable).get();
    return rows.length;
  }

  /// Bulk replace from Supabase sync. Keeps the local mirror in step with
  /// the remote catalog (additions, edits, deletions).
  Future<void> replaceAll(List<CanonicalGrapeTableData> grapes) async {
    await transaction(() async {
      await delete(canonicalGrapeTable).go();
      await batch((b) => b.insertAll(canonicalGrapeTable, grapes));
    });
  }
}
