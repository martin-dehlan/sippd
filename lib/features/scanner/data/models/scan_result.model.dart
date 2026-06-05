import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/scan_quota.entity.dart';
import '../../domain/entities/scan_result.entity.dart';

part 'scan_result.model.freezed.dart';
part 'scan_result.model.g.dart';

/// Envelope returned by the `recognize-label` Edge Function:
/// `{ result: {...}, quota: {...}, mock?: bool }`.
@Freezed(fromJson: true, toJson: false)
class ScanResponseModel with _$ScanResponseModel {
  const factory ScanResponseModel({
    required ScanResultModel result,
    required ScanQuotaModel quota,
    @Default(false) bool mock,
  }) = _ScanResponseModel;

  factory ScanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ScanResponseModelFromJson(json);
}

@Freezed(fromJson: true, toJson: false)
class ScanResultModel with _$ScanResultModel {
  const factory ScanResultModel({
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
  }) = _ScanResultModel;

  factory ScanResultModel.fromJson(Map<String, dynamic> json) =>
      _$ScanResultModelFromJson(json);
}

@Freezed(fromJson: true, toJson: false)
class ScanQuotaModel with _$ScanQuotaModel {
  const factory ScanQuotaModel({
    @Default(0) int used,
    @Default(0) int limit,
    @Default(0) int remaining,
  }) = _ScanQuotaModel;

  factory ScanQuotaModel.fromJson(Map<String, dynamic> json) =>
      _$ScanQuotaModelFromJson(json);
}

extension ScanQuotaModelX on ScanQuotaModel {
  ScanQuotaEntity toEntity() =>
      ScanQuotaEntity(used: used, limit: limit, remaining: remaining);
}

extension ScanResponseModelX on ScanResponseModel {
  ScanResultEntity toEntity() => ScanResultEntity(
    producer: result.producer,
    wineName: result.wineName,
    vintage: result.vintage,
    appellation: result.appellation,
    country: result.country,
    region: result.region,
    grapes: result.grapes,
    tastingNotes: result.tastingNotes,
    servingTempC: result.servingTempC,
    decantMinutes: result.decantMinutes,
    foodPairings: result.foodPairings,
    quota: quota.toEntity(),
    isMock: mock,
  );
}
