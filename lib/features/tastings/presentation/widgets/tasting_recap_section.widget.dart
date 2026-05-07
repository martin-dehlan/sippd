import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../../groups/controller/group.provider.dart';
import '../../../profile/presentation/widgets/profile_avatar.widget.dart';
import '../../../share_cards/controller/share_card.provider.dart';
import '../../../share_cards/presentation/cards/tasting_recap_card.widget.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../controller/tastings.provider.dart';
import '../../domain/entities/tasting_attendee.entity.dart';
import '../../domain/entities/tasting_recap_entry.entity.dart';

/// Concluded-state replacement for the planning lineup. Surfaces the
/// top wine of the night, then a ranked list of every bottle with its
/// per-attendee breakdown so the group can re-litigate the night
/// without scrolling away. Share-recap CTA renders the F3 IG-story
/// share card via [ShareCardService.shareTastingRecapCard].
class TastingRecapSection extends ConsumerWidget {
  const TastingRecapSection({
    super.key,
    required this.tastingId,
    required this.groupId,
    required this.tastingTitle,
    required this.scheduledAt,
    this.location,
  });

  final String tastingId;
  final String groupId;
  final String tastingTitle;
  final DateTime scheduledAt;
  final String? location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(tastingWinesProvider(tastingId));
    final entriesAsync = ref.watch(tastingRecapEntriesProvider(tastingId));

    final wines = winesAsync.valueOrNull;
    final entries = entriesAsync.valueOrNull;
    // Loading vs empty needs distinguishing — non-rating attendees hit
    // this surface with cold cache, so before either provider resolves
    // we'd otherwise flash the "no ratings yet" placeholder. Treat
    // "still null and no error" as loading; once data arrives, the
    // computation below decides between empty-state and full results.
    final stillLoading =
        (wines == null && !winesAsync.hasError) ||
        (entries == null && !entriesAsync.hasError);

    if (stillLoading) {
      return _SectionShell(
        cs: cs,
        shareEnabled: false,
        onShare: () {},
        body: _LoadingBody(cs: cs),
      );
    }

    final safeWines = wines ?? const <WineEntity>[];
    final safeEntries = entries ?? const <TastingRecapEntry>[];

    final byCanonical = <String, List<TastingRecapEntry>>{};
    for (final e in safeEntries) {
      byCanonical.putIfAbsent(e.canonicalWineId, () => []).add(e);
    }

    final ranked =
        safeWines.map((w) {
          final cid = w.canonicalWineId ?? w.id;
          final ratings = byCanonical[cid] ?? const <TastingRecapEntry>[];
          final avg = ratings.isEmpty
              ? null
              : ratings.map((r) => r.rating).reduce((a, b) => a + b) /
                    ratings.length;
          return _RankedWine(wine: w, ratings: ratings, avg: avg);
        }).toList()..sort((a, b) {
          final aHas = a.avg != null;
          final bHas = b.avg != null;
          if (aHas != bHas) return aHas ? -1 : 1;
          if (a.avg == null) return 0;
          return b.avg!.compareTo(a.avg!);
        });

    final top = ranked.firstOrNull;
    final hasAnyRating = top?.avg != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'RESULTS',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.72),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              _ShareRecapButton(
                cs: cs,
                enabled: hasAnyRating,
                onTap: () => _share(context, ref, ranked),
              ),
            ],
          ),
        ),
        if (!hasAnyRating)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.paddingH * 1.3,
              vertical: context.l,
            ),
            child: _NoRatingsYet(cs: cs),
          )
        else ...[
          SizedBox(height: context.m),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: _TopWineCard(top: top!, cs: cs),
          ),
          SizedBox(height: context.l),
          Consumer(
            builder: (_, innerRef, _) {
              final myUid = innerRef.watch(currentUserIdProvider);
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: context.paddingH * 1.3,
                ),
                itemCount: ranked.length,
                separatorBuilder: (_, _) => Padding(
                  padding: EdgeInsets.symmetric(vertical: context.s),
                  child: Divider(
                    color: cs.outlineVariant.withValues(alpha: 0.6),
                    height: 1,
                  ),
                ),
                itemBuilder: (_, i) => _RecapWineRow(
                  rank: i + 1,
                  item: ranked[i],
                  cs: cs,
                  currentUserId: myUid,
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

class _RankedWine {
  final WineEntity wine;
  final List<TastingRecapEntry> ratings;
  final double? avg;
  _RankedWine({required this.wine, required this.ratings, required this.avg});
}

/// Wraps the section in the standard header (RESULTS + Share button) so
/// the loading state shows the same chrome as the loaded state — avoids
/// the section "appearing" once data arrives.
class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.cs,
    required this.shareEnabled,
    required this.onShare,
    required this.body,
  });

  final ColorScheme cs;
  final bool shareEnabled;
  final VoidCallback onShare;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'RESULTS',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.72),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              _ShareRecapButton(cs: cs, enabled: shareEnabled, onTap: onShare),
            ],
          ),
        ),
        body,
      ],
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH * 1.3,
        vertical: context.l,
      ),
      child: Center(
        child: SizedBox(
          width: context.w * 0.06,
          height: context.w * 0.06,
          child: CircularProgressIndicator(strokeWidth: 2, color: cs.primary),
        ),
      ),
    );
  }
}

