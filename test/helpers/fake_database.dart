import 'package:drift/native.dart';
import 'package:sippd/common/database/database.dart';

/// In-memory [AppDatabase] for tests. Schema-fresh per call so tests
/// stay isolated. Caller is responsible for `await db.close()` (use
/// `addTearDown(db.close)`).
AppDatabase makeFakeDatabase() {
  return AppDatabase.forTesting(NativeDatabase.memory());
}
