import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/database/database.dart';
import 'package:sippd/features/push/data/models/notification_prefs.model.dart';
import 'package:sippd/features/push/data/repositories/notification_prefs.repository.impl.dart';
import 'package:sippd/features/push/domain/entities/notification_prefs.entity.dart';

import '../../../helpers/fake_database.dart';
import '../../../helpers/mocks.dart';

void main() {
  setUpAll(registerTestFallbacks);

  group('NotificationPrefsModel JSON', () {
    test('round-trips with snake_case keys', () {
      final original = NotificationPrefsModel(
        userId: 'user-1',
        tastingReminders: true,
        tastingReminderHours: 2,
        friendActivity: false,
        groupActivity: true,
        groupWineShared: false,
        updatedAt: DateTime.utc(2026, 5, 4),
      );
      final json = original.toJson();
      expect(
        json.keys,
        containsAll([
          'user_id',
          'tasting_reminders',
          'tasting_reminder_hours',
          'friend_activity',
          'group_activity',
          'group_wine_shared',
          'updated_at',
        ]),
      );
      expect(NotificationPrefsModel.fromJson(json), original);
    });

    test('toEntity / toModel / toTableData all preserve every field', () {
      final entity = NotificationPrefsEntity(
        userId: 'user-1',
        tastingReminders: false,
        tastingReminderHours: 24,
        friendActivity: true,
        groupActivity: false,
        groupWineShared: true,
        updatedAt: DateTime.utc(2026, 5, 4),
      );
      final round = entity.toModel().toEntity();
      expect(round, entity);
      final fromTable = entity.toTableData().toEntity();
      expect(fromTable, entity);
    });
  });

  group('NotificationPrefsEntity.defaults', () {
    test('opt-in defaults — every channel on, 1h tasting lead time', () {
      final d = NotificationPrefsEntity.defaults('user-1');
      expect(d.tastingReminders, isTrue);
      expect(d.tastingReminderHours, 1);
      expect(d.friendActivity, isTrue);
      expect(d.groupActivity, isTrue);
      expect(d.groupWineShared, isTrue);
    });
  });

  group('NotificationPrefsRepositoryImpl', () {
    late AppDatabase db;
    late MockNotificationPrefsApi api;
    late NotificationPrefsRepositoryImpl repo;

    setUp(() {
      db = makeFakeDatabase();
      api = MockNotificationPrefsApi();
      repo = NotificationPrefsRepositoryImpl(db.notificationPrefsDao, api);
    });

    tearDown(() async {
      await db.close();
    });

    test('getPrefs returns defaults when no local + no remote row', () async {
      when(() => api.fetch(any())).thenAnswer((_) async => null);

      final prefs = await repo.getPrefs('user-1');

      expect(prefs.userId, 'user-1');
      expect(prefs.tastingReminders, isTrue);
    });

    test(
      'getPrefs hydrates local from remote when remote returns a row',
      () async {
        when(() => api.fetch('user-1')).thenAnswer(
          (_) async => NotificationPrefsModel(
            userId: 'user-1',
            tastingReminders: false,
            tastingReminderHours: 6,
            friendActivity: false,
            groupActivity: true,
            groupWineShared: false,
            updatedAt: DateTime.utc(2026, 5, 4),
          ),
        );

        final prefs = await repo.getPrefs('user-1');

        expect(prefs.tastingReminders, isFalse);
        expect(prefs.tastingReminderHours, 6);
        // Confirm the remote row landed in the local mirror.
        final cached = await db.notificationPrefsDao.getByUser('user-1');
        expect(cached, isNotNull);
      },
    );

    test('getPrefs falls back to defaults when remote fetch errors', () async {
      when(() => api.fetch(any())).thenThrow(StateError('offline'));

      final prefs = await repo.getPrefs('user-1');
      expect(
        prefs.tastingReminders,
        isTrue,
        reason: 'defaults() served on offline',
      );
    });

    test(
      'updatePrefs writes locally + syncs + writes back server row',
      () async {
        final updated = NotificationPrefsEntity.defaults(
          'user-1',
        ).copyWith(tastingReminders: false, groupActivity: false);
        when(() => api.upsert(any())).thenAnswer((inv) async {
          final m = inv.positionalArguments.first as NotificationPrefsModel;
          // Simulate server stamping a fresh updated_at.
          return m.copyWith(updatedAt: DateTime.utc(2099));
        });

        await repo.updatePrefs(updated);

        final cached = await db.notificationPrefsDao.getByUser('user-1');
        expect(cached?.tastingReminders, isFalse);
        expect(cached?.groupActivity, isFalse);
        // Server-stamped updated_at should be the one cached, not the
        // optimistic local stamp. Drift round-trips DateTime through
        // epoch ints so we compare moments rather than zone-tagged
        // DateTime equality.
        expect(cached?.updatedAt.isAtSameMomentAs(DateTime.utc(2099)), isTrue);
      },
    );

    test('updatePrefs local write survives Supabase failure', () async {
      when(() => api.upsert(any())).thenThrow(StateError('500'));

      final updated = NotificationPrefsEntity.defaults(
        'user-1',
      ).copyWith(friendActivity: false);
      await repo.updatePrefs(updated);

      final cached = await db.notificationPrefsDao.getByUser('user-1');
      expect(
        cached?.friendActivity,
        isFalse,
        reason: 'local write stands even when sync fails',
      );
    });
  });
}
