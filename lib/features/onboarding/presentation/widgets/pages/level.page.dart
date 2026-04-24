import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/onboarding.provider.dart';
import '../../../domain/onboarding_answers.dart';
import '../onboarding_option_card.widget.dart';
import '../onboarding_page_shell.widget.dart';

class LevelPage extends ConsumerWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return OnboardingPageShell(
      eyebrow: 'About you',
      title: 'How deep are you\ninto wine?',
      subtitle:
          'No wrong answer. We\'ll tune suggestions and keep things your pace.',
      child: ListView(
        children: TasteLevel.values
            .map(
              (l) => OnboardingOptionCard(
                label: l.label,
                subtitle: l.subtitle,
                selected: answers.tasteLevel == l,
                onTap: () => notifier.setTasteLevel(l),
              ),
            )
            .toList(),
      ),
    );
  }
}
