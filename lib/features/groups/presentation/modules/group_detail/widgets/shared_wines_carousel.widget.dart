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

class SharedWinesCarousel extends ConsumerStatefulWidget {
  final String groupId;
  const SharedWinesCarousel({super.key, required this.groupId});

  @override
  ConsumerState<SharedWinesCarousel> createState() =>
      _SharedWinesCarouselState();
}

class _SharedWinesCarouselState extends ConsumerState<SharedWinesCarousel> {
  late final PageController _pageController =
      PageController(viewportFraction: 0.82);
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() => _page = _pageController.page ?? 0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(groupWinesProvider(widget.groupId));

    return winesAsync.when(
      data: (wines) {
        if (wines.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            child: Text('No wines shared yet.',
                style: TextStyle(
                    fontSize: context.bodyFont * 0.95,
                    color: cs.onSurfaceVariant)),
          );
        }
        return SizedBox(
          height: context.h * 0.26,
          child: PageView.builder(
            controller: _pageController,
            itemCount: wines.length,
            padEnds: true,
            itemBuilder: (_, i) {
              final delta = (i - _page).abs().clamp(0.0, 1.0);
              final scale = 1 - delta * 0.06;
              final opacity = 1 - delta * 0.25;
              return Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.w * 0.02),
                    child: _WineCard(
                      groupId: widget.groupId,
                      wine: wines[i],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => SizedBox(
        height: context.h * 0.26,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _WineCard extends ConsumerWidget {
  final String groupId;
  final WineEntity wine;
  const _WineCard({required this.groupId, required this.wine});

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
        padding: EdgeInsets.all(context.w * 0.05),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _TypePill(label: _typeLabel(wine.type), color: typeColor),
                const Spacer(),
                _RateIconButton(
                  onTap: () => showGroupWineRatingSheet(
                    context: context,
                    groupId: groupId,
                    wine: wine,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.m),
            Text(
              wine.name,
              style: TextStyle(
                fontSize: context.bodyFont * 1.15,
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
            _RatingFooter(
              ratings: ratingsAsync.valueOrNull ?? const [],
              fallback: wine.rating,
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

class _TypePill extends StatelessWidget {
  final String label;
  final Color color;
  const _TypePill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.02, vertical: context.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(context.w * 0.015),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.w * 0.015,
            height: context.w * 0.015,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: context.xs),
          Text(label,
              style: TextStyle(
                fontSize: context.captionFont * 0.8,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 0.6,
              )),
        ],
      ),
    );
  }
}

class _RateIconButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RateIconButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(context.xs),
        decoration: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.star_rounded,
            size: context.w * 0.045, color: cs.primary),
      ),
    );
  }
}

class _RatingFooter extends StatelessWidget {
  final List<GroupWineRatingEntity> ratings;
  final double fallback;

  const _RatingFooter({required this.ratings, required this.fallback});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasRatings = ratings.isNotEmpty;
    final avg = hasRatings
        ? ratings.map((r) => r.rating).reduce((a, b) => a + b) /
            ratings.length
        : fallback;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          avg.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.titleFont * 0.85,
            fontWeight: FontWeight.w800,
            color: cs.primary,
            height: 1,
            letterSpacing: -1,
          ),
        ),
        SizedBox(width: context.xs * 0.5),
        Padding(
          padding: EdgeInsets.only(top: context.xs * 0.8),
          child: Text('/10',
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                color: cs.onSurfaceVariant,
              )),
        ),
        const Spacer(),
        if (hasRatings)
          _AvatarStack(
            ratings: ratings.take(3).toList(),
            extra: ratings.length > 3 ? ratings.length - 3 : 0,
          ),
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
    final size = context.w * 0.07;
    final overlap = size * 0.6;
    final total = ratings.length + (extra > 0 ? 1 : 0);
    final stackWidth = (total - 1) * overlap + size;

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
