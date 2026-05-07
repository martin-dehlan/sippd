import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../paywall/controller/paywall.provider.dart';
import '../../controller/taste_match.provider.dart';
import '../../domain/entities/user_style_dna.entity.dart';

/// Editorial trait table beneath the personality hero. The two
/// strongest axes (largest distance from neutral) are shown for free;
/// the remaining four sit behind a Pro divider with a frosted blur and
/// a tap-target into the paywall.
class TasteTraits extends ConsumerWidget {
  const TasteTraits({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dnaAsync = ref.watch(userStyleDnaProvider(userId));
    return dnaAsync.when(
      loading: () => SizedBox(height: context.h * 0.1),
      error: (_, _) => const SizedBox.shrink(),
      data: (dna) {
        // Hero owns the unlock messaging when DNA is thin —
        // collapse the traits block entirely so users see one prompt.
        if (dna.attributedCount < 3) return const SizedBox.shrink();
        return _Body(dna: dna);
      },
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.dna});

  final UserStyleDna dna;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isPro = ref.watch(isProProvider);
    final entries = _orderedEntries(dna);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRAITS',
            style: TextStyle(
              fontSize: context.captionFont * 0.78,
              fontWeight: FontWeight.w700,
              color: cs.outline,
              letterSpacing: 1.4,
            ),
          ),
          SizedBox(height: context.m),
          for (final e in entries.take(2))
            _TraitRow(axis: e.$1, value: e.$2, locked: false),
          SizedBox(height: context.s),
          _ProDivider(isPro: isPro),
          SizedBox(height: context.s),
          _LockedSection(
            entries: entries.skip(2).toList(growable: false),
            isPro: isPro,
          ),
        ],
      ),
    );
  }

  List<(String, double)> _orderedEntries(UserStyleDna dna) {
    final all = <String>[
      'body',
      'tannin',
      'acidity',
      'sweetness',
      'oak',
      'intensity',
    ];
    final entries = all
        .map((k) => (k, (dna.values[k] ?? 0.5).clamp(0.0, 1.0)))
        .toList();
    entries.sort((a, b) {
      final da = (a.$2 - 0.5).abs();
      final db = (b.$2 - 0.5).abs();
      return db.compareTo(da);
    });
    return entries;
  }
}

class _TraitRow extends StatelessWidget {
  const _TraitRow({
    required this.axis,
    required this.value,
    required this.locked,
  });

  final String axis;
  final double value;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pct = (value * 100).round();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.xs * 1.4),
      child: Row(
        children: [
          SizedBox(
            width: context.w * 0.26,
            child: Text(
              _label(axis),
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              _descriptor(axis, value),
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(
            width: context.w * 0.22,
            child: _Bar(value: value),
          ),
          SizedBox(width: context.w * 0.02),
          SizedBox(
            width: context.w * 0.08,
            child: Text(
              '$pct%',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurfaceVariant,
                fontFeatures: tabularFigures,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.w * 0.005),
      child: Stack(
        children: [
          Container(height: context.h * 0.006, color: cs.outlineVariant),
          FractionallySizedBox(
            widthFactor: value.clamp(0.05, 1.0),
            child: Container(height: context.h * 0.006, color: cs.onSurface),
          ),
        ],
      ),
    );
  }
}

class _ProDivider extends StatelessWidget {
  const _ProDivider({required this.isPro});

  final bool isPro;

  @override
  Widget build(BuildContext context) {
    if (isPro) {
      return Container(
        height: 0.5,
        color: Theme.of(context).colorScheme.outlineVariant,
      );
    }
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container(height: 0.5, color: cs.outlineVariant)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w * 0.025),
          child: Text(
            'PRO',
            style: TextStyle(
              fontSize: context.captionFont * 0.75,
              fontWeight: FontWeight.w800,
              color: cs.outline,
              letterSpacing: 1.6,
            ),
          ),
        ),
        Expanded(child: Container(height: 0.5, color: cs.outlineVariant)),
      ],
    );
  }
}

class _LockedSection extends StatelessWidget {
  const _LockedSection({required this.entries, required this.isPro});

  final List<(String, double)> entries;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    final rows = Column(
      children: [
        for (final e in entries)
          _TraitRow(axis: e.$1, value: e.$2, locked: !isPro),
      ],
    );
    if (isPro) return rows;
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push(
        AppRoutes.paywall,
        extra: const {'source': 'taste_traits'},
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(opacity: 0.22, child: rows),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.w * 0.04,
              vertical: context.s * 1.2,
            ),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(context.w * 0.05),
              border: Border.all(color: cs.outlineVariant, width: 0.6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIconsFill.lock,
                  size: context.captionFont,
                  color: cs.onSurface,
                ),
                SizedBox(width: context.w * 0.018),
                Text(
                  'Unlock all traits with Pro',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _labels = {
  'body': 'Body',
  'tannin': 'Tannin',
  'acidity': 'Acidity',
  'sweetness': 'Sweetness',
  'oak': 'Oak',
  'intensity': 'Intensity',
};

String _label(String axis) => _labels[axis] ?? axis;

String _descriptor(String axis, double v) => switch (axis) {
  'body' =>
    v < 0.4
        ? 'Light, easy-drinking'
        : v < 0.65
        ? 'Balanced'
        : 'Bold, full-bodied',
  'tannin' =>
    v < 0.4
        ? 'Soft, low-grip'
        : v < 0.65
        ? 'Medium grip'
        : 'Grippy, structured',
  'acidity' =>
    v < 0.4
        ? 'Soft, round'
        : v < 0.65
        ? 'Balanced'
        : 'Crisp, bright',
  'sweetness' =>
    v < 0.15
        ? 'Bone dry'
        : v < 0.4
        ? 'Off-dry'
        : 'Sweet-leaning',
  'oak' =>
    v < 0.3
        ? 'Unoaked, fresh'
        : v < 0.55
        ? 'Touch of oak'
        : 'Oak-forward',
  'intensity' =>
    v < 0.4
        ? 'Subtle aromatics'
        : v < 0.7
        ? 'Expressive'
        : 'Bold, aromatic',
  _ => '',
};
