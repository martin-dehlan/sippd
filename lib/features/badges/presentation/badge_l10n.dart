import '../../../common/l10n/generated/app_localizations.dart';

/// Localized badge title/description for a badge id, served from l10n
/// instead of the English DB copy. Falls back to the DB value for any
/// id not in the catalog (forward-compat with future badges).
String localizedBadgeTitle(AppLocalizations l, String id, String dbTitle) =>
    switch (id) {
      'first_sip' => l.badgeFirstSipTitle,
      'getting_started' => l.badgeGettingStartedTitle,
      'wine_explorer' => l.badgeWineExplorerTitle,
      'cellar_master' => l.badgeCellarMasterTitle,
      'connoisseur' => l.badgeConnoisseurTitle,
      'red_devotee' => l.badgeRedDevoteeTitle,
      'white_wine_lover' => l.badgeWhiteWineLoverTitle,
      'bubbly_enthusiast' => l.badgeBubblyEnthusiastTitle,
      'rose_all_day' => l.badgeRoseAllDayTitle,
      'balanced_palate' => l.badgeBalancedPalateTitle,
      'globetrotter' => l.badgeGlobetrotterTitle,
      'old_world_scholar' => l.badgeOldWorldScholarTitle,
      'new_world_pioneer' => l.badgeNewWorldPioneerTitle,
      'regional_specialist' => l.badgeRegionalSpecialistTitle,
      'france_aficionado' => l.badgeFranceAficionadoTitle,
      'grape_curious' => l.badgeGrapeCuriousTitle,
      'grape_connoisseur' => l.badgeGrapeConnoisseurTitle,
      'single_variety_devotee' => l.badgeSingleVarietyDevoteeTitle,
      'joiner' => l.badgeJoinerTitle,
      'tasting_regular' => l.badgeTastingRegularTitle,
      'host' => l.badgeHostTitle,
      'social_sipper' => l.badgeSocialSipperTitle,
      'drinking_buddies' => l.badgeDrinkingBuddiesTitle,
      'the_critic' => l.badgeTheCriticTitle,
      'seasoned_taster' => l.badgeSeasonedTasterTitle,
      _ => dbTitle,
    };

String localizedBadgeDesc(AppLocalizations l, String id, String dbDesc) =>
    switch (id) {
      'first_sip' => l.badgeFirstSipDesc,
      'getting_started' => l.badgeGettingStartedDesc,
      'wine_explorer' => l.badgeWineExplorerDesc,
      'cellar_master' => l.badgeCellarMasterDesc,
      'connoisseur' => l.badgeConnoisseurDesc,
      'red_devotee' => l.badgeRedDevoteeDesc,
      'white_wine_lover' => l.badgeWhiteWineLoverDesc,
      'bubbly_enthusiast' => l.badgeBubblyEnthusiastDesc,
      'rose_all_day' => l.badgeRoseAllDayDesc,
      'balanced_palate' => l.badgeBalancedPalateDesc,
      'globetrotter' => l.badgeGlobetrotterDesc,
      'old_world_scholar' => l.badgeOldWorldScholarDesc,
      'new_world_pioneer' => l.badgeNewWorldPioneerDesc,
      'regional_specialist' => l.badgeRegionalSpecialistDesc,
      'france_aficionado' => l.badgeFranceAficionadoDesc,
      'grape_curious' => l.badgeGrapeCuriousDesc,
      'grape_connoisseur' => l.badgeGrapeConnoisseurDesc,
      'single_variety_devotee' => l.badgeSingleVarietyDevoteeDesc,
      'joiner' => l.badgeJoinerDesc,
      'tasting_regular' => l.badgeTastingRegularDesc,
      'host' => l.badgeHostDesc,
      'social_sipper' => l.badgeSocialSipperDesc,
      'drinking_buddies' => l.badgeDrinkingBuddiesDesc,
      'the_critic' => l.badgeTheCriticDesc,
      'seasoned_taster' => l.badgeSeasonedTasterDesc,
      _ => dbDesc,
    };
