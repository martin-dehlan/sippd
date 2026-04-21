import 'package:drift/drift.dart';

@DataClassName('WineMemoryTableData')
class WineMemoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get wineId => text()();
  TextColumn get userId => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get localImagePath => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'wine_memories';
}
