import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasting.entity.freezed.dart';

/// Lifecycle phase of a tasting. Transitions are explicit (host-driven),
/// never auto-flipped by time — events run longer than scheduled.
enum TastingState { upcoming, active, concluded }

/// How the wine lineup is curated.
/// - [planned]: host added wines pre-event (gekauft / curated home tasting).
/// - [open]: lineup discovers on arrival (everyone-brings, external venue).
enum TastingLineupMode { planned, open }

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
    @Default(TastingState.upcoming) TastingState state,
    @Default(TastingLineupMode.planned) TastingLineupMode lineupMode,
    DateTime? startedAt,
    DateTime? endedAt,
    required DateTime createdAt,
  }) = _TastingEntity;
}
