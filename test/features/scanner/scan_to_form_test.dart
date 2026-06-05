import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/scanner/domain/entities/scan_quota.entity.dart';
import 'package:sippd/features/scanner/domain/entities/scan_result.entity.dart';
import 'package:sippd/features/scanner/presentation/scan_to_form.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';
import 'package:sippd/features/wines/presentation/widgets/wine_form.widget.dart';

/// What these catch: how a recognized label becomes the add-wine prefill —
/// name fallback, region←appellation fallback, and the canonical-vs-free-text
/// grape split. What they miss: that the prefilled form actually renders /
/// saves (covered by wine_add flow, not here).
ScanResultEntity result({
  String? producer,
  String? wineName,
  String? region,
  String? appellation,
  List<String> grapes = const [],
}) => ScanResultEntity(
  producer: producer,
  wineName: wineName,
  region: region,
  appellation: appellation,
  grapes: grapes,
  country: 'France',
  vintage: 2019,
  tastingNotes: 'Notes.',
  quota: const ScanQuotaEntity(used: 1, limit: 5, remaining: 4),
);

void main() {
  test('name uses displayName; winery/country/notes carry through', () {
    final f = scanToFormData(result(producer: 'Solo', wineName: 'Cuvée'));
    expect(f.name, 'Cuvée');
    expect(f.winery, 'Solo');
    expect(f.country, 'France');
    expect(f.vintage, 2019);
    expect(f.notes, 'Notes.');
  });

  test('region falls back to appellation when region is null', () {
    final withRegion = scanToFormData(
      result(region: 'Bordeaux', appellation: 'St-Émilion'),
    );
    expect(withRegion.region, 'Bordeaux');

    final appellationOnly = scanToFormData(result(appellation: 'St-Émilion'));
    expect(appellationOnly.region, 'St-Émilion');
  });

  test('no canonical id → first grape goes to free-text', () {
    final f = scanToFormData(result(grapes: ['Merlot', 'Syrah']));
    expect(f.grape, 'Merlot');
    expect(f.grapeFreetext, 'Merlot');
    expect(f.canonicalGrapeId, isNull);
  });

  test('canonical id provided → free-text cleared, id retained', () {
    final f = scanToFormData(
      result(grapes: ['Merlot']),
      canonicalGrapeId: 'grape-123',
      grapeDisplay: 'Merlot',
    );
    expect(f.canonicalGrapeId, 'grape-123');
    expect(f.grape, 'Merlot');
    expect(f.grapeFreetext, isNull);
  });

  test('explicit type override is honored', () {
    final f = scanToFormData(result(), type: WineType.white);
    expect(f.type, WineType.white);
  });
}
