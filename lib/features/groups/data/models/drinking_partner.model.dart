import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/drinking_partner.entity.dart';

part 'drinking_partner.model.freezed.dart';
part 'drinking_partner.model.g.dart';

@freezed
class DrinkingPartnerModel with _$DrinkingPartnerModel {
  const factory DrinkingPartnerModel({
    @JsonKey(name: 'user_id') required String userId,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'shared_wines') required int sharedWines,
  }) = _DrinkingPartnerModel;

  factory DrinkingPartnerModel.fromJson(Map<String, dynamic> json) =>
      _$DrinkingPartnerModelFromJson(json);
}

extension DrinkingPartnerModelX on DrinkingPartnerModel {
  DrinkingPartnerEntity toEntity() => DrinkingPartnerEntity(
    userId: userId,
    username: username,
    displayName: displayName,
    avatarUrl: avatarUrl,
    sharedWines: sharedWines,
  );
}
