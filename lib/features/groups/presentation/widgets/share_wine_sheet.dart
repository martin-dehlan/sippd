import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/group.provider.dart';
import '../../domain/entities/group.entity.dart';

Future<void> showShareWineSheet({
  required BuildContext context,
  required WidgetRef ref,
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
    builder: (ctx) => _ShareWineSheet(parentRef: ref, wineId: wineId),
  );
}

class _ShareWineSheet extends ConsumerWidget {
  final WidgetRef parentRef;
  final String wineId;

  const _ShareWineSheet({required this.parentRef, required this.wineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    for (final g in groups)
                      _GroupRow(
                        group: g,
                        onTap: () async {
                          await parentRef
                              .read(groupControllerProvider.notifier)
                              .shareWineToGroup(g.id, wineId);
                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Shared to ${g.name}'),
                              ),
                            );
                          }
                        },
                      ),
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

class _GroupRow extends StatelessWidget {
  final GroupEntity group;
  final VoidCallback onTap;

  const _GroupRow({required this.group, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.02, vertical: context.s),
        child: Row(
          children: [
            Container(
              width: context.w * 0.1,
              height: context.w * 0.1,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(context.w * 0.02),
              ),
              child: Icon(Icons.wine_bar,
                  color: cs.primary, size: context.w * 0.05),
            ),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Text(
                group.name,
                style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: context.w * 0.035, color: cs.outline),
          ],
        ),
      ),
    );
  }
}
