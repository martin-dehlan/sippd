import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/wine.entity.dart';

class WineCardWidget extends StatelessWidget {
  final WineEntity wine;
  final int rank;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool compact;
  final double? ratingOverride;
  final bool hideRatingIfEmpty;

  const WineCardWidget({
    super.key,
    required this.wine,
    required this.rank,
    this.onTap,
    this.onLongPress,
    this.compact = false,
    this.ratingOverride,
    this.hideRatingIfEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final effectiveRating = ratingOverride ?? wine.rating;
    final showRating = !(hideRatingIfEmpty && effectiveRating <= 0);

    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.w * 0.04),
            border: Border.all(color: cs.outlineVariant, width: 0.5),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: compact ? context.h * 0.1 : context.h * 0.13,
            ),
            child: Row(
              children: [
                WineCardImage(wine: wine, rank: rank, compact: compact),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w * 0.035,
                      vertical: compact ? context.s : context.m,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
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
                              if (!compact) ...[
                                SizedBox(height: context.xs),
                                WineTypeBadge(type: wine.type),
                              ],
                              if (_metaParts(wine).isNotEmpty) ...[
                                SizedBox(height: context.xs),
                                Text(
                                  _metaParts(wine).join(' · '),
                                  style: TextStyle(
                                    fontSize: context.captionFont * 0.9,
                                    color: cs.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (showRating) ...[
                          SizedBox(width: context.w * 0.02),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.w * 0.025,
                              vertical: context.xs * 0.8,
                            ),
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(
                                context.w * 0.025,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  PhosphorIconsRegular.star,
                                  size: context.w * 0.04,
                                  color: const Color(0xFFD4A84B),
                                ),
                                SizedBox(width: context.w * 0.008),
                                Text(
                                  effectiveRating.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: context.captionFont * 0.95,
                                    fontWeight: FontWeight.w800,
                                    color: cs.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> _metaParts(WineEntity wine) {
    final parts = <String>[DateFormat('MMM yyyy').format(wine.createdAt)];
    if (wine.price != null) parts.add('€${wine.price!.toStringAsFixed(0)}');
    final origin = wine.region ?? wine.country;
    if (origin != null) parts.add(origin);
    return parts;
  }
}

class WineCardImage extends StatelessWidget {
  final WineEntity wine;
  final int? rank;
  final bool compact;

  const WineCardImage({
    super.key,
    required this.wine,
    this.rank,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasImage = wine.imageUrl != null;
    final size = context.w * (compact ? 0.15 : 0.2);
    final inset = context.w * 0.025;
    final radius = context.w * 0.025;
    return Padding(
      padding: EdgeInsets.all(inset),
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: hasImage ? null : cs.surface,
                  border: hasImage
                      ? null
                      : Border.all(color: cs.outlineVariant, width: 0.5),
                ),
                child: hasImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: Image.network(
                          wine.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (_, _, _) => Center(
                            child: Icon(
                              PhosphorIconsThin.wine,
                              size: size * 0.42,
                              color: cs.onSurfaceVariant.withValues(
                                alpha: 0.45,
                              ),
                            ),
                          ),
                          frameBuilder: (_, child, frame, wasSync) {
                            if (frame == null && !wasSync) {
                              return Center(
                                child: Icon(
                                  PhosphorIconsThin.wine,
                                  size: size * 0.42,
                                  color: cs.onSurfaceVariant.withValues(
                                    alpha: 0.45,
                                  ),
                                ),
                              );
                            }
                            return child;
                          },
                        ),
                      )
                    : Center(
                        child: Icon(
                          PhosphorIconsThin.wine,
                          size: size * 0.42,
                          color: cs.onSurfaceVariant.withValues(alpha: 0.45),
                        ),
                      ),
              ),
            ),
            if (rank != null)
              Positioned(
                top: context.xs * 0.6,
                left: context.xs * 0.6,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w * 0.022,
                    vertical: context.xs * 0.5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(context.w * 0.02),
                  ),
                  child: Text(
                    '#$rank',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.8,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
          ],
        ),
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
