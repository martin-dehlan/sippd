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
  bucketScore: (json['bucket_score'] as num?)?.toInt(),
  dnaScore: (json['dna_score'] as num?)?.toInt(),
  sameCanonicalPairs: (json['same_canonical_pairs'] as num?)?.toInt() ?? 0,
  agreePairs: (json['agree_pairs'] as num?)?.toInt() ?? 0,
  disagreePairs: (json['disagree_pairs'] as num?)?.toInt() ?? 0,
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
  'bucket_score': instance.bucketScore,
  'dna_score': instance.dnaScore,
  'same_canonical_pairs': instance.sameCanonicalPairs,
  'agree_pairs': instance.agreePairs,
  'disagree_pairs': instance.disagreePairs,
};
