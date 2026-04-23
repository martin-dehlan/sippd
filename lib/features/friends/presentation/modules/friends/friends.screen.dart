import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/friends.provider.dart';
import '../../../domain/entities/friend_profile.entity.dart';
import '../../../domain/entities/friend_request.entity.dart';
import '../../widgets/friend_avatar.widget.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({super.key});

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    final trimmed = value.trim();
    setState(() => _query = trimmed);
    if (trimmed.isEmpty) {
      ref.read(friendSearchControllerProvider.notifier).clear();
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () {
      ref.read(friendSearchControllerProvider.notifier).search(trimmed);
    });
  }

  void _focusSearch() => _searchFocus.requestFocus();

  @override
  Widget build(BuildContext context) {
    final padH = context.paddingH * 1.3;
    final searchMode = _query.isNotEmpty;
    final friends =
        ref.watch(friendsListProvider).valueOrNull ?? const [];
    final requests =
        ref.watch(incomingFriendRequestsProvider).valueOrNull ?? const [];
    final showEmpty = !searchMode && friends.isEmpty && requests.isEmpty;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(friendsListProvider);
            ref.invalidate(incomingFriendRequestsProvider);
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: context.xl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padH),
                child: Text(
                  'FRIENDS',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 1.3,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.05,
                  ),
                ),
              ),
              SizedBox(height: context.xs),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padH),
                child: Text(
                  'Taste with people you know',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(height: context.l),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padH),
                child: _SearchField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  onChanged: _onSearchChanged,
                ),
              ),
              SizedBox(height: context.m),
              if (searchMode)
                const _SearchResultsSection()
              else if (showEmpty)
                _EmptyFriendsState(onFindFriends: _focusSearch)
              else ...[
                const _RequestsSection(),
                const _FriendsSection(),
              ],
              SizedBox(height: context.xl * 2),
            ],
          ),
        ),
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  const _FloatingBackButton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'friends-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => context.pop(),
        child: Icon(Icons.arrow_back_ios_new, size: context.w * 0.06),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String> onChanged;
  const _SearchField({
    required this.controller,
    required this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search by username or name',
        prefixIcon: Icon(Icons.search, color: cs.primary),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.close, size: context.w * 0.05),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              ),
        filled: true,
        fillColor: cs.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.bodyFont,
          fontWeight: FontWeight.w700,
          color: cs.onSurface,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}

class _SearchResultsSection extends ConsumerWidget {
  const _SearchResultsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final resultsAsync = ref.watch(friendSearchControllerProvider);
    return resultsAsync.when(
      data: (results) {
        if (results.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.paddingH * 1.3, vertical: context.l),
            child: Text('No users found',
                style: TextStyle(
                    fontSize: context.bodyFont,
                    color: cs.onSurfaceVariant)),
          );
        }
        return Column(
          children: [
            for (final p in results)
              Padding(
                padding: EdgeInsets.fromLTRB(
                    context.paddingH * 1.3,
                    0,
                    context.paddingH * 1.3,
                    context.s),
                child: _SearchResultRow(profile: p),
              ),
          ],
        );
      },
      loading: () => Padding(
        padding: EdgeInsets.all(context.l),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: EdgeInsets.all(context.l),
        child: Text('Error: $e',
            style: TextStyle(color: cs.error, fontSize: context.bodyFont)),
      ),
    );
  }
}

class _RequestsSection extends ConsumerWidget {
  const _RequestsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(incomingFriendRequestsProvider);
    final requests = requestsAsync.valueOrNull ?? const [];
    if (requests.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.m),
        _SectionHeader(label: 'Requests (${requests.length})'),
        SizedBox(height: context.s),
        for (final r in requests)
          Padding(
            padding: EdgeInsets.fromLTRB(
                context.paddingH * 1.3,
                0,
                context.paddingH * 1.3,
                context.s),
            child: _RequestRow(request: r),
          ),
      ],
    );
  }
}

