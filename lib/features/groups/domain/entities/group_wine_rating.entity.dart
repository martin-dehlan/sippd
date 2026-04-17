import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_wine_rating.entity.freezed.dart';

@freezed
class GroupWineRatingEntity with _$GroupWineRatingEntity {
  const factory GroupWineRatingEntity({
    required String groupId,
    required String wineId,
    required String userId,
    required double rating,
    String? notes,
    required DateTime updatedAt,
    String? username,
    String? displayName,
    String? avatarUrl,
    @Default(false) bool isOwner,
  }) = _GroupWineRatingEntity;
}
