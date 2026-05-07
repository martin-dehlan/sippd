import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/services/connectivity/connectivity.provider.dart';
import '../../auth/controller/auth.provider.dart';
import '../../friends/data/models/friend_profile.model.dart';
import '../../friends/domain/entities/friend_profile.entity.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../data/models/group.model.dart';
import '../domain/entities/group.entity.dart';
import '../domain/entities/group_wine_share.entity.dart';

part 'group_wines_query.provider.g.dart';

/// Single group's metadata. Network-only — the list provider has the
/// realtime invalidation hook, this is just a one-off lookup.
@riverpod
Future<GroupEntity?> groupDetail(GroupDetailRef ref, String groupId) async {
  ref.requireOnline();
  final client = ref.read(supabaseClientProvider);
  final row = await client
      .from('groups')
      .select()
      .eq('id', groupId)
      .maybeSingle()
      .withNetTimeout();
  if (row == null) return null;
  return GroupModel.fromJson(row).toEntity();
}

@riverpod
Future<List<FriendProfileEntity>> groupMembers(
  GroupMembersRef ref,
  String groupId,
) async {
  ref.requireOnline();
  final client = ref.read(supabaseClientProvider);
  final memberRows =
      (await client
              .from('group_members')
              .select('user_id, role')
              .eq('group_id', groupId)
              .withNetTimeout())
          as List;
  if (memberRows.isEmpty) return const [];
  final ids = memberRows
      .map((m) => (m as Map<String, dynamic>)['user_id'] as String)
      .toList();
  final profileRows =
      (await client
              .from('profiles')
              .select()
              .inFilter('id', ids)
              .withNetTimeout())
          as List;
  return profileRows
      .map(
        (p) =>
            FriendProfileModel.fromJson(p as Map<String, dynamic>).toEntity(),
      )
      .toList();
}

/// Wines shared into [groupId]. Returned entities are catalog-keyed:
/// `id` is the canonical_wine.id and `userId` is the original sharer
/// (so downstream can compute "is owner"). Personal log fields (rating,
/// notes, photos) come from the local `wines` mirror when the caller
/// owns the bottle, otherwise from the canonical_wine catalog.
@riverpod
Future<List<WineEntity>> groupWines(GroupWinesRef ref, String groupId) async {
  // Re-run whenever local wines change so owner edits propagate instantly.
  final localWines = ref.watch(wineControllerProvider).valueOrNull ?? const [];
  final localByCanonical = <String, WineEntity>{
    for (final w in localWines)
      if (w.canonicalWineId != null) w.canonicalWineId!: w,
  };

  ref.requireOnline();
  final client = ref.read(supabaseClientProvider);
  final shareRows =
      (await client
              .from('group_wines')
              .select('canonical_wine_id, shared_by, shared_at')
              .eq('group_id', groupId)
              .order('shared_at', ascending: false))
          as List;
  if (shareRows.isEmpty) return const [];

  final orderedCanonicalIds = <String>[];
  final sharerByCanonical = <String, String>{};
  for (final s in shareRows) {
    final m = s as Map<String, dynamic>;
    final cid = m['canonical_wine_id'] as String;
    orderedCanonicalIds.add(cid);
    sharerByCanonical[cid] = m['shared_by'] as String;
  }

  // Hydrate metadata from canonical_wine catalog for any bottle the
  // caller does not own locally.
  final missing = orderedCanonicalIds
      .where((cid) => !localByCanonical.containsKey(cid))
      .toSet()
      .toList();
  final canonicalById = <String, Map<String, dynamic>>{};
  // image_url lives on the original sharer's `wines` row, not on
  // canonical_wine — fetch it separately so other group members see
  // the photo too. RLS policy `wines_select_shared` already allows
  // group members to read these rows by canonical_wine_id.
  final imageUrlByCanonical = <String, String>{};
  if (missing.isNotEmpty) {
    final canonicalRows =
        (await client
                .from('canonical_wine')
                .select(
                  'id, name, winery, region, country, type, vintage, canonical_grape_id',
                )
                .inFilter('id', missing))
            as List;
    for (final r in canonicalRows) {
      final m = r as Map<String, dynamic>;
      canonicalById[m['id'] as String] = m;
    }
    final wineRows =
        (await client
                .from('wines')
                .select('canonical_wine_id, image_url, updated_at')
                .inFilter('canonical_wine_id', missing)
                .not('image_url', 'is', null))
            as List;
    // Multiple users may have a personal wines row for the same
    // canonical bottle — prefer the most recently updated one's image.
    for (final r in wineRows) {
      final m = r as Map<String, dynamic>;
      final cid = m['canonical_wine_id'] as String;
      final url = m['image_url'] as String?;
      if (url == null || url.isEmpty) continue;
      if (!imageUrlByCanonical.containsKey(cid)) {
        imageUrlByCanonical[cid] = url;
      }
    }
  }

  final now = DateTime.now();
  final out = <WineEntity>[];
  for (final cid in orderedCanonicalIds) {
    final local = localByCanonical[cid];
    if (local != null) {
      // Caller owns this bottle — surface their personal log row
      // unchanged (id = personal wines.id) so the wine-detail and
      // wine-edit screens continue to resolve. Group-side providers
      // key off `canonicalWineId` (always present on the entity), so
      // they don't depend on `id` being canonical.
      out.add(local);
      continue;
    }
    final m = canonicalById[cid];
    if (m == null) continue;
    out.add(
      WineEntity(
        id: cid,
        name: (m['name'] as String?) ?? 'Unknown',
        rating: 0,
        type: _parseType(m['type'] as String?) ?? WineType.red,
        country: m['country'] as String?,
        region: m['region'] as String?,
        winery: m['winery'] as String?,
        vintage: m['vintage'] as int?,
        imageUrl: imageUrlByCanonical[cid],
        canonicalWineId: cid,
        canonicalGrapeId: m['canonical_grape_id'] as String?,
        userId: sharerByCanonical[cid] ?? '',
        createdAt: now,
      ),
    );
  }
  return out;
}

