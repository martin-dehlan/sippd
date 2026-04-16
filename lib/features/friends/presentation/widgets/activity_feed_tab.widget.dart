import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../controller/friends.provider.dart';
import '../../domain/entities/activity_item.entity.dart';
import '../../domain/entities/friend_profile.entity.dart';
import 'friend_avatar.widget.dart';

class ActivityFeedTab extends ConsumerWidget {
  const ActivityFeedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final feedAsync = ref.watch(activityFeedProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(activityFeedProvider),
      child: feedAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return ListView(
              children: [
                SizedBox(height: context.h * 0.15),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wine_bar_outlined,
                          size: context.w * 0.18, color: cs.outline),
                      SizedBox(height: context.m),
                      Text('No activity yet',
                          style: TextStyle(
                              fontSize: context.bodyFont,
                              color: cs.onSurfaceVariant)),
                      SizedBox(height: context.xs),
                      Text('Add some friends to see what they taste.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.captionFont,
                              color: cs.outline)),
                    ],
                  ),
                ),
              ],
            );
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal: context.paddingH, vertical: context.m),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(height: context.s),
            itemBuilder: (_, i) => _ActivityCard(item: items[i]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Error: $e',
              style: TextStyle(fontSize: context.bodyFont, color: cs.error)),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final ActivityItemEntity item;
  const _ActivityCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final typeColor = switch (item.wine.type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
    };

    return GestureDetector(
      onTap: () => context.push(AppRoutes.friendProfilePath(item.friend.id)),
      child: Container(
        padding: EdgeInsets.all(context.w * 0.04),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderRow(friend: item.friend, createdAt: item.wine.createdAt),
            SizedBox(height: context.m),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: context.w * 0.025,
                  height: context.w * 0.12,
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(context.w * 0.01),
                  ),
                ),
                SizedBox(width: context.w * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.wine.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: context.bodyFont * 1.05,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.xs * 0.4),
                      Text(
                        [
                          if (item.wine.vintage != null)
                            item.wine.vintage.toString(),
                          if (item.wine.country != null) item.wine.country,
                        ].join(' · '),
                        style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(item.wine.rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: context.headingFont * 1.2,
                          fontWeight: FontWeight.bold,
                          color: cs.primary,
                        )),
                    Text('/ 10',
                        style: TextStyle(
                            fontSize: context.captionFont * 0.9,
                            color: cs.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final FriendProfileEntity friend;
  final DateTime createdAt;
  const _HeaderRow({required this.friend, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final name = friend.displayName ?? friend.username ?? 'Friend';
    return Row(
      children: [
        FriendAvatar(profile: friend, size: context.w * 0.08),
        SizedBox(width: context.w * 0.03),
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(name,
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ),
              SizedBox(width: context.w * 0.015),
              Text('rated a wine',
                  style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant)),
            ],
          ),
        ),
        Text(_timeAgo(createdAt),
            style: TextStyle(
                fontSize: context.captionFont * 0.9, color: cs.outline)),
      ],
    );
  }

  String _timeAgo(DateTime t) {
    final d = DateTime.now().difference(t);
    if (d.inMinutes < 60) return '${d.inMinutes}m';
    if (d.inHours < 24) return '${d.inHours}h';
    if (d.inDays < 7) return '${d.inDays}d';
    return DateFormat.yMMMd().format(t);
  }
}
