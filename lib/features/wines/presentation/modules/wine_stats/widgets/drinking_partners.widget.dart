import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../../groups/domain/entities/drinking_partner.entity.dart';

/// Top users the caller has co-rated wines with inside groups. Mirrors
/// the visual rhythm of [TopWinesList] — first place gets the crown
/// border, the rest sit in a calm vertical list.
class DrinkingPartners extends StatelessWidget {
  final List<DrinkingPartnerEntity> partners;

  const DrinkingPartners({super.key, required this.partners});

  @override
  Widget build(BuildContext context) {
    final visible = partners.take(5).toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SourceHint(),
        SizedBox(height: context.s),
        Column(
          children: [
            for (int i = 0; i < visible.length; i++) ...[
              if (i > 0) SizedBox(height: context.s),
              _PartnerRow(
                rank: i + 1,
                partner: visible[i],
                delay: i * 60,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// Inline note explaining the group-only data source. Quiet — sits above
/// the list as a one-liner so the user always knows why their solo
/// drinking buddy isn't on the list.
class _SourceHint extends StatelessWidget {
  const _SourceHint();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.xs * 0.9,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.025),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(
            PhosphorIconsRegular.info,
            size: context.captionFont * 1.1,
            color: cs.onSurfaceVariant,
          ),
          SizedBox(width: context.xs * 1.2),
          Expanded(
            child: Text(
              'Counts wines rated together inside shared groups.',
              style: TextStyle(
                fontSize: context.captionFont * 0.95,
                color: cs.onSurfaceVariant,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PartnerRow extends StatelessWidget {
  final int rank;
  final DrinkingPartnerEntity partner;
  final int delay;

  const _PartnerRow({
    required this.rank,
    required this.partner,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isFirst = rank == 1;
    final size = context.w * 0.11;

    return Animate(
      effects: [
        FadeEffect(
          duration: 360.ms,
          delay: Duration(milliseconds: delay),
        ),
        SlideEffect(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
          duration: 360.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeOut,
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.03,
          vertical: context.s,
        ),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(
            color: isFirst
                ? cs.primary.withValues(alpha: 0.5)
                : cs.outlineVariant,
            width: isFirst ? 1 : 0.5,
          ),
        ),
        child: Row(
          children: [
            _AvatarWithRank(partner: partner, rank: rank, size: size),
            SizedBox(width: context.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _displayName(partner),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  if (partner.username != null &&
                      partner.username!.isNotEmpty &&
                      partner.username != partner.displayName) ...[
                    SizedBox(height: context.xs * 0.5),
                    Text(
                      '@${partner.username}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.s),
            _CountPill(count: partner.sharedWines, isFirst: isFirst),
          ],
        ),
      ),
    );
  }
}

class _AvatarWithRank extends StatelessWidget {
  final DrinkingPartnerEntity partner;
  final int rank;
  final double size;

  const _AvatarWithRank({
    required this.partner,
    required this.rank,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _Avatar(partner: partner, size: size),
          // Rank badge sits in the bottom-right corner so the avatar
          // stays the focal point. Rank 1 swaps the number for a crown
          // (matches TopWinesList).
          Positioned(
            right: -size * 0.05,
            bottom: -size * 0.05,
            child: Container(
              width: size * 0.42,
              height: size * 0.42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: rank == 1 ? cs.primary : cs.surfaceContainer,
                shape: BoxShape.circle,
                border: Border.all(color: cs.surface, width: 2),
              ),
              child: rank == 1
                  ? Icon(
                      PhosphorIconsFill.crown,
                      color: cs.onPrimary,
                      size: size * 0.22,
                    )
                  : Text(
                      '$rank',
                      style: TextStyle(
                        fontSize: size * 0.22,
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface,
                        height: 1,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final DrinkingPartnerEntity partner;
  final double size;
  const _Avatar({required this.partner, required this.size});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final url = partner.avatarUrl;
    if (url != null && url.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (_, _) => _initialsFallback(context, cs),
          errorWidget: (_, _, _) => _initialsFallback(context, cs),
        ),
      );
    }
    return _initialsFallback(context, cs);
  }

  Widget _initialsFallback(BuildContext context, ColorScheme cs) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _initials(),
          style: GoogleFonts.playfairDisplay(
            fontSize: size * 0.42,
            fontWeight: FontWeight.w900,
            color: cs.primary,
            letterSpacing: -0.5,
            height: 1,
          ),
        ),
      ),
    );
  }

  String _initials() {
    final name = partner.displayName ?? partner.username ?? '?';
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    if (trimmed.length < 2) return trimmed.toUpperCase();
    return trimmed.substring(0, 2).toUpperCase();
  }
}

class _CountPill extends StatelessWidget {
  final int count;
  final bool isFirst;
  const _CountPill({required this.count, required this.isFirst});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.s,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: isFirst ? cs.primary : cs.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsFill.wine,
            size: context.captionFont * 1.05,
            color: isFirst ? cs.onPrimary : cs.primary,
          ),
          SizedBox(width: context.xs * 0.7),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: context.bodyFont * 0.95,
              fontWeight: FontWeight.w800,
              color: isFirst ? cs.onPrimary : cs.primary,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

String _displayName(DrinkingPartnerEntity p) {
  final n = (p.displayName ?? p.username ?? '').trim();
  return n.isEmpty ? 'Wine friend' : n;
}

/// Skeleton state used while the RPC is in flight.
class DrinkingPartnersSkeleton extends StatelessWidget {
  const DrinkingPartnersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SkeletonBox(
            width: double.infinity,
            height: context.captionFont * 2.4,
            radius: context.w * 0.025,
          ),
          SizedBox(height: context.s),
          for (int i = 0; i < 3; i++) ...[
            if (i > 0) SizedBox(height: context.s),
            _RowSkeleton(cs: cs),
          ],
        ],
      ),
    );
  }
}

class _RowSkeleton extends StatelessWidget {
  final ColorScheme cs;
  const _RowSkeleton({required this.cs});

  @override
  Widget build(BuildContext context) {
    final size = context.w * 0.11;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.s,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          SkeletonBox.circle(size: size),
          SizedBox(width: context.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: context.w * 0.4, height: context.bodyFont),
                SizedBox(height: context.xs * 0.6),
                SkeletonBox(
                  width: context.w * 0.25,
                  height: context.captionFont,
                ),
              ],
            ),
          ),
          SizedBox(width: context.s),
          SkeletonBox(
            width: context.w * 0.16,
            height: context.bodyFont * 1.7,
            radius: context.w * 0.03,
          ),
        ],
      ),
    );
  }
}
