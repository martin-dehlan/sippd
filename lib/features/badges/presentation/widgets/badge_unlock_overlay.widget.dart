import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/services/analytics/analytics.provider.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/badges.provider.dart';
import '../../domain/entities/badge.entity.dart';
import '../badge_visuals.dart';

/// Wraps the shell body and pops a celebration the moment a newly-earned badge
/// surfaces (server awards it on the qualifying write; [badgeUnlocksProvider]
/// fetches the unseen set). Multiple unlocks are shown one after another, then
/// marked seen so they never repeat.
class BadgeUnlockGate extends ConsumerStatefulWidget {
  const BadgeUnlockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<BadgeUnlockGate> createState() => _BadgeUnlockGateState();
}

class _BadgeUnlockGateState extends ConsumerState<BadgeUnlockGate> {
  bool _showing = false;

  Future<void> _present(List<BadgeEntity> badges) async {
    if (_showing || badges.isEmpty || !mounted) return;
    _showing = true;
    final analytics = ref.read(analyticsProvider);
    for (final badge in badges) {
      if (!mounted) break;
      analytics.capture(
        'badge_unlocked',
        properties: {
          'badge_id': badge.id,
          'category': badge.category,
          'tier': badge.tier,
        },
      );
      await _showBadgeUnlockDialog(context, badge);
    }
    if (mounted) {
      await ref
          .read(badgeUnlocksProvider.notifier)
          .markSeen(badges.map((b) => b.id).toList());
    }
    _showing = false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(badgeUnlocksProvider, (_, next) {
      final list = next.valueOrNull;
      if (list != null && list.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _present(list));
      }
    });
    return widget.child;
  }
}

Future<void> _showBadgeUnlockDialog(BuildContext context, BadgeEntity badge) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: badge.title,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    transitionDuration: const Duration(milliseconds: 280),
    pageBuilder: (_, _, _) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, _) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
      return Transform.scale(
        scale: 0.85 + 0.15 * curved.value,
        child: Opacity(
          opacity: anim.value.clamp(0, 1),
          child: _UnlockCard(badge: badge),
        ),
      );
    },
  );
}

class _UnlockCard extends StatelessWidget {
  const _UnlockCard({required this.badge});

  final BadgeEntity badge;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final accent = badgeAccent(badge.category, cs);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH),
        child: Material(
          color: cs.surface,
          borderRadius: BorderRadius.circular(context.w * 0.06),
          child: Padding(
            padding: EdgeInsets.all(context.l),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIconsRegular.confetti,
                  size: context.w * 0.08,
                  color: accent,
                ),
                SizedBox(height: context.s),
                Text(
                  l10n.badgesUnlockedHeadline,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: accent,
                  ),
                ),
                SizedBox(height: context.m),
                Container(
                  width: context.w * 0.26,
                  height: context.w * 0.26,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.16),
                    shape: BoxShape.circle,
                    border: Border.all(color: accent.withValues(alpha: 0.5)),
                  ),
                  child: Icon(
                    badgeIcon(badge.icon),
                    size: context.w * 0.12,
                    color: accent,
                  ),
                ),
                SizedBox(height: context.m),
                Text(
                  badge.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.titleFont * 0.72,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                ),
                SizedBox(height: context.xs),
                Text(
                  badge.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: context.l),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: FilledButton.styleFrom(backgroundColor: accent),
                    child: Text(l10n.badgesNice),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