extension on TastingRecapSection {
  Future<void> _share(
    BuildContext context,
    WidgetRef ref,
    List<_RankedWine> ranked,
  ) async {
    final group = ref.read(groupDetailProvider(groupId)).valueOrNull;
    final attendees =
        ref.read(tastingAttendeesProvider(tastingId)).valueOrNull ??
        const <TastingAttendeeEntity>[];
    final goingCount = attendees
        .where((a) => a.status == RsvpStatus.going)
        .length;
    final top = ranked.firstWhere(
      (w) => w.avg != null,
      orElse: () => ranked.first,
    );
    final data = TastingRecapCardData(
      groupName: group?.name ?? 'Group tasting',
      tastingTitle: tastingTitle,
      date: scheduledAt,
      location: location,
      topWineName: top.avg == null ? null : top.wine.name,
      topWineWinery: top.wine.winery,
      topWineVintage: top.wine.vintage,
      topWineAvg: top.avg,
      ranked: [
        for (final r in ranked)
          TastingRecapCardLine(name: r.wine.name, avg: r.avg),
      ],
      attendeeCount: goingCount,
    );
    await ref
        .read(shareCardProvider)
        .shareTastingRecapCard(
          context: context,
          tastingId: tastingId,
          data: data,
          source: 'concluded_recap',
        );
  }
}

class _ShareRecapButton extends StatelessWidget {
  const _ShareRecapButton({
    required this.cs,
    required this.enabled,
    required this.onTap,
  });

  final ColorScheme cs;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final inner = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          PhosphorIconsRegular.shareNetwork,
          size: context.w * 0.04,
          color: cs.primary,
        ),
        SizedBox(width: context.w * 0.012),
        Text(
          'Share recap',
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w600,
            color: cs.primary,
          ),
        ),
      ],
    );
    if (!enabled) return Opacity(opacity: 0.45, child: inner);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: inner,
    );
  }
}

class _NoRatingsYet extends StatelessWidget {
  const _NoRatingsYet({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(
            PhosphorIconsRegular.wine,
            size: context.bodyFont * 1.2,
            color: cs.onSurfaceVariant,
          ),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Text(
              'No ratings submitted for this tasting yet.',
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

class _TopWineCard extends StatelessWidget {
  const _TopWineCard({required this.top, required this.cs});
  final _RankedWine top;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final wine = top.wine;
    final subtitle = [
      if (wine.winery != null && wine.winery!.isNotEmpty) wine.winery!,
      if (wine.vintage != null) wine.vintage.toString(),
    ].join(' · ');

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.045),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIconsFill.trophy,
            size: context.titleFont,
            color: cs.onPrimaryContainer,
          ),
          SizedBox(width: context.w * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOP WINE OF THE NIGHT',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color: cs.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
                SizedBox(height: context.xs),
                Text(
                  wine.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 0.85,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: cs.onPrimaryContainer,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: context.xs * 0.6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: context.w * 0.02),
          _AvgPill(value: top.avg!, cs: cs, onPrimary: true),
        ],
      ),
    );
  }
}

/// Tap-to-expand recap row. Collapsed: rank + wine name + avg pill +
/// caret. Expanded: same head plus a stack of lean per-rater bars
/// (avatar floats along the fill, mirroring the group-rating sheet
/// chrome at ~70% scale so they read as a quick scan rather than a
/// full leaderboard).
class _RecapWineRow extends StatefulWidget {
  const _RecapWineRow({
    required this.rank,
    required this.item,
    required this.cs,
    required this.currentUserId,
  });

  final int rank;
  final _RankedWine item;
  final ColorScheme cs;
  final String? currentUserId;

  @override
  State<_RecapWineRow> createState() => _RecapWineRowState();
}

