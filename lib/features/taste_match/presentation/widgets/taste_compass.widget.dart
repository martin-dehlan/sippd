import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/taste_compass.entity.dart';
import 'compass_radar.widget.dart';

class TasteCompassWidget extends StatelessWidget {
  const TasteCompassWidget({
    super.key,
    required this.compass,
    required this.title,
  });

  final TasteCompassEntity compass;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: context.s),
          if (!compass.hasMinimumData)
            _CompassEmpty(totalCount: compass.totalCount)
          else ...[
            SizedBox(height: context.xs),
            CompassRadar(compass: compass),
            SizedBox(height: context.m),
            if (compass.topRegions.isNotEmpty)
              _BucketStrip(
                heading: 'Top regions',
                buckets: compass.topRegions,
              ),
            if (compass.topCountries.isNotEmpty) ...[
              SizedBox(height: context.s),
              _BucketStrip(
                heading: 'Top countries',
                buckets: compass.topCountries,
              ),
            ],
            SizedBox(height: context.m),
            _Footer(
              totalCount: compass.totalCount,
              overallAvg: compass.overallAvg,
            ),
          ],
        ],
      ),
    );
  }
}

class _CompassEmpty extends StatelessWidget {
  const _CompassEmpty({required this.totalCount});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final missing = (5 - totalCount).clamp(1, 5);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s),
      child: Row(
        children: [
          Icon(
            PhosphorIconsRegular.compass,
            color: cs.onSurfaceVariant,
            size: context.w * 0.05,
          ),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Text(
              'Rate $missing more wine${missing == 1 ? '' : 's'} to unlock the compass.',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal strip of region / country pills under the radar. Each pill
/// shows the bucket name + avg rating; count is implicit in the radar
/// shape so it doesn't need to repeat here.
class _BucketStrip extends StatelessWidget {
  const _BucketStrip({required this.heading, required this.buckets});

  final String heading;
  final List<CompassBucket> buckets;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading.toUpperCase(),
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            color: cs.outline,
            letterSpacing: 0.9,
          ),
        ),
        SizedBox(height: context.xs * 1.2),
        Wrap(
          spacing: context.w * 0.02,
          runSpacing: context.w * 0.018,
          children: [
            for (final b in buckets.take(6))
              _BucketPill(label: b.label, avg: b.avgRating),
          ],
        ),
      ],
    );
  }
}

class _BucketPill extends StatelessWidget {
  const _BucketPill({required this.label, required this.avg});

  final String label;
  final double avg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.h * 0.007,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              color: cs.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: context.w * 0.02),
          Text(
            avg.toStringAsFixed(1),
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              color: cs.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '★',
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              color: cs.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.totalCount, required this.overallAvg});

  final int totalCount;
  final double? overallAvg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          '$totalCount wine${totalCount == 1 ? '' : 's'}',
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
          ),
        ),
        if (overallAvg != null) ...[
          Text(
            ' · ',
            style: TextStyle(color: cs.outlineVariant),
          ),
          Text(
            '${overallAvg!.toStringAsFixed(1)} ★ avg',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
