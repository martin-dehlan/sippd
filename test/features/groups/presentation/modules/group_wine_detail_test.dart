import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/l10n/generated/app_localizations.dart';
import 'package:sippd/features/groups/controller/group_ratings.provider.dart';
import 'package:sippd/features/groups/controller/group_wines_query.provider.dart';
import 'package:sippd/features/groups/domain/entities/group_wine_rating.entity.dart';
import 'package:sippd/features/groups/domain/entities/group_wine_share.entity.dart';
import 'package:sippd/features/groups/presentation/modules/group_wine_detail/group_wine_detail.screen.dart';
import 'package:sippd/features/friends/domain/entities/friend_profile.entity.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

void main() {
  WineEntity sampleWine() => WineEntity(
    id: 'cw-1',
    name: 'Brunello',
    rating: 0,
    type: WineType.red,
    winery: 'Biondi-Santi',
    vintage: 2018,
    region: 'Toscana',
    country: 'IT',
    canonicalWineId: 'cw-1',
    userId: 'sharer-1',
    createdAt: DateTime(2026),
  );

  GroupWineRatingEntity rating({
    required String userId,
    required double score,
    String? notes,
    String? displayName,
    bool isOwner = false,
  }) => GroupWineRatingEntity(
    groupId: 'g-1',
    canonicalWineId: 'cw-1',
    userId: userId,
    rating: score,
    notes: notes,
    displayName: displayName,
    username: displayName?.toLowerCase(),
    updatedAt: DateTime.utc(2026, 5, 1),
    isOwner: isOwner,
  );

  void useIPhoneViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(390 * 2, 844 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> pumpScreen(
    WidgetTester tester, {
    required List<GroupWineRatingEntity> ratings,
    GroupWineShareEntity? share,
  }) async {
    useIPhoneViewport(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          groupWinesProvider('g-1').overrideWith((ref) async => [sampleWine()]),
          groupWineRatingsProvider(
            'g-1',
            'cw-1',
          ).overrideWith((ref) async => ratings),
          groupWineShareDetailsProvider(
            'g-1',
            'cw-1',
          ).overrideWith((ref) async => share),
        ],
        child: MaterialApp(
          home: GroupWineDetailScreen(
            groupId: 'g-1',
            canonicalWineId: 'cw-1',
            initial: sampleWine(),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    // Resolve overridden async providers (data emit).
    await tester.pumpAndSettle();
  }

  testWidgets('renders canonical header from initial entity', (tester) async {
    await pumpScreen(tester, ratings: const []);
    expect(find.text('BRUNELLO'), findsOneWidget);
    expect(find.textContaining('Biondi-Santi'), findsOneWidget);
    expect(find.textContaining('2018'), findsOneWidget);
  });

  testWidgets('shows empty state when no group ratings yet', (tester) async {
    await pumpScreen(tester, ratings: const []);
    expect(find.text('No group ratings yet.'), findsOneWidget);
  });

  testWidgets('renders SHARED BY block when share details available', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      ratings: const [],
      share: GroupWineShareEntity(
        sharer: const FriendProfileEntity(
          id: 'sharer-1',
          username: 'martin',
          displayName: 'Martin',
        ),
        sharedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    );
    expect(find.text('SHARED BY'), findsOneWidget);
    expect(find.textContaining('Martin'), findsOneWidget);
    expect(find.textContaining('d ago'), findsOneWidget);
  });

  testWidgets('renders one row per group rating with score + notes', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      ratings: [
        rating(userId: 'u1', score: 8.5, notes: 'Lovely', displayName: 'Anna'),
        rating(userId: 'u2', score: 6.0, displayName: 'Ben'),
      ],
    );
    expect(find.text('Anna'), findsOneWidget);
    expect(find.text('Ben'), findsOneWidget);
    expect(find.text('8.5'), findsOneWidget);
    expect(find.text('6.0'), findsOneWidget);
    expect(find.text('Lovely'), findsOneWidget);
    // Empty-state copy must NOT appear once we have rows.
    expect(find.text('No group ratings yet.'), findsNothing);
  });

  testWidgets('group avg surfaces in stats column when ratings present', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      ratings: [
        rating(userId: 'u1', score: 8),
        rating(userId: 'u2', score: 6),
      ],
    );
    // Average = 7.0
    expect(find.text('7.0'), findsOneWidget);
    expect(find.text('GROUP AVG'), findsOneWidget);
  });

  testWidgets('renders without layout overflow on a small viewport', (
    tester,
  ) async {
    // iPhone SE 1st gen height (568pt) — the original
    // SizedBox(h * 0.32) gave ~182px which couldn't fit 3 StatItems.
    // After the IntrinsicHeight + tighter spacing fix this should
    // render cleanly with no rendering exception.
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          groupWinesProvider('g-1').overrideWith((ref) async => [sampleWine()]),
          groupWineRatingsProvider(
            'g-1',
            'cw-1',
          ).overrideWith((ref) async => const <GroupWineRatingEntity>[]),
          groupWineShareDetailsProvider(
            'g-1',
            'cw-1',
          ).overrideWith((ref) async => null),
        ],
        child: MaterialApp(
          home: GroupWineDetailScreen(
            groupId: 'g-1',
            canonicalWineId: 'cw-1',
            initial: sampleWine(),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.takeException(),
      isNull,
      reason: 'no RenderFlex overflow on a small viewport',
    );
  });

  testWidgets('shows loading spinner when initial is null and remote empty', (
    tester,
  ) async {
    useIPhoneViewport(tester);
    final pending = Completer<List<WineEntity>>();
    addTearDown(() => pending.complete(const <WineEntity>[]));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          groupWinesProvider('g-1').overrideWith((ref) => pending.future),
          groupWineRatingsProvider(
            'g-1',
            'cw-1',
          ).overrideWith((ref) async => []),
          groupWineShareDetailsProvider(
            'g-1',
            'cw-1',
          ).overrideWith((ref) async => null),
        ],
        child: MaterialApp(
          home: const GroupWineDetailScreen(
            groupId: 'g-1',
            canonicalWineId: 'cw-1',
            initial: null,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    // Don't pumpAndSettle — that'd time out on the never-resolving future.
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
