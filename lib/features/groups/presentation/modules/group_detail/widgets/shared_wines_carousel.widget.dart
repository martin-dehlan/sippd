import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';
import '../../../../../wines/domain/entities/wine.entity.dart';
import '../../../../controller/group.provider.dart';

class SharedWinesCarousel extends ConsumerWidget {
  final String groupId;
  const SharedWinesCarousel({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(groupWinesProvider(groupId));
    return winesAsync.when(
      data: (wines) {
        if (wines.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.paddingH * 1.3),
            child: Text('No wines shared yet.',
                style: TextStyle(
                    fontSize: context.bodyFont * 0.95,
                    color: cs.onSurface)),
          );
        }
        final cardWidth = context.w * 0.55;
        return SizedBox(
          height: cardWidth * 1.15,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
                horizontal: context.paddingH * 1.3),
            itemCount: wines.length,
            separatorBuilder: (_, _) => SizedBox(width: context.w * 0.03),
            itemBuilder: (_, i) => _WineCard(
              wine: wines[i],
              width: cardWidth,
            ),
          ),
        );
      },
      loading: () => SizedBox(
        height: context.w * 0.3,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _WineCard extends StatelessWidget {
  final WineEntity wine;
  final double width;
  const _WineCard({required this.wine, required this.width});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
    };
    return GestureDetector(
      onTap: () => context.push(AppRoutes.wineDetailPath(wine.id)),
      child: Container(
        width: width,
        padding: EdgeInsets.all(context.w * 0.04),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: context.w * 0.02,
                  height: context.w * 0.08,
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(context.w * 0.01),
                  ),
                ),
                SizedBox(width: context.w * 0.02),
                Text(
                  _typeLabel(wine.type),
                  style: TextStyle(
                    fontSize: context.captionFont * 0.8,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.s),
            Text(
              wine.name,
              style: TextStyle(
                fontSize: context.bodyFont * 1.05,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                height: 1.15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.xs),
            Text(
              [
                if (wine.vintage != null) wine.vintage.toString(),
                if (wine.country != null) wine.country,
              ].join(' · '),
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  wine.rating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: context.titleFont * 0.9,
                    fontWeight: FontWeight.w800,
                    color: cs.primary,
                    height: 1,
                    letterSpacing: -1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: context.xs * 0.8),
                  child: Text('/5',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      )),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward,
                    size: context.w * 0.045, color: cs.outline),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(WineType type) => switch (type) {
        WineType.red => 'RED',
        WineType.white => 'WHITE',
        WineType.rose => 'ROSÉ',
      };
}
