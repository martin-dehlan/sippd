import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/services/analytics/analytics.provider.dart';
import '../../../../../common/services/deep_link/deep_link.service.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../profile/controller/profile.provider.dart';
import '../../../../share_cards/controller/share_card.provider.dart';
import '../../../../share_cards/presentation/cards/friend_invite_card.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../controller/friends.provider.dart';
import '../../../data/data_sources/friends.api.dart'
    show FriendRequestExistsException;
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
    final friends = ref.watch(friendsListProvider).valueOrNull ?? const [];
    final requests =
        ref.watch(incomingFriendRequestsProvider).valueOrNull ?? const [];
    final outgoing =
        ref.watch(outgoingFriendRequestsProvider).valueOrNull ?? const [];
    final showEmpty =
        !searchMode && friends.isEmpty && requests.isEmpty && outgoing.isEmpty;

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
                const _OutgoingRequestsSection(),
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
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
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
      maxLength: 60,
      inputFormatters: [LengthLimitingTextInputFormatter(60)],
      decoration: InputDecoration(
        counterText: '',
        hintText: 'Search by username or name',
        prefixIcon: Icon(
          PhosphorIconsRegular.magnifyingGlass,
          color: cs.primary,
        ),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(PhosphorIconsRegular.x, size: context.w * 0.05),
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
              horizontal: context.paddingH * 1.3,
              vertical: context.l,
            ),
            child: Text(
              'No users found',
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurfaceVariant,
              ),
            ),
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
                  context.s,
                ),
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
        child: Text(
          'Error: $e',
          style: TextStyle(color: cs.error, fontSize: context.bodyFont),
        ),
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
            // Stable key so the row's local _resolved/_busy state
            // survives the stream's re-emit when the underlying row
            // status flips to 'accepted' — without it the row would
            // briefly re-render in its un-resolved state before the
            // next emit drops it from the list.
            key: ValueKey('incoming_${r.id}'),
            padding: EdgeInsets.fromLTRB(
              context.paddingH * 1.3,
              0,
              context.paddingH * 1.3,
              context.s,
            ),
            child: _RequestRow(key: ValueKey(r.id), request: r),
          ),
      ],
    );
  }
}

class _OutgoingRequestsSection extends ConsumerWidget {
  const _OutgoingRequestsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outgoing =
        ref.watch(outgoingFriendRequestsProvider).valueOrNull ?? const [];
    if (outgoing.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.m),
        _SectionHeader(label: 'Waiting for reply (${outgoing.length})'),
        SizedBox(height: context.s),
        for (final r in outgoing)
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.paddingH * 1.3,
              0,
              context.paddingH * 1.3,
              context.s,
            ),
            child: _OutgoingRequestRow(request: r),
          ),
      ],
    );
  }
}

class _OutgoingRequestRow extends ConsumerWidget {
  final FriendRequestEntity request;
  const _OutgoingRequestRow({required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final profile = request.receiverProfile;
    final name = profile?.displayName ?? profile?.username ?? 'Unknown';
    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Row(
        children: [
          if (profile != null)
            FriendAvatar(profile: profile, size: context.w * 0.12)
          else
            Icon(
              PhosphorIconsRegular.user,
              size: context.w * 0.12,
              color: cs.outline,
            ),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.xs * 0.5),
                Row(
                  children: [
                    Icon(
                      PhosphorIconsRegular.clock,
                      size: context.captionFont * 1.1,
                      color: cs.primary,
                    ),
                    SizedBox(width: context.w * 0.015),
                    Text(
                      'Request sent',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _confirmCancel(context, ref),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.03,
                vertical: context.s,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final name =
        request.receiverProfile?.displayName ??
        request.receiverProfile?.username ??
        'this user';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel request?'),
        content: Text('Cancel your friend request to $name?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Cancel request'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(friendsControllerProvider.notifier)
          .cancelRequest(request.id);
    }
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
                      context.s,
                    ),
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
            child: Text(
              'Error: $e',
              style: TextStyle(color: cs.error, fontSize: context.bodyFont),
            ),
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
          horizontal: context.w * 0.04,
          vertical: context.m,
        ),
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
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (friend.username != null)
                    Text(
                      '@${friend.username}',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                PhosphorIconsRegular.userMinus,
                color: cs.outline,
                size: context.w * 0.05,
              ),
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
          'Remove ${friend.displayName ?? friend.username ?? 'this user'} from your friends?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(friendsControllerProvider.notifier)
          .removeFriend(friend.id);
    }
  }
}

/// One incoming-request row. Stateful so accept/decline can collapse
/// the tile locally on tap — without that the row "flickers" through
/// the natural sequence of stream emits (request status → accepted,
/// then friendships row inserts, the requests-stream re-emits twice
/// in quick succession). Local collapse hides those rebuild seams
/// and only resolves to the final state once the row is gone.
class _RequestRow extends ConsumerStatefulWidget {
  final FriendRequestEntity request;
  const _RequestRow({super.key, required this.request});

  @override
  ConsumerState<_RequestRow> createState() => _RequestRowState();
}

class _RequestRowState extends ConsumerState<_RequestRow>
    with TickerProviderStateMixin {
  bool _resolved = false;
  bool _busy = false;

  Future<void> _accept() async {
    if (_busy || _resolved) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(friendsControllerProvider.notifier)
          .acceptRequest(widget.request.id);
      if (!mounted) return;
      setState(() => _resolved = true);
    } catch (_) {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _decline() async {
    if (_busy || _resolved) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(friendsControllerProvider.notifier)
          .declineRequest(widget.request.id);
      if (!mounted) return;
      setState(() => _resolved = true);
    } catch (_) {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final profile = widget.request.senderProfile;
    final name = profile?.displayName ?? profile?.username ?? 'Unknown';

    return AnimatedSize(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: _resolved ? 0 : 1,
        child: _resolved
            ? const SizedBox(width: double.infinity)
            : Container(
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
                      Icon(
                        PhosphorIconsRegular.user,
                        size: context.w * 0.12,
                        color: cs.outline,
                      ),
                    SizedBox(width: context.w * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: context.bodyFont,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'wants to be friends',
                            style: TextStyle(
                              fontSize: context.captionFont,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        PhosphorIconsRegular.checkCircle,
                        color: cs.primary,
                        size: context.w * 0.07,
                      ),
                      onPressed: _busy ? null : _accept,
                    ),
                    IconButton(
                      icon: Icon(
                        PhosphorIconsRegular.xCircle,
                        color: cs.outline,
                        size: context.w * 0.07,
                      ),
                      onPressed: _busy ? null : _decline,
                    ),
                  ],
                ),
              ),
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
    } on FriendRequestExistsException {
      // Already requested or already friends — treat as success so the
      // button flips to ✓ instead of spamming an error.
      if (!mounted) return;
      setState(() {
        _sent = true;
        _sending = false;
      });
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
    final friends = ref.watch(friendsListProvider).valueOrNull ?? const [];
    final outgoing =
        ref.watch(outgoingFriendRequestsProvider).valueOrNull ?? const [];
    final alreadyFriend = friends.any((f) => f.id == widget.profile.id);
    final alreadyPending = outgoing.any(
      (r) => r.receiverId == widget.profile.id,
    );
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
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.profile.username != null)
                  Text(
                    '@${widget.profile.username}',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          _SearchResultTrailing(
            alreadyFriend: alreadyFriend,
            alreadyPending: alreadyPending,
            sending: _sending,
            optimisticallySent: _sent,
            onAdd: _send,
          ),
        ],
      ),
    );
  }
}

