import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/groups/controller/group_ratings.provider.dart';
import 'package:sippd/features/groups/data/models/group_wine_rating.model.dart';

void main() {
  GroupWineRatingModel member({
    required String userId,
    double rating = 7,
    DateTime? at,
    String? notes,
  }) => GroupWineRatingModel(
    groupId: 'g',
    canonicalWineId: 'cw',
    userId: userId,
    rating: rating,
    notes: notes,
    updatedAt: at ?? DateTime.utc(2026, 1, 1),
  );

  Map<String, Map<String, dynamic>> profiles(
    Map<String, String> displayNames,
  ) => {
    for (final entry in displayNames.entries)
      entry.key: {
        'id': entry.key,
        'username': entry.key,
        'display_name': entry.value,
        'avatar_url': null,
      },
  };

  group('mergeGroupRatings', () {
    test('owner row inserted with isOwner=true and synthesized rating', () {
      final out = mergeGroupRatings(
        groupId: 'g',
        canonicalWineId: 'cw',
        ownerId: 'owner-1',
        ownerRating: 8.7,
        ownerUpdatedAt: DateTime.utc(2026, 5, 1),
        memberModels: const [],
        profilesById: profiles({'owner-1': 'Owner'}),
      );
      expect(out, hasLength(1));
      expect(out.single.isOwner, isTrue);
      expect(out.single.rating, 8.7);
      expect(out.single.displayName, 'Owner');
    });

    test('owner row dropped when ownerRating is null', () {
      final out = mergeGroupRatings(
        groupId: 'g',
        canonicalWineId: 'cw',
        ownerId: 'owner-1',
        ownerRating: null,
        ownerUpdatedAt: DateTime.utc(2026, 5, 1),
        memberModels: const [],
        profilesById: const {},
      );
      expect(out, isEmpty);
    });

    test('member row from owner is filtered to avoid double-counting', () {
      final out = mergeGroupRatings(
        groupId: 'g',
        canonicalWineId: 'cw',
        ownerId: 'owner-1',
        ownerRating: 9,
        ownerUpdatedAt: DateTime.utc(2026, 5, 1),
        memberModels: [
          member(userId: 'owner-1', rating: 4),
          member(userId: 'm-1', rating: 6),
        ],
        profilesById: profiles({'owner-1': 'O', 'm-1': 'M1'}),
      );
      expect(
        out.where((r) => r.userId == 'owner-1'),
        hasLength(1),
        reason: 'owner row appears exactly once',
      );
      expect(
        out.where((r) => r.userId == 'owner-1').single.rating,
        9,
        reason:
            'owner rating comes from local wines.rating, '
            'not the duplicate member row',
      );
    });

    test('sorts by updatedAt descending across owner + members', () {
      final out = mergeGroupRatings(
        groupId: 'g',
        canonicalWineId: 'cw',
        ownerId: 'o',
        ownerRating: 5,
        ownerUpdatedAt: DateTime.utc(2026, 1, 1),
        memberModels: [
          member(userId: 'a', at: DateTime.utc(2026, 6, 1)),
          member(userId: 'b', at: DateTime.utc(2026, 3, 1)),
        ],
        profilesById: profiles({'o': 'O', 'a': 'A', 'b': 'B'}),
      );
      expect(out.map((r) => r.userId).toList(), ['a', 'b', 'o']);
    });

    test('attaches profile fields to each row, gracefully nulling missing', () {
      final out = mergeGroupRatings(
        groupId: 'g',
        canonicalWineId: 'cw',
        ownerId: null,
        ownerRating: null,
        ownerUpdatedAt: null,
        memberModels: [
          member(userId: 'has-profile'),
          member(userId: 'no-profile'),
        ],
        profilesById: profiles({'has-profile': 'Hp'}),
      );
      final hp = out.firstWhere((r) => r.userId == 'has-profile');
      final np = out.firstWhere((r) => r.userId == 'no-profile');
      expect(hp.displayName, 'Hp');
      expect(np.displayName, isNull);
      expect(np.username, isNull);
      expect(np.avatarUrl, isNull);
    });

    test('member-only path (no owner) returns members as-is', () {
      final out = mergeGroupRatings(
        groupId: 'g',
        canonicalWineId: 'cw',
        ownerId: null,
        ownerRating: null,
        ownerUpdatedAt: null,
        memberModels: [
          member(userId: 'a', rating: 6),
          member(userId: 'b', rating: 8),
        ],
        profilesById: profiles({'a': 'A', 'b': 'B'}),
      );
      expect(out, hasLength(2));
      expect(out.every((r) => r.isOwner), isFalse);
    });

    test('owner row with no profile still appears (just unnamed)', () {
      final out = mergeGroupRatings(
        groupId: 'g',
        canonicalWineId: 'cw',
        ownerId: 'lonely',
        ownerRating: 7,
        ownerUpdatedAt: DateTime.utc(2026),
        memberModels: const [],
        profilesById: const {},
      );
      expect(out, hasLength(1));
      expect(out.single.displayName, isNull);
      expect(out.single.isOwner, isTrue);
    });
  });
}