class _RecapWineRowState extends State<_RecapWineRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    final canExpand = widget.item.ratings.isNotEmpty;
    // Bars sorted high→low so the top rater is on top — same ordering
    // the group rating sheet uses for parity.
    final sortedRatings = [...widget.item.ratings]
      ..sort((a, b) => b.rating.compareTo(a.rating));

    return InkWell(
      onTap: canExpand ? () => setState(() => _expanded = !_expanded) : null,
      borderRadius: BorderRadius.circular(context.w * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.xs * 0.6),
            child: Row(
              children: [
                SizedBox(
                  width: context.w * 0.06,
                  child: Text(
                    '${widget.rank}.',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.item.wine.name,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: context.w * 0.02),
                if (widget.item.avg != null)
                  _AvgPill(value: widget.item.avg!, cs: cs, onPrimary: false)
                else
                  Text(
                    'no ratings',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.outline,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                SizedBox(width: context.w * 0.02),
                Icon(
                  canExpand
                      ? (_expanded
                            ? PhosphorIconsRegular.caretUp
                            : PhosphorIconsRegular.caretDown)
                      : PhosphorIconsRegular.minus,
                  size: context.captionFont * 1.05,
                  color: canExpand
                      ? cs.onSurfaceVariant
                      : cs.outlineVariant,
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: _expanded && canExpand
                ? Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.w * 0.06,
                      context.xs,
                      0,
                      context.s,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final r in sortedRatings)
                          Padding(
                            padding: EdgeInsets.only(bottom: context.s),
                            child: _LeanRaterBar(
                              entry: r,
                              isMe: r.userId == widget.currentUserId,
                              cs: cs,
                            ),
                          ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

/// Compact ranking bar used inside the recap row when expanded.
/// Mirrors the group-rating sheet bar (avatar floats along the fill)
/// at ~70% scale so it reads as quick context rather than a full
/// leaderboard.
class _LeanRaterBar extends StatelessWidget {
  const _LeanRaterBar({
    required this.entry,
    required this.isMe,
    required this.cs,
  });

  final TastingRecapEntry entry;
  final bool isMe;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final label = (entry.displayName?.trim().isNotEmpty ?? false)
        ? entry.displayName!.trim()
        : (entry.username?.trim().isNotEmpty ?? false)
        ? entry.username!.trim()
        : 'Friend';
    final pct = (entry.rating / 10).clamp(0.0, 1.0);
    final barH = context.w * 0.058;
    final avatarSize = barH;
    final fillColor = isMe
        ? cs.primary
        : cs.onSurfaceVariant.withValues(alpha: 0.32);

    return Row(
      children: [
        SizedBox(
          width: context.w * 0.20,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              color: cs.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: context.xs),
        Expanded(
          child: LayoutBuilder(
            builder: (_, c) {
              final trackW = c.maxWidth;
              return TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeOutCubic,
                tween: Tween(begin: 0.0, end: pct),
                builder: (_, animPct, _) {
                  final fillW = (trackW * animPct).clamp(avatarSize, trackW);
                  final avatarLeft = (fillW - avatarSize).clamp(
                    0.0,
                    trackW - avatarSize,
                  );
                  return SizedBox(
                    width: trackW,
                    height: barH,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: cs.surfaceContainer,
                              borderRadius: BorderRadius.circular(barH / 2),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          width: fillW,
                          child: Container(
                            decoration: BoxDecoration(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(barH / 2),
                            ),
                          ),
                        ),
                        Positioned(
                          left: avatarLeft,
                          top: 0,
                          bottom: 0,
                          width: avatarSize,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cs.surface,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: ClipOval(
                              child: ProfileAvatar(
                                avatarUrl: entry.avatarUrl,
                                fallbackText: label,
                                size: avatarSize - 4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(width: context.s),
        SizedBox(
          width: context.w * 0.08,
          child: Text(
            entry.rating.toStringAsFixed(1),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.captionFont * 1.05,
              fontWeight: FontWeight.w800,
              color: isMe ? cs.primary : cs.onSurfaceVariant,
              fontFeatures: tabularFigures,
            ),
          ),
        ),
      ],
    );
  }
}

class _AvgPill extends StatelessWidget {
  const _AvgPill({
    required this.value,
    required this.cs,
    required this.onPrimary,
  });
  final double value;
  final ColorScheme cs;
  final bool onPrimary;

  @override
  Widget build(BuildContext context) {
    final fg = onPrimary ? cs.onPrimaryContainer : cs.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.bodyFont * 1.15,
            fontWeight: FontWeight.bold,
            color: fg,
            fontFeatures: tabularFigures,
          ),
        ),
        SizedBox(width: context.w * 0.008),
        Text(
          '/ 10',
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            color: fg.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
