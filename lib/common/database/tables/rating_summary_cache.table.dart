import 'package:drift/drift.dart';

/// Cached payload of the latest successful `get_user_rating_summary` RPC
/// response. One row per user (PK = userId). Lets the stats screen render
/// offline-safe data after a failed RPC roundtrip — without lying by
/// recomputing a wrong personal-only avg locally.
@DataClassName('RatingSummaryCacheData')
class RatingSummaryCacheTable extends Table {
  TextColumn get userId => text()();
  TextColumn get payload => text()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userId};

  @override
  String get tableName => 'rating_summary_cache';
}
