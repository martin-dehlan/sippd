import 'package:drift/drift.dart';

@DataClassName('WineTableData')
class WinesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get rating => real()();
  TextColumn get type => text()(); // red, white, rose
  RealColumn get price => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('EUR'))();
  TextColumn get country => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get localImagePath => text().nullable()();
  IntColumn get vintage => integer().nullable()();
  TextColumn get grape => text().nullable()();
  TextColumn get userId => text()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'wines';
}
