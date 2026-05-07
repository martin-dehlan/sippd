import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../paywall/controller/paywall.provider.dart';
import '../../../profile/controller/profile.provider.dart';
import '../../../share_cards/controller/share_card.provider.dart';
import '../../../share_cards/presentation/cards/compass_share_card.widget.dart';
import '../../controller/taste_match.provider.dart';
import '../../domain/archetype_match.dart';
import '../../domain/entities/taste_compass.entity.dart';
import '../../domain/entities/user_style_dna.entity.dart';
import 'dna_shape.widget.dart';
import 'taste_traits.widget.dart';

/// Compact-by-default identity block on the user's profile. Collapsed
/// state shows the archetype name + a meta line; tap expands inline to
/// reveal the DNA-shape, tagline, full meta, and trait breakdown.
/// Locked states (too few wines / thin DNA) render a single tight row
/// with no expansion to keep the page settings-first.
class WinePersonalityHero extends ConsumerStatefulWidget {
  const WinePersonalityHero({
    super.key,
    required this.userId,
    this.showShareCta = false,
  });

  final String userId;

  /// When true, the expanded body adds an elevated "Share" button at the
  /// bottom that hands the archetype + DNA to the IG-story share card.
  /// Caller decides — defaulted off so friend-profile embeds don't
  /// accidentally surface a button to share someone else's identity.
  final bool showShareCta;

  @override
  ConsumerState<WinePersonalityHero> createState() => _WinePersonalityHeroState();
}

class _WinePersonalityHeroState extends ConsumerState<WinePersonalityHero> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final compassAsync = ref.watch(tasteCompassProvider(widget.userId));
    final dnaAsync = ref.watch(userStyleDnaProvider(widget.userId));
    return compassAsync.when(
      loading: () => SizedBox(height: context.h * 0.06),
      error: (_, _) => const SizedBox.shrink(),
      data: (compass) => _build(compass, dnaAsync.valueOrNull),
    );
  }

  Widget _build(TasteCompassEntity compass, UserStyleDna? dna) {
    final cs = Theme.of(context).colorScheme;
    final match = matchArchetype(compass, dna);
    final accent = match.isNewcomer ? cs.outline : match.archetype.color;
    final tooFewWines = compass.totalCount < 5;
    final thinDna = !tooFewWines && match.isNewcomer;
    final canExpand = !tooFewWines && !thinDna;
    final isExpanded = _expanded && canExpand;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Hairline(color: accent),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: canExpand ? () => setState(() => _expanded = !_expanded) : null,
          child: _CompactHeader(
            compass: compass,
            match: match,
            tooFewWines: tooFewWines,
            thinDna: thinDna,
            attributedCount: dna?.attributedCount ?? 0,
            expanded: isExpanded,
            canExpand: canExpand,
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: isExpanded
              ? _ExpandedDetail(
                  userId: widget.userId,
                  match: match,
                  compass: compass,
                  dna: dna,
                  onUpgradeTap: () => _onUpgrade(),
                  onShareTap:
                      widget.showShareCta ? () => _onShare(match, compass, dna) : null,
                )
              : const SizedBox(width: double.infinity),
        ),
        _Hairline(color: accent),
      ],
    );
  }

  void _onUpgrade() {
    final isPro = ref.read(isProProvider);
    if (isPro) return;
    context.push(AppRoutes.paywall, extra: const {'source': 'personality_hero'});
  }

  Future<void> _onShare(
    ArchetypeMatch match,
    TasteCompassEntity compass,
    UserStyleDna? dna,
  ) async {
    final username =
        ref.read(currentProfileProvider).valueOrNull?.username;
    final data = CompassShareCardData(
      username: username,
      archetypeName: match.archetype.name,
      archetypeTagline: match.archetype.tagline,
      archetypeColor: match.archetype.color,
      dna: dna,
      totalWines: compass.totalCount,
      date: DateTime.now(),
    );
    await ref.read(shareCardProvider).shareCompassCard(
          context: context,
          data: data,
          source: 'personality_hero',
        );
  }
}

class _CompactHeader extends StatelessWidget {
  const _CompactHeader({
    required this.compass,
    required this.match,
    required this.tooFewWines,
    required this.thinDna,
    required this.attributedCount,
    required this.expanded,
    required this.canExpand,
  });

  final TasteCompassEntity compass;
  final ArchetypeMatch match;
  final bool tooFewWines;
  final bool thinDna;
  final int attributedCount;
  final bool expanded;
  final bool canExpand;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (title, subtitle) = _copy();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PERSONALITY',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.78,
                    fontWeight: FontWeight.w700,
                    color: cs.outline,
                    letterSpacing: 1.4,
                  ),
                ),
                SizedBox(height: context.xs * 1.5),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.headingFont,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                    letterSpacing: -0.3,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: context.xs),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                    fontFeatures: tabularFigures,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          if (canExpand)
            AnimatedRotation(
              turns: expanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 220),
              child: Icon(
                PhosphorIconsRegular.caretDown,
                color: cs.onSurfaceVariant,
                size: context.w * 0.045,
              ),
            ),
        ],
      ),
    );
  }

  (String, String) _copy() {
    if (tooFewWines) {
      final missing = (5 - compass.totalCount).clamp(1, 5);
      return (
        'Curious Newcomer',
        'Rate $missing more wine${missing == 1 ? '' : 's'} to reveal your personality.',
      );
    }
    if (thinDna) {
      final missing = (3 - attributedCount).clamp(1, 3);
      return (
        'Almost There',
        'Tag a canonical grape on $missing more wine${missing == 1 ? '' : 's'} to unlock your archetype.',
      );
    }
    return (match.archetype.name, _matchedSubtitle());
  }

  String _matchedSubtitle() {
    final parts = <String>[];
    if (match.score > 0 && match.confidence > 0) {
      final score = match.score.round();
      parts.add(match.isTentative ? '~$score% match' : '$score% match');
    }
    parts.add('${compass.totalCount} wine${compass.totalCount == 1 ? '' : 's'}');
    if (compass.overallAvg != null) {
      parts.add('${compass.overallAvg!.toStringAsFixed(1)}★ avg');
    }
    return parts.join('  ·  ');
  }
}

class _ExpandedDetail extends StatelessWidget {
  const _ExpandedDetail({
    required this.userId,
    required this.match,
    required this.compass,
    required this.dna,
    required this.onUpgradeTap,
    this.onShareTap,
  });

  final String userId;
  final ArchetypeMatch match;
  final TasteCompassEntity compass;
  final UserStyleDna? dna;
  final VoidCallback onUpgradeTap;

  /// Provided only on surfaces where sharing this identity is the
  /// caller's intent (own profile). Friend-profile embeds leave this
  /// null so the button never appears for someone else's identity.
  final VoidCallback? onShareTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: context.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  match.archetype.tagline,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontStyle: FontStyle.italic,
                    color: cs.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(width: context.s),
              DnaShape(
                dna: dna,
                color: match.archetype.color,
                size: context.w * 0.22,
              ),
            ],
          ),
          SizedBox(height: context.m),
          TasteTraits(userId: userId),
          if (onShareTap != null) ...[
            SizedBox(height: context.m),
            SizedBox(
              width: double.infinity,
              height: context.h * 0.06,
              child: FilledButton.icon(
                onPressed: onShareTap,
                style: FilledButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w * 0.04),
                  ),
                ),
                icon: Icon(
                  PhosphorIconsRegular.shareNetwork,
                  size: context.bodyFont,
                ),
                label: Text(
                  'Share',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Hairline extends StatelessWidget {
  const _Hairline({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: color.withValues(alpha: 0.35),
    );
  }
}
