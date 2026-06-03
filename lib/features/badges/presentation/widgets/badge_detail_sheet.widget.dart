import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/badge.entity.dart';
import '../badge_visuals.dart';

Future<void> showBadgeDetailSheet(BuildContext context, BadgeEntity badge) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.06),
      ),
    ),
    builder: (_) => _BadgeDetailSheet(badge: badge),
  );
}

class _BadgeDetailSheet extends StatelessWidget {
  const _BadgeDetailSheet({required this.badge});

  final BadgeEntity badge;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final accent = badgeAccent(badge.category, cs);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.paddingH,
          context.l,
          context.paddingH,
          context.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: context.w * 0.28,
              height: context.w * 0.28,
              decoration: BoxDecoration(
                color: badge.earned
                    ? accent.withValues(alpha: 0.16)
                    : cs.surfaceContainer,
                shape: BoxShape.circle,
                border: Border.all(
                  color: badge.earned ? accent.withValues(alpha: 0.5) : cs.outlineVariant,
                ),
              ),
              child: Icon(
                badgeIcon(badge.icon),
                size: context.w * 0.13,
                color: badge.earned
                    ? accent
                    : cs.onSurfaceVariant.withValues(alpha: 0.55),
              ),
            ),
            SizedBox(height: context.m),
            Text(
              badge.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.titleFont * 0.8,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              badge.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurfaceVariant,
                height: 1.3,
              ),
            ),
            SizedBox(height: context.l),
            if (badge.earned)
              _EarnedRow(badge: badge, accent: accent, l10n: l10n)
            else
              _ProgressRow(badge: badge, accent: accent, l10n: l10n),
          ],
        ),
      ),
    );
  }
}

class _EarnedRow extends StatelessWidget {
  const _EarnedRow({
    required this.badge,
    required this.accent,
    required this.l10n,
  });

  final BadgeEntity badge;
  final Color accent;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final date = badge.earnedAt;
    final label = date != null
        ? l10n.badgesEarnedOn(DateFormat.yMMMMd().format(date.toLocal()))
        : l10n.badgesEarnedLabel;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(PhosphorIconsFill.checkCircle, size: context.bodyFont, color: accent),
        SizedBox(width: context.w * 0.02),
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
      ],
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.badge,
    required this.accent,
    required this.l10n,
  });

  final BadgeEntity badge;
  final Color accent;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(context.w * 0.02),
          child: LinearProgressIndicator(
            value: badge.progress,
            minHeight: context.h * 0.01,
            backgroundColor: cs.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(accent),
          ),
        ),
        SizedBox(height: context.s),
        Text(
          '${badge.current} / ${badge.target}',
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
