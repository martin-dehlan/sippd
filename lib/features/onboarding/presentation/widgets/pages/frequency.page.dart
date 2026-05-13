import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/onboarding_answers.dart';
import '../onboarding_option_card.widget.dart';
import '../onboarding_page_shell.widget.dart';

class FrequencyPage extends ConsumerWidget {
  const FrequencyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return OnboardingPageShell(
      eyebrow: l10n.onbFreqEyebrow,
      title: l10n.onbFreqTitle,
      child: ListView(
        children: DrinkFrequency.values
            .map(
              (f) => OnboardingOptionCard(
                label: f.label(l10n),
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
