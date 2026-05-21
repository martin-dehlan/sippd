import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../common/utils/responsive.dart';
import '../../../common/widgets/app_logo.widget.dart';
import '../../../common/widgets/stats_card.widget.dart';
import '../../onboarding/presentation/widgets/onboarding_option_card.widget.dart';
import '../../paywall/presentation/widgets/paywall_benefit.widget.dart';
import '../../paywall/presentation/widgets/paywall_hero.widget.dart';
import '../../paywall/presentation/widgets/paywall_trial_timeline.widget.dart';
import '../../share_cards/presentation/cards/compass_share_card.widget.dart';
import '../../share_cards/presentation/cards/friend_invite_card.widget.dart';
import '../../share_cards/presentation/cards/tasting_recap_card.widget.dart';
import '../../share_cards/presentation/cards/wine_rating_card.widget.dart';
import '../../taste_match/presentation/widgets/archetype_headline.widget.dart';
import '../../taste_match/presentation/widgets/compass_radar.widget.dart';
import '../../taste_match/presentation/widgets/dna_shape.widget.dart';
import '../../taste_match/presentation/widgets/shared_bottles.widget.dart';
import '../../taste_match/presentation/widgets/taste_match_score.widget.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../../wines/presentation/modules/wine_compare/widgets/wine_compare_hero.widget.dart';
import '../../wines/presentation/modules/wine_stats/widgets/drinking_partners.widget.dart';
import '../../wines/presentation/modules/wine_stats/widgets/region_skyline.widget.dart';
import '../../wines/presentation/modules/wine_stats/widgets/top_wines_list.widget.dart';
import '../../wines/presentation/modules/wine_stats/widgets/wine_timeline.widget.dart';
import '../../wines/presentation/modules/wine_stats/widgets/wine_type_breakdown.widget.dart';
import '../../wines/presentation/widgets/wine_card.widget.dart';
import 'widgets/promo_callouts.widget.dart';
import '../../wines/presentation/widgets/wine_detail_blocks.widget.dart';
import '../../wines/presentation/widgets/wine_rating_input.widget.dart';
import '../../wines/presentation/widgets/wine_thumb.widget.dart';
import 'promo_sample_data.dart';

/// Default canvas colour — the app's dark scaffold tone, so every widget
/// renders true-to-app. Transparent PNG cut-outs still come from the
/// tight Screenshot boundary, independent of this backdrop.
const Color kPromoCanvas = Color(0xFF14101A);

/// One showcased item.
///
/// Two shapes:
///  - **single widget** — provide [builder] (+ optional [designSize] for the
///    fixed-canvas 1080×1920 share cards, which the stage FittedBox-scales).
///  - **scene** — provide [slots]: an app-like screen built from several
///    widgets, each of which can pop out into focus and return.
class PromoEntry {
  const PromoEntry({
    required this.name,
    this.builder,
    this.slots,
    this.background = kPromoCanvas,
    this.designSize,
  }) : assert(
         builder != null || slots != null,
         'Provide either a builder (single widget) or slots (scene).',
       );

  final String name;
  final WidgetBuilder? builder;

  /// Non-null marks this entry as a [PromoScene]; each slot is a poppable
  /// widget rendered down the screen.
  final List<WidgetBuilder>? slots;

  final Color background;
  final Size? designSize;

  bool get isScene => slots != null;

  /// Filesystem-safe identifier used when naming exported PNG/MP4 files.
  String get slug => name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'(^_+|_+$)'), '');
}

/// Natural pixel size of the Instagram-story share cards.
const Size _storyCanvas = Size(1080, 1920);

