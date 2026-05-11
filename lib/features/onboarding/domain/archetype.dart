import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../common/l10n/generated/app_localizations.dart';
import '../../wines/domain/entities/wine.entity.dart';
import 'onboarding_answers.dart';

class TasteArchetype {
  final String title;
  final IconData icon;
  final String subtitle;

  const TasteArchetype({
    required this.title,
    required this.icon,
    required this.subtitle,
  });
}

TasteArchetype archetypeFor(OnboardingAnswers a, AppLocalizations l) {
  final level = a.tasteLevel;
  final freq = a.frequency;
  final styles = a.styles;

  if (level == TasteLevel.pro) {
    if (freq == DrinkFrequency.weekly) {
      return TasteArchetype(
        title: l.onbArchSommTitle,
        icon: PhosphorIconsThin.medal,
        subtitle: l.onbArchSommSubtitle,
      );
    }
    return TasteArchetype(
      title: l.onbArchPalateTitle,
      icon: PhosphorIconsThin.sparkle,
      subtitle: l.onbArchPalateSubtitle,
    );
  }

  if (level == TasteLevel.enthusiast) {
    if (freq == DrinkFrequency.weekly) {
      return TasteArchetype(
        title: l.onbArchRegularTitle,
        icon: PhosphorIconsThin.wine,
        subtitle: l.onbArchRegularSubtitle,
      );
    }
    return TasteArchetype(
      title: l.onbArchDevotedTitle,
      icon: PhosphorIconsThin.wine,
      subtitle: l.onbArchDevotedSubtitle,
    );
  }

  if (level == TasteLevel.curious) {
    if (styles.length == 1 && styles.contains(WineType.red)) {
      return TasteArchetype(
        title: l.onbArchRedTitle,
        icon: PhosphorIconsThin.wine,
        subtitle: l.onbArchRedSubtitle,
      );
    }
    if (styles.length == 1 && styles.contains(WineType.sparkling)) {
      return TasteArchetype(
        title: l.onbArchBubbleTitle,
        icon: PhosphorIconsThin.champagne,
        subtitle: l.onbArchBubbleSubtitle,
      );
    }
    if (styles.length >= 3) {
      return TasteArchetype(
        title: l.onbArchOpenTitle,
        icon: PhosphorIconsThin.compass,
        subtitle: l.onbArchOpenSubtitle,
      );
    }
    if (freq == DrinkFrequency.weekly) {
      return TasteArchetype(
        title: l.onbArchSteadyTitle,
        icon: PhosphorIconsThin.wine,
        subtitle: l.onbArchSteadySubtitle,
      );
    }
    if (freq == DrinkFrequency.monthly) {
      return TasteArchetype(
        title: l.onbArchNowAndThenTitle,
        icon: PhosphorIconsThin.champagne,
        subtitle: l.onbArchNowAndThenSubtitle,
      );
    }
    if (freq == DrinkFrequency.rare) {
      return TasteArchetype(
        title: l.onbArchOccasionalTitle,
        icon: PhosphorIconsThin.wine,
        subtitle: l.onbArchOccasionalSubtitle,
      );
    }
  }

  if (level == TasteLevel.beginner) {
    return TasteArchetype(
      title: l.onbArchFreshTitle,
      icon: PhosphorIconsThin.plant,
      subtitle: l.onbArchFreshSubtitle,
    );
  }

  return TasteArchetype(
    title: l.onbArchCuriousTitle,
    icon: PhosphorIconsThin.compass,
    subtitle: l.onbArchCuriousSubtitle,
  );
}
