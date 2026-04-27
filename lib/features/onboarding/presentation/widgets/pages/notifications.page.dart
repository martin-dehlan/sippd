import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../push/controller/push.provider.dart';
import '../../../controller/onboarding.provider.dart';
import '../onboarding_page_shell.widget.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  bool _requesting = false;

  // Recording the choice flips notificationsAsked so the screen-level
  // CTA ("Sign in to save it" / "Save and continue") is enabled. We
  // intentionally do NOT auto-advance — the user has to tap that CTA so
  // the choice feels deliberate, not skipped past.

  Future<void> _ask() async {
    if (_requesting) return;
    setState(() => _requesting = true);
    try {
      await ref.read(fcmServiceProvider).requestPermission();
    } catch (_) {
      /* best effort */
    }
    await ref
        .read(onboardingAnswersControllerProvider.notifier)
        .markNotificationsAsked();
    if (mounted) setState(() => _requesting = false);
  }

  Future<void> _skip() async {
    await ref
        .read(onboardingAnswersControllerProvider.notifier)
        .markNotificationsAsked();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final asked = ref
        .watch(onboardingAnswersControllerProvider)
        .notificationsAsked;

    return OnboardingPageShell(
      eyebrow: 'Stay in the loop',
      title: 'Never lose a great\nbottle again.',
      subtitle:
          'We\'ll nudge you when friends start tastings or invite you to '
          'groups. You can turn this off anytime.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(context.m),
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(context.w * 0.04),
            ),
            child: Row(
              children: [
                Icon(
                  PhosphorIconsRegular.bellRinging,
                  color: cs.primary,
                  size: context.w * 0.08,
                ),
                SizedBox(width: context.w * 0.04),
                Expanded(
                  child: Text(
                    'Tasting invites\nGroup ratings\nFriend activity',
                    style: TextStyle(
                      fontSize: context.bodyFont * 0.95,
                      height: 1.5,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (asked)
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.m),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsRegular.check,
                    size: context.w * 0.045,
                    color: cs.primary,
                  ),
                  SizedBox(width: context.w * 0.02),
                  Text(
                    'You\'re set',
                    style: TextStyle(
                      fontSize: context.bodyFont * 0.95,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          else ...[
            SizedBox(
              height: context.h * 0.065,
              child: FilledButton(
                onPressed: _ask,
                style: FilledButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w * 0.04),
                  ),
                ),
                child: _requesting
                    ? SizedBox(
                        height: context.w * 0.05,
                        width: context.w * 0.05,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Turn on notifications',
                        style: TextStyle(
                          fontSize: context.bodyFont * 1.05,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            SizedBox(height: context.s),
            Center(
              child: TextButton(
                onPressed: _skip,
                child: Text(
                  'Not now',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.s),
          ],
        ],
      ),
    );
  }
}
