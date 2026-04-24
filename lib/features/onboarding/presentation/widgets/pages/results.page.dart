import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/archetype.dart';
import '../../../domain/onboarding_answers.dart';

class ResultsPage extends ConsumerWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final archetype = archetypeFor(answers);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.l),
          Text(
            'YOUR TASTE PROFILE',
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              fontWeight: FontWeight.w700,
              color: cs.primary,
              letterSpacing: 1.4,
            ),
          ),
          SizedBox(height: context.m),
          Row(
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
                child: Text(
                  archetype.title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 1.1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.05,
                    color: cs.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.m),
          Text(
            archetype.subtitle,
            style: TextStyle(
              fontSize: context.bodyFont,
              height: 1.4,
              color: cs.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.xl),
          _SummaryBlock(answers: answers),
        ],
      ),
    );
  }
}

class _SummaryBlock extends StatelessWidget {
  final OnboardingAnswers answers;
  const _SummaryBlock({required this.answers});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.m),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (answers.tasteLevel != null)
            _Row(label: 'Level', value: answers.tasteLevel!.label),
          if (answers.frequency != null)
            _Row(label: 'Frequency', value: answers.frequency!.label),
          if (answers.styles.isNotEmpty)
            _Row(
              label: 'Styles',
              value: answers.styles.map((s) => s.onboardingLabel).join(' · '),
            ),
          if (answers.goals.isNotEmpty)
            _Row(
              label: 'Goals',
              value:
                  answers.goals.map((g) => g.label.toLowerCase()).join(' · '),
            ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: context.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.w * 0.22,
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: context.bodyFont * 0.95,
                fontWeight: FontWeight.w500,
                color: cs.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
