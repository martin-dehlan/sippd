import 'package:flutter/material.dart';

import '../../../common/widgets/stats_card.widget.dart';
import '../../groups/domain/entities/drinking_partner.entity.dart';
import '../../share_cards/presentation/cards/compass_share_card.widget.dart';
import '../../share_cards/presentation/cards/friend_invite_card.widget.dart';
import '../../share_cards/presentation/cards/tasting_recap_card.widget.dart';
import '../../taste_match/domain/entities/shared_bottle.entity.dart';
import '../../taste_match/domain/entities/taste_compass.entity.dart';
import '../../taste_match/domain/entities/taste_match.entity.dart';
import '../../taste_match/domain/entities/user_style_dna.entity.dart';
import '../../taste_match/presentation/widgets/compass_modes.dart';
import '../../wines/controller/wine_stats.provider.dart';
import '../../wines/domain/entities/wine.entity.dart';

/// Hand-built, deterministic fixtures so each showcased widget renders a
/// realistic, camera-ready state without touching Riverpod, the network,
/// or the local DB. English-only copy by house rule.
abstract final class PromoSampleData {
  static final WineEntity wine = WineEntity(
    id: 'promo-wine-1',
    name: 'Barolo Riserva',
    rating: 9.2,
    type: WineType.red,
    price: 48,
    country: 'Italy',
    region: 'Piedmont',
    vintage: 2016,
    grape: 'Nebbiolo',
    winery: 'Giacomo Conterno',
    userId: 'promo-user',
    createdAt: DateTime(2026, 4, 12),
  );

  static const UserStyleDna dna = UserStyleDna(
    values: {
      'body': 0.82,
      'tannin': 0.74,
      'acidity': 0.46,
      'sweetness': 0.18,
      'oak': 0.63,
      'intensity': 0.78,
    },
    attributedCount: 34,
    confidence: 0.9,
  );

  static const Color archetypeColor = Color(0xFF6B3A51); // brand aubergine

  static const TasteMatchEntity match = TasteMatchEntity(
    score: 87,
    confidence: MatchConfidence.high,
    overlapCount: 12,
    myTotal: 142,
    theirTotal: 98,
    bucketScore: 84,
    dnaScore: 90,
  );

  static const List<StatEntry> stats = [
    (label: 'Wines', value: '142'),
    (label: 'Avg', value: '8.4'),
    (label: 'Regions', value: '23'),
  ];

  static const List<Tally> regions = [
    Tally(label: 'Piedmont', count: 18),
    Tally(label: 'Tuscany', count: 14),
    Tally(label: 'Burgundy', count: 11),
    Tally(label: 'Rioja', count: 8),
    Tally(label: 'Mosel', count: 6),
    Tally(label: 'Napa', count: 4),
  ];

  static const List<RadarAxis> compassAxes = [
    RadarAxis(
      label: 'Body',
      value: 0.82,
      detail: '82%',
      headline: 'You gravitate to full, weighty wines.',
      color: Color(0xFFA84343),
    ),
    RadarAxis(
      label: 'Tannin',
      value: 0.74,
      detail: '74%',
      headline: 'Grippy structure is your comfort zone.',
      color: Color(0xFF6B3A51),
    ),
    RadarAxis(
      label: 'Acidity',
      value: 0.46,
      detail: '46%',
      headline: 'Balanced freshness, never sharp.',
      color: Color(0xFFD4A84B),
    ),
    RadarAxis(
      label: 'Sweetness',
      value: 0.18,
      detail: '18%',
      headline: 'Bone-dry, almost always.',
      color: Color(0xFFD6889A),
    ),
    RadarAxis(
      label: 'Oak',
      value: 0.63,
      detail: '63%',
      headline: 'A confident touch of wood, never sawdust.',
      color: Color(0xFF8A6BA8),
    ),
    RadarAxis(
      label: 'Intensity',
      value: 0.78,
      detail: '78%',
      headline: 'Loud, expressive aromatics win you over.',
      color: Color(0xFF4B8A6B),
    ),
  ];

  static final CompassShareCardData compassCard = CompassShareCardData(
    username: 'martin',
    archetypeName: 'The Bold Classicist',
    archetypeTagline: 'Structured reds, earthy depth, zero shortcuts.',
    archetypeColor: archetypeColor,
    dna: dna,
    totalWines: 142,
    date: DateTime(2026, 5, 21),
  );

  static final TastingRecapCardData tastingCard = TastingRecapCardData(
    groupName: 'Tuesday Tasters',
    tastingTitle: 'Piedmont Night',
    date: DateTime(2026, 5, 9),
    location: 'Berlin',
    topWineName: 'Barolo Riserva',
    topWineWinery: 'Giacomo Conterno',
    topWineVintage: 2016,
    topWineAvg: 9.1,
    ranked: const [
      TastingRecapCardLine(name: 'Barolo Riserva', avg: 9.1),
      TastingRecapCardLine(name: 'Barbaresco', avg: 8.6),
      TastingRecapCardLine(name: 'Langhe Nebbiolo', avg: 8.0),
      TastingRecapCardLine(name: 'Dolcetto d’Alba', avg: 7.4),
    ],
    attendeeCount: 6,
  );

  static const FriendInviteCardData friendInviteCard = FriendInviteCardData(
    displayName: 'Martin',
    username: 'martin',
  );

