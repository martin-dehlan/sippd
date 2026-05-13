import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../../onboarding/controller/onboarding.provider.dart';
import '../../../onboarding/domain/onboarding_answers.dart';
import '../../../wines/domain/entities/wine.entity.dart';

class TasteProfileEditor extends ConsumerWidget {
  const TasteProfileEditor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Group(
          label: l10n.tasteEditorLevel,
          child: _SegmentRow<TasteLevel>(
            options: TasteLevel.values,
            current: answers.tasteLevel,
            labelOf: (level) => level.label(l10n),
            onSelect: notifier.setTasteLevel,
          ),
        ),
        SizedBox(height: context.l),
        _Group(
          label: l10n.tasteEditorFreq,
          child: _SegmentRow<DrinkFrequency>(
            options: DrinkFrequency.values,
            current: answers.frequency,
            labelOf: (f) => _shortFreq(f, l10n),
            onSelect: notifier.setFrequency,
          ),
        ),
        SizedBox(height: context.l),
        _Group(
          label: l10n.tasteEditorStyles,
          child: _ChipGrid<WineType>(
            options: WineType.values,
            current: answers.styles,
            labelOf: (t) => t.onboardingLabel(l10n),
            emojiOf: (t) => t.onboardingEmoji,
            onToggle: notifier.toggleStyle,
          ),
        ),
        SizedBox(height: context.l),
        _Group(
          label: l10n.tasteEditorGoals,
          child: _ChipGrid<OnboardingGoal>(
            options: OnboardingGoal.values,
            current: answers.goals,
            labelOf: (g) => _shortGoal(g, l10n),
            emojiOf: (g) => g.emoji,
            onToggle: notifier.toggleGoal,
          ),
        ),
      ],
    );
  }
}

String _shortFreq(DrinkFrequency f, AppLocalizations l) => switch (f) {
  DrinkFrequency.weekly => l.tasteEditorFreqWeekly,
  DrinkFrequency.monthly => l.tasteEditorFreqMonthly,
  DrinkFrequency.rare => l.tasteEditorFreqRare,
};

String _shortGoal(OnboardingGoal g, AppLocalizations l) => switch (g) {
  OnboardingGoal.remember => l.tasteEditorGoalRemember,
  OnboardingGoal.discover => l.tasteEditorGoalDiscover,
  OnboardingGoal.social => l.tasteEditorGoalSocial,
  OnboardingGoal.value => l.tasteEditorGoalValue,
};

class _Group extends StatelessWidget {
  final String label;
  final Widget child;
  const _Group({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: context.captionFont * 0.82,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: context.s),
        child,
      ],
    );
  }
}

class _SegmentRow<T> extends StatelessWidget {
  final List<T> options;
  final T? current;
  final String Function(T) labelOf;
  final ValueChanged<T> onSelect;

  const _SegmentRow({
    required this.options,
    required this.current,
    required this.labelOf,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.xs),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.035),
      ),
      child: Row(
        children: options.map((o) {
          final selected = current == o;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelect(o),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: EdgeInsets.symmetric(vertical: context.s),
                margin: EdgeInsets.symmetric(horizontal: context.xs * 0.5),
                decoration: BoxDecoration(
                  color: selected ? cs.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(context.w * 0.028),
                ),
                child: Text(
                  labelOf(o),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.captionFont * 1.02,
                    fontWeight: FontWeight.w600,
                    color: selected ? cs.onPrimary : cs.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ChipGrid<T> extends StatelessWidget {
  final List<T> options;
  final Set<T> current;
  final String Function(T) labelOf;
  final String Function(T) emojiOf;
  final ValueChanged<T> onToggle;

  const _ChipGrid({
    required this.options,
    required this.current,
    required this.labelOf,
    required this.emojiOf,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.w * 0.02,
      runSpacing: context.w * 0.02,
      children: options.map((o) {
        final selected = current.contains(o);
        return _Chip(
          label: labelOf(o),
          emoji: emojiOf(o),
          selected: selected,
          onTap: () => onToggle(o),
        );
      }).toList(),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.s * 1.2,
        ),
        decoration: BoxDecoration(
          color: selected
              ? cs.primary.withValues(alpha: 0.14)
              : cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.08),
          border: Border.all(
            color: selected ? cs.primary : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: context.bodyFont * 1.1)),
            SizedBox(width: context.w * 0.015),
            Text(
              label,
              style: TextStyle(
                fontSize: context.captionFont * 1.05,
                fontWeight: FontWeight.w600,
                color: selected ? cs.onSurface : cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
