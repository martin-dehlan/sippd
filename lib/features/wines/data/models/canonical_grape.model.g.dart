// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canonical_grape.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanonicalGrapeModelImpl _$$CanonicalGrapeModelImplFromJson(
  Map<String, dynamic> json,
) => _$CanonicalGrapeModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  color: json['color'] as String,
  aliases:
      (json['aliases'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$$CanonicalGrapeModelImplToJson(
  _$CanonicalGrapeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'aliases': instance.aliases,
};
