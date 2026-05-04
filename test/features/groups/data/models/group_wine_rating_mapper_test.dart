import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/groups/data/models/group_wine_rating.model.dart';

void main() {
  GroupWineRatingModel sampleModel() => GroupWineRatingModel(
        groupId: 'g-1',
        canonicalWineId: 'cw-1',
        userId: 'u-1',
        rating: 8.5,
        notes: 'Lovely.',
        updatedAt: DateTime.utc(2026, 5, 4),
      );

  group('GroupWineRatingModel ↔ JSON', () {
    test('round-trips with snake_case keys', () {
      final json = sampleModel().toJson();
      expect(json.keys, containsAll([
        'group_id',
        'canonical_wine_id',
        'user_id',
        'updated_at',
      ]));
      expect(GroupWineRatingModel.fromJson(json), sampleModel());
    });

    test('notes is nullable', () {
      final m = GroupWineRatingModel.fromJson({
        'group_id': 'g',
        'canonical_wine_id': 'c',
        'user_id': 'u',
        'rating': 7.0,
        'updated_at': DateTime.utc(2026).toIso8601String(),
      });
      expect(m.notes, isNull);
    });
  });

  group('toEntity', () {
    test('forwards every model field and merges in profile fields', () {
      final e = sampleModel().toEntity(
        username: 'martin',
        displayName: 'Martin',
        avatarUrl: 'https://cdn/m.png',
      );
      expect(e.groupId, 'g-1');
      expect(e.canonicalWineId, 'cw-1');
      expect(e.userId, 'u-1');
      expect(e.rating, 8.5);
      expect(e.notes, 'Lovely.');
      expect(e.username, 'martin');
      expect(e.displayName, 'Martin');
      expect(e.avatarUrl, 'https://cdn/m.png');
      // isOwner default = false; only the merge logic in
      // groupWineRatings provider sets it true for the sharer.
      expect(e.isOwner, isFalse);
    });

    test('omits profile fields when none supplied', () {
      final e = sampleModel().toEntity();
      expect(e.username, isNull);
      expect(e.displayName, isNull);
      expect(e.avatarUrl, isNull);
    });
  });
}
