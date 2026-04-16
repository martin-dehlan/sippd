import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../friends/domain/entities/friend_profile.entity.dart';

part 'tasting_attendee.entity.freezed.dart';

enum RsvpStatus { going, maybe, declined, noResponse }

extension RsvpStatusX on RsvpStatus {
  String get wire => switch (this) {
        RsvpStatus.going => 'going',
        RsvpStatus.maybe => 'maybe',
        RsvpStatus.declined => 'declined',
        RsvpStatus.noResponse => 'no_response',
      };

  static RsvpStatus fromWire(String s) => switch (s) {
        'going' => RsvpStatus.going,
        'maybe' => RsvpStatus.maybe,
        'declined' => RsvpStatus.declined,
        _ => RsvpStatus.noResponse,
      };
}

@freezed
class TastingAttendeeEntity with _$TastingAttendeeEntity {
  const factory TastingAttendeeEntity({
    required String tastingId,
    required String userId,
    required RsvpStatus status,
    FriendProfileEntity? profile,
  }) = _TastingAttendeeEntity;
}
