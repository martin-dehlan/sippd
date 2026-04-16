import 'package:flutter/material.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/wine.entity.dart';

class WineCardWidget extends StatelessWidget {
  final WineEntity wine;
  final int rank;
  final VoidCallback? onTap;

  const WineCardWidget({
    super.key,
    required this.wine,
    required this.rank,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Container(
        padding: EdgeInsets.all(context.w * 0.04),
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            WineRankBadge(rank: rank),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wine.name,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.xs),
                  Row(
                    children: [
                      WineTypeBadge(type: wine.type),
                      if (wine.country != null) ...[
                        SizedBox(width: context.w * 0.02),
                        Text(
                          wine.country!,
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                      if (wine.price != null) ...[
                        const Spacer(),
                        Text(
                          '${wine.price!.toStringAsFixed(2)} ${wine.currency}',
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: context.w * 0.03),
            WineRatingDisplay(rating: wine.rating),
          ],
        ),
      ),
    );
  }
}

class WineRankBadge extends StatelessWidget {
  final int rank;
  const WineRankBadge({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: context.w * 0.09,
      height: context.w * 0.09,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.02),
      ),
      alignment: Alignment.center,
      child: Text(
        '#$rank',
        style: TextStyle(
          fontSize: context.captionFont,
          fontWeight: FontWeight.bold,
          color: cs.onPrimaryContainer,
        ),
      ),
    );
  }
}

class WineTypeBadge extends StatelessWidget {
  final WineType type;
  const WineTypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final label = switch (type) {
      WineType.red => 'Red',
      WineType.white => 'White',
      WineType.rose => 'Rosé',
    };
    final color = switch (type) {
      WineType.red => cs.error,
      WineType.white => cs.tertiary,
      WineType.rose => cs.primary,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.02,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.w * 0.01),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.captionFont * 0.85,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class WineRatingDisplay extends StatelessWidget {
  final double rating;
  const WineRatingDisplay({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
        ),
        Text(
          '/ 10',
          style: TextStyle(
            fontSize: context.captionFont * 0.8,
            color: cs.outline,
          ),
        ),
      ],
    );
  }
}
