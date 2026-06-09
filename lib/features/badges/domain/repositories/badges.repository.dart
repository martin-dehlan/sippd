import '../entities/badge.entity.dart';

abstract class BadgesRepository {
  /// All badges + progress for [userId], local-first (cached payload served on
  /// RPC failure). Use for the signed-in user's own grid.
  Future<List<BadgeEntity>> getProgress(String userId);

  /// Earned badges only for [userId] (own or a friend). Friend rows come back
  /// earned-only from the RPC by RLS.
  Future<List<BadgeEntity>> getEarned(String userId);

  /// Newly-earned, not-yet-shown badges for the signed-in user.
  Future<List<BadgeEntity>> getUnseen();

  /// Mark the given badges as shown.
  Future<void> markSeen(List<String> badgeIds);

  /// Force a server-side re-evaluation; returns ids awarded this call.
  Future<List<String>> evaluate();
}
