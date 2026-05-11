import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';
import '../../../../../paywall/controller/paywall.provider.dart';
import '../../../../controller/expert_tasting.provider.dart';
import '../../../../domain/entities/expert_tasting.entity.dart';
import '../../../../domain/entities/wine.entity.dart';

class WineCompareTastingWidget extends ConsumerWidget {
  final WineEntity left;
  final WineEntity right;

  const WineCompareTastingWidget({
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProProvider);
    if (!isPro) {
      return _LockedSection(
        onUnlock: () {
          context.push(
            AppRoutes.paywall,
            extra: const {'source': 'wine_compare_tasting'},
          );
        },
      );
    }

    final leftAsync = left.canonicalWineId == null
        ? const AsyncValue<ExpertTastingEntity?>.data(null)
        : ref.watch(myExpertTastingProvider(left.canonicalWineId!));
    final rightAsync = right.canonicalWineId == null
        ? const AsyncValue<ExpertTastingEntity?>.data(null)
        : ref.watch(myExpertTastingProvider(right.canonicalWineId!));

    final leftT = leftAsync.valueOrNull;
    final rightT = rightAsync.valueOrNull;

    final axes = _buildAxes(leftT, rightT);
    if (axes.isEmpty) return const _EmptyProSection();
    return _ProSection(axes: axes);
  }

  List<_AxisPair> _buildAxes(
    ExpertTastingEntity? left,
    ExpertTastingEntity? right,
  ) {
    final all = <_AxisPair>[
      _AxisPair('BODY', left?.body, right?.body, 5, _bodyDescriptors),
      _AxisPair('TANNIN', left?.tannin, right?.tannin, 5, _tanninDescriptors),
      _AxisPair(
        'ACIDITY',
        left?.acidity,
        right?.acidity,
        5,
        _acidityDescriptors,
      ),
      _AxisPair(
        'SWEETNESS',
        left?.sweetness,
        right?.sweetness,
        5,
        _sweetnessDescriptors,
      ),
      _AxisPair('OAK', left?.oak, right?.oak, 5, _oakDescriptors),
      _AxisPair('FINISH', left?.finish, right?.finish, 3, _finishDescriptors),
    ];
    return all
        .where((a) => a.leftValue != null || a.rightValue != null)
        .toList();
  }
}

class _LockedSection extends StatelessWidget {
  final VoidCallback onUnlock;
  const _LockedSection({required this.onUnlock});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onUnlock,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: Container(
        padding: EdgeInsets.all(context.w * 0.045),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'See body, tannin, acidity and more side by side.',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(width: context.s),
                const _ProBadge(),
              ],
            ),
            SizedBox(height: context.m),
            for (final axis in _previewAxes) ...[
              _LockedAxisRow(label: axis),
              SizedBox(height: context.xs * 0.7),
            ],
            SizedBox(height: context.s),
            Row(
              children: [
                Icon(
                  PhosphorIconsFill.lock,
                  size: context.w * 0.04,
                  color: cs.primary,
                ),
                SizedBox(width: context.w * 0.015),
                Text(
                  'Unlock with Pro',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                    letterSpacing: 0.2,
                  ),
                ),
                const Spacer(),
                Icon(
                  PhosphorIconsRegular.caretRight,
                  size: context.captionFont,
                  color: cs.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LockedAxisRow extends StatelessWidget {
  final String label;
  const _LockedAxisRow({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(flex: 5, child: _BlurredBar(align: Alignment.centerRight)),
        SizedBox(width: context.w * 0.025),
        Expanded(
          flex: 4,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.captionFont * 0.78,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
              color: cs.outline,
            ),
          ),
        ),
        SizedBox(width: context.w * 0.025),
        Expanded(flex: 5, child: _BlurredBar(align: Alignment.centerLeft)),
      ],
    );
  }
}

