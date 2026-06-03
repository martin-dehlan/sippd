import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/badge.entity.dart';
import '../badge_visuals.dart';

/// One grid cell. Earned = accent icon, full color. Locked = desaturated icon
/// with a small lock and a thin progress bar. No assets — grayscale is derived
/// in-widget per the design rules.
class BadgeCard extends StatelessWidget {
  const BadgeCard({super.key, required this.badge, required this.onTap});

  final BadgeEntity badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final accent = badgeAccent(badge.category, cs);
    final earned = badge.earned;
    final iconColor = earned ? accent : cs.onSurfaceVariant.withValues(alpha: 0.55);
    final ringColor = earned ? accent.withValues(alpha: 0.16) : cs.surfaceContainer;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: context.w * 0.16,
                height: context.w * 0.16,
                decoration: BoxDecoration(
                  color: ringColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: earned ? accent.withValues(alpha: 0.5) : cs.outlineVariant,
                    width: 0.5,
                  ),
                ),
                child: Icon(
                  badgeIcon(badge.icon),
                  color: iconColor,
                  size: context.w * 0.075,
                ),
              ),
              if (!earned)
                Container(
                  padding: EdgeInsets.all(context.w * 0.008),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIconsFill.lock,
                    size: context.w * 0.03,
                    color: cs.outline,
                  ),
                ),
            ],
          ),
          SizedBox(height: context.xs),
          Text(
            badge.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: context.captionFont * 0.92,
              fontWeight: FontWeight.w700,
              height: 1.1,
              color: earned ? cs.onSurface : cs.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.xs * 0.6),
          if (!earned)
            _ProgressBar(fraction: badge.progress, accent: accent)
          else
            Icon(
              PhosphorIconsFill.checkCircle,
              size: context.captionFont,
              color: accent,
            ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.fraction, required this.accent});

  final double fraction;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.w * 0.01),
      child: LinearProgressIndicator(
        value: fraction,
        minHeight: context.h * 0.005,
        backgroundColor: cs.surfaceContainerHighest,
        valueColor: AlwaysStoppedAnimation<Color>(accent.withValues(alpha: 0.7)),
      ),
    );
  }
}
