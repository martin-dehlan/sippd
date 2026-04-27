import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/entities/wine.entity.dart';
import 'wine.provider.dart';

part 'wine_stats.provider.g.dart';

class StatsHeroData {
  final int totalWines;
  final int distinctRegions;
  final int distinctCountries;
  final double avgRating;
  final WineEntity? topWine;

  const StatsHeroData({
    required this.totalWines,
    required this.distinctRegions,
    required this.distinctCountries,
    required this.avgRating,
    required this.topWine,
  });
}

class Tally {
  final String label;
  final int count;
  const Tally({required this.label, required this.count});
}

class TypeBreakdown {
  final WineType type;
  final int count;
  final double avgRating;
  const TypeBreakdown({
    required this.type,
    required this.count,
    required this.avgRating,
  });
}

@riverpod
List<WineEntity> _wineList(_WineListRef ref) {
  return ref.watch(wineControllerProvider).valueOrNull ?? const [];
}

@riverpod
StatsHeroData statsHero(StatsHeroRef ref) {
  final wines = ref.watch(_wineListProvider);
  if (wines.isEmpty) {
    return const StatsHeroData(
      totalWines: 0,
      distinctRegions: 0,
      distinctCountries: 0,
      avgRating: 0,
      topWine: null,
    );
  }
  final regions = <String>{};
  final countries = <String>{};
  double sum = 0;
  WineEntity? top;
  for (final w in wines) {
    sum += w.rating;
    final region = w.region;
    final country = w.country;
    if (region != null && region.isNotEmpty) regions.add(region);
    if (country != null && country.isNotEmpty) countries.add(country);
    if (top == null || w.rating > top.rating) top = w;
  }
  return StatsHeroData(
    totalWines: wines.length,
    distinctRegions: regions.length,
    distinctCountries: countries.length,
    avgRating: sum / wines.length,
    topWine: top,
  );
}

@riverpod
List<Tally> statsTopRegions(StatsTopRegionsRef ref) {
  final wines = ref.watch(_wineListProvider);
  final counts = <String, int>{};
  for (final w in wines) {
    final key = w.region ?? w.country;
    if (key == null || key.isEmpty) continue;
    counts[key] = (counts[key] ?? 0) + 1;
  }
  final list = counts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return list.map((e) => Tally(label: e.key, count: e.value)).toList();
}

@riverpod
List<Tally> statsTopWineries(StatsTopWineriesRef ref) {
  final wines = ref.watch(_wineListProvider);
  final counts = <String, int>{};
  for (final w in wines) {
    final key = w.winery;
    if (key == null || key.isEmpty) continue;
    counts[key] = (counts[key] ?? 0) + 1;
  }
  final list = counts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return list.map((e) => Tally(label: e.key, count: e.value)).toList();
}

@riverpod
List<WineEntity> statsTopWines(StatsTopWinesRef ref) {
  final wines = ref.watch(_wineListProvider);
  final sorted = [...wines]
    ..sort((a, b) => b.rating.compareTo(a.rating));
  return sorted.take(10).toList();
}

@riverpod
List<WineEntity> statsWinesWithLocation(StatsWinesWithLocationRef ref) {
  final wines = ref.watch(_wineListProvider);
  return wines
      .where((w) => w.latitude != null && w.longitude != null)
      .toList();
}

@riverpod
List<TypeBreakdown> statsTypeBreakdown(StatsTypeBreakdownRef ref) {
  final wines = ref.watch(_wineListProvider);
  final perType = <WineType, List<WineEntity>>{};
  for (final w in wines) {
    perType.putIfAbsent(w.type, () => []).add(w);
  }
  // Always emit all four types in canonical order so the donut + cards
  // stay visually stable even when the user has zero wines of a type.
  return WineType.values.map((t) {
    final list = perType[t] ?? const [];
    if (list.isEmpty) {
      return TypeBreakdown(type: t, count: 0, avgRating: 0);
    }
    final sum = list.fold<double>(0, (acc, w) => acc + w.rating);
    return TypeBreakdown(
      type: t,
      count: list.length,
      avgRating: sum / list.length,
    );
  }).toList();
}
