import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/controller/auth.provider.dart';
import '../data/data_sources/friend_ratings.api.dart';
import '../data/models/friend_rating.model.dart';
import '../domain/entities/friend_rating.entity.dart';

part 'friend_ratings.provider.g.dart';

@riverpod
FriendRatingsApi? friendRatingsApi(FriendRatingsApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return FriendRatingsApi(client);
}

/// Friends who have rated the canonical wine. Empty list when no auth or
/// no overlap. Network-only — friend data is not cached in Drift (privacy
/// + freshness wins over local-first for non-owned rows).
@riverpod
Future<List<FriendRatingEntity>> friendRatingsForCanonicalWine(
  FriendRatingsForCanonicalWineRef ref,
  String canonicalWineId,
) async {
  final api = ref.watch(friendRatingsApiProvider);
  if (api == null) return const [];
  final models = await api.getForCanonicalWine(canonicalWineId);
  return models.map((m) => m.toEntity()).toList(growable: false);
}
