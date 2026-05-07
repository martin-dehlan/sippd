import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../common/utils/responsive.dart';

class WineRatingInput extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onChanged;

  const WineRatingInput({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              PhosphorIconsRegular.star,
              color: cs.primary,
              size: context.w * 0.06,
            ),
            SizedBox(width: context.w * 0.02),
            Text(
              'Rating',
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.03,
                vertical: context.xs,
              ),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(context.w * 0.02),
              ),
              child: Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: context.headingFont,
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.s),
        Row(
          children: [
            Text(
              '0',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.outline,
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: cs.primary,
                  inactiveTrackColor: cs.outlineVariant,
                  thumbColor: cs.primary,
                  overlayColor: cs.primary.withValues(alpha: 0.12),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: rating,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  onChanged: onChanged,
                ),
              ),
            ),
            Text(
              '10',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.outline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
