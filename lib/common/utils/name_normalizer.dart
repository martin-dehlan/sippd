const _diacritics = {
  'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a', 'æ': 'ae',
  'ç': 'c',
  'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e',
  'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
  'ñ': 'n',
  'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o', 'ø': 'o', 'œ': 'oe',
  'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u',
  'ý': 'y', 'ÿ': 'y',
  'ß': 'ss',
};

final _punct = RegExp(r'[^\w\s]');
final _whitespace = RegExp(r'\s+');

/// Normalizes a wine/winery name for fuzzy-equality matching.
/// lowercase → strip diacritics → drop punctuation → collapse whitespace.
String normalizeName(String? input) {
  if (input == null) return '';
  var s = input.toLowerCase();
  final buf = StringBuffer();
  for (final ch in s.split('')) {
    buf.write(_diacritics[ch] ?? ch);
  }
  s = buf.toString();
  s = s.replaceAll(_punct, ' ');
  s = s.replaceAll(_whitespace, ' ').trim();
  return s;
}
