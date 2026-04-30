import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_grape_share.entity.freezed.dart';

/// One entry in a user's top-grapes list — count + avg rating per
/// canonical grape they've rated. Drives the Grapes compass mode.
@freezed
class UserGrapeShare with _$UserGrapeShare {
  const factory UserGrapeShare({
    required String canonicalGrapeId,
    required String grapeName,
    required String grapeColor,
    required int count,
    required double avgRating,
  }) = _UserGrapeShare;
}
