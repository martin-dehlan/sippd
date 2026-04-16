import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../controller/friends.provider.dart';
import '../../domain/entities/friend_profile.entity.dart';
import 'friend_avatar.widget.dart';

class FriendsListTab extends ConsumerWidget {
  const FriendsListTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final friendsAsync = ref.watch(friendsListProvider);

    return friendsAsync.when(
      data: (friends) {
        if (friends.isEmpty) {
          return _Empty(
            icon: Icons.people_outline,
            text: 'No friends yet.\nUse search to add some.',
          );
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: context.paddingH, vertical: context.m),
          itemCount: friends.length,
          separatorBuilder: (_, __) => SizedBox(height: context.s),
          itemBuilder: (_, i) => _FriendRow(
            friend: friends[i],
            onTap: () =>
                context.push(AppRoutes.friendProfilePath(friends[i].id)),
            onRemove: () => _confirmRemove(context, ref, friends[i]),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text('Error: $e',
            style: TextStyle(
                fontSize: context.bodyFont, color: cs.error)),
      ),
    );
  }

  Future<void> _confirmRemove(
      BuildContext context, WidgetRef ref, FriendProfileEntity f) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove friend?'),
        content: Text('Remove ${f.displayName ?? f.username ?? 'this user'} from your friends?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Remove')),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(friendsControllerProvider.notifier).removeFriend(f.id);
    }
  }
}

class _FriendRow extends StatelessWidget {
  final FriendProfileEntity friend;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  const _FriendRow({
    required this.friend,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04, vertical: context.m),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        children: [
          FriendAvatar(profile: friend, size: context.w * 0.12),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.displayName ?? friend.username ?? 'Unknown',
                  style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                if (friend.username != null)
                  Text(
                    '@${friend.username}',
                    style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_remove_outlined,
                color: cs.outline, size: context.w * 0.05),
            onPressed: onRemove,
          ),
        ],
      ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Empty({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.w * 0.18, color: cs.outline),
          SizedBox(height: context.m),
          Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: context.bodyFont,
                  color: cs.onSurfaceVariant,
                  height: 1.4)),
        ],
      ),
    );
  }
}
