import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/groups/controller/group_ratings.provider.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

void main() {
  WineEntity wine({
    required String id,
    required String userId,
    required double rating,
    String? cid,
  }) =>
      WineEntity(
        id: id,
        name: id,
        rating: rating,
        type: WineType.red,
        userId: userId,
        canonicalWineId: cid ?? id,
        createdAt: DateTime(2026),
      );

  group('computeGroupWineRanks', () {
    test('owner-only: rank order matches descending rating', () {
      final ranks = computeGroupWineRanks(
        wines: [
          wine(id: 'a', userId: 'u-a', rating: 6),
          wine(id: 'b', userId: 'u-b', rating: 9),
          wine(id: 'c', userId: 'u-c', rating: 7),
        ],
        memberRatings: const [],
      );
      expect(ranks, {'b': 1, 'c': 2, 'a': 3});
    });

    test('drops wines without canonical_wine_id', () {
      final ranks = computeGroupWineRanks(
        wines: [
          WineEntity(
            id: 'no-canon',
            name: '',
            rating: 9,
            type: WineType.red,
            userId: 'u',
            createdAt: DateTime(2026),
          ),
          wine(id: 'a', userId: 'u-a', rating: 7),
        ],
        memberRatings: const [],
      );
      expect(ranks.keys, ['a']);
    });

    test('member ratings raise the average — non-owner', () {
      // Wine "a" owner rates 4. One non-owner adds 10 → avg = 7.
      // Wine "b" owner rates 7 (no members) → avg = 7.
      // Tie → both share rank 1.
      final ranks = computeGroupWineRanks(
        wines: [
          wine(id: 'a', userId: 'owner-a', rating: 4),
          wine(id: 'b', userId: 'owner-b', rating: 7),
        ],
        memberRatings: [
          const MemberRatingRow(
            canonicalWineId: 'a',
            userId: 'm-1',
            rating: 10,
          ),
        ],
      );
      expect(ranks, {'a': 1, 'b': 1});
    });

    test('owner-as-member rating is dropped (no double count)', () {
      // Owner of "a" wrote BOTH wines.rating (8) and a group_wine_rating
      // row (2). The duplicate from the owner must be ignored.
      final ranks = computeGroupWineRanks(
        wines: [
          wine(id: 'a', userId: 'owner-a', rating: 8),
        ],
        memberRatings: [
          const MemberRatingRow(
            canonicalWineId: 'a',
            userId: 'owner-a',
            rating: 2,
          ),
        ],
      );
      // Only the owner's wines.rating (8) survives.
      expect(ranks, {'a': 1});
    });

    test('ties share a rank, next slot skips appropriately', () {
      // Three wines: 9, 9, 6 → ranks 1, 1, 3.
      final ranks = computeGroupWineRanks(
        wines: [
          wine(id: 'a', userId: 'u-a', rating: 9),
          wine(id: 'b', userId: 'u-b', rating: 9),
          wine(id: 'c', userId: 'u-c', rating: 6),
        ],
        memberRatings: const [],
      );
      expect(ranks['a'], 1);
      expect(ranks['b'], 1);
      expect(ranks['c'], 3);
    });

    test('empty input returns empty map', () {
      expect(
        computeGroupWineRanks(wines: const [], memberRatings: const []),
        isEmpty,
      );
    });
  });
}
