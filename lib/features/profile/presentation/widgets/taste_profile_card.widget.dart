import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/responsive.dart';
import '../../../onboarding/controller/onboarding.provider.dart';
import '../../../onboarding/domain/archetype.dart';

class TasteMetaLine extends ConsumerWidget {
  const TasteMetaLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final cs = Theme.of(context).colorScheme;

    if (answers.tasteLevel == null && answers.frequency == null) {
      return const SizedBox.shrink();
    }

    final archetype = archetypeFor(answers);
    final iconSize = context.w * 0.045;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.xs * 1.2,
      ),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(context.w * 0.08),
        border: Border.all(
          color: cs.primary.withValues(alpha: 0.3),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(archetype.icon, size: iconSize, color: cs.primary),
          SizedBox(width: context.w * 0.025),
          Text(
            archetype.title,
            style: TextStyle(
              fontSize: context.bodyFont * 0.95,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
