import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../wines/controller/wine.provider.dart';
import '../../../../../wines/domain/entities/wine.entity.dart';
import '../../../../controller/group.provider.dart';

class WinePickerSheet extends ConsumerWidget {
  final String groupId;
  const WinePickerSheet({super.key, required this.groupId});

  static Future<void> show(
    BuildContext context, {
    required String groupId,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
      ),
      builder: (_) => WinePickerSheet(groupId: groupId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(wineControllerProvider);

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
              'Share a wine',
              style: TextStyle(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.s),
            Flexible(
              child: winesAsync.when(
                data: (wines) {
                  if (wines.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: context.l),
                      child: Text(
                        'You have no wines yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant),
                      ),
                    );
                  }
                  final sorted = List<WineEntity>.from(wines)
                    ..sort((a, b) => b.rating.compareTo(a.rating));
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: sorted.length,
                    separatorBuilder: (_, _) =>
                        SizedBox(height: context.xs),
                    itemBuilder: (_, i) => _WinePickerRow(
                      wine: sorted[i],
                      onTap: () async {
                        await ref
                            .read(groupControllerProvider.notifier)
                            .shareWineToGroup(groupId, sorted[i].id);
                        ref.invalidate(groupWinesProvider(groupId));
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    '${sorted[i].name} shared')),
                          );
                        }
                      },
                    ),
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e',
                    style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.error)),
              ),
            ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }
}

class _WinePickerRow extends StatelessWidget {
  final WineEntity wine;
  final VoidCallback onTap;
  const _WinePickerRow({required this.wine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
      WineType.sparkling => const Color(0xFFD4A84B),
    };
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.02, vertical: context.s),
        child: Row(
          children: [
            Container(
              width: context.w * 0.02,
              height: context.w * 0.1,
              decoration: BoxDecoration(
                color: typeColor,
                borderRadius: BorderRadius.circular(context.w * 0.01),
              ),
            ),
            SizedBox(width: context.w * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wine.name,
                      style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: context.xs * 0.4),
                  Text(
                    [
                      if (wine.vintage != null) wine.vintage.toString(),
                      if (wine.country != null) wine.country,
                    ].join(' · '),
                    style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text(
              wine.rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.bold,
                color: cs.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
