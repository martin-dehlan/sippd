import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/taste_match.entity.dart';

class TasteMatchScoreWidget extends StatelessWidget {
  const TasteMatchScoreWidget({super.key, required this.match});

  final TasteMatchEntity match;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (!match.hasScore) {
      return _EmptyState(reason: match.reason, match: match);
    }

    final score = match.score!;
    final confidence = match.confidence!;

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$score%',
                style: TextStyle(
                  fontSize: context.titleFont * 1.2,
                  fontWeight: FontWeight.w800,
                  color: _confidenceColour(cs, confidence),
                  letterSpacing: -1.5,
                  height: 1.0,
                ),
              ),
              SizedBox(width: context.w * 0.025),
              Padding(
                padding: EdgeInsets.only(bottom: context.h * 0.012),
                child: Text(
                  'taste match',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.s),
          _ConfidenceBadge(confidence: confidence),
          SizedBox(height: context.xs),
          Text(
            _supportingText(match),
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          if (match.hasDna || match.sameCanonicalPairs > 0) ...[
            SizedBox(height: context.s),
            _Breakdown(match: match),
          ],
        ],
      ),
    );
  }

  Color _confidenceColour(ColorScheme cs, MatchConfidence c) {
    switch (c) {
      case MatchConfidence.high:
        return cs.primary;
      case MatchConfidence.medium:
        return cs.primary.withValues(alpha: 0.85);
      case MatchConfidence.low:
        return cs.onSurfaceVariant;
    }
  }

  String _supportingText(TasteMatchEntity m) {
    final c = m.confidence!;
    final overlap = m.overlapCount;
    final dnaPart = m.hasDna
        ? ' + WSET style overlap'
        : '';
    final base = 'Based on $overlap shared region/type bucket'
        '${overlap == 1 ? '' : 's'}$dnaPart.';
    switch (c) {
      case MatchConfidence.high:
        return '$base Strong signal.';
      case MatchConfidence.medium:
        return '$base Solid signal.';
      case MatchConfidence.low:
        return '$base Early signal — keep rating to sharpen this.';
    }
  }
}

class _Breakdown extends StatelessWidget {
  const _Breakdown({required this.match});

  final TasteMatchEntity match;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.s),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.025),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6),
            width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (match.bucketScore != null && match.dnaScore != null) ...[
            _BreakdownRow(
              label: 'Region & type fit',
              value: '${match.bucketScore!}%',
            ),
            SizedBox(height: context.xs * 0.6),
            _BreakdownRow(
              label: 'Style DNA fit',
              value: '${match.dnaScore!}%',
            ),
          ],
          if (match.sameCanonicalPairs > 0) ...[
            if (match.bucketScore != null) SizedBox(height: context.xs * 0.6),
            _BreakdownRow(
              label: 'Same wines rated',
              value: '${match.sameCanonicalPairs} '
                  '(${match.agreePairs} aligned, '
                  '${match.disagreePairs} disagreed)',
              accent: match.agreePairs > match.disagreePairs
                  ? cs.primary
                  : cs.error,
            ),
          ],
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.label,
    required this.value,
    this.accent,
  });

  final String label;
  final String value;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: context.captionFont * 0.95,
            fontWeight: FontWeight.w700,
            color: accent ?? cs.onSurface,
          ),
        ),
      ],
    );
  }
}

class _ConfidenceBadge extends StatelessWidget {
  const _ConfidenceBadge({required this.confidence});

  final MatchConfidence confidence;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (label, dots) = switch (confidence) {
      MatchConfidence.high => ('Strong', 3),
      MatchConfidence.medium => ('Solid', 2),
      MatchConfidence.low => ('Early', 1),
    };

    return Row(
      children: [
        for (var i = 0; i < 3; i++) ...[
          Container(
            width: context.w * 0.018,
            height: context.w * 0.018,
            decoration: BoxDecoration(
              color: i < dots ? cs.primary : cs.outlineVariant,
              shape: BoxShape.circle,
            ),
          ),
          if (i < 2) SizedBox(width: context.w * 0.008),
        ],
        SizedBox(width: context.w * 0.02),
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.reason, required this.match});

  final MatchUnavailableReason? reason;
  final TasteMatchEntity match;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final message = _message();

    if (message == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            PhosphorIconsRegular.handshake,
            color: cs.onSurfaceVariant,
            size: context.w * 0.06,
          ),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _message() {
    switch (reason) {
      case MatchUnavailableReason.notEnoughRatings:
        return 'Not enough wines to compare yet — rate a few more bottles to unlock taste match.';
      case MatchUnavailableReason.notEnoughOverlap:
        return 'You haven\'t rated wines from the same regions or types yet. Match opens up as your tastes overlap.';
      case MatchUnavailableReason.unavailable:
      case null:
        return null;
    }
  }
}
