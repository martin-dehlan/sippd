import 'package:flutter/material.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
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

  String displayName(AppLocalizations l) => switch (this) {
    CompassMode.style => l.tasteCompassModeStyle,
    CompassMode.world => l.tasteCompassModeWorld,
    CompassMode.grapes => l.tasteCompassModeGrapes,
    CompassMode.dna => l.tasteCompassModeDna,
  };

  bool get isProGated => switch (this) {
    CompassMode.style => false,
    _ => true,
  };
}

enum CompassMetric {
  count,
  rating;

  String displayName(AppLocalizations l) => switch (this) {
    CompassMetric.count => l.tasteCompassMetricCount,
    CompassMetric.rating => l.tasteCompassMetricRating,
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

String _continentKey(String country) {
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

String _continentLabel(String key, AppLocalizations l) => switch (key) {
  'europe' => l.tasteCompassContinentEurope,
  'north america' => l.tasteCompassContinentNorthAmerica,
  'south america' => l.tasteCompassContinentSouthAmerica,
  'africa' => l.tasteCompassContinentAfrica,
  'asia' => l.tasteCompassContinentAsia,
  'oceania' => l.tasteCompassContinentOceania,
  _ => key,
};

String _wineTypeLabel(String key, AppLocalizations l) => switch (key) {
  'red' => l.wineTypeRed,
  'white' => l.wineTypeWhite,
  'rose' => l.wineTypeRose,
  'sparkling' => l.wineTypeSparkling,
  _ => key,
};

/// Style mode — wine type breakdown (red/white/rose/sparkling).
List<RadarAxis> buildStyleAxes(
  TasteCompassEntity c,
  CompassMetric metric,
  AppLocalizations l,
) {
  final total = c.totalCount;
  if (total <= 0) return const [];

  CompassBucket? bucket(String type) {
    final list = c.typeBreakdown.where((b) => b.label.toLowerCase() == type);
    return list.isEmpty ? null : list.first;
  }

  final entries = [
    ('red', bucket('red'), _redColor),
    ('white', bucket('white'), _whiteColor),
    ('rose', bucket('rose'), _roseColor),
    ('sparkling', bucket('sparkling'), _sparklingColor),
  ];

  return entries.map((e) {
    final (typeKey, b, color) = e;
    final label = _wineTypeLabel(typeKey, l);
    final count = b?.count ?? 0;
    final avg = b?.avgRating ?? 0;
    final value = metric == CompassMetric.count
        ? (total == 0 ? 0.0 : count / total)
        : (avg / 10.0);
    final detail = metric == CompassMetric.count
        ? (total == 0 ? '0%' : '${(count * 100 / total).round()}%')
        : (count == 0 ? '—' : '${avg.toStringAsFixed(1)}★');
    final avgStr = avg.toStringAsFixed(1);
    final headline = count == 0
        ? l.tasteCompassStyleNoneYet(label)
        : count == 1
        ? l.tasteCompassStyleSummaryOne(count, label, avgStr)
        : l.tasteCompassStyleSummaryMany(count, label, avgStr);
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
List<RadarAxis> buildWorldAxes(
  TasteCompassEntity c,
  CompassMetric metric,
  AppLocalizations l,
) {
  if (c.totalCount <= 0) return const [];

  // Aggregate top countries into the 6 continents.
  final byContinent = <String, ({int count, double weightedRating})>{};
  for (final cont in _continentColors.keys) {
    byContinent[cont] = (count: 0, weightedRating: 0);
  }
  for (final b in c.topCountries) {
    final cont = _continentKey(b.label);
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
    final label = _continentLabel(cont, l);
    final avgStr = avg.toStringAsFixed(1);
    final headline = stat.count == 0
        ? l.tasteCompassWorldNoneYet(label)
        : stat.count == 1
        ? l.tasteCompassWorldSummaryOne(label, avgStr)
        : l.tasteCompassWorldSummaryMany(stat.count, label, avgStr);
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
  AppLocalizations l,
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
            ? l.tasteCompassGrapeEmptySlot
            : list[i].count == 1
            ? l.tasteCompassGrapeSummaryOne(
                list[i].grapeName,
                list[i].avgRating.toStringAsFixed(1),
              )
            : l.tasteCompassGrapeSummaryMany(
                list[i].grapeName,
                list[i].count,
                list[i].avgRating.toStringAsFixed(1),
              ),
        color: _grapeAccentColors[i % _grapeAccentColors.length],
      ),
  ];
}

/// DNA mode — six WSET-aligned style axes from server-side aggregation.
List<RadarAxis> buildDnaAxes(UserStyleDna dna, AppLocalizations l) {
  String label(String k) {
    switch (k) {
      case 'body':
        return l.tasteTraitBody;
      case 'tannin':
        return l.tasteTraitTannin;
      case 'acidity':
        return l.tasteTraitAcidity;
      case 'sweetness':
        return l.tasteTraitSweetShort;
      case 'oak':
        return l.tasteTraitOak;
      case 'intensity':
        return l.tasteTraitIntensity;
    }
    return k;
  }

  String descriptor(String k, double v) {
    final pct = (v * 100).round();
    switch (k) {
      case 'body':
        return v < 0.4
            ? l.tasteDnaBodyLowPct(pct)
            : v < 0.65
            ? l.tasteDnaBodyMidPct(pct)
            : l.tasteDnaBodyHighPct(pct);
      case 'tannin':
        return v < 0.4
            ? l.tasteDnaTanninLowPct(pct)
            : v < 0.65
            ? l.tasteDnaTanninMidPct(pct)
            : l.tasteDnaTanninHighPct(pct);
      case 'acidity':
        return v < 0.4
            ? l.tasteDnaAcidityLowPct(pct)
            : v < 0.65
            ? l.tasteDnaAcidityMidPct(pct)
            : l.tasteDnaAcidityHighPct(pct);
      case 'sweetness':
        return v < 0.15
            ? l.tasteDnaSweetnessLowPct(pct)
            : v < 0.4
            ? l.tasteDnaSweetnessMidPct(pct)
            : l.tasteDnaSweetnessHighPct(pct);
      case 'oak':
        return v < 0.3
            ? l.tasteDnaOakLowPct(pct)
            : v < 0.55
            ? l.tasteDnaOakMidPct(pct)
            : l.tasteDnaOakHighPct(pct);
      case 'intensity':
        return v < 0.4
            ? l.tasteDnaIntensityLowPct(pct)
            : v < 0.7
            ? l.tasteDnaIntensityMidPct(pct)
            : l.tasteDnaIntensityHighPct(pct);
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
          ? l.tasteDnaNotEnoughYet
          : descriptor(key, v),
      color: entry.value,
    );
  }).toList();
}
