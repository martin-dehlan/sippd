import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/responsive.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../wines/controller/wine.provider.dart';
import '../../controller/group.provider.dart';
import '../../domain/entities/group.entity.dart';
import '../modules/group_detail/widgets/share_match_dialog.widget.dart';

Future<void> showShareWineSheet({
  required BuildContext context,
  required String wineId,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (_) => _ShareWineSheet(wineId: wineId),
  );
}

class _ShareWineSheet extends ConsumerStatefulWidget {
  final String wineId;

  const _ShareWineSheet({required this.wineId});

  @override
  ConsumerState<_ShareWineSheet> createState() => _ShareWineSheetState();
}

class _ShareWineSheetState extends ConsumerState<_ShareWineSheet> {
  String? _busyGroupId;

  Future<void> _onPick(GroupEntity group) async {
    if (_busyGroupId != null) return;
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    setState(() => _busyGroupId = group.id);
    try {
      final aliasRepo = ref.read(wineAliasRepositoryProvider);
      final canonical = await aliasRepo.resolveCanonical(
        userId: userId,
        localWineId: widget.wineId,
      );

      if (canonical != widget.wineId) {
        await ref.read(groupControllerProvider.notifier).shareCanonicalToGroup(
              groupId: group.id,
              canonicalWineId: canonical,
            );
        _finish(group);
        return;
      }

      final wine =
          await ref.read(wineRepositoryProvider).getWineById(widget.wineId);
      if (wine == null) return;

      final groupCtrl = ref.read(groupControllerProvider.notifier);
      final candidates = await groupCtrl.findShareMatchCandidates(
        groupId: group.id,
        localWine: wine,
      );

      if (candidates.isEmpty) {
        await groupCtrl.shareWineToGroup(group.id, widget.wineId);
        _finish(group);
        return;
      }

      if (!mounted) return;
      final result = await showShareMatchDialog(
        context: context,
        mine: wine,
        candidates: candidates,
      );
      if (!mounted || result == null) return;

      switch (result.choice) {
        case ShareMatchChoice.same:
          final c = result.canonical;
          if (c == null) return;
          await aliasRepo.link(
            userId: userId,
            localWineId: widget.wineId,
            canonicalWineId: c.id,
          );
          await groupCtrl.shareCanonicalToGroup(
            groupId: group.id,
            canonicalWineId: c.id,
          );
          _finish(group);
        case ShareMatchChoice.different:
          await groupCtrl.shareWineToGroup(group.id, widget.wineId);
          _finish(group);
        case ShareMatchChoice.cancel:
          return;
      }
    } finally {
      if (mounted) setState(() => _busyGroupId = null);
    }
  }

  void _finish(GroupEntity group) {
    ref.invalidate(groupWinesProvider(group.id));
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text('Shared to ${group.name}')));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final groupsAsync = ref.watch(groupControllerProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.paddingH, vertical: context.m),
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
            Text('Share to group',
                style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant)),
            SizedBox(height: context.m),
            groupsAsync.when(
              data: (groups) {
                if (groups.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: context.l),
                    child: Text(
                      'You are not in any groups yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant),
                    ),
                  );
                }
                return Column(
                  children: [
                    for (final g in groups) ...[
                      _GroupRow(
                        group: g,
                        isBusy: _busyGroupId == g.id,
                        onTap: _busyGroupId != null ? null : () => _onPick(g),
                      ),
                      SizedBox(height: context.s),
                    ],
                  ],
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e',
                  style:
                      TextStyle(fontSize: context.captionFont, color: cs.error)),
            ),
            SizedBox(height: context.m),
          ],
        ),
      ),
    );
  }
}

class _GroupRow extends ConsumerWidget {
  final GroupEntity group;
  final VoidCallback? onTap;
  final bool isBusy;

  const _GroupRow({
    required this.group,
    required this.onTap,
    this.isBusy = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final membersAsync = ref.watch(groupMembersProvider(group.id));
    final subtitle = _subtitle();

    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(context.w * 0.04),
          child: Row(
            children: [
              Container(
                width: context.w * 0.12,
                height: context.w * 0.12,
                decoration: BoxDecoration(
                  color: group.imageUrl == null
                      ? cs.primaryContainer
                      : cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                  image: group.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(group.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: group.imageUrl == null
                    ? Icon(Icons.wine_bar,
                        color: cs.primary, size: context.w * 0.06)
                    : null,
              ),
              SizedBox(width: context.w * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: context.bodyFont,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2)),
                    if (subtitle != null) ...[
                      SizedBox(height: context.xs),
                      Text(subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: context.captionFont,
                              color: cs.onSurfaceVariant)),
                    ],
                  ],
                ),
              ),
              SizedBox(width: context.w * 0.02),
              if (isBusy)
                SizedBox(
                  width: context.w * 0.05,
                  height: context.w * 0.05,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              else
                membersAsync.maybeWhen(
                  data: (members) => members.isEmpty
                      ? Icon(Icons.arrow_forward_ios,
                          size: context.w * 0.035, color: cs.outline)
                      : _AvatarCluster(members: members),
                  orElse: () => Icon(Icons.arrow_forward_ios,
                      size: context.w * 0.035, color: cs.outline),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String? _subtitle() {
    final parts = <String>[];
    if (group.memberCount > 0) {
      parts.add('${group.memberCount} '
          '${group.memberCount == 1 ? 'member' : 'members'}');
    }
    if (group.wineCount > 0) {
      parts.add('${group.wineCount} '
          '${group.wineCount == 1 ? 'wine' : 'wines'}');
    }
    return parts.isEmpty ? null : parts.join(' · ');
  }
}

class _AvatarCluster extends StatelessWidget {
  final List<FriendProfileEntity> members;
  const _AvatarCluster({required this.members});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.075;
    final overlap = size * 0.5;
    final visible = members.take(3).toList();
    final extra = members.length - visible.length;
    final slots = visible.length + (extra > 0 ? 1 : 0);
    final width = slots == 0 ? 0.0 : size + (slots - 1) * (size - overlap);
    final inner = size - size * 0.08;

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * (size - overlap),
              child: Container(
                padding: EdgeInsets.all(size * 0.04),
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: FriendAvatar(
                  profile: visible[i],
                  size: inner,
                ),
              ),
            ),
          if (extra > 0)
            Positioned(
              left: visible.length * (size - overlap),
              child: Container(
                padding: EdgeInsets.all(size * 0.04),
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: inner,
                  height: inner,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+$extra',
                    style: TextStyle(
                      fontSize: size * 0.3,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
