import 'package:drift/drift.dart';

/// Cached payload of the latest successful `get_user_badge_progress` RPC for
/// the signed-in user (PK = userId). Lets the badge grid render instantly /
/// offline. Same JSON-payload pattern as `rating_summary_cache`.
@DataClassName('BadgeProgressCacheData')
class BadgeProgressCacheTable extends Table {
  TextColumn get userId => text()();
  TextColumn get payload => text()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userId};

  @override
  String get tableName => 'badge_progress_cache';
}
