import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/error_view.widget.dart';
import '../../controller/group_invitation.provider.dart';

Future<void> showFriendActionsSheet({
  required BuildContext context,
  required String friendId,
  required String friendDisplayName,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (ctx) => _Sheet(
      friendId: friendId,
      friendDisplayName: friendDisplayName,
    ),
  );
}

class _Sheet extends StatelessWidget {
  final String friendId;
  final String friendDisplayName;
  const _Sheet({
    required this.friendId,
    required this.friendDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.m,
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
              friendDisplayName,
              style: TextStyle(
                fontSize: context.bodyFont * 1.05,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.m),
            _ActionTile(
              icon: PhosphorIconsRegular.userPlus,
              label: 'Invite to a group',
              onTap: () {
                Navigator.pop(context);
                _openGroupPicker(context, friendId, friendDisplayName);
              },
            ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }

  void _openGroupPicker(
    BuildContext context,
    String friendId,
    String friendDisplayName,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (ctx) => _GroupPickerSheet(
        friendId: friendId,
        friendDisplayName: friendDisplayName,
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.04,
            vertical: context.m,
          ),
          child: Row(
            children: [
              Icon(icon, color: cs.primary, size: context.w * 0.06),
              SizedBox(width: context.w * 0.04),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(PhosphorIconsRegular.caretRight,
                  size: context.w * 0.05, color: cs.outline),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupPickerSheet extends ConsumerWidget {
  final String friendId;
  final String friendDisplayName;
  const _GroupPickerSheet({
    required this.friendId,
    required this.friendDisplayName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final groupsAsync = ref.watch(invitableGroupsForFriendProvider(friendId));

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.m,
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
              'Invite ${friendDisplayName.split(' ').first} to…',
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.m),
            Flexible(
              child: groupsAsync.when(
                data: (groups) {
                  if (groups.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: context.l),
                      child: Text(
                        'No groups to invite to. Create or join one first.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.bodyFont * 0.95,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: groups.length,
                    separatorBuilder: (_, _) => SizedBox(height: context.s),
                    itemBuilder: (_, i) => _GroupRow(
                      group: groups[i],
                      onInvite: () =>
                          _onInvite(context, ref, groups[i].groupId),
                    ),
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => ErrorView(
                  title: "Couldn't load groups",
                  compact: true,
                  error: e,
                ),
              ),
            ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }

  Future<void> _onInvite(
    BuildContext context,
    WidgetRef ref,
    String groupId,
  ) async {
    try {
      await ref
          .read(groupInvitationControllerProvider.notifier)
          .invite(groupId: groupId, inviteeId: friendId);
      if (!context.mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invite sent to $friendDisplayName'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not send invite: $e')),
      );
    }
  }
}

class _GroupRow extends StatelessWidget {
  final ({String groupId, String name, String? imageUrl}) group;
  final VoidCallback onInvite;

  const _GroupRow({required this.group, required this.onInvite});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.11;
    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onInvite,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.04,
            vertical: context.s,
          ),
          child: Row(
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: group.imageUrl == null
                      ? cs.primaryContainer
                      : cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(context.w * 0.025),
                  image: group.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(group.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: group.imageUrl == null
                    ? Icon(PhosphorIconsRegular.wine,
                        color: cs.primary, size: size * 0.5)
                    : null,
              ),
              SizedBox(width: context.w * 0.04),
              Expanded(
                child: Text(
                  group.name,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(PhosphorIconsRegular.paperPlaneRight,
                  size: context.w * 0.045, color: cs.primary),
            ],
          ),
        ),
      ),
    );
  }
}
