import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_bottle.entity.freezed.dart';

@freezed
class SharedBottleEntity with _$SharedBottleEntity {
  const factory SharedBottleEntity({
    required String groupId,
    required String wineId,
    required String wineName,
    String? winery,
    String? region,
    String? country,
    required String type,
    int? vintage,
    required double myRating,
    required double theirRating,
    required double delta,
    DateTime? ratedAt,
  }) = _SharedBottleEntity;

  const SharedBottleEntity._();

  bool get isAgreement => delta <= 0.5;
  bool get isDisagreement => delta >= 1.5;
}
