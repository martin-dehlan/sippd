import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'entities/taste_compass.entity.dart';
import 'entities/user_style_dna.entity.dart';

/// One curated wine personality. Distance from the user's DNA vector
/// (body/tannin/acid/sweet/oak/intensity) plus a small contextual
/// adjustment per-archetype produces the match score.
class Archetype {
  const Archetype({
    required this.id,
    required this.name,
    required this.tagline,
    required this.icon,
    required this.color,
    required this.targetVector,
    required this.weights,
    this.contextualBonus,
  });

  final String id;
  final String name;
  final String tagline;
  final IconData icon;
  final Color color;

  /// Target DNA values per axis (0..1). Axes matching map keys in
  /// [UserStyleDna.values]. Tannin can be omitted for white-only
  /// archetypes — distance is then computed over the present axes.
  final Map<String, double> targetVector;

  /// Axis weights summing to ~1.0 — controls which dimensions matter
  /// most for this archetype's identity.
  final Map<String, double> weights;

  /// Optional callback that nudges the score by ±0..0.15 based on
  /// non-DNA signals (e.g. % sparkling for Sparkling Sociable, region
  /// count for Eclectic Explorer). Returns a delta in 0..1 space.
  final double Function(TasteCompassEntity compass)? contextualBonus;
}

class ArchetypeMatch {
  const ArchetypeMatch({
    required this.archetype,
    required this.score,
    required this.confidence,
  });

  final Archetype archetype;

  /// 0..100. Higher = closer match.
  final double score;

  /// 0..1 — clamped by user's DNA confidence. Below 0.5 the score is
  /// labelled "Tentative" in the UI.
  final double confidence;

  bool get isTentative => confidence < 0.5;

  /// True while we don't have enough signal to commit to an archetype.
  bool get isNewcomer => archetype.id == 'curious_newcomer';
}

