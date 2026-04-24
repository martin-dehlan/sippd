import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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

TasteArchetype archetypeFor(OnboardingAnswers a) {
  final level = a.tasteLevel;
  final freq = a.frequency;
  final styles = a.styles;

  if (level == TasteLevel.pro) {
    if (freq == DrinkFrequency.weekly) {
      return TasteArchetype(
        title: 'Seasoned Somm',
        icon: PhosphorIconsThin.medal,
        subtitle: 'You know your terroir. Sippd keeps the receipts.',
      );
    }
    return TasteArchetype(
      title: 'Sharp Palate',
      icon: PhosphorIconsThin.sparkle,
      subtitle: 'Nuance-chaser. Sippd captures the detail.',
    );
  }

  if (level == TasteLevel.enthusiast) {
    if (freq == DrinkFrequency.weekly) {
      return TasteArchetype(
        title: 'Cellar Regular',
        icon: PhosphorIconsThin.wine,
        subtitle: 'A bottle a week, opinions sharper every month.',
      );
    }
    return TasteArchetype(
      title: 'Devoted Taster',
      icon: PhosphorIconsThin.wine,
      subtitle: 'Serious about each pour. Sippd keeps your notes.',
    );
  }

  if (level == TasteLevel.curious) {
    if (styles.length == 1 && styles.contains(WineType.red)) {
      return TasteArchetype(
        title: 'Red Loyalist',
        icon: PhosphorIconsThin.wine,
        subtitle: "One grape per glass. We'll help you branch out.",
      );
    }
    if (styles.length == 1 && styles.contains(WineType.sparkling)) {
      return TasteArchetype(
        title: 'Bubble Chaser',
        icon: PhosphorIconsThin.champagne,
        subtitle: 'Bubbles over everything. Sippd tracks the good ones.',
      );
    }
    if (styles.length >= 3) {
      return TasteArchetype(
        title: 'Open Palate',
        icon: PhosphorIconsThin.compass,
        subtitle: 'Red, white, pink, sparkling — all welcome. Log them all.',
      );
    }
    if (freq == DrinkFrequency.weekly) {
      return TasteArchetype(
        title: 'Steady Sipper',
        icon: PhosphorIconsThin.wine,
        subtitle: 'Wine stays in the rotation. Sippd keeps the thread.',
      );
    }
    if (freq == DrinkFrequency.monthly) {
      return TasteArchetype(
        title: 'Now-and-Then Taster',
        icon: PhosphorIconsThin.champagne,
        subtitle: 'Wine for the moments that matter.',
      );
    }
    if (freq == DrinkFrequency.rare) {
      return TasteArchetype(
        title: 'Occasional Glass',
        icon: PhosphorIconsThin.wine,
        subtitle: 'Rare pour, worth remembering.',
      );
    }
  }

  if (level == TasteLevel.beginner) {
    return TasteArchetype(
      title: 'Fresh Palate',
      icon: PhosphorIconsThin.plant,
      subtitle: 'New journey. Every bottle counts from here.',
    );
  }

  return TasteArchetype(
    title: 'Wine Curious',
    icon: PhosphorIconsThin.compass,
    subtitle: 'Tell us more and your profile sharpens.',
  );
}
