import 'package:flutter/material.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/archetype_match.dart';
import '../../domain/entities/taste_compass.entity.dart';
import '../../domain/entities/user_style_dna.entity.dart';

/// Wine personality headline above the compass radar. Uses curated
/// archetype distance matching against the user's Style DNA vector
/// plus contextual bonuses (sparkling share, old-world share, region
/// variety) to pick the closest archetype with a confidence label.
class ArchetypeHeadline extends StatelessWidget {
  const ArchetypeHeadline({
    super.key,
    required this.compass,
    this.dna,
  });

  final TasteCompassEntity compass;
  final UserStyleDna? dna;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final match = matchArchetype(compass, dna);
    final a = match.archetype;
    final score = match.score.round();
    final showScore = match.score > 0 && dna != null && dna!.attributedCount >= 3;

    return Container(
      padding: EdgeInsets.all(context.s * 1.4),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.035),
        border: Border.all(
          color: a.color.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: context.w * 0.11,
            height: context.w * 0.11,
            decoration: BoxDecoration(
              color: a.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: a.color.withValues(alpha: 0.6),
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              a.icon,
              color: a.color,
              size: context.w * 0.055,
            ),
          ),
          SizedBox(width: context.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'YOUR WINE PERSONALITY',
                      style: TextStyle(
                        fontSize: context.captionFont * 0.75,
                        fontWeight: FontWeight.w700,
                        color: cs.outline,
                        letterSpacing: 0.9,
                      ),
                    ),
                    if (showScore) ...[
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.xs * 1.2,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: a.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          match.isTentative ? '~$score%' : '$score%',
                          style: TextStyle(
                            fontSize: context.captionFont * 0.78,
                            fontWeight: FontWeight.w800,
                            color: a.color,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: context.xs * 0.4),
                Text(
                  a.name,
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.05,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: context.xs * 0.4),
                Text(
                  a.tagline,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
                if (match.isTentative && showScore) ...[
                  SizedBox(height: context.xs * 0.6),
                  Text(
                    'Tentative — rate more wines for a sharper read',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.85,
                      fontStyle: FontStyle.italic,
                      color: cs.outline,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
