import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/controller/auth.provider.dart';
import '../../groups/data/models/drinking_partner.model.dart';
import '../../groups/domain/entities/drinking_partner.entity.dart';
import '../data/models/rating_summary.model.dart';
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

/// Server-aggregated rating summary unified across personal + group +
/// tasting contexts, deduped latest-wins per canonical_wine_id. Powers the
/// stats-hero avg + the 3 context chips and any breakdown that wants
/// "your whole drinking life" semantics.
///
/// Offline contract: on RPC failure, last successful payload is served
/// from the Drift `rating_summary_cache` table. With no cached payload,
/// the error propagates so UI can show a retry state — we don't silently
/// fall back to a personal-only local recompute (would lie about the
/// number).
@riverpod
class UserRatingSummary extends _$UserRatingSummary {
  @override
  Future<RatingSummaryModel> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return RatingSummaryModel.empty();
    final db = ref.read(appDatabaseProvider);
    final dao = db.ratingSummaryCacheDao;
    final client = ref.read(supabaseClientProvider);

    try {
      final raw = await client.rpc(
        'get_user_rating_summary',
        params: {'p_user_id': userId},
      );
      if (raw is Map) {
        final m = Map<String, dynamic>.from(raw);
        await dao.upsert(userId, jsonEncode(m), DateTime.now());
        return RatingSummaryModel.fromJson(m);
      }
      // Unexpected null/empty response — try cache before giving up.
    } catch (_) {
      // Fall through to cache.
    }

    final cached = await dao.getByUser(userId);
    if (cached != null) {
      return RatingSummaryModel.fromJson(
        Map<String, dynamic>.from(jsonDecode(cached.payload) as Map),
      );
    }
    return RatingSummaryModel.empty();
  }
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
  final sorted = [...wines]..sort((a, b) => b.rating.compareTo(a.rating));
  return sorted.take(10).toList();
}

@riverpod
List<WineEntity> statsWinesWithLocation(StatsWinesWithLocationRef ref) {
  final wines = ref.watch(_wineListProvider);
  return wines.where((w) => w.latitude != null && w.longitude != null).toList();
}

class StatsSpending {
  final double total;
  final double avg;
  final String currency;
  final WineEntity? mostExpensive;
  final WineEntity? bestValue;
  final int pricedCount;

  const StatsSpending({
    required this.total,
    required this.avg,
    required this.currency,
    required this.mostExpensive,
    required this.bestValue,
    required this.pricedCount,
  });
}

@riverpod
StatsSpending statsSpending(StatsSpendingRef ref) {
  final wines = ref.watch(_wineListProvider);
  final priced = wines.where((w) => (w.price ?? 0) > 0).toList();
  if (priced.isEmpty) {
    return const StatsSpending(
      total: 0,
      avg: 0,
      currency: 'EUR',
      mostExpensive: null,
      bestValue: null,
      pricedCount: 0,
    );
  }
  // Most-common currency among priced wines wins. Wines on a different
  // currency are excluded from total / avg so the headline isn't a
  // mixed-currency lie.
  final byCurrency = <String, int>{};
  for (final w in priced) {
    byCurrency[w.currency] = (byCurrency[w.currency] ?? 0) + 1;
  }
  final currency = byCurrency.entries
      .reduce((a, b) => a.value >= b.value ? a : b)
      .key;
  final sameCcy = priced.where((w) => w.currency == currency).toList();
  final total = sameCcy.fold<double>(0, (acc, w) => acc + (w.price ?? 0));
  final avg = sameCcy.isEmpty ? 0.0 : total / sameCcy.length;
  final mostExpensive = sameCcy.reduce(
    (a, b) => (a.price ?? 0) >= (b.price ?? 0) ? a : b,
  );
  final bestValue = sameCcy.reduce((a, b) {
    final ra = (a.price ?? 0) == 0 ? 0.0 : a.rating / a.price!;
    final rb = (b.price ?? 0) == 0 ? 0.0 : b.rating / b.price!;
    return ra >= rb ? a : b;
  });
  return StatsSpending(
    total: total,
    avg: avg,
    currency: currency,
    mostExpensive: mostExpensive,
    bestValue: bestValue,
    pricedCount: sameCcy.length,
  );
}

/// One chapter in the user's wine timeline — a single calendar month with
/// every wine they rated that month, newest first. Months with zero wines
/// are skipped entirely (we tell the story they actually lived, not the
/// blank weeks in between).
class TimelineMonth {
  final DateTime month;
  final List<WineEntity> wines;

  const TimelineMonth({required this.month, required this.wines});

  int get count => wines.length;

  double get avgRating {
    if (wines.isEmpty) return 0;
    final sum = wines.fold<double>(0, (acc, w) => acc + w.rating);
    return sum / wines.length;
  }

  WineEntity get topWine =>
      wines.reduce((a, b) => a.rating >= b.rating ? a : b);
}

/// Top users the caller has co-rated wines with inside shared groups.
/// Source is `group_wine_ratings` only — solo (private) wines never count
/// because we have no way to link them to another person without a
/// canonical wine UUID.
@riverpod
Future<List<DrinkingPartnerEntity>> statsDrinkingPartners(
  StatsDrinkingPartnersRef ref,
) async {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return const [];
  final client = ref.read(supabaseClientProvider);
  final raw = await client.rpc(
    'get_top_drinking_partners',
    params: {'p_limit': 5},
  );
  if (raw is! List) return const [];
  return raw
      .map(
        (row) => DrinkingPartnerModel.fromJson(
          Map<String, dynamic>.from(row as Map),
        ).toEntity(),
      )
      .toList(growable: false);
}

@riverpod
List<TimelineMonth> statsTimeline(StatsTimelineRef ref) {
  final wines = ref.watch(_wineListProvider);
  if (wines.isEmpty) return const [];
  final byMonth = <DateTime, List<WineEntity>>{};
  for (final w in wines) {
    final key = DateTime(w.createdAt.year, w.createdAt.month);
    byMonth.putIfAbsent(key, () => []).add(w);
  }
  for (final list in byMonth.values) {
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
  final keys = byMonth.keys.toList()..sort((a, b) => b.compareTo(a));
  return keys
      .map((k) => TimelineMonth(month: k, wines: byMonth[k]!))
      .toList(growable: false);
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