/// The curated promo set. Add entries here — the showcase screen and the
/// debug menu pick them up automatically.
final List<PromoEntry> promoEntries = [
  // ── Share cards (fixed 1080×1920, self-rendering dark canvas) ──
  PromoEntry(
    name: 'Wine Rating Card',
    designSize: _storyCanvas,
    builder: (_) => WineRatingCard(
      wine: PromoSampleData.ratingCardWine,
      username: 'martin',
    ),
  ),
  PromoEntry(
    name: 'Compass Share Card',
    designSize: _storyCanvas,
    builder: (_) => CompassShareCard(data: PromoSampleData.compassCard),
  ),
  PromoEntry(
    name: 'Tasting Recap Card',
    designSize: _storyCanvas,
    builder: (_) => TastingRecapCard(data: PromoSampleData.tastingCard),
  ),
  PromoEntry(
    name: 'Friend Invite Card',
    designSize: _storyCanvas,
    builder: (_) => FriendInviteCard(data: PromoSampleData.friendInviteCard),
  ),

  // ── In-app widgets (responsive, sized to a phone-width box) ──
  PromoEntry(
    name: 'Wine Card',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: WineCardWidget(wine: PromoSampleData.wine, rank: 1),
    ),
  ),
  PromoEntry(
    name: 'Taste DNA Shape',
    builder: (context) => DnaShape(
      dna: PromoSampleData.dna,
      color: PromoSampleData.archetypeColor,
      size: context.w * 0.62,
      strokeWidth: 2.4,
      vertexRadius: 3.2,
    ),
  ),
  PromoEntry(
    name: 'Taste Match Score',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: const TasteMatchScoreWidget(match: PromoSampleData.match),
    ),
  ),
  PromoEntry(
    name: 'Compass Radar',
    builder: (context) => SizedBox(
      width: context.w * 0.86,
      height: context.w * 0.86,
      child: const CompassRadar(axes: PromoSampleData.compassAxes),
    ),
  ),
  PromoEntry(
    name: 'Region Skyline',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: const RegionSkyline(items: PromoSampleData.regions),
    ),
  ),
  PromoEntry(
    name: 'Stats Card',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: const StatsCard(stats: PromoSampleData.stats),
    ),
  ),

  // ── Stats screen ──
  PromoEntry(
    name: 'Top Wines',
    builder: (context) => SizedBox(
      width: context.w * 0.92,
      child: TopWinesList(wines: PromoSampleData.wines),
    ),
  ),
  PromoEntry(
    name: 'Wine Types',
    builder: (context) => SizedBox(
      width: context.w * 0.92,
      child: const WineTypeBreakdown(data: PromoSampleData.typeBreakdown),
    ),
  ),
  PromoEntry(
    name: 'Wine Timeline',
    builder: (context) => SizedBox(
      width: context.w * 0.92,
      child: WineTimeline(months: PromoSampleData.timelineMonths),
    ),
  ),
  PromoEntry(
    name: 'Drinking Partners',
    builder: (context) => SizedBox(
      width: context.w * 0.92,
      child: const DrinkingPartners(partners: PromoSampleData.partners),
    ),
  ),

  // ── Taste ──
  PromoEntry(
    name: 'Archetype Headline',
    builder: (context) => SizedBox(
      width: context.w * 0.92,
      child: const ArchetypeHeadline(
        compass: PromoSampleData.compass,
        dna: PromoSampleData.dna,
      ),
    ),
  ),
  PromoEntry(
    name: 'Shared Bottles',
    builder: (context) => SizedBox(
      width: context.w * 0.92,
      child: const SharedBottlesWidget(bottles: PromoSampleData.sharedBottles),
    ),
  ),

  // ── Paywall ──
  PromoEntry(
    name: 'Paywall Hero',
    builder: (context) => PaywallHero(size: context.w * 0.5),
  ),
  PromoEntry(
    name: 'Paywall Benefit',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: const PaywallBenefitRow(
        icon: PhosphorIconsRegular.infinity,
        title: 'Unlimited tastings',
        subtitle: 'Host as many group flights as you like',
      ),
    ),
  ),
  PromoEntry(
    name: 'Trial Timeline',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: const PaywallTrialTimeline(),
    ),
  ),

  // ── Wine detail / compare ──
  PromoEntry(
    name: 'Compare Hero',
    builder: (context) => SizedBox(
      width: context.w * 0.94,
      child: WineCompareHeroWidget(
        left: PromoSampleData.wines[0],
        right: PromoSampleData.wines[2],
      ),
    ),
  ),
  PromoEntry(
    name: 'Wine Thumb',
    builder: (context) => WineThumb(
      wine: PromoSampleData.wine,
      size: context.w * 0.5,
    ),
  ),
  PromoEntry(
    name: 'Wine Detail Title',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: const WineDetailTitle(name: 'Barolo Riserva'),
    ),
  ),
  PromoEntry(
    name: 'Rating Input',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: WineRatingInput(rating: 8.5, onChanged: (_) {}),
    ),
  ),

  // ── Onboarding / branding ──
  PromoEntry(
    name: 'Onboarding Card',
    builder: (context) => SizedBox(
      width: context.w * 0.9,
      child: OnboardingOptionCard(
        label: 'Red wine',
        subtitle: 'My usual pour',
        emoji: '🍷',
        selected: true,
        onTap: () {},
      ),
    ),
  ),
  PromoEntry(
    name: 'App Logo',
    builder: (context) => AppLogo(size: context.w * 0.4),
  ),

  // ── Overlay callouts: background-free highlight chips for the edit ──
  PromoEntry(
    name: 'Callout · Rating',
    builder: (context) => const PromoRatingBadge(rating: 9.2),
  ),
  PromoEntry(
    name: 'Callout · Price',
    builder: (context) => const PromoPriceTag(price: 48),
  ),
  PromoEntry(
    name: 'Callout · Region',
    builder: (context) => const PromoRegionChip(label: 'Piedmont'),
  ),
  PromoEntry(
    name: 'Callout · Wine Type',
    builder: (context) => const WineTypeBadge(type: WineType.red),
  ),

  // ── Individual tiles, for a "pop in 1·2·3·4" overlay sequence ──
  ..._wineTileEntries(),

  // ── Scenes: app-like screens whose widgets pop out into focus ──
  PromoEntry(
    name: 'Scene · Stats',
    slots: [
      (context) => const StatsCard(stats: PromoSampleData.stats),
      (context) => const WineTypeBreakdown(data: PromoSampleData.typeBreakdown),
      (context) => const RegionSkyline(items: PromoSampleData.regions),
      (context) => TopWinesList(wines: PromoSampleData.wines),
    ],
  ),
  PromoEntry(
    name: 'Scene · Wine list',
    slots: _wineListSlots(),
  ),
  PromoEntry(
    name: 'Scene · Taste',
    slots: [
      (context) => const ArchetypeHeadline(
        compass: PromoSampleData.compass,
        dna: PromoSampleData.dna,
      ),
      (context) => Center(
        child: DnaShape(
          dna: PromoSampleData.dna,
          color: PromoSampleData.archetypeColor,
          size: context.w * 0.5,
          strokeWidth: 2.2,
          vertexRadius: 3,
        ),
      ),
      (context) => const TasteMatchScoreWidget(match: PromoSampleData.match),
      (context) =>
          const SharedBottlesWidget(bottles: PromoSampleData.sharedBottles),
    ],
  ),
];

/// One showcase entry per sample wine tile, so each can be exported as its
/// own transparent PNG and popped in sequence (1·2·3·4) in the edit.
List<PromoEntry> _wineTileEntries() {
  return [
    for (final (i, w) in PromoSampleData.wines.indexed)
      PromoEntry(
        name: 'Tile ${i + 1} · ${w.name}',
        builder: (context) => SizedBox(
          width: context.w * 0.9,
          child: WineCardWidget(wine: w, rank: i + 1),
        ),
      ),
  ];
}

/// One [WineCardWidget] per sample wine, ranked — used by the wine-list
/// scene so each card can pop out individually.
List<WidgetBuilder> _wineListSlots() {
  return [
    for (final (i, w) in PromoSampleData.wines.indexed)
      (context) => WineCardWidget(wine: w, rank: i + 1),
  ];
}
