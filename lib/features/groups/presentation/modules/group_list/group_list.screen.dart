import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/group.provider.dart';
import '../../../domain/entities/group.entity.dart';

class GroupListScreen extends ConsumerWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(groupControllerProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.m),
              Text('Groups',
                  style: TextStyle(
                      fontSize: context.titleFont,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5)),
              SizedBox(height: context.xs),
              Text('Share wines with friends',
                  style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant)),
              SizedBox(height: context.l),

              // Join group
              GestureDetector(
                onTap: () => _showJoinDialog(context, ref),
                child: Container(
                  padding: EdgeInsets.all(context.w * 0.04),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(context.w * 0.03),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.link, color: cs.primary),
                      SizedBox(width: context.w * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Join a Group',
                                style: TextStyle(
                                    fontSize: context.bodyFont,
                                    fontWeight: FontWeight.w600,
                                    color: cs.onPrimaryContainer)),
                            Text('Enter an invite code',
                                style: TextStyle(
                                    fontSize: context.captionFont,
                                    color: cs.onPrimaryContainer
                                        .withValues(alpha: 0.7))),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: context.w * 0.04,
                          color: cs.onPrimaryContainer),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.m),

              // Groups list
              Expanded(
                child: groupsAsync.when(
                  data: (groups) {
                    if (groups.isEmpty) {
                      return GroupEmptyState(
                        onCreate: () => _showCreateDialog(context, ref),
                      );
                    }
                    return ListView.separated(
                      itemCount: groups.length,
                      separatorBuilder: (_, _) =>
                          SizedBox(height: context.s),
                      itemBuilder: (_, index) =>
                          GroupCard(group: groups[index]),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Text('Sign in to see groups',
                        style: TextStyle(
                            color: cs.onSurfaceVariant,
                            fontSize: context.captionFont)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Create Group'),
      ),
    );
  }

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final cs = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            context.paddingH,
            context.l,
            context.paddingH,
            MediaQuery.of(ctx).viewInsets.bottom + context.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: 3,
                decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            SizedBox(height: context.m),
            Text('Create Group',
                style: TextStyle(
                    fontSize: context.headingFont,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: context.m),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Group Name',
                prefixIcon: Icon(Icons.group_add),
              ),
            ),
            SizedBox(height: context.l),
            SizedBox(
              width: double.infinity,
              height: context.h * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    ref
                        .read(groupControllerProvider.notifier)
                        .createGroup(controller.text.trim());
                    Navigator.pop(ctx);
                  }
                },
                child: Text('Create',
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJoinDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final cs = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            context.paddingH,
            context.l,
            context.paddingH,
            MediaQuery.of(ctx).viewInsets.bottom + context.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: 3,
                decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            SizedBox(height: context.m),
            Text('Join Group',
                style: TextStyle(
                    fontSize: context.headingFont,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: context.m),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Invite Code',
                prefixIcon: Icon(Icons.link),
                hintText: 'e.g. a1b2c3d4',
              ),
            ),
            SizedBox(height: context.l),
            SizedBox(
              width: double.infinity,
              height: context.h * 0.06,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.text.trim().isNotEmpty) {
                    try {
                      await ref
                          .read(groupControllerProvider.notifier)
                          .joinGroup(controller.text.trim());
                      if (ctx.mounted) Navigator.pop(ctx);
                    } catch (e) {
                      if (ctx.mounted) {
                        ScaffoldMessenger.of(ctx).showSnackBar(
                          SnackBar(content: Text('Group not found')),
                        );
                      }
                    }
                  }
                },
                child: Text('Join',
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final GroupEntity group;
  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: context.w * 0.12,
            height: context.w * 0.12,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(context.w * 0.03),
            ),
            child: Icon(Icons.wine_bar, color: cs.primary,
                size: context.w * 0.06),
          ),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group.name,
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: context.xs * 0.5),
                Text(
                  'Code: ${group.inviteCode}',
                  style: TextStyle(
                      fontSize: context.captionFont * 0.9,
                      color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: cs.outline),
        ],
      ),
    );
  }
}

class GroupEmptyState extends StatelessWidget {
  final VoidCallback onCreate;
  const GroupEmptyState({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: context.w * 0.2,
            height: context.w * 0.2,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.group_outlined,
                size: context.w * 0.1, color: cs.primary),
          ),
          SizedBox(height: context.m),
          Text('No groups yet',
              style: TextStyle(
                  fontSize: context.bodyFont, fontWeight: FontWeight.w600)),
          SizedBox(height: context.xs),
          Text('Create or join a group to share wines',
              style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}
