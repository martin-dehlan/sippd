import 'package:drift/drift.dart';

@DataClassName('WineMemoryTableData')
class WineMemoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get wineId => text()();
  TextColumn get userId => text()();

  // Legacy single-photo cols. Kept through phase 2 for back-compat
  // with WineMemoriesEditor; cleared/migrated in phase 3.
  TextColumn get imageUrl => text().nullable()();
  TextColumn get localImagePath => text().nullable()();
  TextColumn get caption => text().nullable()();

  // Moment context (added 2026-05-13, migration 20260513101501).
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get occasion => text().nullable()();
  TextColumn get placeName => text().nullable()();
  RealColumn get placeLat => real().nullable()();
  RealColumn get placeLng => real().nullable()();
  TextColumn get foodPaired => text().nullable()();

  /// JSON-encoded list of friend user UUIDs tagged on this moment.
  /// Drift can't mirror Postgres uuid[] directly so we serialise as
  /// text — repo layer encodes/decodes against `List<String>`.
  TextColumn get companionUserIds => text().withDefault(const Constant('[]'))();
  TextColumn get note => text().nullable()();
  TextColumn get visibility => text().withDefault(const Constant('friends'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'wine_memories';
}
