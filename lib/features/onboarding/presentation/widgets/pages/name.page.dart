import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/data/avatar_icons.dart';
import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/onboarding.provider.dart';
import '../onboarding_page_shell.widget.dart';

class NamePage extends ConsumerStatefulWidget {
  const NamePage({super.key});

  @override
  ConsumerState<NamePage> createState() => _NamePageState();
}

class _NamePageState extends ConsumerState<NamePage> {
  late final TextEditingController _controller;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    if (!_loaded) {
      _controller.text = answers.displayName ?? '';
      _loaded = true;
    }

    return OnboardingPageShell(
      eyebrow: l10n.onbNameEyebrow,
      title: l10n.onbNameTitle,
      subtitle: l10n.onbNameSubtitle,
      child: ListView(
        children: [
          TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.words,
            maxLength: 30,
            style: TextStyle(
              fontSize: context.bodyFont * 1.05,
              fontWeight: FontWeight.w500,
            ),
            onChanged: (v) => notifier.setName(displayName: v.trim()),
            decoration: InputDecoration(
              hintText: l10n.onbNameHint,
              counterText: '',
              filled: true,
              fillColor: cs.surfaceContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.w * 0.04),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.w * 0.045,
                vertical: context.m,
              ),
            ),
          ),
          SizedBox(height: context.l),
          Text(
            l10n.onbNameIconLabel,
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.s),
          Text(
            l10n.onbNameIconSubtitle,
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              color: cs.outline,
            ),
          ),
          SizedBox(height: context.m),
          Wrap(
            spacing: context.w * 0.025,
            runSpacing: context.w * 0.025,
            children: avatarIconOptions.map((entry) {
              final selected = answers.emoji == entry.key;
              final tile = context.w * 0.16;
              return GestureDetector(
                onTap: () => notifier.setName(emoji: entry.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: tile,
                  height: tile,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? cs.primaryContainer : cs.surfaceContainer,
                    borderRadius: BorderRadius.circular(context.w * 0.035),
                    border: Border.all(
                      color: selected ? cs.primary : cs.outlineVariant,
                      width: selected ? 1.5 : 0.5,
                    ),
                  ),
                  child: Icon(
                    entry.icon,
                    size: tile * 0.42,
                    color: selected
                        ? cs.onPrimaryContainer
                        : cs.onSurfaceVariant,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
