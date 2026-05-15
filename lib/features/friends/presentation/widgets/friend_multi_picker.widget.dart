import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/friends.provider.dart';
import '../../domain/entities/friend_profile.entity.dart';
import 'friend_avatar.widget.dart';

/// Generic multi-select friend picker. Opens as a bottom sheet,
/// returns the final set of selected friend IDs on confirm, or null
/// if the user dismisses without confirming.
///
/// Reuse target: moment capture (companion tagging), share-with-friend
/// flow, future tasting invite flow, etc. Keeps shared chrome (avatar
/// list + select toggle + done CTA) in one place.
Future<Set<String>?> showFriendMultiPicker({
  required BuildContext context,
  required Set<String> initialSelected,
  String? title,
}) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (ctx) =>
        _FriendMultiPicker(initialSelected: initialSelected, title: title),
  );
}

class _FriendMultiPicker extends ConsumerStatefulWidget {
  const _FriendMultiPicker({
    required this.initialSelected,
    required this.title,
  });

  final Set<String> initialSelected;
  final String? title;

  @override
  ConsumerState<_FriendMultiPicker> createState() => _FriendMultiPickerState();
}

class _FriendMultiPickerState extends ConsumerState<_FriendMultiPicker> {
  late final Set<String> _selected;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selected = {...widget.initialSelected};
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final friendsAsync = ref.watch(friendsListProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: context.paddingH,
        right: context.paddingH,
        top: context.l,
        bottom: MediaQuery.viewInsetsOf(context).bottom + context.l,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: context.w * 0.1,
              height: 4,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: context.m),
          Text(
            widget.title ?? l10n.momentFieldCompanions,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.s),
          TextField(
            decoration: InputDecoration(
              hintText: l10n.momentCompanionsAddFriend,
              prefixIcon: const Icon(PhosphorIconsRegular.magnifyingGlass),
              isDense: true,
            ),
            onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
          ),
          SizedBox(height: context.s),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: context.h * 0.45),
              child: friendsAsync.when(
                data: (friends) {
                  final filtered = friends.where(_matches).toList();
                  if (filtered.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: context.l),
                        child: Text(
                          l10n.momentCompanionsEmpty,
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => SizedBox(height: context.xs),
                    itemBuilder: (_, i) {
                      final f = filtered[i];
                      final isSelected = _selected.contains(f.id);
                      return _FriendRow(
                        profile: f,
                        selected: isSelected,
                        onTap: () => setState(() {
                          if (isSelected) {
                            _selected.remove(f.id);
                          } else {
                            _selected.add(f.id);
                          }
                        }),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (_, _) => Padding(
                  padding: EdgeInsets.all(context.m),
                  child: Text(
                    l10n.locSearchFailed,
                    style: TextStyle(color: cs.error),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: context.m),
          FilledButton(
            onPressed: () => Navigator.pop(context, _selected),
            child: Text(
              _selected.isEmpty
                  ? l10n.winesMemoriesRemoveCancel
                  : '${l10n.momentSave} (${_selected.length})',
            ),
          ),
        ],
      ),
    );
  }

  bool _matches(FriendProfileEntity f) {
    if (_query.isEmpty) return true;
    final name = (f.displayName ?? f.username ?? '').toLowerCase();
    return name.contains(_query);
  }
}

class _FriendRow extends StatelessWidget {
  final FriendProfileEntity profile;
  final bool selected;
  final VoidCallback onTap;
  const _FriendRow({
    required this.profile,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final label =
        profile.displayName ?? profile.username ?? profile.id.substring(0, 6);
    return Material(
      color: selected ? cs.primaryContainer : cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: InkWell(
        borderRadius: BorderRadius.circular(context.w * 0.03),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.m,
            vertical: context.s,
          ),
          child: Row(
            children: [
              FriendAvatar(profile: profile, size: context.w * 0.1),
              SizedBox(width: context.m),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: selected ? cs.onPrimaryContainer : cs.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                selected
                    ? PhosphorIconsFill.checkCircle
                    : PhosphorIconsRegular.circle,
                color: selected ? cs.primary : cs.outlineVariant,
                size: context.w * 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
