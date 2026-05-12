import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../../wines/presentation/widgets/wine_detail_blocks.widget.dart';
import '../../../controller/group_ratings.provider.dart';
import '../../../controller/group_wines_query.provider.dart';
import '../../../domain/entities/group_wine_rating.entity.dart';
import '../../../domain/entities/group_wine_share.entity.dart';

class GroupWineDetailScreen extends ConsumerWidget {
  final String groupId;
  final String canonicalWineId;
  final WineEntity? initial;

  const GroupWineDetailScreen({
    super.key,
    required this.groupId,
    required this.canonicalWineId,
    this.initial,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(groupWinesProvider(groupId));
    final list = winesAsync.valueOrNull;
    WineEntity? matched;
    if (list != null) {
      for (final w in list) {
        if (w.canonicalWineId == canonicalWineId) {
          matched = w;
          break;
        }
      }
    }
    final wine = matched ?? initial;

    return Scaffold(
      body: wine == null
          ? const Center(child: CircularProgressIndicator())
          : _Body(wine: wine, groupId: groupId),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _Body extends ConsumerWidget {
  final WineEntity wine;
  final String groupId;

  const _Body({required this.wine, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canonicalId = wine.canonicalWineId ?? wine.id;
    final ratingsAsync = ref.watch(
      groupWineRatingsProvider(groupId, canonicalId),
    );
    final shareAsync = ref.watch(
      groupWineShareDetailsProvider(groupId, canonicalId),
    );

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: context.xl * 1.5),
          WineDetailTitle(name: wine.name),
          SizedBox(height: context.s),
          WineDetailMetaLine(
            type: wine.type,
            winery: wine.winery,
            vintage: wine.vintage,
            canonicalGrapeId: wine.canonicalGrapeId,
            grapeFreetext: wine.grapeFreetext,
            legacyGrape: wine.grape,
          ),
          SizedBox(height: context.xl),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            // Lower-bound the row height so the wine image always
            // gets enough room, but let the stats column shrink the
            // upper bound to its natural size on tall phones.
            // IntrinsicHeight prevents the small-viewport overflow
            // where a fixed h * 0.32 (=192px on iPhone SE 1st gen)
            // wasn't enough room for three StatItems + spacing.
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: context.h * 0.28),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(flex: 5, child: WineDetailImage(wine: wine)),
                    Expanded(
                      flex: 4,
                      child: _GroupStatsColumn(
                        wine: wine,
                        ratings: ratingsAsync.valueOrNull ?? const [],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: context.xl),
          shareAsync.when(
            data: (share) => share == null
                ? const SizedBox.shrink()
                : _SharedByBlock(share: share),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          SizedBox(height: context.xl),
          WineDetailSectionHeader(label: l10n.groupWineDetailSectionRatings),
          SizedBox(height: context.m),
          ratingsAsync.when(
            data: (ratings) => _RatingsList(ratings: ratings),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => const _EmptyRatings(),
          ),
          SizedBox(height: context.xxl * 1.5),
        ],
      ),
    );
  }
}

class _GroupStatsColumn extends StatelessWidget {
  final WineEntity wine;
  final List<GroupWineRatingEntity> ratings;

  const _GroupStatsColumn({required this.wine, required this.ratings});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final hasRatings = ratings.isNotEmpty;
    final avg = hasRatings
        ? ratings.map((r) => r.rating).reduce((a, b) => a + b) / ratings.length
        : 0.0;

    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          _StatItem(
            label: l10n.groupWineDetailStatGroupAvg,
            value: hasRatings ? avg.toStringAsFixed(1) : '–',
            unit: '/ 10',
          ),
          SizedBox(height: context.m),
          _StatItem(
            label: hasRatings
                ? l10n.groupWineDetailStatRatings
                : l10n.groupWineDetailStatNoRatings,
            value: hasRatings ? ratings.length.toString() : '0',
          ),
          SizedBox(height: context.m),
          if (wine.region != null)
            _StatItem(
              label: l10n.groupWineDetailStatRegion,
              value: wine.region!,
              isText: true,
            )
          else if (wine.country != null)
            _StatItem(
              label: l10n.groupWineDetailStatCountry,
              value: wine.country!,
              isText: true,
            )
          else
            _StatItem(
              label: l10n.groupWineDetailStatOrigin,
              value: '–',
              isText: true,
              subtleColor: cs.onSurfaceVariant,
            ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final bool isText;
  final Color? subtleColor;

  const _StatItem({
    required this.label,
    required this.value,
    this.unit,
    this.isText = false,
    this.subtleColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: context.captionFont * 0.95,
            fontWeight: FontWeight.w700,
            color: cs.onSurface.withValues(alpha: 0.72),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: context.xs * 0.3),
        if (isText)
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.bold,
              color: subtleColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: context.headingFont * 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unit != null) ...[
                SizedBox(width: context.w * 0.01),
                Text(
                  unit!,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
      ],
    );
  }
}

class _SharedByBlock extends StatelessWidget {
  final GroupWineShareEntity share;
  const _SharedByBlock({required this.share});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final name = share.sharer.displayName ??
        share.sharer.username ??
        l10n.groupWineDetailSharerFallback;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Row(
        children: [
          FriendAvatar(profile: share.sharer, size: context.w * 0.1),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.groupWineDetailSharedByEyebrow,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.9,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.65),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: context.xs * 0.4),
                Text(
                  '$name · ${_relativeTime(share.sharedAt, l10n)}',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingsList extends StatelessWidget {
  final List<GroupWineRatingEntity> ratings;

  const _RatingsList({required this.ratings});

  @override
  Widget build(BuildContext context) {
    if (ratings.isEmpty) return const _EmptyRatings();
    return Column(children: [for (final r in ratings) _RatingRow(rating: r)]);
  }
}

class _RatingRow extends StatelessWidget {
  final GroupWineRatingEntity rating;

  const _RatingRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final name = rating.displayName ??
        rating.username ??
        l10n.groupWineDetailMemberFallback;
    final profile = FriendProfileEntity(
      id: rating.userId,
      username: rating.username,
      displayName: rating.displayName,
      avatarUrl: rating.avatarUrl,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH * 1.3,
        vertical: context.s,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FriendAvatar(profile: profile, size: context.w * 0.11),
          SizedBox(width: context.w * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: context.s),
                    Text(
                      rating.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.05,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: context.xs * 0.4),
                      child: Text(
                        '/10',
                        style: TextStyle(
                          fontSize: context.captionFont * 0.9,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                if (rating.notes != null && rating.notes!.isNotEmpty) ...[
                  SizedBox(height: context.xs * 0.6),
                  Text(
                    rating.notes!,
                    style: TextStyle(
                      fontSize: context.bodyFont * 0.95,
                      color: cs.onSurfaceVariant,
                      height: 1.4,
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

class _EmptyRatings extends StatelessWidget {
  const _EmptyRatings();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH * 1.3,
        vertical: context.l,
      ),
      child: Text(
        l10n.groupWineDetailEmptyRatings,
        style: TextStyle(
          fontSize: context.bodyFont,
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  const _FloatingBackButton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'group-wine-detail-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => Navigator.pop(context),
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}

String _relativeTime(DateTime then, AppLocalizations l10n) {
  final diff = DateTime.now().difference(then);
  if (diff.inMinutes < 1) return l10n.groupWineDetailRelJustNow;
  if (diff.inHours < 1) return l10n.groupWineDetailRelMinutes(diff.inMinutes);
  if (diff.inDays < 1) return l10n.groupWineDetailRelHours(diff.inHours);
  if (diff.inDays < 7) return l10n.groupWineDetailRelDays(diff.inDays);
  if (diff.inDays < 30) {
    return l10n.groupWineDetailRelWeeks((diff.inDays / 7).floor());
  }
  if (diff.inDays < 365) {
    return l10n.groupWineDetailRelMonths((diff.inDays / 30).floor());
  }
  return l10n.groupWineDetailRelYears((diff.inDays / 365).floor());
}
