import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/onboarding_answers.dart';
import '../onboarding_option_card.widget.dart';
import '../onboarding_page_shell.widget.dart';

class StylesPage extends ConsumerWidget {
  const StylesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return OnboardingPageShell(
      eyebrow: l10n.onbStylesEyebrow,
      title: l10n.onbStylesTitle,
      subtitle: l10n.onbStylesSubtitle,
      child: ListView(
        children: WineType.values
            .map(
              (t) => OnboardingOptionCard(
                label: t.onboardingLabel(l10n),
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
