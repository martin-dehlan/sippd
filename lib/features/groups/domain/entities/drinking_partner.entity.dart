import 'package:freezed_annotation/freezed_annotation.dart';

part 'drinking_partner.entity.freezed.dart';

@freezed
class DrinkingPartnerEntity with _$DrinkingPartnerEntity {
  const factory DrinkingPartnerEntity({
    required String userId,
    String? username,
    String? displayName,
    String? avatarUrl,
    required int sharedWines,
  }) = _DrinkingPartnerEntity;
}
