import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../domain/entities/wine.entity.dart';
import '../../../widgets/wine_thumb.widget.dart';

class TopWinesList extends StatelessWidget {
  final List<WineEntity> wines;
  final int maxItems;

  const TopWinesList({super.key, required this.wines, this.maxItems = 5});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (wines.isEmpty) {
      return Skeleton(
        child: Column(
          children: [
            for (int i = 0; i < 3; i++) ...[
              if (i > 0) SizedBox(height: context.s),
              _TopWineRowSkeleton(cs: cs),
            ],
          ],
        ),
      );
    }
    final visible = wines.take(maxItems).toList();
    return Column(
      children: [
        for (int i = 0; i < visible.length; i++) ...[
          if (i > 0) SizedBox(height: context.s),
          _Row(rank: i + 1, wine: visible[i], delay: i * 60),
        ],
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final int rank;
  final WineEntity wine;
  final int delay;

  const _Row({required this.rank, required this.wine, required this.delay});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final origin = wine.region ?? wine.country;
    final isFirst = rank == 1;

    return Animate(
      effects: [
        FadeEffect(
          duration: 360.ms,
          delay: Duration(milliseconds: delay),
        ),
        SlideEffect(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
          duration: 360.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeOut,
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.03,
          vertical: context.s,
        ),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(
            color: isFirst
                ? cs.primary.withValues(alpha: 0.5)
                : cs.outlineVariant,
            width: isFirst ? 1 : 0.5,
          ),
        ),
        child: Row(
          children: [
            WineThumb(
              wine: wine,
              size: context.w * 0.13,
              cornerOverlay: _RankCorner(rank: rank),
            ),
            SizedBox(width: context.s * 1.4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wine.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  if (origin != null) ...[
                    SizedBox(height: context.xs * 0.5),
                    Text(
                      origin,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.s),
            _RatingPill(rating: wine.rating, isFirst: isFirst),
          ],
        ),
      ),
    );
  }
}

class _RankCorner extends StatelessWidget {
  final int rank;
  const _RankCorner({required this.rank});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.052;
    final isFirst = rank == 1;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFirst ? cs.primary : cs.surfaceContainer,
        shape: BoxShape.circle,
        border: Border.all(
          color: cs.surface,
          width: 1.5,
        ),
      ),
      child: isFirst
          ? Icon(
              PhosphorIconsFill.crown,
              color: cs.onPrimary,
              size: size * 0.58,
            )
          : Text(
              rank.toString(),
              style: TextStyle(
                color: cs.onSurface,
                fontWeight: FontWeight.w800,
                fontSize: size * 0.52,
                height: 1,
              ),
            ),
    );
  }
}

class _TopWineRowSkeleton extends StatelessWidget {
  final ColorScheme cs;
  const _TopWineRowSkeleton({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.s,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          SkeletonBox(
            width: context.w * 0.13,
            height: context.w * 0.13,
            radius: context.w * 0.13 * 0.22,
          ),
          SizedBox(width: context.s * 1.4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(
                  width: context.w * 0.45,
                  height: context.bodyFont,
                ),
                SizedBox(height: context.xs * 0.6),
                SkeletonBox(
                  width: context.w * 0.3,
                  height: context.captionFont,
                ),
              ],
            ),
          ),
          SizedBox(width: context.s),
          SkeletonBox(
            width: context.w * 0.13,
            height: context.bodyFont * 1.7,
            radius: context.w * 0.03,
          ),
        ],
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  final double rating;
  final bool isFirst;
  const _RatingPill({required this.rating, required this.isFirst});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.s,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: isFirst ? cs.primary : cs.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Text(
        rating.toStringAsFixed(1),
        style: TextStyle(
          fontSize: context.bodyFont * 0.95,
          fontWeight: FontWeight.w800,
          color: isFirst ? cs.onPrimary : cs.primary,
        ),
      ),
    );
  }
}
