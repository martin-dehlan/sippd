import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/onboarding_answers.dart';
import '../onboarding_option_card.widget.dart';
import '../onboarding_page_shell.widget.dart';

class StylesPage extends ConsumerWidget {
  const StylesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return OnboardingPageShell(
      eyebrow: 'Your styles',
      title: 'What do you\nreach for?',
      subtitle:
          'Pick any that feel like you. We\'ll keep an eye on your picks.',
      child: ListView(
        children: WineType.values
            .map(
              (t) => OnboardingOptionCard(
                label: t.onboardingLabel,
                icon: t.onboardingIcon,
                iconColor: t.onboardingIconTint,
                selected: answers.styles.contains(t),
                onTap: () => notifier.toggleStyle(t),
              ),
            )
            .toList(),
      ),
    );
  }
}
