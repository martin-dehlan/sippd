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
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Row(
          children: [
            // Left: Image area with rank
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
                        // Gold rating badge
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
                                  color: cs.primary),
                              SizedBox(width: context.w * 0.005),
                              Text(
                                wine.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: context.captionFont * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: cs.primary,
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
        WineType.sparkling => 'Sparkling',
      };
}

class WineCardImage extends StatelessWidget {
  final WineEntity wine;
  final int rank;

  const WineCardImage({super.key, required this.wine, required this.rank});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFF8B2252),
      WineType.white => const Color(0xFF9E8B5E),
      WineType.rose => const Color(0xFFB5658A),
      WineType.sparkling => const Color(0xFFB8923B),
    };

    return Container(
      width: context.w * 0.22,
      height: context.w * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.w * 0.04),
          bottomLeft: Radius.circular(context.w * 0.04),
        ),
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            typeColor.withValues(alpha: 0.2),
            cs.surfaceContainer,
          ],
        ),
      ),
      child: Stack(
        children: [
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
                    size: context.w * 0.09,
                    color: typeColor.withValues(alpha: 0.5)),
          ),
          // Rank badge
          Positioned(
            top: context.xs,
            left: context.xs,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.018,
                vertical: context.xs * 0.4,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(context.w * 0.01),
              ),
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontSize: context.captionFont * 0.75,
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
    final color = switch (type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
      WineType.sparkling => const Color(0xFFD4A84B),
    };

    return Container(
      width: context.w * 0.02,
      height: context.w * 0.02,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class WineTypeBadge extends StatelessWidget {
  final WineType type;
  const WineTypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final label = switch (type) {
      WineType.red => 'Red',
      WineType.white => 'White',
      WineType.rose => 'Rosé',
      WineType.sparkling => 'Sparkling',
    };
    final color = switch (type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
      WineType.sparkling => const Color(0xFFD4A84B),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.02,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(context.w * 0.01),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.captionFont * 0.85,
          fontWeight: FontWeight.w600,
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
