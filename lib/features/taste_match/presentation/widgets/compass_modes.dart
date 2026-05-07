import 'package:flutter/material.dart';

import '../../domain/entities/taste_compass.entity.dart';
import '../../domain/entities/user_grape_share.entity.dart';
import '../../domain/entities/user_style_dna.entity.dart';

/// One axis on the compass radar. Pure data — the painter pulls
/// label/value/color/detail and renders.
@immutable
class RadarAxis {
  const RadarAxis({
    required this.label,
    required this.value,
    required this.detail,
    required this.headline,
    required this.color,
  });

  final String label;
  final double value; // 0..1
  final String detail; // short under-label (e.g. "57%" or "8.2★")
  final String headline; // detail-card sentence on tap
  final Color color;
}

enum CompassMode {
  style,
  world,
  grapes,
  dna;

  String get displayName => switch (this) {
    CompassMode.style => 'Style',
    CompassMode.world => 'World',
    CompassMode.grapes => 'Grapes',
    CompassMode.dna => 'DNA',
  };

  bool get isProGated => switch (this) {
    CompassMode.style => false,
    _ => true,
  };
}

enum CompassMetric {
  count,
  rating;

  String get displayName => switch (this) {
    CompassMetric.count => 'count',
    CompassMetric.rating => 'rating',
  };
}

const _redColor = Color(0xFFE05A6B);
const _whiteColor = Color(0xFFE8D9A1);
const _roseColor = Color(0xFFE3A6BA);
const _sparklingColor = Color(0xFFB7C7DC);

const _continentColors = {
  'europe': Color(0xFFD08F5C),
  'north america': Color(0xFFE05A6B),
  'south america': Color(0xFF4FC3B0),
  'africa': Color(0xFFE8D9A1),
  'asia': Color(0xFFB48BD0),
  'oceania': Color(0xFFB7C7DC),
};

const _grapeAccentColors = [
  Color(0xFFE05A6B),
  Color(0xFF4FC3B0),
  Color(0xFFE8D9A1),
  Color(0xFFD08F5C),
  Color(0xFFB48BD0),
  Color(0xFFB7C7DC),
  Color(0xFFE3A6BA),
];

const _dnaColors = {
  'body': Color(0xFFE05A6B),
  'tannin': Color(0xFFD08F5C),
  'acidity': Color(0xFFE8D9A1),
  'sweetness': Color(0xFFE3A6BA),
  'oak': Color(0xFFB48BD0),
  'intensity': Color(0xFF4FC3B0),
};

const _europeanCountries = {
  'france',
  'italy',
  'spain',
  'germany',
  'portugal',
  'austria',
  'greece',
  'hungary',
  'croatia',
  'slovenia',
  'romania',
  'bulgaria',
  'switzerland',
  'czechia',
  'czech republic',
  'slovakia',
  'moldova',
  'ukraine',
  'serbia',
  'macedonia',
  'cyprus',
  'england',
  'united kingdom',
  'uk',
  'belgium',
  'luxembourg',
  'netherlands',
  'denmark',
  'sweden',
  'norway',
  'finland',
  'poland',
  'ireland',
};

String _continentForCountry(String country) {
  final c = country.toLowerCase().trim();
  if (_europeanCountries.contains(c)) return 'europe';
  if ({'united states', 'usa', 'us', 'canada', 'mexico'}.contains(c)) {
    return 'north america';
  }
  if ({
    'argentina',
    'chile',
    'brazil',
    'uruguay',
    'peru',
    'bolivia',
  }.contains(c)) {
    return 'south america';
  }
  if ({'south africa', 'morocco', 'egypt', 'tunisia', 'algeria'}.contains(c)) {
    return 'africa';
  }
  if ({
    'china',
    'japan',
    'india',
    'korea',
    'thailand',
    'lebanon',
    'turkey',
    'israel',
    'georgia',
  }.contains(c)) {
    return 'asia';
  }
  if ({'australia', 'new zealand'}.contains(c)) return 'oceania';
  return 'europe'; // default fallback
}

/// Style mode — wine type breakdown (red/white/rose/sparkling).
List<RadarAxis> buildStyleAxes(TasteCompassEntity c, CompassMetric metric) {
  final total = c.totalCount;
  if (total <= 0) return const [];

  CompassBucket? bucket(String type) {
    final list = c.typeBreakdown.where((b) => b.label.toLowerCase() == type);
    return list.isEmpty ? null : list.first;
  }

  final entries = [
    ('Red', bucket('red'), _redColor),
    ('White', bucket('white'), _whiteColor),
    ('Rosé', bucket('rose'), _roseColor),
    ('Sparkling', bucket('sparkling'), _sparklingColor),
  ];

  return entries.map((e) {
    final (label, b, color) = e;
    final count = b?.count ?? 0;
    final avg = b?.avgRating ?? 0;
    final value = metric == CompassMetric.count
        ? (total == 0 ? 0.0 : count / total)
        : (avg / 10.0);
    final detail = metric == CompassMetric.count
        ? (total == 0 ? '0%' : '${(count * 100 / total).round()}%')
        : (count == 0 ? '—' : '${avg.toStringAsFixed(1)}★');
    final headline = count == 0
        ? 'No $label wines yet'
        : '$count $label wine${count == 1 ? '' : 's'} · ${avg.toStringAsFixed(1)}★ avg';
    return RadarAxis(
      label: label,
      value: value.clamp(0.0, 1.0),
      detail: detail,
      headline: headline,
      color: color,
    );
  }).toList();
}

