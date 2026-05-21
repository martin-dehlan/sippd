import 'package:flutter/material.dart';

import '../../../common/utils/responsive.dart';
import '../../../common/widgets/stats_card.widget.dart';
import '../../share_cards/presentation/cards/compass_share_card.widget.dart';
import '../../share_cards/presentation/cards/friend_invite_card.widget.dart';
import '../../share_cards/presentation/cards/tasting_recap_card.widget.dart';
import '../../share_cards/presentation/cards/wine_rating_card.widget.dart';
import '../../taste_match/presentation/widgets/compass_radar.widget.dart';
import '../../taste_match/presentation/widgets/dna_shape.widget.dart';
import '../../taste_match/presentation/widgets/taste_match_score.widget.dart';
import '../../wines/presentation/modules/wine_stats/widgets/region_skyline.widget.dart';
import '../../wines/presentation/widgets/wine_card.widget.dart';
import 'promo_sample_data.dart';

/// Default canvas colour — the app's dark scaffold tone, so every widget
/// renders true-to-app. Transparent PNG cut-outs still come from the
/// tight Screenshot boundary, independent of this backdrop.
const Color kPromoCanvas = Color(0xFF14101A);

/// One showcased widget: a stable [name], the [builder] that produces it
/// at presentation size, and an optional [designSize] for fixed-canvas
/// artifacts (the 1080×1920 share cards) which the stage FittedBox-scales.
class PromoEntry {
  const PromoEntry({
    required this.name,
    required this.builder,
    this.background = kPromoCanvas,
    this.designSize,
  });

  final String name;
  final WidgetBuilder builder;
  final Color background;
  final Size? designSize;

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
];
