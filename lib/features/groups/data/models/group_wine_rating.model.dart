import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/group_wine_rating.entity.dart';

part 'group_wine_rating.model.freezed.dart';
part 'group_wine_rating.model.g.dart';

@freezed
class GroupWineRatingModel with _$GroupWineRatingModel {
  const factory GroupWineRatingModel({
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'canonical_wine_id') required String canonicalWineId,
    @JsonKey(name: 'user_id') required String userId,
    required double rating,
    String? notes,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _GroupWineRatingModel;

  factory GroupWineRatingModel.fromJson(Map<String, dynamic> json) =>
      _$GroupWineRatingModelFromJson(json);
}

extension GroupWineRatingModelX on GroupWineRatingModel {
  GroupWineRatingEntity toEntity({
    String? username,
    String? displayName,
    String? avatarUrl,
  }) => GroupWineRatingEntity(
    groupId: groupId,
    canonicalWineId: canonicalWineId,
    userId: userId,
    rating: rating,
    notes: notes,
    updatedAt: updatedAt,
    username: username,
    displayName: displayName,
    avatarUrl: avatarUrl,
  );
}
