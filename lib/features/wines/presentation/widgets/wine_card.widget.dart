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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border.all(color: cs.outlineVariant, width: 0.5),
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
        child: Row(
          children: [
            // Left: Image/rank area
            WineCardImage(wine: wine, rank: rank),
            // Right: Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.035,
                  vertical: context.m,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      wine.name,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.xs),
                    // Type + Country
                    Row(
                      children: [
                        WineTypeDot(type: wine.type),
                        SizedBox(width: context.w * 0.015),
                        Text(
                          _typeLabel(wine.type),
                          style: TextStyle(
                            fontSize: context.captionFont * 0.9,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        if (wine.country != null) ...[
                          Text(' · ',
                              style: TextStyle(
                                  color: cs.outline,
                                  fontSize: context.captionFont)),
                          Flexible(
                            child: Text(
                              wine.country!,
                              style: TextStyle(
                                fontSize: context.captionFont * 0.9,
                                color: cs.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: context.s),
                    // Bottom row: price + rating
                    Row(
                      children: [
                        if (wine.price != null)
                          Text(
                            '€${wine.price!.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: context.captionFont,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        if (wine.grape != null) ...[
                          if (wine.price != null)
                            Text(' · ',
                                style: TextStyle(
                                    color: cs.outline,
                                    fontSize: context.captionFont)),
                          Flexible(
                            child: Text(
                              wine.grape!,
                              style: TextStyle(
                                fontSize: context.captionFont * 0.9,
                                color: cs.outline,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        const Spacer(),
                        // Rating
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.w * 0.025,
                            vertical: context.xs * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: cs.primaryContainer,
                            borderRadius:
                                BorderRadius.circular(context.w * 0.015),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded,
                                  size: context.w * 0.035,
                                  color: cs.onPrimaryContainer),
                              SizedBox(width: context.w * 0.005),
                              Text(
                                wine.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: context.captionFont * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: cs.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(WineType type) => switch (type) {
        WineType.red => 'Red',
        WineType.white => 'White',
        WineType.rose => 'Rosé',
      };
}

class WineCardImage extends StatelessWidget {
  final WineEntity wine;
  final int rank;

  const WineCardImage({super.key, required this.wine, required this.rank});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: context.w * 0.22,
      height: context.w * 0.22,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.w * 0.04),
          bottomLeft: Radius.circular(context.w * 0.04),
        ),
      ),
      child: Stack(
        children: [
          // Wine image or placeholder
          Center(
            child: wine.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.w * 0.04),
                      bottomLeft: Radius.circular(context.w * 0.04),
                    ),
                    child: Image.network(wine.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity),
                  )
                : Icon(Icons.wine_bar,
                    size: context.w * 0.1,
                    color: cs.outline.withValues(alpha: 0.3)),
          ),
          // Rank badge
          Positioned(
            top: context.xs,
            left: context.xs,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.02,
                vertical: context.xs * 0.5,
              ),
              decoration: BoxDecoration(
                color: cs.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(context.w * 0.01),
              ),
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontSize: context.captionFont * 0.8,
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WineTypeDot extends StatelessWidget {
  final WineType type;
  const WineTypeDot({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = switch (type) {
      WineType.red => cs.error,
      WineType.white => const Color(0xFFD4A017),
      WineType.rose => cs.primary,
    };

    return Container(
      width: context.w * 0.02,
      height: context.w * 0.02,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// Keep for backward compat (used in detail screen)
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
