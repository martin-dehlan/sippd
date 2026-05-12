import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../wines/presentation/widgets/wine_thumb.widget.dart';
import '../../../../../../core/routes/app.routes.dart';
import '../../../../../auth/controller/auth.provider.dart';
import '../../../../../wines/domain/entities/wine.entity.dart';
import '../../../../controller/group.provider.dart';
import '../../../../domain/entities/group_wine_rating.entity.dart';
import 'group_wine_rating_sheet.widget.dart';
import 'wine_picker_sheet.widget.dart';

class _RatingFooter extends StatelessWidget {
  final List<GroupWineRatingEntity> ratings;
  final double fallback;
  final VoidCallback onDetails;

  const _RatingFooter({
    required this.ratings,
    required this.fallback,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasRatings = ratings.isNotEmpty;
    final avg = hasRatings
        ? ratings.map((r) => r.rating).reduce((a, b) => a + b) / ratings.length
        : fallback;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          avg.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.titleFont * 0.85,
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
            height: 1,
            letterSpacing: -1,
          ),
        ),
        SizedBox(width: context.xs * 0.5),
        Padding(
          padding: EdgeInsets.only(top: context.xs * 0.8),
          child: Text(
            '/10',
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
        const Spacer(),
        _DetailsButton(onTap: onDetails),
      ],
    );
  }
}

