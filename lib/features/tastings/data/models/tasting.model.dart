import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/tasting.entity.dart';

part 'tasting.model.freezed.dart';
part 'tasting.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class TastingModel with _$TastingModel {
  const factory TastingModel({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    required String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'scheduled_at') required DateTime scheduledAt,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'is_blind') @Default(false) bool isBlind,
    @JsonKey(name: 'is_revealed') @Default(false) bool isRevealed,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TastingModel;

  factory TastingModel.fromJson(Map<String, dynamic> json) =>
      _$TastingModelFromJson(json);
}

extension TastingModelX on TastingModel {
  TastingEntity toEntity() => TastingEntity(
        id: id,
        groupId: groupId,
        title: title,
        description: description,
        location: location,
        latitude: latitude,
        longitude: longitude,
        scheduledAt: scheduledAt,
        createdBy: createdBy,
        isBlind: isBlind,
        isRevealed: isRevealed,
        createdAt: createdAt,
      );
}
