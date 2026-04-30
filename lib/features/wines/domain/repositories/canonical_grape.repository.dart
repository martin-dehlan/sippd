import '../entities/canonical_grape.entity.dart';

abstract class CanonicalGrapeRepository {
  /// All canonical grapes from the local mirror, sorted by name.
  Future<List<CanonicalGrapeEntity>> getAll();

  Future<CanonicalGrapeEntity?> getById(String id);

  /// Refreshes the local mirror from Supabase. Safe to call on every app
  /// boot; the catalog is small so we replace it wholesale.
  Future<void> syncFromRemote();

  /// Case-insensitive search across name + aliases. Empty query returns
  /// the full sorted list. Results are sorted with prefix matches first.
  Future<List<CanonicalGrapeEntity>> search(String query);
}
