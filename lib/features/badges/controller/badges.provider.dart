import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/controller/auth.provider.dart';
import '../../wines/controller/wine.provider.dart' show appDatabaseProvider;
import '../data/data_sources/badges.api.dart';
import '../data/repositories/badges.repository.impl.dart';
import '../domain/entities/badge.entity.dart';
import '../domain/repositories/badges.repository.dart';

part 'badges.provider.g.dart';

@riverpod
BadgesApi badgesApi(BadgesApiRef ref) {
  return BadgesApi(ref.watch(supabaseClientProvider));
}

@riverpod
BadgesRepository badgesRepository(BadgesRepositoryRef ref) {
  return BadgesRepositoryImpl(
    api: ref.watch(badgesApiProvider),
    cacheDao: ref.watch(appDatabaseProvider).badgeProgressCacheDao,
  );
}

/// The signed-in user's full badge grid (earned + locked w/ progress).
@riverpod
class MyBadges extends _$MyBadges {
  @override
  Future<List<BadgeEntity>> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return const [];
    return ref.watch(badgesRepositoryProvider).getProgress(userId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) return const <BadgeEntity>[];
      await ref.read(badgesRepositoryProvider).evaluate();
      return ref.read(badgesRepositoryProvider).getProgress(userId);
    });
  }
}

/// Earned badges for any profile (own or a friend) — drives the showcase.
@riverpod
Future<List<BadgeEntity>> earnedBadges(
  EarnedBadgesRef ref,
  String userId,
) async {
  if (!ref.watch(isAuthenticatedProvider)) return const [];
  return ref.watch(badgesRepositoryProvider).getEarned(userId);
}

/// Newly-unlocked badges not yet celebrated. MainShell watches this and pops
/// the unlock overlay; dismissing calls [markSeen].
@riverpod
class BadgeUnlocks extends _$BadgeUnlocks {
  @override
  Future<List<BadgeEntity>> build() async {
    if (!ref.watch(isAuthenticatedProvider)) return const [];
    return ref.watch(badgesRepositoryProvider).getUnseen();
  }

  Future<void> markSeen(List<String> ids) async {
    if (ids.isEmpty) return;
    await ref.read(badgesRepositoryProvider).markSeen(ids);
    state = const AsyncData([]);
    // Own grid may now show them as earned.
    ref.invalidate(myBadgesProvider);
  }
}
