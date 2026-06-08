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
  TextColumn get region => text().nullable()();
  TextColumn get location => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get localImagePath => text().nullable()();
  IntColumn get vintage => integer().nullable()();
  TextColumn get grape => text().nullable()();
  TextColumn get canonicalGrapeId => text().nullable()();
  TextColumn get grapeFreetext => text().nullable()();
  TextColumn get canonicalWineId => text().nullable()();
  TextColumn get winery => text().nullable()();
  // Wine attributes recognized by the label scanner (FastCork). All
  // nullable / additive — see schema v5 migration.
  IntColumn get servingTempC => integer().nullable()();
  IntColumn get decantMinutes => integer().nullable()();
  RealColumn get abv => real().nullable()();
  TextColumn get nameNorm => text().nullable()();
  TextColumn get userId => text()();
  TextColumn get visibility => text().withDefault(const Constant('friends'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'wines';
}