/// World mode — continent rollup (always 6 axes).
List<RadarAxis> buildWorldAxes(TasteCompassEntity c, CompassMetric metric) {
  if (c.totalCount <= 0) return const [];

  // Aggregate top countries into the 6 continents.
  final byContinent = <String, ({int count, double weightedRating})>{};
  for (final cont in _continentColors.keys) {
    byContinent[cont] = (count: 0, weightedRating: 0);
  }
  for (final b in c.topCountries) {
    final cont = _continentForCountry(b.label);
    final cur = byContinent[cont]!;
    byContinent[cont] = (
      count: cur.count + b.count,
      weightedRating: cur.weightedRating + b.avgRating * b.count,
    );
  }

  final total = byContinent.values.fold<int>(0, (s, v) => s + v.count);

  return _continentColors.entries.map((entry) {
    final cont = entry.key;
    final color = entry.value;
    final stat = byContinent[cont]!;
    final avg = stat.count == 0 ? 0.0 : stat.weightedRating / stat.count;
    final value = metric == CompassMetric.count
        ? (total == 0 ? 0.0 : stat.count / total)
        : (avg / 10.0);
    final detail = metric == CompassMetric.count
        ? (total == 0 ? '0%' : '${(stat.count * 100 / total).round()}%')
        : (stat.count == 0 ? '—' : '${avg.toStringAsFixed(1)}★');
    final label = cont
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
    final headline = stat.count == 0
        ? 'No bottles from $label yet'
        : '${stat.count} bottle${stat.count == 1 ? '' : 's'} from $label · ${avg.toStringAsFixed(1)}★ avg';
    return RadarAxis(
      label: label,
      value: value.clamp(0.0, 1.0),
      detail: detail,
      headline: headline,
      color: color,
    );
  }).toList();
}

/// Grapes mode — top 7 by count or avg rating.
List<RadarAxis> buildGrapeAxes(
  List<UserGrapeShare> shares,
  CompassMetric metric,
) {
  if (shares.isEmpty) return const [];
  final maxCount = shares.map((g) => g.count).reduce((a, b) => a > b ? a : b);
  // Pad to 7 axes with empty slots if user has fewer rated grapes.
  final padded = [...shares];
  while (padded.length < 7) {
    padded.add(
      const UserGrapeShare(
        canonicalGrapeId: '',
        grapeName: '—',
        grapeColor: 'red',
        count: 0,
        avgRating: 0,
      ),
    );
  }
  final list = padded.take(7).toList();

  return [
    for (int i = 0; i < list.length; i++)
      RadarAxis(
        label: list[i].grapeName,
        value: () {
          if (list[i].count == 0) return 0.0;
          return metric == CompassMetric.count
              ? (list[i].count / maxCount).clamp(0.0, 1.0)
              : (list[i].avgRating / 10.0).clamp(0.0, 1.0);
        }(),
        detail: list[i].count == 0
            ? ''
            : metric == CompassMetric.count
            ? '${list[i].count}×'
            : '${list[i].avgRating.toStringAsFixed(1)}★',
        headline: list[i].count == 0
            ? 'Empty slot — rate more grapes to fill'
            : '${list[i].grapeName} · ${list[i].count} bottle${list[i].count == 1 ? '' : 's'} · ${list[i].avgRating.toStringAsFixed(1)}★ avg',
        color: _grapeAccentColors[i % _grapeAccentColors.length],
      ),
  ];
}

/// DNA mode — six WSET-aligned style axes from server-side aggregation.
List<RadarAxis> buildDnaAxes(UserStyleDna dna) {
  String label(String k) {
    switch (k) {
      case 'body':
        return 'Body';
      case 'tannin':
        return 'Tannin';
      case 'acidity':
        return 'Acidity';
      case 'sweetness':
        return 'Sweet';
      case 'oak':
        return 'Oak';
      case 'intensity':
        return 'Intensity';
    }
    return k;
  }

  String descriptor(String k, double v) {
    final pct = (v * 100).round();
    switch (k) {
      case 'body':
        return v < 0.4
            ? 'You lean light-bodied · $pct%'
            : v < 0.65
            ? 'Balanced body · $pct%'
            : 'You lean full-bodied · $pct%';
      case 'tannin':
        return v < 0.4
            ? 'Soft tannins · $pct%'
            : v < 0.65
            ? 'Medium tannin · $pct%'
            : 'Bold, gripping tannins · $pct%';
      case 'acidity':
        return v < 0.4
            ? 'Soft acid · $pct%'
            : v < 0.65
            ? 'Balanced acid · $pct%'
            : 'High-acid drinker · $pct%';
      case 'sweetness':
        return v < 0.15
            ? 'Bone dry · $pct%'
            : v < 0.4
            ? 'Off-dry tendency · $pct%'
            : 'Sweet leaning · $pct%';
      case 'oak':
        return v < 0.3
            ? 'Unoaked / fresh · $pct%'
            : v < 0.55
            ? 'Some oak · $pct%'
            : 'Oak lover · $pct%';
      case 'intensity':
        return v < 0.4
            ? 'Subtle aromatics · $pct%'
            : v < 0.7
            ? 'Expressive · $pct%'
            : 'Bold aromatics · $pct%';
    }
    return '$pct%';
  }

  return _dnaColors.entries.map((entry) {
    final key = entry.key;
    final v = (dna.values[key] ?? 0).clamp(0.0, 1.0);
    return RadarAxis(
      label: label(key),
      value: v,
      detail: dna.attributedCount < 3 ? '—' : '${(v * 100).round()}%',
      headline: dna.attributedCount < 3
          ? 'Not enough rated wines yet — keep going'
          : descriptor(key, v),
      color: entry.value,
    );
  }).toList();
}
