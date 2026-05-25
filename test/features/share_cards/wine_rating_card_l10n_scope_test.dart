import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/l10n/generated/app_localizations.dart';
import 'package:sippd/features/share_cards/presentation/cards/share_card_branding.widget.dart';
import 'package:sippd/features/share_cards/presentation/cards/wine_rating_card.widget.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

/// Regression guard for the "grey share image" bug.
///
/// `ShareCardService` renders share cards off-screen via the `screenshot`
/// package, which builds them in a *detached* render tree. That tree
/// copies inherited Themes + MediaQuery but NOT `Localizations` (a plain
/// InheritedWidget). Once the cards started calling
/// `AppLocalizations.of(context)` / `Localizations.localeOf` (i18n PR),
/// those lookups threw in the detached tree, Flutter swapped the subtree
/// for an `ErrorWidget` — a plain grey box in release — and that grey
/// PNG was what got shared.
///
/// The fix wraps the captured card in its own `Localizations` scope. This
/// test pins the contract that makes that fix sufficient: a card must
/// build with ONLY a Localizations scope around it (no MaterialApp), i.e.
/// exactly what the detached capture tree provides post-fix.
///
/// What this catches: a card gaining a dependency on an ambient widget
/// the capture tree doesn't supply (the regression mechanism).
/// What it does NOT catch: regressions in the service's wrapping itself
/// (removing the `Localizations` wrap in `_renderToFile`), or the native
/// screenshot/share path — those live in manual smoke / integration.
void main() {
  WineEntity sampleWine() => WineEntity(
    id: 'w1',
    name: 'Barolo Riserva',
    rating: 9.2,
    type: WineType.red,
    userId: 'u1',
    createdAt: DateTime(2026, 5, 1),
  );

  // Mirrors the post-fix detached capture environment: a bare
  // Localizations scope (our fix) over the card. Deliberately no
  // MaterialApp — that is the whole point.
  Widget underLocalizations(Widget child) => Localizations(
    locale: const Locale('en'),
    delegates: AppLocalizations.localizationsDelegates,
    child: MediaQuery(
      data: const MediaQueryData(),
      child: Directionality(textDirection: TextDirection.ltr, child: child),
    ),
  );

  // Drains every exception the binding captured during the pump. The
  // card pulls in `Image.asset` (branding logo) and GoogleFonts, which
  // fail to load in the test bundle — environmental noise we filter out
  // so we can assert specifically on the Localizations failure.
  List<Object> drainExceptions(WidgetTester tester) {
    final out = <Object>[];
    for (Object? e = tester.takeException(); e != null;) {
      out.add(e);
      e = tester.takeException();
    }
    return out;
  }

  testWidgets('wine rating card builds under a bare Localizations scope', (
    tester,
  ) async {
    await tester.pumpWidget(
      underLocalizations(
        WineRatingCard(wine: sampleWine(), username: 'martin'),
      ),
    );
    await tester.pump();

    // The rating row lives in the same subtree as the l10n lookups, so it
    // only renders if those resolved instead of throwing into an
    // ErrorWidget.
    expect(find.byType(WineRatingCard), findsOneWidget);
    expect(find.text('9.2'), findsOneWidget);
    drainExceptions(tester); // clear branding-asset / font noise
  });

  // A content-heavy wine in the photo layout (imageUrl set => the 980px
  // photo block is reserved, leaving the least room for the meta block)
  // is the worst case for vertical overflow. German strings are the
  // longest, so this is the tightest combination.
  WineEntity richWine() => WineEntity(
    id: 'w2',
    name: 'Château Lafite Rothschild Grand Cru Classé',
    winery: 'Domaine de la Romanée-Conti',
    region: 'Bordeaux, Médoc, Pauillac',
    rating: 9.7,
    type: WineType.red,
    vintage: 2018,
    notes:
        'Tiefe Aromen von schwarzer Johannisbeere, Zedernholz und Tabak, '
        'mit einem langen, seidigen Abgang.',
    imageUrl: 'https://example.com/wine.jpg',
    userId: 'u1',
    createdAt: DateTime(2026, 5, 1),
  );

  // Renders [child] inside the real share-card canvas and returns the
  // overflow errors the binding captured during layout. RenderFlex
  // overflows surface as FlutterErrors whose message contains
  // "overflowed"; all other captured exceptions (network image fetch,
  // branding asset, GoogleFonts) are environmental noise.
  Future<List<Object>> overflowErrors(
    WidgetTester tester,
    Widget child,
    Locale locale,
  ) async {
    await tester.binding.setSurfaceSize(
      const Size(shareCardWidth, shareCardHeight),
    );
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      Localizations(
        locale: locale,
        delegates: AppLocalizations.localizationsDelegates,
        child: MediaQuery(
          data: const MediaQueryData(
            size: Size(shareCardWidth, shareCardHeight),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: shareCardWidth,
              height: shareCardHeight,
              child: child,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    return drainExceptions(
      tester,
    ).where((e) => e.toString().contains('overflowed')).toList();
  }

  testWidgets('photo card does not overflow with rich content (en + de)', (
    tester,
  ) async {
    for (final locale in const [Locale('en'), Locale('de')]) {
      final errors = await overflowErrors(
        tester,
        WineRatingCard(wine: richWine(), username: 'martin'),
        locale,
      );
      expect(
        errors,
        isEmpty,
        reason: 'wine card overflowed in "${locale.languageCode}": $errors',
      );
    }
  });

  testWidgets('without a Localizations scope the card breaks (the bug)', (
    tester,
  ) async {
    // No Localizations — reproduces the pre-fix detached tree, where the
    // card's AppLocalizations.of / Localizations.localeOf lookups blow up
    // and Flutter swaps the subtree for the grey ErrorWidget that got
    // shared.
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: WineRatingCard(wine: sampleWine()),
        ),
      ),
    );
    await tester.pump();

    // Subtree threw during build → rating never rendered, and at least
    // one build exception was captured.
    expect(find.text('9.2'), findsNothing);
    expect(drainExceptions(tester), isNotEmpty);
  });
}
