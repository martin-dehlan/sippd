import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../push/controller/push.provider.dart';
import '../../../../push/domain/entities/notification_prefs.entity.dart';

const _reminderHourOptions = [1, 2, 3, 4, 6, 12, 24];

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final prefsAsync = ref.watch(notificationPrefsControllerProvider);
    final controller = ref.read(notificationPrefsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: prefsAsync.when(
        data: (prefs) => _Body(
          prefs: prefs,
          controller: controller,
          onSendTestReminder: () => _sendTestReminder(context, ref),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(context.paddingH),
            child: Text(
              'Could not load notification settings: $e',
              style: TextStyle(color: cs.error),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _sendTestReminder(BuildContext context, WidgetRef ref) async {
  final pushHandler = ref.read(pushHandlerProvider);
  final reminderAt = DateTime.now().add(const Duration(minutes: 3));
  // Stable id so a second tap replaces the pending alarm rather than
  // stacking another one. Cleanup is best-effort; the cancel runs first
  // anyway as part of the deterministic id contract on zonedSchedule.
  await pushHandler.scheduleTastingReminder(
    tastingId: 'debug-test-reminder',
    tastingTitle: 'Test reminder',
    reminderAt: reminderAt,
    offsetHours: 0,
  );
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Test reminder scheduled in 3 minutes'),
      duration: Duration(seconds: 2),
    ),
  );
}

class _Body extends StatelessWidget {
  final NotificationPrefsEntity prefs;
  final NotificationPrefsController controller;
  final VoidCallback onSendTestReminder;

  const _Body({
    required this.prefs,
    required this.controller,
    required this.onSendTestReminder,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH,
        vertical: context.l,
      ),
      children: [
        const _SectionLabel('Tastings'),
        _ToggleTile(
          icon: PhosphorIconsRegular.wine,
          label: 'Tasting reminders',
          subtitle: 'Push before a tasting starts',
          value: prefs.tastingReminders,
          onChanged: controller.setTastingReminders,
        ),
        if (prefs.tastingReminders) ...[
          SizedBox(height: context.s),
          _HourPicker(
            selected: prefs.tastingReminderHours,
            onChanged: controller.setTastingReminderHours,
          ),
          SizedBox(height: context.xs),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.w * 0.02),
            child: Text(
              'Applies to new tastings. Existing reminders keep their original timing until the tasting is edited.',
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
        SizedBox(height: context.l),

        const _SectionLabel('Friends'),
        _ToggleTile(
          icon: PhosphorIconsRegular.users,
          label: 'Friend activity',
          subtitle: 'Requests and acceptances',
          value: prefs.friendActivity,
          onChanged: controller.setFriendActivity,
        ),
        SizedBox(height: context.l),

        const _SectionLabel('Groups'),
        _ToggleTile(
          icon: PhosphorIconsRegular.usersThree,
          label: 'Group activity',
          subtitle: 'Invites, joins and new tastings',
          value: prefs.groupActivity,
          onChanged: controller.setGroupActivity,
        ),
        SizedBox(height: context.s),
        _ToggleTile(
          icon: PhosphorIconsRegular.shareNetwork,
          label: 'New wine shared',
          subtitle: 'When a friend adds a wine to your group',
          value: prefs.groupWineShared,
          onChanged: controller.setGroupWineShared,
        ),
        if (kDebugMode) ...[
          SizedBox(height: context.l),
          const _SectionLabel('Debug'),
          _DebugActionTile(
            icon: PhosphorIconsRegular.bellRinging,
            label: 'Send test reminder (3 min)',
            subtitle: 'Schedules a one-off local notification right now',
            onTap: onSendTestReminder,
          ),
        ],
      ],
    );
  }
}

class _DebugActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _DebugActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.m,
            horizontal: context.w * 0.04,
          ),
          child: Row(
            children: [
              Icon(icon, color: cs.primary, size: context.w * 0.05),
              SizedBox(width: context.w * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w500,
                        color: cs.onSurface,
                      ),
                    ),
                    SizedBox(height: context.xs * 0.5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: context.captionFont * 0.95,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                size: context.w * 0.05,
                color: cs.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.02, bottom: context.s),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: context.captionFont * 0.85,
          fontWeight: FontWeight.w600,
          color: cs.onSurfaceVariant,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.m,
        horizontal: context.w * 0.04,
      ),
      margin: EdgeInsets.only(bottom: context.xs),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        children: [
          Icon(icon, color: cs.primary, size: context.w * 0.05),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w500,
                    color: cs.onSurface,
                  ),
                ),
                SizedBox(height: context.xs * 0.5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _HourPicker extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const _HourPicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.m,
        horizontal: context.w * 0.04,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notify me before',
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w500,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: context.s),
          Wrap(
            spacing: context.w * 0.02,
            runSpacing: context.s,
            children: _reminderHourOptions.map((h) {
              final isSelected = h == selected;
              return ChoiceChip(
                label: Text(h == 1 ? '1h' : '${h}h'),
                selected: isSelected,
                onSelected: (_) => onChanged(h),
                selectedColor: cs.primary,
                backgroundColor: cs.surface,
                labelStyle: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? cs.onPrimary : cs.onSurface,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.025),
                  side: BorderSide(
                    color: isSelected ? cs.primary : cs.outlineVariant,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
