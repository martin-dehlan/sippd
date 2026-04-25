import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/onboarding.provider.dart';
import '../../../domain/onboarding_answers.dart';
import '../onboarding_option_card.widget.dart';
import '../onboarding_page_shell.widget.dart';

class GoalsPage extends ConsumerWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return OnboardingPageShell(
      eyebrow: 'Your goals',
      title: 'What do you\nwant from Sippd?',
      subtitle: 'Pick one or more. You can change this later.',
      child: ListView(
        children: OnboardingGoal.values
            .map(
              (g) => OnboardingOptionCard(
                label: g.label,
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
