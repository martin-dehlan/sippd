import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Maps a badge `icon` key (from `badge_definitions.icon`) to a Phosphor glyph
/// and a category to a colorScheme-derived accent. Locked state is rendered by
/// the card (desaturated) — no separate assets, per the design rules.
IconData badgeIcon(String key) {
  return _byIcon[key] ?? PhosphorIconsFill.trophy;
}

Color badgeAccent(String category, ColorScheme cs) {
  switch (category) {
    case 'volume':
      return cs.primary;
    case 'type':
      return cs.secondary;
    case 'geo':
      return cs.tertiary;
    case 'grape':
      return cs.primary;
    case 'social':
      return cs.secondary;
    case 'engagement':
      return cs.tertiary;
    default:
      return cs.primary;
  }
}

const Map<String, IconData> _byIcon = {
  // Volume
  'first_sip': PhosphorIconsFill.wine,
  'getting_started': PhosphorIconsFill.wine,
  'wine_explorer': PhosphorIconsRegular.compass,
  'cellar_master': PhosphorIconsFill.trophy,
  'connoisseur': PhosphorIconsFill.crown,
  // Type
  'red_devotee': PhosphorIconsFill.wine,
  'white_wine_lover': PhosphorIconsFill.wine,
  'bubbly_enthusiast': PhosphorIconsRegular.champagne,
  'rose_all_day': PhosphorIconsRegular.flower,
  'balanced_palate': PhosphorIconsFill.star,
  // Geo
  'globetrotter': PhosphorIconsFill.globe,
  'old_world_scholar': PhosphorIconsRegular.globeHemisphereWest,
  'new_world_pioneer': PhosphorIconsRegular.compass,
  'regional_specialist': PhosphorIconsFill.mapPin,
  'france_aficionado': PhosphorIconsFill.globe,
  // Grape
  'grape_curious': PhosphorIconsFill.sparkle,
  'grape_connoisseur': PhosphorIconsFill.trophy,
  'single_variety_devotee': PhosphorIconsFill.star,
  // Social
  'joiner': PhosphorIconsFill.usersThree,
  'tasting_regular': PhosphorIconsRegular.calendarCheck,
  'host': PhosphorIconsFill.crown,
  'social_sipper': PhosphorIconsFill.heart,
  'drinking_buddies': PhosphorIconsRegular.handshake,
  // Engagement
  'the_critic': PhosphorIconsRegular.fileText,
  'seasoned_taster': PhosphorIconsFill.star,
};
