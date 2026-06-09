import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sippd/common/l10n/generated/app_localizations.dart';
import 'package:sippd/features/badges/domain/entities/badge.entity.dart';
import 'package:sippd/features/badges/presentation/widgets/badge_card.widget.dart';

BadgeEntity _badge({required bool earned, int current = 0}) => BadgeEntity(
  id: 'wine_explorer',
  category: 'volume',
  tier: 3,
  title: 'Wine Explorer',
  description: 'Rate 50 wines',
  icon: 'wine_explorer',
  earned: earned,
  current: current,
  target: 50,
);

Widget _host(BadgeEntity badge) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Center(
      child: SizedBox(
        width: 100,
        child: BadgeCard(badge: badge, onTap: () {}),
      ),
    ),
  ),
);

void main() {
  testWidgets('locked badge shows a lock and no earned check', (tester) async {
    await tester.pumpWidget(_host(_badge(earned: false, current: 20)));

    expect(find.text('Wine Explorer'), findsOneWidget);
    expect(find.byIcon(PhosphorIconsFill.lock), findsOneWidget);
    expect(find.byIcon(PhosphorIconsFill.checkCircle), findsNothing);
    // A progress bar is present for locked badges.
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('earned badge shows a check and no lock', (tester) async {
    await tester.pumpWidget(_host(_badge(earned: true)));

    expect(find.byIcon(PhosphorIconsFill.checkCircle), findsOneWidget);
    expect(find.byIcon(PhosphorIconsFill.lock), findsNothing);
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });

  testWidgets('tapping the card fires onTap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SizedBox(
            width: 100,
            child: BadgeCard(
              badge: _badge(earned: true),
              onTap: () => tapped = true,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(BadgeCard));
    expect(tapped, isTrue);
  });
}