const _archetypes = <Archetype>[
  Archetype(
    id: 'bold_red_hunter',
    name: 'Bold Red Hunter',
    tagline: 'Full-bodied, tannin-rich reds are your home turf.',
    icon: PhosphorIconsRegular.flame,
    color: Color(0xFFE05A6B),
    targetVector: {
      'body': 0.85, 'tannin': 0.85, 'acidity': 0.55,
      'sweetness': 0.0, 'oak': 0.65, 'intensity': 0.75,
    },
    weights: {
      'body': 0.25, 'tannin': 0.25, 'acidity': 0.05,
      'sweetness': 0.1, 'oak': 0.2, 'intensity': 0.15,
    },
  ),
  Archetype(
    id: 'elegant_burgundian',
    name: 'Elegant Burgundian',
    tagline: 'Lighter reds with bright acidity drive your palate.',
    icon: PhosphorIconsRegular.leaf,
    color: Color(0xFFD08F5C),
    targetVector: {
      'body': 0.35, 'tannin': 0.3, 'acidity': 0.75,
      'sweetness': 0.0, 'oak': 0.4, 'intensity': 0.6,
    },
    weights: {
      'body': 0.25, 'tannin': 0.2, 'acidity': 0.25,
      'sweetness': 0.05, 'oak': 0.1, 'intensity': 0.15,
    },
  ),
  Archetype(
    id: 'aromatic_white_lover',
    name: 'Aromatic White Lover',
    tagline: 'Crisp, expressive whites with cut-through acidity.',
    icon: PhosphorIconsRegular.flowerLotus,
    color: Color(0xFFE8D9A1),
    targetVector: {
      'body': 0.45, 'acidity': 0.8, 'sweetness': 0.1,
      'oak': 0.15, 'intensity': 0.85,
    },
    weights: {
      'body': 0.15, 'acidity': 0.3, 'sweetness': 0.1,
      'oak': 0.15, 'intensity': 0.3,
    },
  ),
  Archetype(
    id: 'sparkling_sociable',
    name: 'Sparkling Sociable',
    tagline: 'Bubbles and pale wines feature heavily in your collection.',
    icon: PhosphorIconsRegular.sparkle,
    color: Color(0xFFB7C7DC),
    targetVector: {
      'body': 0.45, 'acidity': 0.85, 'sweetness': 0.1,
      'oak': 0.1, 'intensity': 0.65,
    },
    weights: {
      'body': 0.15, 'acidity': 0.25, 'sweetness': 0.15,
      'oak': 0.1, 'intensity': 0.15,
    },
    contextualBonus: _sparklingShare,
  ),
  Archetype(
    id: 'classic_structure',
    name: 'Classic Structure',
    tagline: 'Restrained, food-aligned wines with bright acidity.',
    icon: PhosphorIconsRegular.bookOpen,
    color: Color(0xFFD08F5C),
    targetVector: {
      'body': 0.55, 'tannin': 0.55, 'acidity': 0.7,
      'sweetness': 0.0, 'oak': 0.4, 'intensity': 0.6,
    },
    weights: {
      'body': 0.1, 'tannin': 0.1, 'acidity': 0.2,
      'sweetness': 0.05, 'oak': 0.15, 'intensity': 0.1,
    },
    contextualBonus: _coolClimateShare,
  ),
  Archetype(
    id: 'sun_ripened_bold',
    name: 'Sun-Ripened Bold',
    tagline: 'Big fruit, oak-friendly wines from sun-soaked vineyards.',
    icon: PhosphorIconsRegular.sun,
    color: Color(0xFF4FC3B0),
    targetVector: {
      'body': 0.75, 'tannin': 0.65, 'acidity': 0.55,
      'sweetness': 0.05, 'oak': 0.65, 'intensity': 0.7,
    },
    weights: {
      'body': 0.2, 'tannin': 0.15, 'acidity': 0.05,
      'sweetness': 0.1, 'oak': 0.25, 'intensity': 0.1,
    },
    contextualBonus: _warmClimateShare,
  ),
  Archetype(
    id: 'dessert_off_dry',
    name: 'Dessert / Off-Dry',
    tagline: 'You lean toward bottles with a touch of sweetness.',
    icon: PhosphorIconsRegular.dropHalf,
    color: Color(0xFFE3A6BA),
    targetVector: {
      'body': 0.65, 'acidity': 0.6, 'sweetness': 0.7,
      'oak': 0.3, 'intensity': 0.85,
    },
    weights: {
      'body': 0.1, 'acidity': 0.1, 'sweetness': 0.5,
      'oak': 0.1, 'intensity': 0.2,
    },
  ),
  Archetype(
    id: 'natural_low_intervention',
    name: 'Natural / Low-Intervention',
    tagline: 'Unoaked, lighter wines — the freshness camp.',
    icon: PhosphorIconsRegular.plant,
    color: Color(0xFFB48BD0),
    targetVector: {
      'body': 0.5, 'tannin': 0.4, 'acidity': 0.65,
      'sweetness': 0.0, 'oak': 0.05, 'intensity': 0.55,
    },
    weights: {
      'body': 0.1, 'tannin': 0.1, 'acidity': 0.15,
      'sweetness': 0.1, 'oak': 0.4, 'intensity': 0.15,
    },
  ),
  Archetype(
    id: 'crisp_mineral_fan',
    name: 'Crisp Mineral Fan',
    tagline: 'Tight, mineral, high-acid styles are your signature.',
    icon: PhosphorIconsRegular.snowflake,
    color: Color(0xFFB7C7DC),
    targetVector: {
      'body': 0.4, 'acidity': 0.85, 'sweetness': 0.0,
      'oak': 0.1, 'intensity': 0.6,
    },
    weights: {
      'body': 0.2, 'acidity': 0.4, 'sweetness': 0.1,
      'oak': 0.15, 'intensity': 0.15,
    },
  ),
  Archetype(
    id: 'eclectic_explorer',
    name: 'Eclectic Explorer',
    tagline: 'Wide-ranging palate — you taste across the wine map.',
    icon: PhosphorIconsRegular.compass,
    color: Color(0xFF4FC3B0),
    targetVector: {
      'body': 0.55, 'tannin': 0.5, 'acidity': 0.6,
      'sweetness': 0.05, 'oak': 0.4, 'intensity': 0.6,
    },
    weights: {
      'body': 0.1, 'tannin': 0.1, 'acidity': 0.1,
      'sweetness': 0.1, 'oak': 0.1, 'intensity': 0.1,
    },
    contextualBonus: _explorerBonus,
  ),
];

const _curiousNewcomer = Archetype(
  id: 'curious_newcomer',
  name: 'Curious Newcomer',
  tagline: 'Rate a few more wines and your personality reveals itself.',
  icon: PhosphorIconsRegular.compass,
  color: Color(0xFFB48BD0),
  targetVector: {},
  weights: {},
);

