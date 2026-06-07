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
}
