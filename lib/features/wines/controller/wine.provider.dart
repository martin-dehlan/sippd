import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/database/database.dart';
import '../../auth/controller/auth.provider.dart';
import '../domain/entities/wine.entity.dart';
import '../domain/repositories/wine.repository.dart';
import '../data/data_sources/wine_image.service.dart';
import '../data/data_sources/wine_supabase.api.dart';
import '../data/repositories/wine.repository.impl.dart';

part 'wine.provider.g.dart';

// ========================================
// DEPENDENCIES
// ========================================

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}

@riverpod
WineSupabaseApi? wineSupabaseApi(WineSupabaseApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return WineSupabaseApi(client);
}

@riverpod
WineRepository wineRepository(WineRepositoryRef ref) {
  final db = ref.read(appDatabaseProvider);
  final api = ref.watch(wineSupabaseApiProvider);
  return WineRepositoryImpl(db.winesDao, api);
}

@riverpod
WineImageService? wineImageService(WineImageServiceRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return WineImageService(client);
}

// ========================================
// STATE MANAGEMENT
// ========================================

@riverpod
class WineController extends _$WineController {
  @override
  Stream<List<WineEntity>> build() {
    return ref.read(wineRepositoryProvider).watchWines();
  }

  Future<void> addWine(WineEntity wine) async {
    await ref.read(wineRepositoryProvider).addWine(wine);
  }

  Future<void> updateWine(WineEntity wine) async {
    await ref.read(wineRepositoryProvider).updateWine(wine);
  }

  Future<void> deleteWine(String id) async {
    await ref.read(wineRepositoryProvider).deleteWine(id);
  }
}

// ========================================
// FAMILY PROVIDERS
// ========================================

@riverpod
Future<WineEntity?> wineDetail(WineDetailRef ref, String wineId) async {
  return ref.read(wineRepositoryProvider).getWineById(wineId);
}

// ========================================
// FILTER STATE
// ========================================

@riverpod
class WineTypeFilter extends _$WineTypeFilter {
  @override
  WineType? build() => null;

  void setFilter(WineType? type) {
    state = type;
  }
}
