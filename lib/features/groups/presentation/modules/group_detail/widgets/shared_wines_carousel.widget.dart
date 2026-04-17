import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';
import '../../../../../profile/presentation/widgets/profile_avatar.widget.dart';
import '../../../../../wines/domain/entities/wine.entity.dart';
import '../../../../controller/group.provider.dart';
import '../../../../domain/entities/group_wine_rating.entity.dart';
import 'group_wine_rating_sheet.widget.dart';

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
        final cardWidth = context.w * 0.6;
        return SizedBox(
          height: cardWidth * 1.35,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
                horizontal: context.paddingH * 1.3),
            itemCount: wines.length,
            separatorBuilder: (_, _) => SizedBox(width: context.w * 0.03),
            itemBuilder: (_, i) => _WineCard(
              groupId: groupId,
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

class _WineCard extends ConsumerWidget {
  final String groupId;
  final WineEntity wine;
  final double width;
  const _WineCard({
    required this.groupId,
    required this.wine,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final ratingsAsync =
        ref.watch(groupWineRatingsProvider(groupId, wine.id));
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
            _RatingRow(
              ratings: ratingsAsync.valueOrNull ?? const [],
              fallback: wine.rating,
            ),
            SizedBox(height: context.s),
            _RateButton(
              onTap: () => showGroupWineRatingSheet(
                context: context,
                groupId: groupId,
                wine: wine,
              ),
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

class _RatingRow extends StatelessWidget {
  final List<GroupWineRatingEntity> ratings;
  final double fallback;

  const _RatingRow({required this.ratings, required this.fallback});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasRatings = ratings.isNotEmpty;
    final avg = hasRatings
        ? ratings.map((r) => r.rating).reduce((a, b) => a + b) /
            ratings.length
        : fallback;
    final count = ratings.length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          avg.toStringAsFixed(1),
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
          child: Text('/10',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              )),
        ),
        const Spacer(),
        if (hasRatings)
          _AvatarStack(
            ratings: ratings.take(3).toList(),
            extra: count > 3 ? count - 3 : 0,
          )
        else
          Text('No ratings',
              style: TextStyle(
                  fontSize: context.captionFont * 0.9,
                  color: cs.outline)),
      ],
    );
  }
}

class _AvatarStack extends StatelessWidget {
  final List<GroupWineRatingEntity> ratings;
  final int extra;

  const _AvatarStack({required this.ratings, required this.extra});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.065;
    final overlap = size * 0.55;
    final stackWidth =
        ratings.length * overlap + (size - overlap) + (extra > 0 ? size : 0);

    return SizedBox(
      width: stackWidth,
      height: size,
      child: Stack(
        children: [
          for (var i = 0; i < ratings.length; i++)
            Positioned(
              left: i * overlap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: cs.surfaceContainer, width: 2),
                ),
                child: ProfileAvatar(
                  avatarUrl: ratings[i].avatarUrl,
                  fallbackText: ratings[i].username ??
                      ratings[i].displayName ??
                      '?',
                  size: size,
                ),
              ),
            ),
          if (extra > 0)
            Positioned(
              left: ratings.length * overlap,
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primaryContainer,
                  border: Border.all(color: cs.surfaceContainer, width: 2),
                ),
                child: Text('+$extra',
                    style: TextStyle(
                      fontSize: size * 0.32,
                      fontWeight: FontWeight.bold,
                      color: cs.primary,
                    )),
              ),
            ),
        ],
      ),
    );
  }
}

class _RateButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RateButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: context.s),
        decoration: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(context.w * 0.025),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star_outline,
                size: context.w * 0.045, color: cs.primary),
            SizedBox(width: context.xs),
            Text('Rate',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                  color: cs.primary,
                )),
          ],
        ),
      ),
    );
  }
}
