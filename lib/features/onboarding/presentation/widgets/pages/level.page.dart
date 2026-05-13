import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/onboarding_answers.dart';
import '../onboarding_option_card.widget.dart';
import '../onboarding_page_shell.widget.dart';

class LevelPage extends ConsumerWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return OnboardingPageShell(
      eyebrow: l10n.onbLevelEyebrow,
      title: l10n.onbLevelTitle,
      subtitle: l10n.onbLevelSubtitle,
      child: ListView(
        children: TasteLevel.values
            .map(
              (level) => OnboardingOptionCard(
                label: level.label(l10n),
                subtitle: level.subtitle(l10n),
                icon: level.icon,
                selected: answers.tasteLevel == level,
                onTap: () => notifier.setTasteLevel(level),
              ),
            )
            .toList(),
      ),
    );
  }
}
