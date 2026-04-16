import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import 'friend_profile.entity.dart';

part 'activity_item.entity.freezed.dart';

@freezed
class ActivityItemEntity with _$ActivityItemEntity {
  const factory ActivityItemEntity({
    required WineEntity wine,
    required FriendProfileEntity friend,
  }) = _ActivityItemEntity;
}
