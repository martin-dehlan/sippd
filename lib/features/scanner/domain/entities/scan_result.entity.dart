import 'package:freezed_annotation/freezed_annotation.dart';

import 'scan_quota.entity.dart';

part 'scan_result.entity.freezed.dart';

/// Normalized wine fields recognized from a label photo by FastCork,
/// proxied through the `recognize-label` Edge Function. Every field is
/// nullable — recognition is best-effort and the user reviews/edits the
/// prefilled form before saving.
@freezed
class ScanResultEntity with _$ScanResultEntity {
  const factory ScanResultEntity({
    String? producer,
    String? wineName,
    int? vintage,
    String? appellation,
    String? country,
    String? region,
    @Default(<String>[]) List<String> grapes,
    String? tastingNotes,
    int? servingTempC,
    int? decantMinutes,
    @Default(<String>[]) List<String> foodPairings,

    /// FastCork's wine type string (red | white | rose | sparkling), used
    /// to preselect the form's type instead of guessing from grape color.
    String? wineType,

    /// Aroma descriptors + alcohol % (FastCork), surfaced as structured
    /// wine attributes on the prefilled form.
    String? aroma,
    double? abv,

    /// Quota state after this scan was consumed.
    required ScanQuotaEntity quota,

    /// True when the Edge Function returned a deterministic stand-in
    /// (no FastCork key configured yet). Lets the UI flag mock data in
    /// debug without changing the happy path.
    @Default(false) bool isMock,
  }) = _ScanResultEntity;

  const ScanResultEntity._();

  /// Best display name for the wine: explicit cuvée name, else producer.
  String? get displayName => wineName ?? producer;

  /// Whether recognition actually returned something usable. A 200 from
  /// FastCork with all-null fields (label unreadable / not a wine) must
  /// NOT be treated as a hit — the UI shows a "nothing found" state
  /// instead of silently opening an empty add-wine form.
  bool get hasContent =>
      (displayName?.trim().isNotEmpty ?? false) ||
      producer != null ||
      vintage != null ||
      region != null ||
      appellation != null ||
      grapes.isNotEmpty;
}
