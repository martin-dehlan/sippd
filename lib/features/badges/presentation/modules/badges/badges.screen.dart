import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/services/analytics/analytics.provider.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/badges.provider.dart';
import '../../../domain/entities/badge.entity.dart';
import '../../widgets/badge_card.widget.dart';
import '../../widgets/badge_detail_sheet.widget.dart';

const _categoryOrder = ['volume', 'type', 'geo', 'grape', 'social', 'engagement'];

class BadgesScreen extends ConsumerStatefulWidget {
  const BadgesScreen({super.key});

  @override
  ConsumerState<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends ConsumerState<BadgesScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(analyticsProvider).capture('badge_grid_viewed');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final badgesAsync = ref.watch(myBadgesProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(PhosphorIconsRegular.arrowLeft, color: cs.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.badgesTitle,
          style: TextStyle(
            fontSize: context.titleFont * 0.7,
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
          ),
        ),
      ),
      body: badgesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _ErrorState(
          onRetry: () => ref.read(myBadgesProvider.notifier).refresh(),
        ),
        data: (badges) => badges.isEmpty
            ? _EmptyState(l10n: l10n)
            : _BadgesBody(badges: badges),
      ),
    );
  }
}

class _BadgesBody extends StatelessWidget {
  const _BadgesBody({required this.badges});

  final List<BadgeEntity> badges;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final earned = badges.where((b) => b.earned).length;

    final grouped = <String, List<BadgeEntity>>{};
    for (final b in badges) {
      grouped.putIfAbsent(b.category, () => []).add(b);
    }
    final cats = _categoryOrder.where(grouped.containsKey).toList();

    return ListView(
      padding: EdgeInsets.fromLTRB(
        context.paddingH,
        context.m,
        context.paddingH,
        context.xxl,
      ),
      children: [
        _SummaryHeader(earned: earned, total: badges.length),
        SizedBox(height: context.l),
        for (final cat in cats) ...[
          Text(
            _categoryLabel(cat, l10n),
            style: TextStyle(
              fontSize: context.bodyFont * 1.05,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: context.m),
          _BadgeGrid(badges: grouped[cat]!),
          SizedBox(height: context.l),
        ],
      ],
    );
  }

  static String _categoryLabel(String cat, AppLocalizations l10n) {
    switch (cat) {
      case 'volume':
        return l10n.badgesCategoryVolume;
      case 'type':
        return l10n.badgesCategoryType;
      case 'geo':
        return l10n.badgesCategoryGeo;
      case 'grape':
        return l10n.badgesCategoryGrape;
      case 'social':
        return l10n.badgesCategorySocial;
      case 'engagement':
        return l10n.badgesCategoryEngagement;
      default:
        return cat;
    }
  }
}

class _BadgeGrid extends StatelessWidget {
  const _BadgeGrid({required this.badges});

  final List<BadgeEntity> badges;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: badges.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: context.m,
        crossAxisSpacing: context.w * 0.02,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, i) {
        final badge = badges[i];
        return BadgeCard(
          badge: badge,
          onTap: () => showBadgeDetailSheet(context, badge),
        );
      },
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.earned, required this.total});

  final int earned;
  final int total;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final fraction = total == 0 ? 0.0 : earned / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.badgesEarnedCount(earned, total),
          style: TextStyle(
            fontSize: context.bodyFont,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        SizedBox(height: context.s),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.w * 0.02),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: context.h * 0.008,
            backgroundColor: cs.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.paddingH),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIconsFill.trophy, size: context.w * 0.18, color: cs.outline),
            SizedBox(height: context.m),
            Text(
              l10n.badgesEmptyTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              l10n.badgesEmptyBody,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: context.captionFont, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(PhosphorIconsRegular.arrowClockwise, size: context.w * 0.1, color: cs.outline),
          SizedBox(height: context.m),
          TextButton(onPressed: onRetry, child: Text(l10n.badgesRetry)),
        ],
      ),
    );
  }
}
