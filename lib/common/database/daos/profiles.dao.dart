import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/profiles.table.dart';

part 'profiles.dao.g.dart';

@DriftAccessor(tables: [ProfilesTable])
class ProfilesDao extends DatabaseAccessor<AppDatabase>
    with _$ProfilesDaoMixin {
  ProfilesDao(super.db);

  Future<ProfileTableData?> getById(String id) {
    return (select(
      profilesTable,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  Stream<ProfileTableData?> watchById(String id) {
    return (select(
      profilesTable,
    )..where((p) => p.id.equals(id))).watchSingleOrNull();
  }

  Future<void> upsert(ProfileTableData data) {
    return into(profilesTable).insertOnConflictUpdate(data);
  }

  Future<void> deleteById(String id) {
    return (delete(profilesTable)..where((p) => p.id.equals(id))).go();
  }
}
