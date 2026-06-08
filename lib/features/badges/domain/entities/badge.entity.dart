import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge.entity.freezed.dart';

/// A single badge plus this user's standing on it. Pure domain — no Flutter,
/// no JSON. `current`/`target` drive the progress bar; `earned` + `earnedAt`
/// mark an unlocked badge.
@freezed
class BadgeEntity with _$BadgeEntity {
  const factory BadgeEntity({
    required String id,
    required String category,
    required int tier,
    required String title,
    required String description,
    required String icon,
    @Default(false) bool earned,
    DateTime? earnedAt,
    @Default(0) int current,
    @Default(1) int target,
  }) = _BadgeEntity;

  const BadgeEntity._();

  /// Clamped 0..1 progress fraction for the bar.
  double get progress {
    if (earned) return 1;
    if (target <= 0) return 0;
    return (current / target).clamp(0, 1).toDouble();
  }
}
