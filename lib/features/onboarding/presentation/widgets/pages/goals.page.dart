import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/onboarding_answers.dart';
import '../onboarding_option_card.widget.dart';
import '../onboarding_page_shell.widget.dart';

class GoalsPage extends ConsumerWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return OnboardingPageShell(
      eyebrow: l10n.onbGoalsEyebrow,
      title: l10n.onbGoalsTitle,
      subtitle: l10n.onbGoalsSubtitle,
      child: ListView(
        children: OnboardingGoal.values
            .map(
              (g) => OnboardingOptionCard(
                label: g.label(l10n),
                icon: g.icon,
                selected: answers.goals.contains(g),
                onTap: () => notifier.toggleGoal(g),
              ),
            )
            .toList(),
      ),
    );
  }
}
