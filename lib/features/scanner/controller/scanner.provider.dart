import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/open_food_facts.api.dart';
import '../domain/entities/scanned_wine.entity.dart';

part 'scanner.provider.g.dart';

@riverpod
OpenFoodFactsApi openFoodFactsApi(OpenFoodFactsApiRef ref) {
  return OpenFoodFactsApi();
}

@riverpod
class ScannerController extends _$ScannerController {
  @override
  AsyncValue<ScannedWineData?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> lookupBarcode(String barcode) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(openFoodFactsApiProvider);
      return api.lookupBarcode(barcode);
    });
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
