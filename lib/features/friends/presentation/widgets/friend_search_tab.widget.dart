import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/friends.provider.dart';
import '../../domain/entities/friend_profile.entity.dart';
import 'friend_avatar.widget.dart';

class FriendSearchTab extends ConsumerStatefulWidget {
  const FriendSearchTab({super.key});

  @override
  ConsumerState<FriendSearchTab> createState() => _FriendSearchTabState();
}

class _FriendSearchTabState extends ConsumerState<FriendSearchTab> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    if (value.trim().isEmpty) {
      ref.read(friendSearchControllerProvider.notifier).clear();
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () {
      ref.read(friendSearchControllerProvider.notifier).search(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final resultsAsync = ref.watch(friendSearchControllerProvider);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.paddingH, vertical: context.m),
          child: TextField(
            controller: _controller,
            onChanged: _onChanged,
            decoration: InputDecoration(
              hintText: 'Search by username or name',
              prefixIcon: Icon(Icons.search, color: cs.primary),
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
          ),
        ),
        Expanded(
          child: resultsAsync.when(
            data: (results) {
              if (results.isEmpty) {
                return Center(
                  child: Text(
                    _controller.text.trim().isEmpty
                        ? 'Type to search users'
                        : 'No users found',
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        color: cs.onSurfaceVariant),
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: context.paddingH),
                itemCount: results.length,
                separatorBuilder: (_, __) => SizedBox(height: context.s),
                itemBuilder: (_, i) => _SearchResultRow(profile: results[i]),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
                child: Text('Error: $e',
                    style: TextStyle(
                        fontSize: context.bodyFont, color: cs.error))),
          ),
        ),
      ],
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

  Future<void> _send() async {
    await ref
        .read(friendsControllerProvider.notifier)
        .sendRequest(widget.profile.id);
    if (mounted) setState(() => _sent = true);
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
