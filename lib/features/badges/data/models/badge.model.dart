import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/badge.entity.dart';

part 'badge.model.freezed.dart';
part 'badge.model.g.dart';

/// Maps one row of `get_user_badge_progress` / `get_unseen_badges`. Unseen
/// rows omit `current`/`target`/`earned` — defaults cover them since the
/// celebration UI only needs title/description/icon.
@freezed
class BadgeModel with _$BadgeModel {
  const factory BadgeModel({
    @JsonKey(name: 'badge_id') required String badgeId,
    required String category,
    required int tier,
    required String title,
    required String description,
    required String icon,
    @Default(false) bool earned,
    @JsonKey(name: 'earned_at') DateTime? earnedAt,
    @Default(0) int current,
    @Default(1) int target,
  }) = _BadgeModel;

  factory BadgeModel.fromJson(Map<String, dynamic> json) =>
      _$BadgeModelFromJson(json);
}

extension BadgeModelX on BadgeModel {
  BadgeEntity toEntity({bool forceEarned = false}) => BadgeEntity(
    id: badgeId,
    category: category,
    tier: tier,
    title: title,
    description: description,
    icon: icon,
    earned: earned || forceEarned || earnedAt != null,
    earnedAt: earnedAt,
    current: current,
    target: target,
  );
}
