import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/responsive.dart';
import '../../../onboarding/controller/onboarding.provider.dart';
import '../../../onboarding/domain/onboarding_answers.dart';

class TasteMetaLine extends ConsumerWidget {
  const TasteMetaLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingAnswersControllerProvider);

    final chips = <String>[
      if (answers.tasteLevel != null) answers.tasteLevel!.label,
      if (answers.frequency != null) answers.frequency!.label,
      ...answers.styles.map((s) => s.onboardingLabel),
    ];
    if (chips.isEmpty) return const SizedBox.shrink();

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: context.w * 0.02,
      runSpacing: context.w * 0.015,
      children: chips.map((c) => _Chip(label: c)).toList(),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(
          color: cs.outlineVariant.withValues(alpha: 0.4),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.captionFont * 0.9,
          fontWeight: FontWeight.w500,
          color: cs.onSurface,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