class _DetailsButton extends StatelessWidget {
  final VoidCallback onTap;
  const _DetailsButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Material(
      color: cs.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(context.w * 0.025),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.03,
            vertical: context.xs * 1.1,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.groupWineCarouselDetails,
                style: TextStyle(
                  fontSize: context.captionFont * 0.9,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(width: context.xs * 0.6),
              Icon(
                PhosphorIconsRegular.arrowRight,
                size: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SharedWinesCarousel extends ConsumerStatefulWidget {
  final String groupId;
  const SharedWinesCarousel({super.key, required this.groupId});

  @override
  ConsumerState<SharedWinesCarousel> createState() =>
      _SharedWinesCarouselState();
}

class _SharedWinesCarouselState extends ConsumerState<SharedWinesCarousel> {
  late final PageController _pageController = PageController(
    viewportFraction: 0.62,
  );
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() => _page = _pageController.page ?? 0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final winesAsync = ref.watch(groupWinesProvider(widget.groupId));
    final ranks =
        ref.watch(groupWineRanksProvider(widget.groupId)).valueOrNull ??
        const <String, int>{};

    return winesAsync.when(
      // Keep showing the previous wine list while a save / refresh is
      // in flight — without this, every group_wines_provider invalidate
      // (owner-rates-own-wine path) flashes the whole carousel back
      // through the skeleton state.
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      data: (wines) {
        if (wines.isEmpty) {
          return _EmptyShared(
            onShare: () =>
                WinePickerSheet.show(context, groupId: widget.groupId),
          );
        }
        final sorted = [...wines]
          ..sort((a, b) {
            final ra = ranks[a.canonicalWineId ?? a.id];
            final rb = ranks[b.canonicalWineId ?? b.id];
            if (ra == null && rb == null) return 0;
            if (ra == null) return 1;
            if (rb == null) return -1;
            return ra.compareTo(rb);
          });
        return SizedBox(
          height: context.h * 0.28,
          child: PageView.builder(
            controller: _pageController,
            itemCount: sorted.length,
            padEnds: true,
            clipBehavior: Clip.none,
            itemBuilder: (_, i) {
              final delta = (i - _page).abs().clamp(0.0, 2.0);
              final scale = (1 - delta * 0.12).clamp(0.76, 1.0);
              final opacity = (1 - delta * 0.35).clamp(0.3, 1.0);
              final translate = delta * context.w * 0.03;
              return Transform.translate(
                offset: Offset(0, translate),
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: _WineCard(
                      groupId: widget.groupId,
                      wine: sorted[i],
                      isActive: delta < 0.5,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const _CarouselSkeleton(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _EmptyShared extends StatelessWidget {
  final VoidCallback onShare;
  const _EmptyShared({required this.onShare});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _EmptyStateCard(
      icon: PhosphorIconsRegular.wine,
      title: l10n.groupWineCarouselEmptyTitle,
      subtitle: l10n.groupWineCarouselEmptyBody,
      buttonLabel: l10n.groupWineCarouselEmptyCta,
      buttonIcon: PhosphorIconsRegular.plus,
      onTap: onShare,
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final IconData buttonIcon;
  final VoidCallback onTap;

  const _EmptyStateCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.buttonIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.06,
          vertical: context.l,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHigh.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(context.w * 0.05),
          border: Border.all(
            color: cs.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: context.w * 0.14,
              height: context.w * 0.14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.surfaceContainerHighest,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: context.w * 0.07,
                color: cs.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.m),
            Text(
              title,
              style: TextStyle(
                fontSize: context.bodyFont * 1.05,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont * 1.05,
                color: cs.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            SizedBox(height: context.m),
            Material(
              color: cs.primary,
              borderRadius: BorderRadius.circular(context.w * 0.1),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w * 0.06,
                    vertical: context.s * 1.2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        buttonIcon,
                        size: context.w * 0.045,
                        color: cs.onPrimary,
                      ),
                      SizedBox(width: context.w * 0.015),
                      Text(
                        buttonLabel,
                        style: TextStyle(
                          fontSize: context.captionFont * 1.1,
                          fontWeight: FontWeight.w700,
                          color: cs.onPrimary,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselSkeleton extends StatelessWidget {
  const _CarouselSkeleton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cardWidth = context.w * 0.56;
    final cardHeight = context.h * 0.24;
    return SizedBox(
      height: context.h * 0.28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: context.w * 0.08),
        itemCount: 3,
        itemBuilder: (_, i) {
          final scale = i == 1 ? 1.0 : 0.88;
          final opacity = i == 1 ? 1.0 : 0.6;
          return Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: cardWidth,
                  height: cardHeight,
                  margin: EdgeInsets.symmetric(horizontal: context.w * 0.015),
                  padding: EdgeInsets.all(context.w * 0.05),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(context.w * 0.05),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: context.captionFont * 1.8,
                        width: context.w * 0.14,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(context.w * 0.02),
                        ),
                      ),
                      SizedBox(height: context.m),
                      Container(
                        height: context.bodyFont * 1.1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(context.w * 0.01),
                        ),
                      ),
                      SizedBox(height: context.xs),
                      Container(
                        height: context.captionFont,
                        width: context.w * 0.3,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(context.w * 0.01),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WineCard extends ConsumerWidget {
  final String groupId;
  final WineEntity wine;
  final bool isActive;
  const _WineCard({
    required this.groupId,
    required this.wine,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final ratingsAsync = ref.watch(groupWineRatingsProvider(groupId, wine.id));
    final ranksAsync = ref.watch(groupWineRanksProvider(groupId));
    final rank = ranksAsync.valueOrNull?[wine.canonicalWineId ?? wine.id];
    final currentUserId = ref.watch(currentUserIdProvider);
    final isOwner = currentUserId != null && wine.userId == currentUserId;
    final l10n = AppLocalizations.of(context);
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
      WineType.sparkling => const Color(0xFFD4A84B),
    };

    void openRateSheet() => showGroupWineRatingSheet(
      context: context,
      groupId: groupId,
      wine: wine,
    );

    return GestureDetector(
      onTap: openRateSheet,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.w * 0.01),
        padding: EdgeInsets.all(context.w * 0.05),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(context.w * 0.05),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _TypePill(label: _typeLabel(l10n, wine.type), color: typeColor),
                const Spacer(),
                if (rank != null) _RankBadge(rank: rank),
              ],
            ),
            SizedBox(height: context.s),
            Expanded(
              child: _WineImageArea(wine: wine, typeColor: typeColor),
            ),
            SizedBox(height: context.s),
            Text(
              wine.name,
              style: TextStyle(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                height: 1.15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.xs * 0.5),
            Text(
              [
                if (wine.vintage != null) wine.vintage.toString(),
                if (wine.country != null) wine.country,
              ].join(' · '),
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.xs),
            _RatingFooter(
              ratings: ratingsAsync.valueOrNull ?? const [],
              fallback: wine.rating,
              onDetails: () {
                if (isOwner) {
                  context.push(AppRoutes.wineDetailPath(wine.id), extra: wine);
                } else {
                  final cid = wine.canonicalWineId ?? wine.id;
                  context.push(
                    AppRoutes.groupWineDetailPath(groupId, cid),
                    extra: wine,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(AppLocalizations l10n, WineType type) => switch (type) {
    WineType.red => l10n.groupWineTypeRed,
    WineType.white => l10n.groupWineTypeWhite,
    WineType.rose => l10n.groupWineTypeRose,
    WineType.sparkling => l10n.groupWineTypeSparkling,
  };
}

class _WineImageArea extends StatelessWidget {
  final WineEntity wine;
  final Color typeColor;
  const _WineImageArea({required this.wine, required this.typeColor});

  @override
  Widget build(BuildContext context) {
    final size = context.w * 0.22;
    // Use the shared resolver so newly-added / offline wines that only
    // have a `localImagePath` show their photo here too — matching the
    // main wine list. Without this the carousel would only render after
    // Supabase upload completed and `imageUrl` was populated.
    final image = resolveWineImage(wine);
    final placeholder = Icon(
      PhosphorIconsRegular.wine,
      size: size * 0.55,
      color: typeColor.withValues(alpha: 0.6),
    );
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: typeColor.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: image != null
            ? ClipOval(
                child: Image(
                  image: image,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => placeholder,
                ),
              )
            : placeholder,
      ),
    );
  }
}

class _TypePill extends StatelessWidget {
  final String label;
  final Color color;
  const _TypePill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.022,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.w * 0.015),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.w * 0.018,
            height: context.w * 0.018,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: context.xs),
          Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont * 0.8,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;
  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.025,
        vertical: context.xs * 1.2,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Text(
        '#$rank',
        style: TextStyle(
          fontSize: context.captionFont * 1.0,
          fontWeight: FontWeight.w800,
          color: cs.onSurface,
          height: 1,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}
