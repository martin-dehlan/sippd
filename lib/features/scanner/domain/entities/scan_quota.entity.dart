import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_quota.entity.freezed.dart';

/// Remaining wine-label scans in the rolling 30-day window. Returned by
/// the `recognize-label` Edge Function alongside a result, and by the
/// `scan_quota_status` RPC when the UI needs the count without consuming
/// a scan.
@freezed
class ScanQuotaEntity with _$ScanQuotaEntity {
  const factory ScanQuotaEntity({
    required int used,
    required int limit,
    required int remaining,
  }) = _ScanQuotaEntity;

  const ScanQuotaEntity._();

  bool get isExhausted => remaining <= 0;

  /// Pro users get the higher daily limit; free users get 5. Used to tailor
  /// the exhausted-state copy (a Pro user shouldn't be nudged to "Go Pro").
  bool get isPro => limit > 5;
}
