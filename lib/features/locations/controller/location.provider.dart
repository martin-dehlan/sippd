import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../application/location_search.service.dart';
import '../domain/entities/location.entity.dart';

part 'location.provider.g.dart';

@riverpod
LocationSearchService locationSearchService(LocationSearchServiceRef ref) {
  return LocationSearchService();
}

@riverpod
class LocationSearchController extends _$LocationSearchController {
  @override
  FutureOr<List<LocationEntity>> build() async {
    return [];
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final service = ref.read(locationSearchServiceProvider);
      return service.searchLocations(query);
    });
  }

  void clearResults() {
    state = const AsyncValue.data([]);
  }
}
