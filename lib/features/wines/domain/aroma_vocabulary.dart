/// Controlled aroma vocabulary for the expert-tasting tags, plus a matcher
/// that maps FastCork's free-text aroma descriptors onto these canonical
/// tags so a scan can pre-select them.
///
/// Pure Dart — no Flutter — so it stays unit-testable and shareable between
/// the tasting UI and the scanner mapping.
library;

/// Canonical aroma tags grouped by family. The group order + within-group
/// order is the display order. Group labels are English (the tags are
/// English data too); i18n batched into #185.
const kAromaGroups = <String, List<String>>{
  'Red fruit': ['cherry', 'raspberry', 'strawberry', 'redcurrant', 'cranberry'],
  'Black fruit': ['plum', 'blackcurrant', 'blackberry', 'blueberry'],
  'Orchard': ['apple', 'pear', 'quince', 'peach', 'apricot', 'nectarine'],
  'Citrus': ['lemon', 'lime', 'grapefruit', 'orange'],
  'Tropical': ['pineapple', 'mango', 'passion fruit', 'lychee', 'melon'],
  'Floral': ['rose', 'violet', 'honeysuckle', 'jasmine', 'elderflower', 'blossom'],
  'Herbal': ['bell pepper', 'mint', 'eucalyptus', 'grass', 'thyme', 'fennel'],
  'Spice': ['black pepper', 'white pepper', 'clove', 'cinnamon', 'nutmeg', 'liquorice'],
  'Oak & roast': ['vanilla', 'toast', 'smoke', 'cedar', 'coffee', 'chocolate', 'caramel'],
  'Earthy': ['leather', 'tobacco', 'mushroom', 'forest floor', 'wet stone', 'mineral'],
  'Other': ['honey', 'butter', 'cream', 'almond', 'hazelnut', 'bread'],
};

/// Flat list of all canonical tags, in display order.
final List<String> kAromaTags = [
  for (final tags in kAromaGroups.values) ...tags,
];

final Set<String> _kAromaVocab = {...kAromaTags};

/// Synonyms / category words FastCork uses that don't substring-match a
/// canonical tag. Maps a descriptor to one or more canonical tags.
const _kAromaSynonyms = <String, List<String>>{
  'citrus': ['lemon', 'lime'],
  'floral': ['rose', 'violet'],
  'flowers': ['rose'],
  'tropical': ['pineapple', 'mango'],
  'tropical fruit': ['pineapple', 'mango'],
  'red fruit': ['cherry', 'raspberry', 'strawberry'],
  'red fruits': ['cherry', 'raspberry', 'strawberry'],
  'dark fruit': ['blackberry', 'blackcurrant'],
  'black fruit': ['blackberry', 'blackcurrant'],
  'berry': ['raspberry', 'blackberry'],
  'berries': ['raspberry', 'blackberry'],
  'stone fruit': ['peach', 'apricot'],
  'cassis': ['blackcurrant'],
  'oak': ['cedar', 'vanilla'],
  'oaky': ['cedar', 'vanilla'],
  'spice': ['black pepper', 'clove'],
  'spicy': ['black pepper', 'clove'],
  'spices': ['black pepper', 'clove'],
  'pepper': ['black pepper'],
  'herbal': ['thyme', 'mint'],
  'herbs': ['thyme', 'mint'],
  'earthy': ['forest floor', 'mushroom'],
  'earth': ['forest floor'],
  'nutty': ['almond', 'hazelnut'],
  'buttery': ['butter'],
  'toasty': ['toast'],
  'smoky': ['smoke'],
  'chocolatey': ['chocolate'],
  'cocoa': ['chocolate'],
  'vanilla bean': ['vanilla'],
};

/// Match FastCork's free-text aroma string (e.g. "green apple, citrus,
/// floral notes") to canonical [kAromaTags]. Direct hits, synonyms, then a
/// substring fallback ("green apple" → apple). Returns deduped tags in
/// vocabulary order.
List<String> matchAromas(String? raw) {
  if (raw == null || raw.trim().isEmpty) return const [];
  final hits = <String>{};

  final parts = raw
      .toLowerCase()
      .split(RegExp(r'[,;/]|\band\b|&'))
      .map(
        (s) => s
            .replaceAll(RegExp(r'\bnotes?\b'), '')
            .replaceAll(RegExp(r'\bhints?\b'), '')
            .replaceAll(RegExp(r'\baromas?\b'), '')
            .trim(),
      )
      .where((s) => s.isNotEmpty);

  for (final p in parts) {
    if (_kAromaVocab.contains(p)) {
      hits.add(p);
      continue;
    }
    final syn = _kAromaSynonyms[p];
    if (syn != null) {
      hits.addAll(syn.where(_kAromaVocab.contains));
      continue;
    }
    // Substring fallback: "green apple" contains "apple"; "lemon zest"
    // contains "lemon". Prefer the longest matching tag.
    String? best;
    for (final tag in kAromaTags) {
      if (p == tag || p.contains(tag) || tag.contains(p)) {
        if (best == null || tag.length > best.length) best = tag;
      }
    }
    if (best != null) hits.add(best);
  }

  // Preserve vocabulary order for stable display.
  return kAromaTags.where(hits.contains).toList();
}
