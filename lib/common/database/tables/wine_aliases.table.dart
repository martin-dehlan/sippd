import 'package:drift/drift.dart';

/// Maps a user's local wine id to a canonical wine id (usually another
/// user's wine). Used by the dedup-on-share flow so that rating and group
/// ranking always resolve to a single canonical wine across members.
@DataClassName('WineAliasTableData')
class WineAliasesTable extends Table {
  TextColumn get userId => text()();
  TextColumn get localWineId => text()();
  TextColumn get canonicalWineId => text()();
  TextColumn get source => text().withDefault(const Constant('share_match'))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, localWineId};

  @override
  String get tableName => 'wine_aliases';
}
