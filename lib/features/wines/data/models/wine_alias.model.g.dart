// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_alias.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WineAliasModelImpl _$$WineAliasModelImplFromJson(Map<String, dynamic> json) =>
    _$WineAliasModelImpl(
      userId: json['user_id'] as String,
      localWineId: json['local_wine_id'] as String,
      canonicalWineId: json['canonical_wine_id'] as String,
      source: json['source'] as String? ?? 'share_match',
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$WineAliasModelImplToJson(
  _$WineAliasModelImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'local_wine_id': instance.localWineId,
  'canonical_wine_id': instance.canonicalWineId,
  'source': instance.source,
  'created_at': instance.createdAt.toIso8601String(),
};