  /// A small varied cellar for list/timeline/compare widgets.
  static final List<WineEntity> wines = [
    wine,
    WineEntity(
      id: 'promo-wine-2',
      name: 'Sancerre',
      rating: 8.6,
      type: WineType.white,
      price: 24,
      country: 'France',
      region: 'Loire',
      vintage: 2022,
      grape: 'Sauvignon Blanc',
      winery: 'Domaine Vacheron',
      userId: 'promo-user',
      createdAt: DateTime(2026, 3, 2),
    ),
    WineEntity(
      id: 'promo-wine-3',
      name: 'Brunello di Montalcino',
      rating: 9.0,
      type: WineType.red,
      price: 62,
      country: 'Italy',
      region: 'Tuscany',
      vintage: 2018,
      grape: 'Sangiovese',
      winery: 'Biondi-Santi',
      userId: 'promo-user',
      createdAt: DateTime(2026, 2, 14),
    ),
    WineEntity(
      id: 'promo-wine-4',
      name: 'Provence Rosé',
      rating: 7.8,
      type: WineType.rose,
      price: 18,
      country: 'France',
      region: 'Provence',
      vintage: 2023,
      grape: 'Grenache',
      winery: 'Château Minuty',
      userId: 'promo-user',
      createdAt: DateTime(2026, 1, 20),
    ),
    WineEntity(
      id: 'promo-wine-5',
      name: 'Champagne Brut',
      rating: 8.9,
      type: WineType.sparkling,
      price: 55,
      country: 'France',
      region: 'Champagne',
      vintage: 2017,
      grape: 'Chardonnay',
      winery: 'Pol Roger',
      userId: 'promo-user',
      createdAt: DateTime(2025, 12, 31),
    ),
  ];

  static const List<TypeBreakdown> typeBreakdown = [
    TypeBreakdown(type: WineType.red, count: 84, avgRating: 8.6),
    TypeBreakdown(type: WineType.white, count: 38, avgRating: 8.2),
    TypeBreakdown(type: WineType.rose, count: 12, avgRating: 7.9),
    TypeBreakdown(type: WineType.sparkling, count: 8, avgRating: 8.8),
  ];

  static final List<TimelineMonth> timelineMonths = [
    TimelineMonth(month: DateTime(2026, 4), wines: wines.take(3).toList()),
    TimelineMonth(
      month: DateTime(2026, 3),
      wines: wines.skip(1).take(2).toList(),
    ),
    TimelineMonth(month: DateTime(2026, 2), wines: wines.take(2).toList()),
  ];

  static const List<DrinkingPartnerEntity> partners = [
    DrinkingPartnerEntity(
      userId: 'u1',
      displayName: 'Lena',
      username: 'lena',
      sharedWines: 23,
    ),
    DrinkingPartnerEntity(
      userId: 'u2',
      displayName: 'Tom',
      username: 'tom',
      sharedWines: 17,
    ),
    DrinkingPartnerEntity(
      userId: 'u3',
      displayName: 'Sofia',
      username: 'sofia',
      sharedWines: 11,
    ),
    DrinkingPartnerEntity(
      userId: 'u4',
      displayName: 'Max',
      username: 'max',
      sharedWines: 6,
    ),
  ];

  static const TasteCompassEntity compass = TasteCompassEntity(
    totalCount: 142,
    overallAvg: 8.4,
    topRegions: [
      CompassBucket(label: 'Piedmont', count: 18, avgRating: 8.9),
      CompassBucket(label: 'Tuscany', count: 14, avgRating: 8.5),
      CompassBucket(label: 'Burgundy', count: 11, avgRating: 8.7),
    ],
    topCountries: [
      CompassBucket(label: 'Italy', count: 64, avgRating: 8.6),
      CompassBucket(label: 'France', count: 52, avgRating: 8.5),
    ],
    typeBreakdown: [
      CompassBucket(label: 'Red', count: 84, avgRating: 8.6),
      CompassBucket(label: 'White', count: 38, avgRating: 8.2),
    ],
  );

  static const List<SharedBottleEntity> sharedBottles = [
    SharedBottleEntity(
      groupId: 'g1',
      wineId: 'w1',
      wineName: 'Barolo Riserva',
      winery: 'Giacomo Conterno',
      region: 'Piedmont',
      country: 'Italy',
      type: 'red',
      vintage: 2016,
      myRating: 9.2,
      theirRating: 9.0,
      delta: 0.2,
    ),
    SharedBottleEntity(
      groupId: 'g1',
      wineId: 'w2',
      wineName: 'Brunello di Montalcino',
      winery: 'Biondi-Santi',
      region: 'Tuscany',
      country: 'Italy',
      type: 'red',
      vintage: 2018,
      myRating: 9.0,
      theirRating: 7.8,
      delta: 1.2,
    ),
    SharedBottleEntity(
      groupId: 'g1',
      wineId: 'w3',
      wineName: 'Sancerre',
      winery: 'Domaine Vacheron',
      region: 'Loire',
      country: 'France',
      type: 'white',
      vintage: 2022,
      myRating: 8.6,
      theirRating: 8.9,
      delta: 0.3,
    ),
  ];

  /// Wine rating share card uses the same wine; no image → editorial
  /// (typographic) layout, which keeps the render network-free.
  static WineEntity get ratingCardWine => wine;
}
