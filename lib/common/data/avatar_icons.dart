import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Single source of truth for the avatar icons users can pick during
/// onboarding. Used by the picker UI and by the profile avatar's
/// fallback so picking an icon actually surfaces somewhere visible.
const List<({String key, IconData icon})> avatarIconOptions = [
  (key: 'wine', icon: PhosphorIconsRegular.wine),
  (key: 'champagne', icon: PhosphorIconsRegular.champagne),
  (key: 'martini', icon: PhosphorIconsRegular.martini),
  (key: 'sparkle', icon: PhosphorIconsRegular.sparkle),
  (key: 'heart', icon: PhosphorIconsRegular.heart),
  (key: 'star', icon: PhosphorIconsRegular.star),
  (key: 'fire', icon: PhosphorIconsRegular.fire),
  (key: 'confetti', icon: PhosphorIconsRegular.confetti),
  (key: 'crown', icon: PhosphorIconsRegular.crown),
  (key: 'flower', icon: PhosphorIconsRegular.flower),
];

IconData? avatarIconForKey(String? key) {
  if (key == null || key.isEmpty) return null;
  for (final o in avatarIconOptions) {
    if (o.key == key) return o.icon;
  }
  return null;
}
