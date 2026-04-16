import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasting.entity.freezed.dart';

@freezed
class TastingEntity with _$TastingEntity {
  const factory TastingEntity({
    required String id,
    required String groupId,
    required String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    required DateTime scheduledAt,
    required String createdBy,
    @Default(false) bool isBlind,
    @Default(false) bool isRevealed,
    required DateTime createdAt,
  }) = _TastingEntity;
}