class _FriendsSection extends ConsumerWidget {
  const _FriendsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final friendsAsync = ref.watch(friendsListProvider);
    final friends = friendsAsync.valueOrNull ?? const [];
    if (friends.isEmpty && !friendsAsync.isLoading && !friendsAsync.hasError) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.m),
        _SectionHeader(label: 'Your friends'),
        SizedBox(height: context.s),
        friendsAsync.when(
          data: (friends) {
            if (friends.isEmpty) return const SizedBox.shrink();
            return Column(
              children: [
                for (final f in friends)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        context.paddingH * 1.3,
                        0,
                        context.paddingH * 1.3,
                        context.s),
                    child: _FriendRow(friend: f),
                  ),
              ],
            );
          },
          loading: () => Padding(
            padding: EdgeInsets.all(context.l),
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Padding(
            padding: EdgeInsets.all(context.l),
            child: Text('Error: $e',
                style:
                    TextStyle(color: cs.error, fontSize: context.bodyFont)),
          ),
        ),
      ],
    );
  }
}

class _FriendRow extends ConsumerWidget {
  final FriendProfileEntity friend;
  const _FriendRow({required this.friend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push(AppRoutes.friendProfilePath(friend.id)),
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
                    Text('@${friend.username}',
                        style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant),
                        overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.person_remove_outlined,
                  color: cs.outline, size: context.w * 0.05),
              onPressed: () => _confirmRemove(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove friend?'),
        content: Text(
            'Remove ${friend.displayName ?? friend.username ?? 'this user'} from your friends?'),
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
      await ref.read(friendsControllerProvider.notifier).removeFriend(friend.id);
    }
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

class _SearchResultRow extends ConsumerStatefulWidget {
  final FriendProfileEntity profile;
  const _SearchResultRow({required this.profile});

  @override
  ConsumerState<_SearchResultRow> createState() => _SearchResultRowState();
}

class _SearchResultRowState extends ConsumerState<_SearchResultRow> {
  bool _sent = false;
  bool _sending = false;

  Future<void> _send() async {
    if (_sending || _sent) return;
    setState(() => _sending = true);
    try {
      await ref
          .read(friendsControllerProvider.notifier)
          .sendRequest(widget.profile.id);
      if (!mounted) return;
      setState(() {
        _sent = true;
        _sending = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Friend request sent')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not send request: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        children: [
          FriendAvatar(profile: widget.profile, size: context.w * 0.12),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.profile.displayName ??
                      widget.profile.username ??
                      'Unknown',
                  style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.profile.username != null)
                  Text('@${widget.profile.username}',
                      style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          if (_sent)
            Icon(Icons.check, color: cs.primary, size: context.w * 0.06)
          else if (_sending)
            SizedBox(
              width: context.w * 0.05,
              height: context.w * 0.05,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: cs.primary),
            )
          else
            TextButton(
              onPressed: _send,
              child: Text('Add',
                  style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.primary,
                      fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }
}

class _EmptyFriendsState extends StatelessWidget {
  final VoidCallback onFindFriends;
  const _EmptyFriendsState({required this.onFindFriends});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final padH = context.paddingH * 1.3;
    return Padding(
      padding: EdgeInsets.fromLTRB(padH, context.l, padH, context.m),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.06,
          vertical: context.xl,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.05),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: context.w * 0.18,
              height: context.w * 0.18,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.groups_outlined,
                size: context.w * 0.09,
                color: cs.primary,
              ),
            ),
            SizedBox(height: context.m),
            Text(
              'No friends yet',
              style: TextStyle(
                fontSize: context.headingFont,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.xs),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w * 0.04),
              child: Text(
                'Search by username to add people you taste wine with.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: context.l),
            FilledButton.tonalIcon(
              onPressed: onFindFriends,
              icon: Icon(Icons.search, size: context.w * 0.045),
              label: Text(
                'Find friends',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.06,
                  vertical: context.s * 1.4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
