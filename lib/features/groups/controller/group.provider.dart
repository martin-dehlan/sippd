import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../common/services/analytics/analytics.provider.dart';
import '../../../common/services/connectivity/connectivity.provider.dart';
import '../../auth/controller/auth.provider.dart';
import '../../onboarding/controller/onboarding.provider.dart';
import '../../../common/utils/name_normalizer.dart';
import '../../wines/controller/wine.provider.dart';
import '../../wines/data/models/wine.model.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../domain/entities/share_match_candidate.entity.dart';
import '../data/data_sources/group_image.service.dart';
import '../domain/entities/group.entity.dart';
import '../data/models/group.model.dart';
import 'group_wines_query.provider.dart';

// Re-export the split-out providers so consumers keep importing
// `group.provider.dart` as the single entry point. Once the team is
// comfortable, callers can switch to the narrower imports directly.
export 'group_ratings.provider.dart';
export 'group_wines_query.provider.dart';

part 'group.provider.g.dart';

@riverpod
class GroupController extends _$GroupController {
  @override
  Future<List<GroupEntity>> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return [];

    // Short-circuit when offline. Without this, the Supabase auth client
    // sits in an indefinite token-refresh retry loop and the group queries
    // never resolve, leaving the UI on a spinner forever. The provider
    // auto-rebuilds when connectivity returns.
    ref.requireOnline();

    final client = ref.read(supabaseClientProvider);

