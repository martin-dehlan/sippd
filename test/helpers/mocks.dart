import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show GoTrueClient, SupabaseClient, User;
import 'package:sippd/common/services/analytics/analytics.service.dart';
import 'package:sippd/features/auth/controller/auth.provider.dart';
import 'package:sippd/features/friends/data/data_sources/activity.api.dart';
import 'package:sippd/features/friends/data/data_sources/friend_wines.api.dart';
import 'package:sippd/features/friends/data/data_sources/friends.api.dart';
import 'package:sippd/features/friends/domain/entities/friend_profile.entity.dart';
import 'package:sippd/features/friends/domain/repositories/friends.repository.dart';
import 'package:sippd/features/groups/data/data_sources/group_image.service.dart';
import 'package:sippd/features/profile/data/data_sources/profile.api.dart';
import 'package:sippd/features/paywall/data/services/paywall.service.dart';
import 'package:sippd/features/profile/data/models/profile.model.dart';
import 'package:sippd/features/push/data/data_sources/notification_prefs.api.dart';
import 'package:sippd/features/push/data/models/notification_prefs.model.dart';
import 'package:sippd/features/tastings/data/data_sources/tastings.api.dart';
import 'package:sippd/features/wines/data/data_sources/canonical_wine.api.dart';
import 'package:sippd/features/wines/data/data_sources/wine_image.service.dart';
import 'package:sippd/features/wines/data/data_sources/wine_memory_supabase.api.dart';
import 'package:sippd/features/wines/data/data_sources/wine_supabase.api.dart';
import 'package:sippd/features/wines/data/models/wine.model.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';
import 'package:sippd/features/wines/domain/repositories/wine.repository.dart';
import 'package:sippd/features/wines/domain/repositories/wine_memory.repository.dart';

// ---- API mocks --------------------------------------------------------
class MockWineSupabaseApi extends Mock implements WineSupabaseApi {}

class MockWineImageService extends Mock implements WineImageService {}

class MockWineMemorySupabaseApi extends Mock
    implements WineMemorySupabaseApi {}

class MockCanonicalWineApi extends Mock implements CanonicalWineApi {}

class MockProfileApi extends Mock implements ProfileApi {}

class MockFriendsApi extends Mock implements FriendsApi {}

class MockFriendWinesApi extends Mock implements FriendWinesApi {}

class MockActivityApi extends Mock implements ActivityApi {}

class MockGroupImageService extends Mock implements GroupImageService {}

class MockTastingsApi extends Mock implements TastingsApi {}

class MockNotificationPrefsApi extends Mock
    implements NotificationPrefsApi {}

class MockPaywallService extends Mock implements PaywallService {}

// ---- Repository mocks -------------------------------------------------
class MockWineRepository extends Mock implements WineRepository {}

class MockWineMemoryRepository extends Mock implements WineMemoryRepository {}

class MockFriendsRepository extends Mock implements FriendsRepository {}

// ---- Service mocks ----------------------------------------------------
class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

// ---- Riverpod auth notifier fake -------------------------------------
/// Override [authControllerProvider] with one of these to pin the
/// signed-in user (or sign them out) without booting Supabase.
class FakeAuthController extends AuthController {
  FakeAuthController({this.user});
  final User? user;
  @override
  AsyncValue<User?> build() => AsyncValue.data(user);
}

/// Call once per `setUpAll` so mocktail can synthesise default values
/// for `any()` matchers on parameters typed with these classes.
void registerTestFallbacks() {
  registerFallbackValue(_anyWineEntity());
  registerFallbackValue(_anyWineModel());
  registerFallbackValue(_anyProfileModel());
  registerFallbackValue(_anyNotificationPrefsModel());
  registerFallbackValue(FriendProfileEntity(id: 'test-friend'));
  registerFallbackValue(StackTrace.empty);
  registerFallbackValue(<String, Object>{});
  registerFallbackValue(<String>[]);
}

WineEntity _anyWineEntity() => WineEntity(
      id: 'test-wine',
      name: 'Test Wine',
      rating: 7,
      type: WineType.red,
      userId: 'test-user',
      createdAt: DateTime(2026),
    );

WineModel _anyWineModel() => WineModel(
      id: 'test-wine',
      name: 'Test Wine',
      rating: 7,
      type: 'red',
      userId: 'test-user',
      createdAt: DateTime(2026),
    );

ProfileModel _anyProfileModel() => const ProfileModel(
      id: 'test-user',
      onboardingCompleted: true,
    );

NotificationPrefsModel _anyNotificationPrefsModel() =>
    NotificationPrefsModel(
      userId: 'test-user',
      tastingReminders: true,
      tastingReminderHours: 1,
      friendActivity: true,
      groupActivity: true,
      groupWineShared: true,
      updatedAt: DateTime(2026),
    );
