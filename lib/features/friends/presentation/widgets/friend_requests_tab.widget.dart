import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/friends.provider.dart';
import '../../domain/entities/friend_request.entity.dart';
import 'friend_avatar.widget.dart';

class FriendRequestsTab extends ConsumerWidget {
  const FriendRequestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final requestsAsync = ref.watch(incomingFriendRequestsProvider);

    return requestsAsync.when(
      data: (requests) {
        if (requests.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mark_email_read_outlined,
                    size: context.w * 0.18, color: cs.outline),
                SizedBox(height: context.m),
                Text('No pending requests',
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        color: cs.onSurfaceVariant)),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: context.paddingH, vertical: context.m),
          itemCount: requests.length,
          separatorBuilder: (_, __) => SizedBox(height: context.s),
          itemBuilder: (_, i) => _RequestRow(request: requests[i]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
          child: Text('Error: $e',
              style: TextStyle(
                  fontSize: context.bodyFont, color: cs.error))),
    );
  }
}

class _RequestRow extends ConsumerWidget {
  final FriendRequestEntity request;
  const _RequestRow({required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final profile = request.senderProfile;
    final name = profile?.displayName ?? profile?.username ?? 'Unknown';

    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        children: [
          if (profile != null)
            FriendAvatar(profile: profile, size: context.w * 0.12)
          else
            Icon(Icons.person, size: context.w * 0.12, color: cs.outline),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
                Text('wants to be friends',
                    style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.check_circle,
                color: cs.primary, size: context.w * 0.07),
            onPressed: () => ref
                .read(friendsControllerProvider.notifier)
                .acceptRequest(request.id),
          ),
          IconButton(
            icon: Icon(Icons.cancel_outlined,
                color: cs.outline, size: context.w * 0.07),
            onPressed: () => ref
                .read(friendsControllerProvider.notifier)
                .declineRequest(request.id),
          ),
        ],
      ),
    );
  }
}