class _BlurredBar extends StatelessWidget {
  final Alignment align;
  const _BlurredBar({required this.align});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Align(
      alignment: align,
      child: SizedBox(
        width: context.w * 0.22,
        height: context.h * 0.012,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (i) {
            return Padding(
              padding: EdgeInsets.only(right: i == 4 ? 0 : context.w * 0.012),
              child: Container(
                width: context.w * 0.022,
                height: context.w * 0.022,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.outlineVariant.withValues(alpha: 0.7),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _EmptyProSection extends StatelessWidget {
  const _EmptyProSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Text(
        'Add tasting notes from either wine to see them compared here.',
        style: TextStyle(
          fontSize: context.captionFont,
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ProSection extends StatelessWidget {
  final List<_AxisPair> axes;
  const _ProSection({required this.axes});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.s,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < axes.length; i++) ...[
            _AxisRow(pair: axes[i]),
            if (i != axes.length - 1)
              Container(
                height: 0.5,
                color: cs.outlineVariant.withValues(alpha: 0.55),
              ),
          ],
        ],
      ),
    );
  }
}

class _AxisRow extends StatelessWidget {
  final _AxisPair pair;
  const _AxisRow({required this.pair});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.m * 0.7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: _AxisSide(
              value: pair.leftValue,
              max: pair.max,
              descriptors: pair.descriptors,
              align: Alignment.centerRight,
            ),
          ),
          SizedBox(width: context.w * 0.025),
          Expanded(
            flex: 4,
            child: Text(
              pair.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont * 0.78,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
                color: cs.outline,
              ),
            ),
          ),
          SizedBox(width: context.w * 0.025),
          Expanded(
            flex: 5,
            child: _AxisSide(
              value: pair.rightValue,
              max: pair.max,
              descriptors: pair.descriptors,
              align: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }
}

class _AxisSide extends StatelessWidget {
  final int? value;
  final int max;
  final Map<int, String> descriptors;
  final Alignment align;

  const _AxisSide({
    required this.value,
    required this.max,
    required this.descriptors,
    required this.align,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (value == null) {
      return Align(
        alignment: align,
        child: Text(
          '—',
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant.withValues(alpha: 0.45),
          ),
        ),
      );
    }
    final word = descriptors[value!.clamp(1, max)] ?? '';
    return Column(
      crossAxisAlignment: align == Alignment.centerRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          word,
          style: GoogleFonts.playfairDisplay(
            fontSize: context.bodyFont * 1.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: cs.onSurface,
            height: 1.2,
          ),
        ),
        SizedBox(height: context.xs * 0.7),
        _DotTrack(value: value!, max: max),
      ],
    );
  }
}

class _DotTrack extends StatelessWidget {
  final int value;
  final int max;
  const _DotTrack({required this.value, required this.max});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.018;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(max, (i) {
        final filled = i < value;
        return Padding(
          padding: EdgeInsets.only(right: i == max - 1 ? 0 : context.w * 0.01),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled
                  ? cs.primary
                  : cs.outlineVariant.withValues(alpha: 0.7),
            ),
          ),
        );
      }),
    );
  }
}

class _ProBadge extends StatelessWidget {
  const _ProBadge();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.022,
        vertical: context.xs * 0.5,
      ),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.w * 0.015),
      ),
      child: Text(
        'PRO',
        style: TextStyle(
          fontSize: context.captionFont * 0.78,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
          color: cs.primary,
        ),
      ),
    );
  }
}

class _AxisPair {
  final String label;
  final int? leftValue;
  final int? rightValue;
  final int max;
  final Map<int, String> descriptors;
  const _AxisPair(
    this.label,
    this.leftValue,
    this.rightValue,
    this.max,
    this.descriptors,
  );
}

const _previewAxes = ['BODY', 'TANNIN', 'ACIDITY', 'OAK'];

const _bodyDescriptors = {
  1: 'very light',
  2: 'light',
  3: 'medium',
  4: 'full',
  5: 'heavy',
};
const _tanninDescriptors = {
  1: 'silky',
  2: 'soft',
  3: 'medium',
  4: 'firm',
  5: 'gripping',
};
const _acidityDescriptors = {
  1: 'flat',
  2: 'soft',
  3: 'balanced',
  4: 'crisp',
  5: 'sharp',
};
const _sweetnessDescriptors = {
  1: 'bone dry',
  2: 'dry',
  3: 'off-dry',
  4: 'sweet',
  5: 'lush',
};
const _oakDescriptors = {
  1: 'unoaked',
  2: 'subtle',
  3: 'present',
  4: 'oak-forward',
  5: 'heavy',
};
const _finishDescriptors = {1: 'short', 2: 'medium', 3: 'long'};
