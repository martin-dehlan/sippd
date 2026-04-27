import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../paywall/presentation/widgets/paywall_body.widget.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/archetype.dart';
import '../onboarding_page_shell.widget.dart';

/// Onboarding-flow paywall step. Lands directly after the archetype
/// reveal so the personalised "the app gets me" feeling carries straight
/// into the upgrade pitch. The archetype chip up top is a visual echo of
/// the previous screen — psychological continuity, not a fresh ad.
class OnboardingPaywallPage extends ConsumerWidget {
  const OnboardingPaywallPage({super.key, required this.onFinish});

  /// Called for both purchase-success and "Maybe later" — onboarding has no
  /// screen left to render after this step, so either path hands off to the
  /// auth flow / app shell the same way.
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final archetype = archetypeFor(answers);

    return OnboardingPageShell(
      eyebrow: 'Sippd Pro',
      title: 'Your taste,\nbut elevated.',
      subtitle:
          'Pro maps every bottle, leaderboards your friends, and shows '
          'exactly how your taste sharpens — built around the profile we '
          'just made for you.',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ArchetypeChip(archetype: archetype),
            SizedBox(height: context.l),
            PaywallBody(
              triggerSource: 'onboarding',
              benefits: const [
                (
                  icon: PhosphorIconsRegular.chartLineUp,
                  title: 'Deep stats & taste insights',
                  subtitle: 'Map · prices · top regions · podium.',
                ),
                (
                  icon: PhosphorIconsRegular.usersThree,
                  title: 'Unlimited groups & members',
                  subtitle: 'Bring your whole tasting circle.',
                ),
                (
                  icon: PhosphorIconsRegular.shareNetwork,
                  title: 'Premium share-cards & themes',
                  subtitle: 'Stand out everywhere you post.',
                ),
              ],
              showTrialTimeline: true,
              primaryLabel: 'Start 7-day free trial',
              dismissLabel: 'Maybe later',
              onSuccess: onFinish,
              onDismiss: onFinish,
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact chip echoing the user's archetype from the previous step.
/// Appears above the Pro pitch so the upgrade narrative reads as
/// "your archetype deserves more" instead of a context-free ad.
class _ArchetypeChip extends StatelessWidget {
  const _ArchetypeChip({required this.archetype});

  final TasteArchetype archetype;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child:
          Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.04,
                  vertical: context.xs * 1.4,
                ),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(context.w * 0.06),
                  border: Border.all(
                    color: cs.primary.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      archetype.icon,
                      size: context.w * 0.045,
                      color: cs.onPrimaryContainer,
                    ),
                    SizedBox(width: context.w * 0.02),
                    Text(
                      archetype.title,
                      style: TextStyle(
                        fontSize: context.captionFont,
                        fontWeight: FontWeight.w800,
                        color: cs.onPrimaryContainer,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 360.ms)
              .scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1, 1),
                duration: 360.ms,
                curve: Curves.easeOutBack,
              ),
    );
  }
}
