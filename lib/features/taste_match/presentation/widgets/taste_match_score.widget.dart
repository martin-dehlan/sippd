import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/taste_match.entity.dart';

class TasteMatchScoreWidget extends StatelessWidget {
  const TasteMatchScoreWidget({super.key, required this.match});

  final TasteMatchEntity match;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);

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
                  l.tasteMatchLabel,
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
            _supportingText(match, l),
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          if (match.hasDna) ...[
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

  String _supportingText(TasteMatchEntity m, AppLocalizations l) {
    final c = m.confidence!;
    final overlap = m.overlapCount;
    final dnaPart = m.hasDna ? l.tasteMatchSupportingDnaPart : '';
    final base = overlap == 1
        ? l.tasteMatchSupportingOne(dnaPart)
        : l.tasteMatchSupportingMany(overlap, dnaPart);
    switch (c) {
      case MatchConfidence.high:
        return '$base ${l.tasteMatchSignalStrong}';
      case MatchConfidence.medium:
        return '$base ${l.tasteMatchSignalSolid}';
      case MatchConfidence.low:
        return '$base ${l.tasteMatchSignalEarly}';
    }
  }
}

class _Breakdown extends StatelessWidget {
  const _Breakdown({required this.match});

  final TasteMatchEntity match;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(context.s),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.025),
        border: Border.all(
          color: cs.outlineVariant.withValues(alpha: 0.6),
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (match.bucketScore != null && match.dnaScore != null) ...[
            _BreakdownRow(
              label: l.tasteMatchBreakdownBucket,
              value: '${match.bucketScore!}%',
            ),
            SizedBox(height: context.xs * 0.6),
            _BreakdownRow(
              label: l.tasteMatchBreakdownDna,
              value: '${match.dnaScore!}%',
            ),
          ],
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.label, required this.value});

  final String label;
  final String value;

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
            color: cs.onSurface,
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
    final l = AppLocalizations.of(context);
    final (label, dots) = switch (confidence) {
      MatchConfidence.high => (l.tasteMatchConfidenceStrong, 3),
      MatchConfidence.medium => (l.tasteMatchConfidenceSolid, 2),
      MatchConfidence.low => (l.tasteMatchConfidenceEarly, 1),
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
    final l = AppLocalizations.of(context);
    final message = _message(l);

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

  String? _message(AppLocalizations l) {
    switch (reason) {
      case MatchUnavailableReason.notEnoughRatings:
        return l.tasteMatchEmptyNotEnough;
      case MatchUnavailableReason.notEnoughOverlap:
        return l.tasteMatchEmptyNoOverlap;
      case MatchUnavailableReason.unavailable:
      case null:
        return null;
    }
  }
}
