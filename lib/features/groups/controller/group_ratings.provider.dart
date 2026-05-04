import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/services/analytics/analytics.provider.dart';
import '../../../common/services/connectivity/connectivity.provider.dart';
import '../../auth/controller/auth.provider.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../data/models/group_wine_rating.model.dart';
import '../domain/entities/group_wine_rating.entity.dart';
import 'group_wines_query.provider.dart';

part 'group_ratings.provider.g.dart';

/// All member ratings + the owner's personal rating for a single bottle
/// inside a group. Owner row is synthesized from the local `wines` mirror
/// (or remote fallback) so it stays in lockstep with the wine-detail
/// rating, then merged with `group_wine_ratings` rows from other members.
@riverpod
Future<List<GroupWineRatingEntity>> groupWineRatings(
    GroupWineRatingsRef ref, String groupId, String canonicalWineId) async {
  ref.requireOnline();
  final client = ref.read(supabaseClientProvider);

  // Owner = the original sharer of the bottle in this group.
  final shareRow = await client
      .from('group_wines')
      .select('shared_by')
      .eq('group_id', groupId)
      .eq('canonical_wine_id', canonicalWineId)
      .maybeSingle();
  final ownerId = shareRow?['shared_by'] as String?;

  // Pull the owner's personal log for this canonical so their rating
  // tracks `wines.rating` directly. Local-first: prefer the cached
  // wines stream so owner edits show up instantly.
  final localWines = ref.watch(wineControllerProvider).valueOrNull ?? const [];
  WineEntity? ownerLocal;
  for (final w in localWines) {
    if (w.canonicalWineId == canonicalWineId &&
        (ownerId == null || w.userId == ownerId)) {
      ownerLocal = w;
      break;
    }
  }
  double? ownerRating = ownerLocal?.rating;
  DateTime? ownerUpdated = ownerLocal?.updatedAt;
  if (ownerId != null && ownerLocal == null) {
    final wineRow = await client
        .from('wines')
        .select('rating, updated_at, created_at')
        .eq('canonical_wine_id', canonicalWineId)
        .eq('user_id', ownerId)
        .maybeSingle();
    ownerRating = (wineRow?['rating'] as num?)?.toDouble();
    final raw = (wineRow?['updated_at'] as String?) ??
        (wineRow?['created_at'] as String?);
    if (raw != null) ownerUpdated = DateTime.tryParse(raw);
  }

  final memberRows = (await client
      .from('group_wine_ratings')
      .select()
      .eq('group_id', groupId)
      .eq('canonical_wine_id', canonicalWineId)) as List;

  final memberModels = memberRows
      .map((r) => GroupWineRatingModel.fromJson(r as Map<String, dynamic>))
      .where((m) => m.userId != ownerId)
      .toList();

  final userIds = <String>{
    ...memberModels.map((m) => m.userId),
    ?ownerId,
  }.toList();
  if (userIds.isEmpty) return const [];

  final profileRows = (await client
      .from('profiles')
      .select('id, username, display_name, avatar_url')
      .inFilter('id', userIds)) as List;
  final profiles = {
    for (final p in profileRows)
      (p as Map<String, dynamic>)['id'] as String: p,
  };

  return mergeGroupRatings(
    groupId: groupId,
    canonicalWineId: canonicalWineId,
    ownerId: ownerId,
    ownerRating: ownerRating,
    ownerUpdatedAt: ownerUpdated,
    memberModels: memberModels,
    profilesById: profiles.cast<String, Map<String, dynamic>>(),
  );
}

/// Pure merge: combine the owner's personal rating with the
/// `group_wine_ratings` member rows, attach profile info, sort by
/// recency. Extracted so the merge rules can be tested without
/// standing up a Supabase client.
List<GroupWineRatingEntity> mergeGroupRatings({
  required String groupId,
  required String canonicalWineId,
  required String? ownerId,
  required double? ownerRating,
  required DateTime? ownerUpdatedAt,
  required List<GroupWineRatingModel> memberModels,
  required Map<String, Map<String, dynamic>> profilesById,
}) {
  final list = <GroupWineRatingEntity>[];
  if (ownerId != null && ownerRating != null) {
    final p = profilesById[ownerId];
    list.add(GroupWineRatingEntity(
      groupId: groupId,
      canonicalWineId: canonicalWineId,
      userId: ownerId,
      rating: ownerRating,
      updatedAt: ownerUpdatedAt ?? DateTime.now(),
      username: p?['username'] as String?,
      displayName: p?['display_name'] as String?,
      avatarUrl: p?['avatar_url'] as String?,
      isOwner: true,
    ));
  }
  list.addAll(memberModels
      .where((m) => m.userId != ownerId)
      .map((m) {
    final p = profilesById[m.userId];
    return m.toEntity(
      username: p?['username'] as String?,
      displayName: p?['display_name'] as String?,
      avatarUrl: p?['avatar_url'] as String?,
    );
  }));
  list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return list;
}

