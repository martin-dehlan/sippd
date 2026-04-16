import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/friends.provider.dart';
import '../../widgets/activity_feed_tab.widget.dart';
import '../../widgets/friend_requests_tab.widget.dart';
import '../../widgets/friend_search_tab.widget.dart';
import '../../widgets/friends_list_tab.widget.dart';

class FriendsScreen extends ConsumerWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final requestsAsync = ref.watch(incomingFriendRequestsProvider);
    final pendingCount = requestsAsync.valueOrNull?.length ?? 0;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.paddingH, vertical: context.s),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => context.pop(),
                    ),
                    Text('Friends',
                        style: TextStyle(
                            fontSize: context.titleFont,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5)),
                  ],
                ),
              ),
              TabBar(
                labelColor: cs.primary,
                unselectedLabelColor: cs.onSurfaceVariant,
                indicatorColor: cs.primary,
                labelStyle: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600),
                tabs: [
                  const Tab(text: 'Feed'),
                  const Tab(text: 'Friends'),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Requests'),
                        if (pendingCount > 0) ...[
                          SizedBox(width: context.w * 0.015),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.w * 0.015,
                                vertical: context.xs * 0.3),
                            decoration: BoxDecoration(
                              color: cs.primary,
                              borderRadius:
                                  BorderRadius.circular(context.w * 0.02),
                            ),
                            child: Text('$pendingCount',
                                style: TextStyle(
                                    fontSize: context.captionFont * 0.8,
                                    fontWeight: FontWeight.w700,
                                    color: cs.onPrimary)),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Tab(text: 'Search'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ActivityFeedTab(),
                    FriendsListTab(),
                    FriendRequestsTab(),
                    FriendSearchTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