class _SearchResultTrailing extends StatelessWidget {
  final bool alreadyFriend;
  final bool alreadyPending;
  final bool sending;
  final bool optimisticallySent;
  final VoidCallback onAdd;
  const _SearchResultTrailing({
    required this.alreadyFriend,
    required this.alreadyPending,
    required this.sending,
    required this.optimisticallySent,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (alreadyFriend) {
      return _StatusChip(
        icon: PhosphorIconsRegular.checkCircle,
        label: 'Friend',
        color: cs.primary,
      );
    }
    if (alreadyPending || optimisticallySent) {
      return _StatusChip(
        icon: PhosphorIconsRegular.clock,
        label: 'Pending',
        color: cs.onSurfaceVariant,
      );
    }
    if (sending) {
      return SizedBox(
        width: context.w * 0.05,
        height: context.w * 0.05,
        child: CircularProgressIndicator(strokeWidth: 2, color: cs.primary),
      );
    }
    return TextButton(
      onPressed: onAdd,
      child: Text(
        'Add',
        style: TextStyle(
          fontSize: context.captionFont,
          color: cs.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _StatusChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: context.captionFont * 1.2, color: color),
        SizedBox(width: context.w * 0.015),
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _EmptyFriendsState extends ConsumerWidget {
  final VoidCallback onFindFriends;
  const _EmptyFriendsState({required this.onFindFriends});

  Future<void> _shareInvite(BuildContext context, WidgetRef ref) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    ref
        .read(analyticsProvider)
        .capture(
          'friend_invite_share',
          properties: const {'source': 'empty_state'},
        );
    final profile = ref.read(currentProfileProvider).valueOrNull;
    final inviteUrl = DeepLinkService.friendHttpsUri(userId);
    final displayName = (profile?.displayName?.trim().isNotEmpty ?? false)
        ? profile!.displayName!.trim()
        : (profile?.username?.trim() ?? 'A friend');
    await ref
        .read(shareCardProvider)
        .shareFriendInviteCard(
          context: context,
          data: FriendInviteCardData(
            displayName: displayName,
            username: profile?.username,
            avatarUrl: profile?.avatarUrl,
          ),
          inviteUrl: inviteUrl,
          source: 'empty_state',
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                PhosphorIconsRegular.usersThree,
                size: context.w * 0.09,
                color: cs.primary,
              ),
            ),
            SizedBox(height: context.m),
            Text(
              'Bring your tasting circle',
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
                'Sippd gets better with friends. Send an invite — they land straight on your profile.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: context.l),
            FilledButton.icon(
              onPressed: () => _shareInvite(context, ref),
              icon: Icon(
                PhosphorIconsRegular.paperPlaneTilt,
                size: context.w * 0.045,
              ),
              label: Text(
                'Invite friends',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.08,
                  vertical: context.s * 1.4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.1),
                ),
              ),
            ),
            SizedBox(height: context.s),
            TextButton.icon(
              onPressed: onFindFriends,
              icon: Icon(
                PhosphorIconsRegular.magnifyingGlass,
                size: context.w * 0.04,
              ),
              label: Text(
                'Find by username',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