@riverpod
class GroupWineRatingController extends _$GroupWineRatingController {
  @override
  FutureOr<void> build() {}

  Future<void> upsertRating({
    required String groupId,
    required String canonicalWineId,
    required double rating,
    String? notes,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final client = ref.read(supabaseClientProvider);
    await client.from('group_wine_ratings').upsert({
      'group_id': groupId,
      'canonical_wine_id': canonicalWineId,
      'user_id': userId,
      'rating': rating,
      'notes': notes,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'group_id,canonical_wine_id,user_id');
    ref.read(analyticsProvider).capture(
      'group_rating_submitted',
      properties: {
        'rating': rating,
        'has_notes': (notes ?? '').isNotEmpty,
      },
    );
    ref.invalidate(groupWineRatingsProvider(groupId, canonicalWineId));
    ref.invalidate(groupWineRanksProvider(groupId));
  }

  Future<void> deleteRating({
    required String groupId,
    required String canonicalWineId,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final client = ref.read(supabaseClientProvider);
    await client
        .from('group_wine_ratings')
        .delete()
        .eq('group_id', groupId)
        .eq('canonical_wine_id', canonicalWineId)
        .eq('user_id', userId);
    ref.invalidate(groupWineRatingsProvider(groupId, canonicalWineId));
    ref.invalidate(groupWineRanksProvider(groupId));
  }
}

/// Map from canonical_wine_id → 1-based rank inside [groupId], averaged
/// across owner + member ratings. Ties share a rank.
@riverpod
Future<Map<String, int>> groupWineRanks(
    GroupWineRanksRef ref, String groupId) async {
  final wines = await ref.watch(groupWinesProvider(groupId).future);
  if (wines.isEmpty) return const {};
  ref.requireOnline();
  final client = ref.read(supabaseClientProvider);
  final canonicalIds = <String>[
    for (final w in wines)
      if (w.canonicalWineId != null) w.canonicalWineId!,
  ];
  if (canonicalIds.isEmpty) return const {};

  final ratingRows = (await client
      .from('group_wine_ratings')
      .select('canonical_wine_id, user_id, rating')
      .eq('group_id', groupId)
      .inFilter('canonical_wine_id', canonicalIds)) as List;

  return computeGroupWineRanks(
    wines: wines,
    memberRatings: [
      for (final row in ratingRows)
        MemberRatingRow(
          canonicalWineId:
              (row as Map<String, dynamic>)['canonical_wine_id'] as String,
          userId: row['user_id'] as String,
          rating: (row['rating'] as num).toDouble(),
        ),
    ],
  );
}

/// Single member rating extracted into a value type so [computeGroupWineRanks]
/// can be tested without mocking Supabase row shapes.
class MemberRatingRow {
  const MemberRatingRow({
    required this.canonicalWineId,
    required this.userId,
    required this.rating,
  });
  final String canonicalWineId;
  final String userId;
  final double rating;
}

/// Pure rank computation. Owner rating (from each wine's local row)
/// counts exactly once; member rows from the same owner are dropped to
/// avoid double-counting. Ties share a rank.
Map<String, int> computeGroupWineRanks({
  required List<WineEntity> wines,
  required List<MemberRatingRow> memberRatings,
}) {
  final ownerByCanonical = <String, String>{
    for (final w in wines)
      if (w.canonicalWineId != null) w.canonicalWineId!: w.userId,
  };
  final perWine = <String, List<double>>{};
  for (final w in wines) {
    final cid = w.canonicalWineId;
    if (cid == null) continue;
    perWine[cid] = [w.rating];
  }
  for (final r in memberRatings) {
    if (r.userId == ownerByCanonical[r.canonicalWineId]) continue;
    perWine.putIfAbsent(r.canonicalWineId, () => []).add(r.rating);
  }
  final avgByWine = <String, double>{
    for (final e in perWine.entries)
      if (e.value.isNotEmpty)
        e.key: e.value.reduce((a, b) => a + b) / e.value.length,
  };
  final sorted = avgByWine.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  final ranks = <String, int>{};
  int prevRank = 0;
  double? prevAvg;
  for (var i = 0; i < sorted.length; i++) {
    final e = sorted[i];
    final rank = (prevAvg != null && prevAvg == e.value) ? prevRank : i + 1;
    ranks[e.key] = rank;
    prevRank = rank;
    prevAvg = e.value;
  }
  return ranks;
}
