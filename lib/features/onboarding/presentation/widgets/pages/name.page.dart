import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../controller/onboarding.provider.dart';
import '../onboarding_page_shell.widget.dart';

const avatarIconOptions = <(String, IconData)>[
  ('wine', PhosphorIconsRegular.wine),
  ('champagne', PhosphorIconsRegular.champagne),
  ('martini', PhosphorIconsRegular.martini),
  ('sparkle', PhosphorIconsRegular.sparkle),
  ('heart', PhosphorIconsRegular.heart),
  ('star', PhosphorIconsRegular.star),
  ('fire', PhosphorIconsRegular.fire),
  ('confetti', PhosphorIconsRegular.confetti),
];

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
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    if (!_loaded) {
      _controller.text = answers.displayName ?? '';
      _loaded = true;
    }

    return OnboardingPageShell(
      eyebrow: 'Almost there',
      title: 'What should we\ncall you?',
      subtitle: 'First name, nickname — whatever fits. Pick an icon too.',
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
              hintText: 'Your name',
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
            'Pick an icon',
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.s),
          Wrap(
            spacing: context.w * 0.03,
            runSpacing: context.w * 0.03,
            children: avatarIconOptions.map((entry) {
              final (key, iconData) = entry;
              final selected = answers.emoji == key;
              return GestureDetector(
                onTap: () => notifier.setName(emoji: key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: context.w * 0.14,
                  height: context.w * 0.14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? cs.primary.withValues(alpha: 0.15)
                        : cs.surfaceContainer,
                    borderRadius: BorderRadius.circular(context.w * 0.04),
                    border: Border.all(
                      color: selected ? cs.primary : cs.outlineVariant,
                      width: selected ? 1.5 : 0.5,
                    ),
                  ),
                  child: Icon(
                    iconData,
                    size: context.w * 0.065,
                    color: selected ? cs.primary : cs.onSurfaceVariant,
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