    // Realtime: when the user's membership row changes (join, leave, or
    // cascade-delete from a group being deleted on another device), refetch.
    // Using onPostgresChanges avoids the initial-snapshot emit that
    // .stream() would cause — no rebuild loop.
    final channel = client.channel('group_memberships_$userId');
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'group_members',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (_) => ref.invalidateSelf(),
        )
        .subscribe();
    ref.onDispose(() {
      client.removeChannel(channel);
    });

    final memberships = (await client
        .from('group_members')
        .select('group_id')
        .eq('user_id', userId)
        .withNetTimeout()) as List;

    if (memberships.isEmpty) return [];

    final groupIds =
        memberships.map((m) => m['group_id'] as String).toList();

    final groupsData = (await client
        .from('groups')
        .select()
        .inFilter('id', groupIds)
        .withNetTimeout()) as List;

    return groupsData
        .map((g) => GroupModel.fromJson(g).toEntity())
        .toList();
  }

  /// Creates a group and returns the inserted row so the caller can chain
  /// the invite-share sheet without re-fetching. Returns null only if the
  /// user is unauthenticated (caller skips the post-create UI).
  ///
  /// Insert and re-fetch run as two separate calls. Combining them with
  /// `.insert(...).select()` triggers the SELECT RLS policy on the same
  /// snapshot the INSERT was prepared on — before the AFTER-INSERT trigger
  /// `handle_new_group` adds the creator to `group_members` — which makes
  /// the row invisible to the SELECT policy and 42501s the whole call.
  /// A separate SELECT after the trigger has committed sees the membership.
  Future<GroupEntity?> createGroup(String name) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return null;

    final client = ref.read(supabaseClientProvider);

    await client.from('groups').insert({
      'name': name,
      'created_by': userId,
    });

    final row = await client
        .from('groups')
        .select()
        .eq('created_by', userId)
        .eq('name', name)
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    ref.read(analyticsProvider).capture('group_created');
    ref.invalidateSelf();
    if (row == null) return null;
    return GroupModel.fromJson(row).toEntity();
  }

  Future<void> joinGroup(String inviteCode) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    await client.rpc(
      'join_group_by_invite_code',
      params: {'p_code': inviteCode},
    );

    ref.read(analyticsProvider).capture(
      'group_joined',
      properties: const {'via': 'invite_code'},
    );
    ref.invalidateSelf();
  }

  /// Shares the personal wine [wineId] into [groupId] under its canonical
  /// identity. The personal wines row is upserted first so its
  /// canonical_wine_id is resolved by the wines_resolve_canonical_trigger.
  Future<void> shareWineToGroup(String groupId, String wineId) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    final wine = await ref.read(wineRepositoryProvider).getWineById(wineId);
    if (wine == null) return;
    final model = wine
        .copyWith(userId: userId, updatedAt: DateTime.now())
        .toModel();
    await client.from('wines').upsert(model.toJson());

    final canonicalId = wine.canonicalWineId ??
        (await client
            .from('wines')
            .select('canonical_wine_id')
            .eq('id', wineId)
            .maybeSingle())?['canonical_wine_id'] as String?;
    if (canonicalId == null) {
      throw Exception('Wine has no canonical identity yet — try again.');
    }

    await client.from('group_wines').upsert({
      'group_id': groupId,
      'canonical_wine_id': canonicalId,
      'shared_by': userId,
    }, onConflict: 'group_id,canonical_wine_id');
    ref.read(analyticsProvider).capture(
      'wine_shared_to_group',
      properties: const {'mode': 'local'},
    );
  }

  /// Shares an existing [canonicalWineId] into [groupId]. Used when the
  /// share sheet matched the wine to a canonical the user does not own
  /// locally (e.g. a friend's bottle).
  Future<void> shareCanonicalToGroup({
    required String groupId,
    required String canonicalWineId,
  }) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final client = ref.read(supabaseClientProvider);
    await client.from('group_wines').upsert({
      'group_id': groupId,
      'canonical_wine_id': canonicalWineId,
      'shared_by': userId,
    }, onConflict: 'group_id,canonical_wine_id');
    ref.read(analyticsProvider).capture(
      'wine_shared_to_group',
      properties: const {'mode': 'canonical'},
    );
  }

  /// Returns canonical wines already shared in [groupId] whose normalized
  /// name matches [localWine], excluding [localWine]'s own canonical.
  /// Each candidate carries the original sharer's username for the dedup
  /// dialog. Match key is now canonical_wine_id, so two members sharing
  /// the same bottle from their personal logs collapse to one candidate.
  Future<List<ShareMatchCandidate>> findShareMatchCandidates({
    required String groupId,
    required WineEntity localWine,
  }) async {
    final nameNorm = normalizeName(localWine.name);
    if (nameNorm.isEmpty) return const [];

    final client = ref.read(supabaseClientProvider);

    final shareRows = (await client
        .from('group_wines')
        .select('canonical_wine_id, shared_by')
        .eq('group_id', groupId)) as List;
    if (shareRows.isEmpty) return const [];

    final sharerByCanonical = <String, String>{};
    for (final r in shareRows) {
      final m = r as Map<String, dynamic>;
      sharerByCanonical[m['canonical_wine_id'] as String] =
          m['shared_by'] as String;
    }

    final sharedCanonicalIds = sharerByCanonical.keys
        .where((id) => id != localWine.canonicalWineId)
        .toList();
    if (sharedCanonicalIds.isEmpty) return const [];

    final canonicalRows = (await client
        .from('canonical_wine')
        .select('id, name, winery, region, country, type, vintage, name_norm')
        .inFilter('id', sharedCanonicalIds)
        .eq('name_norm', nameNorm)) as List;
    if (canonicalRows.isEmpty) return const [];

    final now = DateTime.now();
    final matches = canonicalRows.map((r) {
      final m = r as Map<String, dynamic>;
      final id = m['id'] as String;
      return WineEntity(
        id: id,
        name: (m['name'] as String?) ?? 'Unknown',
        rating: 0,
        type: _parseType(m['type'] as String?) ?? WineType.red,
        country: m['country'] as String?,
        region: m['region'] as String?,
        winery: m['winery'] as String?,
        vintage: m['vintage'] as int?,
        canonicalWineId: id,
        userId: '',
        createdAt: now,
      );
    }).toList();

    final sharerIds = matches
        .map((w) => sharerByCanonical[w.id])
        .whereType<String>()
        .toSet()
        .toList();
    final usernameById = <String, String>{};
    if (sharerIds.isNotEmpty) {
      final profiles = (await client
          .from('profiles')
          .select('id, username')
          .inFilter('id', sharerIds)) as List;
      for (final p in profiles) {
        final m = p as Map<String, dynamic>;
        final uname = m['username'] as String?;
        if (uname != null) usernameById[m['id'] as String] = uname;
      }
    }

    return matches
        .map((w) => ShareMatchCandidate(
              wine: w,
              sharedByUsername: usernameById[sharerByCanonical[w.id]],
            ))
        .toList();
  }

  Future<void> deleteGroup(String groupId) async {
    final client = ref.read(supabaseClientProvider);
    await client.from('groups').delete().eq('id', groupId);
    ref.read(analyticsProvider).capture('group_deleted');
    ref.invalidateSelf();
  }

  /// Removes the bottle identified by [canonicalWineId] from [groupId]. RLS
  /// restricts this to the original sharer and the group owner; other
  /// members get a permission error.
  Future<void> unshareWineFromGroup({
    required String groupId,
    required String canonicalWineId,
  }) async {
    final client = ref.read(supabaseClientProvider);
    final rows = await client
        .from('group_wines')
        .delete()
        .eq('group_id', groupId)
        .eq('canonical_wine_id', canonicalWineId)
        .select();
    if (rows.isEmpty) {
      throw Exception('You cannot remove this wine from the group.');
    }
    ref.invalidate(groupWinesProvider(groupId));
    ref.invalidate(groupWineShareMetaProvider(groupId, canonicalWineId));
  }

  Future<void> updateGroup({
    required String groupId,
    String? name,
    String? imageUrl,
    bool clearImage = false,
  }) async {
    final client = ref.read(supabaseClientProvider);
    final patch = <String, dynamic>{};
    if (name != null) patch['name'] = name;
    if (clearImage) {
      patch['image_url'] = null;
    } else if (imageUrl != null) {
      patch['image_url'] = imageUrl;
    }
    if (patch.isEmpty) return;
    final rows = await client
        .from('groups')
        .update(patch)
        .eq('id', groupId)
        .select();
    if (rows.isEmpty) {
      throw Exception('You do not have permission to edit this group.');
    }
    ref.invalidateSelf();
    ref.invalidate(groupDetailProvider(groupId));
  }

  Future<void> leaveGroup(String groupId) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final client = ref.read(supabaseClientProvider);

    await client
        .from('group_members')
        .delete()
        .eq('group_id', groupId)
        .eq('user_id', userId);

    ref.read(analyticsProvider).capture('group_left');
    ref.invalidateSelf();
  }
}

// ========================================
// SORT STATE
// ========================================

enum GroupSortMode { recent, name }

const _groupSortModeKey = 'group_sort_mode';

@riverpod
class GroupSort extends _$GroupSort {
  @override
  GroupSortMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final stored = prefs.getString(_groupSortModeKey);
    return GroupSortMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => GroupSortMode.recent,
    );
  }

  Future<void> toggle() async {
    final next = state == GroupSortMode.recent
        ? GroupSortMode.name
        : GroupSortMode.recent;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_groupSortModeKey, next.name);
    state = next;
  }
}

@riverpod
GroupImageService groupImageService(GroupImageServiceRef ref) {
  final client = ref.read(supabaseClientProvider);
  return GroupImageService(client);
}

WineType? _parseType(String? raw) {
  if (raw == null) return null;
  for (final t in WineType.values) {
    if (t.name == raw) return t;
  }
  return null;
}

