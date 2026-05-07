import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/shared_bottle.entity.dart';

part 'shared_bottle.model.freezed.dart';
part 'shared_bottle.model.g.dart';

@freezed
class SharedBottleModel with _$SharedBottleModel {
  const factory SharedBottleModel({
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'wine_id') required String wineId,
    @JsonKey(name: 'wine_name') required String wineName,
    String? winery,
    String? region,
    String? country,
    required String type,
    int? vintage,
    @JsonKey(name: 'my_rating') required double myRating,
    @JsonKey(name: 'their_rating') required double theirRating,
    required double delta,
    @JsonKey(name: 'rated_at') DateTime? ratedAt,
  }) = _SharedBottleModel;

  factory SharedBottleModel.fromJson(Map<String, dynamic> json) =>
      _$SharedBottleModelFromJson(json);
}

extension SharedBottleModelX on SharedBottleModel {
  SharedBottleEntity toEntity() => SharedBottleEntity(
    groupId: groupId,
    wineId: wineId,
    wineName: wineName,
    winery: winery,
    region: region,
    country: country,
    type: type,
    vintage: vintage,
    myRating: myRating,
    theirRating: theirRating,
    delta: delta,
    ratedAt: ratedAt,
  );
}