ArchetypeMatch matchArchetype(
  TasteCompassEntity compass,
  UserStyleDna? dna,
) {
  if (compass.totalCount < 5 || dna == null || dna.attributedCount < 3) {
    return ArchetypeMatch(
      archetype: _curiousNewcomer,
      score: 0,
      confidence: 0,
    );
  }

  Archetype? best;
  double bestScore = -1;

  for (final a in _archetypes) {
    final dist = _weightedDistance(a, dna);
    final maxDist = _maxPossibleDistance(a);
    var score = maxDist == 0 ? 0.0 : 1.0 - (dist / maxDist).clamp(0.0, 1.0);
    final bonus = a.contextualBonus?.call(compass) ?? 0.0;
    score = (score + bonus).clamp(0.0, 1.0);
    if (score > bestScore) {
      bestScore = score;
      best = a;
    }
  }

  return ArchetypeMatch(
    archetype: best ?? _curiousNewcomer,
    score: bestScore * 100,
    confidence: dna.confidence,
  );
}

double _weightedDistance(Archetype a, UserStyleDna dna) {
  var sumSquared = 0.0;
  for (final entry in a.targetVector.entries) {
    final axis = entry.key;
    final target = entry.value;
    final actual = dna.values[axis];
    if (actual == null) continue;
    final w = a.weights[axis] ?? 0;
    final delta = target - actual;
    sumSquared += w * delta * delta;
  }
  return math.sqrt(sumSquared);
}

double _maxPossibleDistance(Archetype a) {
  // Worst case: each axis is 1.0 away from target.
  var sumSquared = 0.0;
  for (final entry in a.weights.entries) {
    final axis = entry.key;
    final target = a.targetVector[axis];
    if (target == null) continue;
    final maxDelta = math.max(target, 1 - target);
    sumSquared += entry.value * maxDelta * maxDelta;
  }
  return math.sqrt(sumSquared);
}

// Climate-based grouping describes wine character (acidity vs ripeness),
// not geopolitical heritage. Approximation at country granularity — fine
// for a small contextual nudge (capped at +0.15).
const _coolClimateCountries = {
  'france', 'germany', 'austria', 'switzerland', 'new zealand',
  'czechia', 'czech republic', 'slovakia', 'hungary', 'slovenia',
  'england', 'united kingdom', 'uk', 'belgium', 'luxembourg',
  'canada', 'romania', 'moldova', 'ukraine', 'georgia',
};
const _warmClimateCountries = {
  'spain', 'portugal', 'italy', 'greece', 'croatia', 'cyprus',
  'lebanon', 'turkey', 'israel', 'argentina', 'chile', 'australia',
  'south africa', 'united states', 'usa', 'us', 'mexico', 'brazil',
  'uruguay', 'china', 'japan', 'india',
};

double _sparklingShare(TasteCompassEntity c) {
  if (c.totalCount == 0) return 0;
  final n = c.typeBreakdown
      .where((b) {
        final l = b.label.toLowerCase();
        return l == 'sparkling' || l == 'rose';
      })
      .fold<int>(0, (s, b) => s + b.count);
  final share = n / c.totalCount;
  // Up to +0.15 if user is heavy on sparkling/rosé.
  return (share * 0.3).clamp(0.0, 0.15);
}

double _coolClimateShare(TasteCompassEntity c) {
  if (c.totalCount == 0) return 0;
  final n = c.topCountries
      .where((b) => _coolClimateCountries.contains(b.label.toLowerCase()))
      .fold<int>(0, (s, b) => s + b.count);
  final share = n / c.totalCount;
  return (share * 0.25).clamp(0.0, 0.15);
}

double _warmClimateShare(TasteCompassEntity c) {
  if (c.totalCount == 0) return 0;
  final n = c.topCountries
      .where((b) => _warmClimateCountries.contains(b.label.toLowerCase()))
      .fold<int>(0, (s, b) => s + b.count);
  final share = n / c.totalCount;
  return (share * 0.25).clamp(0.0, 0.15);
}

double _explorerBonus(TasteCompassEntity c) {
  // Reward variety — 3 regions = small bonus, 6+ = full.
  final n = c.topRegions.length;
  if (n < 3) return 0;
  return ((n - 2) / 4 * 0.15).clamp(0.0, 0.15);
}
