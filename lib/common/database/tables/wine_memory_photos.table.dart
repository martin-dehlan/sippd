import 'package:drift/drift.dart';

/// Photos belonging to a wine_memories row. A single memory (moment)
/// can hold up to 10 photos; the cap is enforced server-side via a
/// trigger. `position` controls display order — first one is the
/// cover photo shown in the wine-detail moment card.
@DataClassName('WineMemoryPhotoTableData')
class WineMemoryPhotosTable extends Table {
  TextColumn get id => text()();
  TextColumn get memoryId => text()();
  TextColumn get storagePath => text()();
  IntColumn get position => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'wine_memory_photos';
}
