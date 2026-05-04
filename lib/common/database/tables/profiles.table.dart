import 'package:drift/drift.dart';

/// Local mirror of the Supabase `profiles` row for the current user.
/// Stored as a single row keyed by [id] (Supabase user UUID). Acts as
/// the offline source of truth so the router and profile screens can
/// render immediately without waiting for a Supabase round-trip.
///
/// List-typed fields (goals, styles) are persisted as comma-separated
/// strings to avoid pulling in a JSON column type just for two enum
/// lists. They round-trip through extension helpers in
/// [ProfilesDao] / [profile.model.dart].
@DataClassName('ProfileTableData')
class ProfilesTable extends Table {
  TextColumn get id => text()();
  TextColumn get username => text().nullable()();
  TextColumn get displayName => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
  TextColumn get tasteLevel => text().nullable()();
  TextColumn get goalsCsv => text().withDefault(const Constant(''))();
  TextColumn get stylesCsv => text().withDefault(const Constant(''))();
  TextColumn get drinkFrequency => text().nullable()();
  TextColumn get tasteEmoji => text().nullable()();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'profiles';
}
