import 'package:drift/drift.dart';

/// One row per wine whose image still needs to be uploaded to Supabase
/// Storage. Lifecycle:
///   1. WineRepositoryImpl tries to upload → fails → enqueue here.
///   2. OutboxFlusher periodically reads + retries.
///   3. Upload succeeds → delete row + write the resolved URL back to
///      the wine's Drift row + Supabase row.
///
/// Bounded retries via [attempts] (capped at 5 to avoid hammering a
/// permanently-broken file). [lastErrorAt] drives exponential backoff
/// so a transient blip doesn't burn the budget.
@DataClassName('PendingImageUploadData')
class PendingImageUploadsTable extends Table {
  TextColumn get wineId => text()();
  TextColumn get localPath => text()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastErrorAt => dateTime().nullable()();
  DateTimeColumn get queuedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {wineId};

  @override
  String get tableName => 'pending_image_uploads';
}
