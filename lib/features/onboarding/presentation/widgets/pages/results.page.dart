import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/archetype.dart';
import '../../../domain/onboarding_answers.dart';

class ResultsPage extends ConsumerWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final archetype = archetypeFor(answers, l10n);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      children: [
        SizedBox(height: context.m),
        Text(
          l10n.onbResultsEyebrow,
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            fontWeight: FontWeight.w700,
            color: cs.primary,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: context.m),
        _ArchetypeHeader(archetype: archetype),
        SizedBox(height: context.xl),
        if (answers.tasteLevel != null)
          _LevelCard(current: answers.tasteLevel!),
        if (answers.frequency != null) ...[
          SizedBox(height: context.m),
          _FrequencyCard(current: answers.frequency!),
        ],
        if (answers.styles.isNotEmpty) ...[
          SizedBox(height: context.m),
          _StylesCard(styles: answers.styles),
        ],
        if (answers.goals.isNotEmpty) ...[
          SizedBox(height: context.m),
          _GoalsCard(goals: answers.goals),
        ],
        SizedBox(height: context.xl),
      ],
    );
  }
}

class _ArchetypeHeader extends StatelessWidget {
  final TasteArchetype archetype;
  const _ArchetypeHeader({required this.archetype});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: context.w * 0.16,
          height: context.w * 0.16,
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            archetype.icon,
            size: context.w * 0.08,
            color: cs.primary,
          ),
        ),
        SizedBox(width: context.w * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                archetype.title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: context.titleFont * 1.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.05,
                  color: cs.onSurface,
                ),
              ),
              SizedBox(height: context.xs),
              Text(
                archetype.subtitle,
                style: TextStyle(
                  fontSize: context.bodyFont * 0.92,
                  height: 1.3,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String eyebrow;
  final Widget child;
  const _SectionCard({required this.eyebrow, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.m),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(
          color: cs.outlineVariant.withValues(alpha: 0.4),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.78,
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
              letterSpacing: 1.3,
            ),
          ),
          SizedBox(height: context.s),
          child,
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final TasteLevel current;
  const _LevelCard({required this.current});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final levels = TasteLevel.values;
    final currentIndex = levels.indexOf(current);

    return _SectionCard(
      eyebrow: l10n.onbResultsLevelCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(levels.length, (i) {
              final isActive = i <= currentIndex;
              final isCurrent = i == currentIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: i < levels.length - 1 ? context.w * 0.015 : 0,
                  ),
                  child: Container(
                    height: context.h * 0.008,
                    decoration: BoxDecoration(
                      color: isActive
                          ? cs.primary.withValues(alpha: isCurrent ? 1 : 0.55)
                          : cs.outlineVariant.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(context.w * 0.01),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: context.s),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(levels.length, (i) {
              final level = levels[i];
              final isCurrent = i == currentIndex;
              return Expanded(
                child: Text(
                  level.label(l10n),
                  textAlign: i == 0
                      ? TextAlign.start
                      : i == levels.length - 1
                      ? TextAlign.end
                      : TextAlign.center,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w400,
                    color: isCurrent ? cs.onSurface : cs.onSurfaceVariant,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _FrequencyCard extends StatelessWidget {
  final DrinkFrequency current;
  const _FrequencyCard({required this.current});

  int get _fillBars => switch (current) {
    DrinkFrequency.weekly => 5,
    DrinkFrequency.monthly => 3,
    DrinkFrequency.rare => 1,
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return _SectionCard(
      eyebrow: l10n.onbResultsFreqCard,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(current.icon, size: context.w * 0.06, color: cs.primary),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current.label(l10n),
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                SizedBox(height: context.xs * 0.7),
                Row(
                  children: List.generate(5, (i) {
                    final filled = i < _fillBars;
                    return Padding(
                      padding: EdgeInsets.only(right: context.w * 0.015),
                      child: Container(
                        width: context.w * 0.035,
                        height: context.h * 0.008,
                        decoration: BoxDecoration(
                          color: filled
                              ? cs.primary
                              : cs.outlineVariant.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StylesCard extends StatelessWidget {
  final Set<WineType> styles;
  const _StylesCard({required this.styles});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _SectionCard(
      eyebrow: l10n.onbResultsStylesCard,
      child: Wrap(
        spacing: context.w * 0.02,
        runSpacing: context.w * 0.02,
        children: styles.map((s) => _StyleChip(style: s)).toList(),
      ),
    );
  }
}

class _StyleChip extends StatelessWidget {
  final WineType style;
  const _StyleChip({required this.style});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final dotSize = context.w * 0.018;
    final color = style.onboardingIconTint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.032,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: dotSize * 1.2,
                ),
              ],
            ),
          ),
          SizedBox(width: context.w * 0.02),
          Text(
            style.onboardingLabel(l10n),
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              fontWeight: FontWeight.w500,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalsCard extends StatelessWidget {
  final Set<OnboardingGoal> goals;
  const _GoalsCard({required this.goals});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return _SectionCard(
      eyebrow: l10n.onbResultsGoalsCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: goals
            .map(
              (g) => Padding(
                padding: EdgeInsets.only(top: context.xs),
                child: Row(
                  children: [
                    Container(
                      width: context.w * 0.07,
                      height: context.w * 0.07,
                      decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(context.w * 0.02),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        g.icon,
                        size: context.w * 0.04,
                        color: cs.primary,
                      ),
                    ),
                    SizedBox(width: context.w * 0.03),
                    Expanded(
                      child: Text(
                        g.label(l10n),
                        style: TextStyle(
                          fontSize: context.bodyFont * 0.95,
                          fontWeight: FontWeight.w500,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
