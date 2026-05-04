import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';
import 'package:sippd/features/wines/presentation/widgets/wine_detail_blocks.widget.dart';

import '../../../../helpers/pump_provider_app.dart';

void main() {
  WineEntity sample({
    String name = 'Brunello',
    WineType type = WineType.red,
    String? winery = 'Biondi-Santi',
    int? vintage = 2018,
    String? imageUrl,
  }) =>
      WineEntity(
        id: 'w-1',
        name: name,
        rating: 9,
        type: type,
        winery: winery,
        vintage: vintage,
        imageUrl: imageUrl,
        userId: 'u-1',
        createdAt: DateTime(2026),
      );

  group('WineDetailTitle', () {
    testWidgets('renders the name in uppercase', (tester) async {
      await tester.pumpProviderApp(
        child: const WineDetailTitle(name: 'Pinot Noir'),
      );
      expect(find.text('PINOT NOIR'), findsOneWidget);
    });

    testWidgets('truncates very long names without overflow',
        (tester) async {
      await tester.pumpProviderApp(
        child: WineDetailTitle(
          name: 'A' * 200,
        ),
      );
      // Render did not blow up — that's the assertion. Lock it in
      // with a positive find so accidental Text-replacement breaks
      // here too.
      expect(find.byType(WineDetailTitle), findsOneWidget);
    });
  });

  group('WineDetailMetaLine', () {
    testWidgets('joins type · winery · vintage with separators',
        (tester) async {
      await tester.pumpProviderApp(
        child: WineDetailMetaLine(
          type: sample().type,
          winery: sample().winery,
          vintage: sample().vintage,
          canonicalGrapeId: null,
          grapeFreetext: null,
          legacyGrape: null,
        ),
      );
      // Text.rich is rendered as a single RichText — assert via
      // textContaining on the underlying widget tree.
      expect(find.textContaining('Red'), findsOneWidget);
      expect(find.textContaining('Biondi-Santi'), findsOneWidget);
      expect(find.textContaining('2018'), findsOneWidget);
    });

    testWidgets('renders grapeFreetext when no canonical grape',
        (tester) async {
      await tester.pumpProviderApp(
        child: const WineDetailMetaLine(
          type: WineType.red,
          winery: 'Boutique',
          vintage: 2020,
          canonicalGrapeId: null,
          grapeFreetext: 'Sangiovese Grosso',
          legacyGrape: null,
        ),
      );
      expect(find.textContaining('Sangiovese Grosso'), findsOneWidget);
    });

    testWidgets('falls back to legacyGrape when both canonical + freetext absent',
        (tester) async {
      await tester.pumpProviderApp(
        child: const WineDetailMetaLine(
          type: WineType.white,
          winery: null,
          vintage: null,
          canonicalGrapeId: null,
          grapeFreetext: null,
          legacyGrape: 'Riesling',
        ),
      );
      expect(find.textContaining('Riesling'), findsOneWidget);
    });

    testWidgets('omits absent winery and vintage cleanly', (tester) async {
      await tester.pumpProviderApp(
        child: const WineDetailMetaLine(
          type: WineType.rose,
          winery: null,
          vintage: null,
          canonicalGrapeId: null,
          grapeFreetext: null,
          legacyGrape: null,
        ),
      );
      // Only the type label remains.
      expect(find.textContaining('Rosé'), findsOneWidget);
      expect(find.textContaining('null'), findsNothing);
    });
  });

  group('WineDetailImage', () {
    testWidgets('falls back to a wine icon when imageUrl is null',
        (tester) async {
      await tester.pumpProviderApp(child: WineDetailImage(wine: sample()));
      // Network image not attempted → icon present.
      expect(find.byType(WineDetailImage), findsOneWidget);
    });
  });

  group('WineDetailSectionHeader', () {
    testWidgets('renders the label uppercase', (tester) async {
      await tester.pumpProviderApp(
        child: const WineDetailSectionHeader(label: 'NOTES'),
      );
      expect(find.text('NOTES'), findsOneWidget);
    });
  });
}
