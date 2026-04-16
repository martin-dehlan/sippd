import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/wines.table.dart';
import 'daos/wines.dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [WinesTable],
  daos: [WinesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(winesTable, winesTable.memoryImageUrl);
            await m.addColumn(winesTable, winesTable.memoryLocalImagePath);
          }
          if (from < 3) {
            await m.addColumn(winesTable, winesTable.latitude);
            await m.addColumn(winesTable, winesTable.longitude);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'sippd_database');
  }
}
