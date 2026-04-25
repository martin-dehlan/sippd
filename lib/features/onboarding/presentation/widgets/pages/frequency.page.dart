import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/onboarding.provider.dart';
import '../../../domain/onboarding_answers.dart';
import '../onboarding_option_card.widget.dart';
import '../onboarding_page_shell.widget.dart';

class FrequencyPage extends ConsumerWidget {
  const FrequencyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return OnboardingPageShell(
      eyebrow: 'Your rhythm',
      title: 'How often\ndo you open a bottle?',
      child: ListView(
        children: DrinkFrequency.values
            .map(
              (f) => OnboardingOptionCard(
                label: f.label,
                icon: f.icon,
                selected: answers.frequency == f,
                onTap: () => notifier.setFrequency(f),
              ),
            )
            .toList(),
      ),
    );
  }
}
