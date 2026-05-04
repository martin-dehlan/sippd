import 'package:drift/drift.dart';

/// Read-only mirror of `canonical_grape` from Supabase. Used for grape
/// typeahead in the wine form and canonical id resolution. Refreshed on
/// app boot / login.
@DataClassName('CanonicalGrapeTableData')
class CanonicalGrapeTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get color => text()(); // 'red' | 'white'
  TextColumn get aliases => text()
      .map(const AliasesConverter())
      .withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'canonical_grape';
}

/// Pipe-joined list of lowercase aliases. Pipe is rare in grape names so
/// it keeps the storage simple without JSON overhead.
class AliasesConverter extends TypeConverter<List<String>, String> {
  const AliasesConverter();

  @override
  List<String> fromSql(String fromDb) =>
      fromDb.isEmpty ? const [] : fromDb.split('|');

  @override
  String toSql(List<String> value) => value.join('|');
}
