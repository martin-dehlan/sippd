import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/taste_compass.entity.dart';
import '../../domain/entities/user_style_dna.entity.dart';

/// Wine personality headline above the compass radar. Phase 1 uses a
/// simple rule-based heuristic over compass + DNA — Phase 2 will plug
/// in proper archetype distance matching.
class ArchetypeHeadline extends StatelessWidget {
  const ArchetypeHeadline({
    super.key,
    required this.compass,
    this.dna,
  });

  final TasteCompassEntity compass;
  final UserStyleDna? dna;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final archetype = _pickArchetype(compass, dna);

    return Container(
      padding: EdgeInsets.all(context.s * 1.4),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.035),
        border: Border.all(
          color: archetype.color.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: context.w * 0.11,
            height: context.w * 0.11,
            decoration: BoxDecoration(
              color: archetype.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: archetype.color.withValues(alpha: 0.6),
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              archetype.icon,
              color: archetype.color,
              size: context.w * 0.055,
            ),
          ),
          SizedBox(width: context.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'YOUR WINE PERSONALITY',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.75,
                    fontWeight: FontWeight.w700,
                    color: cs.outline,
                    letterSpacing: 0.9,
                  ),
                ),
                SizedBox(height: context.xs * 0.4),
                Text(
                  archetype.name,
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.05,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: context.xs * 0.4),
                Text(
                  archetype.tagline,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Archetype {
  const _Archetype({
    required this.name,
    required this.tagline,
    required this.icon,
    required this.color,
  });
  final String name;
  final String tagline;
  final IconData icon;
  final Color color;
}

const _oldWorldCountries = {
  'france', 'italy', 'spain', 'germany', 'portugal', 'austria',
  'greece', 'hungary', 'croatia', 'slovenia', 'georgia', 'romania',
  'bulgaria', 'switzerland', 'czechia', 'czech republic', 'slovakia',
  'moldova', 'ukraine', 'serbia', 'macedonia', 'cyprus', 'lebanon',
  'turkey', 'israel',
};
const _newWorldCountries = {
  'united states', 'usa', 'us', 'argentina', 'chile', 'australia',
  'new zealand', 'south africa', 'canada', 'brazil', 'uruguay',
  'mexico', 'china', 'japan', 'india',
};

_Archetype _pickArchetype(TasteCompassEntity c, UserStyleDna? dna) {
  if (c.totalCount < 5) {
    return const _Archetype(
      name: 'Curious Newcomer',
      tagline:
          'Rate a few more wines and your personality reveals itself.',
      icon: PhosphorIconsRegular.compass,
      color: Color(0xFFB48BD0),
    );
  }

  int countOf(String type) => c.typeBreakdown
      .where((b) => b.label.toLowerCase() == type)
      .fold<int>(0, (s, b) => s + b.count);
  int countryShare(Set<String> set) => c.topCountries
      .where((b) => set.contains(b.label.toLowerCase()))
      .fold<int>(0, (s, b) => s + b.count);

  final total = c.totalCount;
  final red = countOf('red');
  final white = countOf('white');
  final rose = countOf('rose');
  final sparkling = countOf('sparkling');
  final oldWorld = countryShare(_oldWorldCountries);
  final newWorld = countryShare(_newWorldCountries);
  final regionCount = c.topRegions.length;

  final body = dna?.values['body'] ?? 0.5;
  final tannin = dna?.values['tannin'] ?? 0.5;
  final acidity = dna?.values['acidity'] ?? 0.55;
  final sweetness = dna?.values['sweetness'] ?? 0.05;
  final oak = dna?.values['oak'] ?? 0.3;

  double pct(int n) => total == 0 ? 0 : n / total;

  if (sweetness > 0.3) {
    return const _Archetype(
      name: 'Dessert / Off-Dry',
      tagline: 'You lean toward bottles with a touch of sweetness.',
      icon: PhosphorIconsRegular.dropHalf,
      color: Color(0xFFE3A6BA),
    );
  }
  if (pct(sparkling + rose) > 0.3) {
    return const _Archetype(
      name: 'Sparkling Sociable',
      tagline: 'Bubbles and pale wines feature heavily in your collection.',
      icon: PhosphorIconsRegular.sparkle,
      color: Color(0xFFB7C7DC),
    );
  }
  if (pct(red) > 0.6 && body > 0.6 && tannin > 0.55) {
    return const _Archetype(
      name: 'Bold Red Hunter',
      tagline: 'Full-bodied, tannin-rich reds are your home turf.',
      icon: PhosphorIconsRegular.flame,
      color: Color(0xFFE05A6B),
    );
  }
  if (pct(red) > 0.5 && body < 0.5 && acidity > 0.65) {
    return const _Archetype(
      name: 'Elegant Burgundian',
      tagline: 'Lighter reds with bright acidity drive your palate.',
      icon: PhosphorIconsRegular.leaf,
      color: Color(0xFFD08F5C),
    );
  }
  if (pct(white) > 0.5 && acidity > 0.65) {
    return const _Archetype(
      name: 'Aromatic White Lover',
      tagline: 'Crisp, expressive whites with cut-through acidity.',
      icon: PhosphorIconsRegular.flowerLotus,
      color: Color(0xFFE8D9A1),
    );
  }
  if (oldWorld > newWorld && pct(oldWorld) > 0.5) {
    return const _Archetype(
      name: 'Old-World Curious',
      tagline: 'European heritage producers shape your palate.',
      icon: PhosphorIconsRegular.castleTurret,
      color: Color(0xFFD08F5C),
    );
  }
  if (newWorld > oldWorld && pct(newWorld) > 0.5 && (oak > 0.4 || body > 0.55)) {
    return const _Archetype(
      name: 'New-World Bold',
      tagline: 'Big-fruit, oak-friendly bottles from the Americas + south.',
      icon: PhosphorIconsRegular.sun,
      color: Color(0xFF4FC3B0),
    );
  }
  if (oak < 0.2 && body < 0.55) {
    return const _Archetype(
      name: 'Natural / Low-Intervention',
      tagline: 'Unoaked, lighter wines — the freshness camp.',
      icon: PhosphorIconsRegular.plant,
      color: Color(0xFFB48BD0),
    );
  }
  if (acidity > 0.7 && body < 0.5) {
    return const _Archetype(
      name: 'Crisp Mineral Fan',
      tagline: 'Tight, mineral, high-acid styles are your signature.',
      icon: PhosphorIconsRegular.snowflake,
      color: Color(0xFFB7C7DC),
    );
  }
  if (regionCount >= 5) {
    return const _Archetype(
      name: 'Eclectic Explorer',
      tagline: 'Wide-ranging palate — you taste across the wine map.',
      icon: PhosphorIconsRegular.compass,
      color: Color(0xFF4FC3B0),
    );
  }
  return const _Archetype(
    name: 'Balanced Drinker',
    tagline: 'No dominant lean yet — your style is still finding shape.',
    icon: PhosphorIconsRegular.scales,
    color: Color(0xFFB48BD0),
  );
}
