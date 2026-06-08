import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (_, _, _) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, _) {
      // Lean: a quiet fade + subtle settle — no bounce/overshoot.
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return Opacity(
        opacity: anim.value.clamp(0, 1),
        child: Transform.scale(
          scale: 0.96 + 0.04 * curved.value,
          child: _UnlockCard(badge: badge),
        ),
      );
    },
  );
}

class _UnlockCard extends StatefulWidget {
  const _UnlockCard({required this.badge});

  final BadgeEntity badge;

  @override
  State<_UnlockCard> createState() => _UnlockCardState();
}

class _UnlockCardState extends State<_UnlockCard> {
  @override
  void initState() {
    super.initState();
    // A satisfying little tap the instant the reward lands.
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final badge = widget.badge;
    final accent = badgeAccent(badge.category, cs);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH),
        child: Material(
          color: cs.surface,
          borderRadius: BorderRadius.circular(context.w * 0.07),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.l,
              vertical: context.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success burst: a gold ring sweeps to completion with a
                // soft pulse — lean medal moment.
                _SuccessRing(icon: badgeIcon(badge.icon), accent: accent),
                SizedBox(height: context.l),
                // Neutral eyebrow — no coloured/red headline.
                Text(
                  l10n.badgesUnlockedHeadline.toUpperCase(),
                  style: TextStyle(
                    fontSize: context.captionFont * 0.82,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.6,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.s),
                Text(
                  badge.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.titleFont * 0.78,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
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
                    height: 1.35,
                  ),
                ),
                SizedBox(height: context.l),
                // Rounded progress bar filling to 100% + the count ticking
                // to N/N — same language as the detail sheet.
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, value, _) {
                    final shown = (badge.target * value).round().clamp(
                      0,
                      badge.target,
                    );
                    return Column(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.55,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              context.w * 0.02,
                            ),
                            child: LinearProgressIndicator(
                              value: value,
                              minHeight: context.h * 0.011,
                              backgroundColor: cs.surfaceContainerHighest,
                              // Brand gold (logo tone), not category accent.
                              valueColor: AlwaysStoppedAnimation<Color>(
                                cs.secondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.s),
                        Text(
                          '$shown / ${badge.target}',
                          style: TextStyle(
                            fontSize: context.captionFont,
                            fontWeight: FontWeight.w700,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: context.xl),
                // Clean neutral button — not a loud accent block.
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.onSurface,
                      foregroundColor: cs.surface,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: context.m),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.w * 0.035),
                      ),
                    ),
                    child: Text(
                      l10n.badgesNice,
                      style: const TextStyle(fontWeight: FontWeight.w600),
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
}

/// Lean success flourish around the badge: a gold ring sweeps to a full
/// circle while a soft pulse expands outward once. Gold = the brand/medal
/// tone; the glyph keeps its category accent and settles in.
class _SuccessRing extends StatefulWidget {
  const _SuccessRing({required this.icon, required this.accent});

  final IconData icon;
  final Color accent;

  @override
  State<_SuccessRing> createState() => _SuccessRingState();
}

class _SuccessRingState extends State<_SuccessRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )..forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = context.w;
    final gold = Theme.of(context).colorScheme.secondary;
    return SizedBox(
      width: w * 0.27,
      height: w * 0.27,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final sweep = Curves.easeOutCubic.transform(_c.value);
          final pulse = Curves.easeOut.transform(_c.value);
          return Stack(
            alignment: Alignment.center,
            children: [
              // Soft pulse expanding outward once, then gone.
              Opacity(
                opacity: (1 - pulse) * 0.4,
                child: Transform.scale(
                  scale: 0.85 + pulse * 0.7,
                  child: Container(
                    width: w * 0.22,
                    height: w * 0.22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: gold, width: 1.2),
                    ),
                  ),
                ),
              ),
              // Gold ring sweeping to a full circle — the "completed" beat.
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: sweep,
                  strokeWidth: w * 0.008,
                  color: gold,
                  backgroundColor: gold.withValues(alpha: 0.12),
                ),
              ),
              // Badge glyph settling in.
              Transform.scale(
                scale: 0.85 + sweep * 0.15,
                child: Container(
                  width: w * 0.2,
                  height: w * 0.2,
                  decoration: BoxDecoration(
                    color: widget.accent.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: w * 0.095,
                    color: widget.accent,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
