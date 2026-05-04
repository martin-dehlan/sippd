import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../friends/domain/entities/friend_profile.entity.dart';

part 'group_wine_share.entity.freezed.dart';

@freezed
class GroupWineShareEntity with _$GroupWineShareEntity {
  const factory GroupWineShareEntity({
    required FriendProfileEntity sharer,
    required DateTime sharedAt,
  }) = _GroupWineShareEntity;
}
