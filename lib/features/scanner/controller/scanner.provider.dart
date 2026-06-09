import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/controller/auth.provider.dart';
import '../data/data_sources/scanner.api.dart';
import '../data/repositories/scanner.repository.impl.dart';
import '../domain/entities/scan_quota.entity.dart';
import '../domain/entities/scan_result.entity.dart';
import '../domain/repositories/scanner.repository.dart';

part 'scanner.provider.g.dart';

@riverpod
ScannerApi scannerApi(ScannerApiRef ref) {
  return ScannerApi(ref.watch(supabaseClientProvider));
}

@riverpod
ScannerRepository scannerRepository(ScannerRepositoryRef ref) {
  return ScannerRepositoryImpl(ref.watch(scannerApiProvider));
}

/// Remaining scans in the rolling window (read-only — does not consume).
/// Powers the "N scans left" badge near the scan entry point.
@riverpod
Future<ScanQuotaEntity?> scanQuota(ScanQuotaRef ref) {
  return ref.watch(scannerRepositoryProvider).quotaStatus();
}

/// Drives the capture → recognition → result flow. `build` returns null
/// (idle); [scan] transitions loading → data(result) | error.
@riverpod
class ScannerController extends _$ScannerController {
  @override
  FutureOr<ScanResultEntity?> build() => null;

  Future<void> scan(File image, {String lang = 'en'}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(scannerRepositoryProvider).recognize(image, lang: lang),
    );
    // Refresh the remaining-scans badge whether or not we succeeded
    // (a consumed scan or a quota hit both change the count).
    ref.invalidate(scanQuotaProvider);
  }

  void reset() => state = const AsyncData(null);

  /// Demo only (`kIsDemo`): fake a recognition without touching the camera,
  /// the Edge Function, or the scan quota. Plays the loading state for a
  /// beat, then emits a fixed Hugel Riesling result so the tour lands on a
  /// fully prefilled add-wine form.
  Future<void> scanDemo() async {
    state = const AsyncLoading();
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    state = const AsyncData(_demoResult);
  }

  static const _demoResult = ScanResultEntity(
    producer: 'Hugel',
    wineName: 'Riesling Classic',
    vintage: 2021,
    appellation: 'Alsace AOC',
    country: 'France',
    region: 'Alsace',
    grapes: ['Riesling'],
    wineType: 'white',
    tastingNotes:
        'Dry and crisp, with green apple, citrus and a flinty minerality '
        'through a long, clean finish.',
    servingTempC: 9,
    foodPairings: ['Seafood', 'Goat cheese', 'Thai curry'],
    aroma: 'Green apple, lime, white flowers, flint',
    abv: 12.5,
    quota: ScanQuotaEntity(used: 1, limit: 5, remaining: 4),
    isMock: true,
  );
}
