import 'package:drift/drift.dart';

@DataClassName('NotificationPrefsTableData')
class NotificationPrefsTable extends Table {
  TextColumn get userId => text()();
  BoolColumn get tastingReminders =>
      boolean().withDefault(const Constant(true))();
  IntColumn get tastingReminderHours =>
      integer().withDefault(const Constant(1))();
  BoolColumn get friendActivity =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get groupActivity =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get groupWineShared =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId};

  @override
  String get tableName => 'notification_prefs';
}
