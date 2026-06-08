import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/wines/domain/aroma_vocabulary.dart';

/// What these catch: FastCork's free-text aroma descriptors map onto our
/// canonical tags — direct hits, category synonyms, and substring fallback.
/// What they miss: descriptors with no sensible mapping (correctly dropped).
void main() {
  test('null / empty → no tags', () {
    expect(matchAromas(null), isEmpty);
    expect(matchAromas('   '), isEmpty);
  });

  test('direct vocabulary hits', () {
    expect(matchAromas('cedar, vanilla'), ['vanilla', 'cedar']);
  });

  test('substring fallback: "green apple" → apple', () {
    expect(matchAromas('green apple'), ['apple']);
  });

  test('category synonyms: citrus → lemon+lime, floral → rose+violet', () {
    final tags = matchAromas('citrus, floral');
    expect(tags, containsAll(['lemon', 'lime', 'rose', 'violet']));
  });

  test('real FastCork string maps to several tags', () {
    // "Green apple, citrus, floral notes"
    final tags = matchAromas('Green apple, citrus, floral notes');
    expect(tags, contains('apple'));
    expect(tags, contains('lemon'));
    expect(tags, contains('rose'));
  });

  test('result is deduped and in vocabulary order', () {
    final tags = matchAromas('vanilla, vanilla, cedar');
    expect(tags, ['vanilla', 'cedar']); // vocab order, no dup
  });

  test('unmappable descriptor is dropped', () {
    expect(matchAromas('petrichor-xyz'), isEmpty);
  });

  test('every matched tag is in the canonical vocabulary', () {
    final tags = matchAromas('blackcurrant, cassis, oak, spicy, nutty');
    for (final t in tags) {
      expect(kAromaTags, contains(t));
    }
  });
}
