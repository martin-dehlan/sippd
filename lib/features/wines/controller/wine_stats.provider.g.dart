// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_stats.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wineListHash() => r'f9e906384f9b3a690c406ce8b9cba6cde8e93a12';

/// See also [_wineList].
@ProviderFor(_wineList)
final _wineListProvider = AutoDisposeProvider<List<WineEntity>>.internal(
  _wineList,
  name: r'_wineListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wineListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _WineListRef = AutoDisposeProviderRef<List<WineEntity>>;
String _$statsHeroHash() => r'ddca93fa84433476da5e74d95aed44ffe6ab6c43';

/// See also [statsHero].
@ProviderFor(statsHero)
final statsHeroProvider = AutoDisposeProvider<StatsHeroData>.internal(
  statsHero,
  name: r'statsHeroProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsHeroHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsHeroRef = AutoDisposeProviderRef<StatsHeroData>;
String _$statsTopRegionsHash() => r'45746b24590208bd1dace8b6c1b39d992acc6962';

/// See also [statsTopRegions].
@ProviderFor(statsTopRegions)
final statsTopRegionsProvider = AutoDisposeProvider<List<Tally>>.internal(
  statsTopRegions,
  name: r'statsTopRegionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsTopRegionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsTopRegionsRef = AutoDisposeProviderRef<List<Tally>>;
String _$statsTopWineriesHash() => r'097a8788e811ea7a53c95f3280c853c41ac2a85f';

/// See also [statsTopWineries].
@ProviderFor(statsTopWineries)
final statsTopWineriesProvider = AutoDisposeProvider<List<Tally>>.internal(
  statsTopWineries,
  name: r'statsTopWineriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsTopWineriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsTopWineriesRef = AutoDisposeProviderRef<List<Tally>>;
String _$statsTopWinesHash() => r'25157a857a53c59846b677a148fb0c609e8b094b';

/// See also [statsTopWines].
@ProviderFor(statsTopWines)
final statsTopWinesProvider = AutoDisposeProvider<List<WineEntity>>.internal(
  statsTopWines,
  name: r'statsTopWinesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsTopWinesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsTopWinesRef = AutoDisposeProviderRef<List<WineEntity>>;
String _$statsWinesWithLocationHash() =>
    r'ecfada361d3e55b93520ad870705e1ea1c0bb0e4';

/// See also [statsWinesWithLocation].
@ProviderFor(statsWinesWithLocation)
final statsWinesWithLocationProvider =
    AutoDisposeProvider<List<WineEntity>>.internal(
      statsWinesWithLocation,
      name: r'statsWinesWithLocationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statsWinesWithLocationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsWinesWithLocationRef = AutoDisposeProviderRef<List<WineEntity>>;
String _$statsSpendingHash() => r'0761a11eb996cb3d749464feaf9e61ef05dac3ec';

/// See also [statsSpending].
@ProviderFor(statsSpending)
final statsSpendingProvider = AutoDisposeProvider<StatsSpending>.internal(
  statsSpending,
  name: r'statsSpendingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsSpendingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsSpendingRef = AutoDisposeProviderRef<StatsSpending>;
String _$statsDrinkingPartnersHash() =>
    r'c71cc26263e28d3a23db28c1d86b00a7cc759670';

/// Top users the caller has co-rated wines with inside shared groups.
/// Source is `group_wine_ratings` only — solo (private) wines never count
/// because we have no way to link them to another person without a
/// canonical wine UUID.
///
/// Copied from [statsDrinkingPartners].
@ProviderFor(statsDrinkingPartners)
final statsDrinkingPartnersProvider =
    AutoDisposeFutureProvider<List<DrinkingPartnerEntity>>.internal(
      statsDrinkingPartners,
      name: r'statsDrinkingPartnersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statsDrinkingPartnersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsDrinkingPartnersRef =
    AutoDisposeFutureProviderRef<List<DrinkingPartnerEntity>>;
String _$statsTimelineHash() => r'6bfb2645b6d933ce17fceed55599aa845fe89998';

/// See also [statsTimeline].
@ProviderFor(statsTimeline)
final statsTimelineProvider = AutoDisposeProvider<List<TimelineMonth>>.internal(
  statsTimeline,
  name: r'statsTimelineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsTimelineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsTimelineRef = AutoDisposeProviderRef<List<TimelineMonth>>;
String _$statsTypeBreakdownHash() =>
    r'a2f7455c30b3feeb8a4f7a18599c6aac27711cbb';

/// See also [statsTypeBreakdown].
@ProviderFor(statsTypeBreakdown)
final statsTypeBreakdownProvider =
    AutoDisposeProvider<List<TypeBreakdown>>.internal(
      statsTypeBreakdown,
      name: r'statsTypeBreakdownProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statsTypeBreakdownHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsTypeBreakdownRef = AutoDisposeProviderRef<List<TypeBreakdown>>;
String _$userRatingSummaryHash() => r'247be51584fa481d9ed2779d3c3a36807e0eb949';

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
///
/// Copied from [UserRatingSummary].
@ProviderFor(UserRatingSummary)
final userRatingSummaryProvider =
    AutoDisposeAsyncNotifierProvider<
      UserRatingSummary,
      RatingSummaryModel
    >.internal(
      UserRatingSummary.new,
      name: r'userRatingSummaryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userRatingSummaryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserRatingSummary = AutoDisposeAsyncNotifier<RatingSummaryModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