WineType? _parseType(String? raw) {
  if (raw == null) return null;
  for (final t in WineType.values) {
    if (t.name == raw) return t;
  }
  return null;
}

/// Returns who originally shared [canonicalWineId] into [groupId].
/// Used to decide who can unshare it (sharer + group owner).
@riverpod
Future<String?> groupWineShareMeta(
  GroupWineShareMetaRef ref,
  String groupId,
  String canonicalWineId,
) async {
  final client = ref.read(supabaseClientProvider);
  final row = await client
      .from('group_wines')
      .select('shared_by')
      .eq('group_id', groupId)
      .eq('canonical_wine_id', canonicalWineId)
      .maybeSingle();
  return row?['shared_by'] as String?;
}

/// Sharer profile + when the bottle was shared into [groupId]. Used by
/// the group wine detail screen to show "shared by @user · X ago".
@riverpod
Future<GroupWineShareEntity?> groupWineShareDetails(
  GroupWineShareDetailsRef ref,
  String groupId,
  String canonicalWineId,
) async {
  ref.requireOnline();
  final client = ref.read(supabaseClientProvider);
  final shareRow = await client
      .from('group_wines')
      .select('shared_by, shared_at')
      .eq('group_id', groupId)
      .eq('canonical_wine_id', canonicalWineId)
      .maybeSingle();
  if (shareRow == null) return null;
  final sharerId = shareRow['shared_by'] as String?;
  final sharedAtRaw = shareRow['shared_at'] as String?;
  if (sharerId == null || sharedAtRaw == null) return null;

  final profileRow = await client
      .from('profiles')
      .select('id, username, display_name, avatar_url')
      .eq('id', sharerId)
      .maybeSingle();
  if (profileRow == null) return null;

  return GroupWineShareEntity(
    sharer: FriendProfileEntity(
      id: profileRow['id'] as String,
      username: profileRow['username'] as String?,
      displayName: profileRow['display_name'] as String?,
      avatarUrl: profileRow['avatar_url'] as String?,
    ),
    sharedAt: DateTime.parse(sharedAtRaw),
  );
}

/// Set of group IDs that already contain the canonical bottle for
/// the personal wine [wineId]. Used by the share sheet to mark groups
/// that already received this wine.
@riverpod
Future<Set<String>> groupsContainingWine(
  GroupsContainingWineRef ref,
  String wineId,
) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return const {};

  final wine = await ref.read(wineRepositoryProvider).getWineById(wineId);
  final canonicalId = wine?.canonicalWineId;
  if (canonicalId == null) return const {};

  final client = ref.read(supabaseClientProvider);
  final rows = await client
      .from('group_wines')
      .select('group_id')
      .eq('canonical_wine_id', canonicalId);
  return (rows as List)
      .map((r) => (r as Map<String, dynamic>)['group_id'] as String)
      .toSet();
}
