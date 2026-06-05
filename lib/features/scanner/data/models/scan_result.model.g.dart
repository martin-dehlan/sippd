// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanResponseModelImpl _$$ScanResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$ScanResponseModelImpl(
  result: ScanResultModel.fromJson(json['result'] as Map<String, dynamic>),
  quota: ScanQuotaModel.fromJson(json['quota'] as Map<String, dynamic>),
  mock: json['mock'] as bool? ?? false,
);

_$ScanResultModelImpl _$$ScanResultModelImplFromJson(
  Map<String, dynamic> json,
) => _$ScanResultModelImpl(
  producer: json['producer'] as String?,
  wineName: json['wineName'] as String?,
  vintage: (json['vintage'] as num?)?.toInt(),
  appellation: json['appellation'] as String?,
  country: json['country'] as String?,
  region: json['region'] as String?,
  grapes:
      (json['grapes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  tastingNotes: json['tastingNotes'] as String?,
  servingTempC: (json['servingTempC'] as num?)?.toInt(),
  decantMinutes: (json['decantMinutes'] as num?)?.toInt(),
  foodPairings:
      (json['foodPairings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

_$ScanQuotaModelImpl _$$ScanQuotaModelImplFromJson(Map<String, dynamic> json) =>
    _$ScanQuotaModelImpl(
      used: (json['used'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      remaining: (json['remaining'] as num?)?.toInt() ?? 0,
    );
