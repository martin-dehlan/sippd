// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_match.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TasteMatchModelImpl _$$TasteMatchModelImplFromJson(
  Map<String, dynamic> json,
) => _$TasteMatchModelImpl(
  score: (json['score'] as num?)?.toInt(),
  confidence: json['confidence'] as String?,
  overlapCount: (json['overlap_count'] as num?)?.toInt() ?? 0,
  myTotal: (json['my_total'] as num?)?.toInt() ?? 0,
  theirTotal: (json['their_total'] as num?)?.toInt() ?? 0,
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$$TasteMatchModelImplToJson(
  _$TasteMatchModelImpl instance,
) => <String, dynamic>{
  'score': instance.score,
  'confidence': instance.confidence,
  'overlap_count': instance.overlapCount,
  'my_total': instance.myTotal,
  'their_total': instance.theirTotal,
  'reason': instance.reason,
};
