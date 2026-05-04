import 'package:flutter/material.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/canonical_wine_candidate.entity.dart';

/// Result returned to the caller. [linkedCandidateId] non-null means
/// the user confirmed the suggested match and the new wines row
/// should set canonical_wine_id explicitly. Null means the user
/// declined — let the trigger create a fresh canonical.
class CanonicalMatchPromptResult {
  const CanonicalMatchPromptResult.linked(this.linkedCandidateId);
  const CanonicalMatchPromptResult.different() : linkedCandidateId = null;

  final String? linkedCandidateId;
  bool get isLinked => linkedCandidateId != null;
}

/// Shown when the server suggests Tier 2 fuzzy candidates for the
/// wine being added. Lets the user link to one of them or confirm
/// it's a different wine. Either way the choice is recorded so we
/// never re-prompt for the same input pair.
Future<CanonicalMatchPromptResult?> showCanonicalWinePromptSheet({
  required BuildContext context,
  required String inputName,
  String? inputWinery,
  int? inputVintage,
  required List<CanonicalWineCandidate> candidates,
}) {
  return showModalBottomSheet<CanonicalMatchPromptResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (ctx) => _PromptSheet(
      inputName: inputName,
      inputWinery: inputWinery,
      inputVintage: inputVintage,
      candidates: candidates,
    ),
  );
}

class _PromptSheet extends StatelessWidget {
  const _PromptSheet({
    required this.inputName,
    required this.inputWinery,
    required this.inputVintage,
    required this.candidates,
  });

  final String inputName;
  final String? inputWinery;
  final int? inputVintage;
  final List<CanonicalWineCandidate> candidates;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.m,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.m),
            Text(
              'Same wine?',
              style: TextStyle(
                fontSize: context.headingFont,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              "Looks similar to a wine that's already in the catalog. "
              'Linking them keeps your stats and matches accurate.',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            SizedBox(height: context.m),
            _InputCard(
              name: inputName,
              winery: inputWinery,
              vintage: inputVintage,
              label: "What you're adding",
            ),
            SizedBox(height: context.s),
            for (final c in candidates) ...[
              _CandidateTile(
                candidate: c,
                onTap: () => Navigator.pop(
                  context,
                  CanonicalMatchPromptResult.linked(c.id),
                ),
              ),
              SizedBox(height: context.s),
            ],
            SizedBox(height: context.xs),
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                const CanonicalMatchPromptResult.different(),
              ),
              child: Text(
                'No, this is a different wine',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  const _InputCard({
    required this.name,
    required this.winery,
    required this.vintage,
    required this.label,
  });

  final String name;
  final String? winery;
  final int? vintage;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.s * 1.5),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              fontWeight: FontWeight.w700,
              color: cs.outline,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            name,
            style: TextStyle(
              fontSize: context.bodyFont * 1.05,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          if ((winery != null && winery!.isNotEmpty) || vintage != null) ...[
            SizedBox(height: context.xs * 0.5),
            Text(
              [
                if (winery != null && winery!.isNotEmpty) winery!,
                if (vintage != null) vintage.toString(),
              ].join(' · '),
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CandidateTile extends StatelessWidget {
  const _CandidateTile({required this.candidate, required this.onTap});

  final CanonicalWineCandidate candidate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pct = (candidate.similarity * 100).round();
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Container(
        padding: EdgeInsets.all(context.s * 1.5),
        decoration: BoxDecoration(
          border: Border.all(color: cs.primary, width: 1.5),
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'EXISTING IN CATALOG',
                        style: TextStyle(
                          fontSize: context.captionFont * 0.85,
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(width: context.xs),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.xs * 1.2,
                          vertical: context.xs * 0.4,
                        ),
                        decoration: BoxDecoration(
                          color: cs.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(context.xs),
                        ),
                        child: Text(
                          '$pct% match',
                          style: TextStyle(
                            fontSize: context.captionFont * 0.8,
                            fontWeight: FontWeight.w600,
                            color: cs.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.xs),
                  Text(
                    candidate.name,
                    style: TextStyle(
                      fontSize: context.bodyFont * 1.05,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  if ((candidate.winery != null &&
                          candidate.winery!.isNotEmpty) ||
                      candidate.vintage != null) ...[
                    SizedBox(height: context.xs * 0.5),
                    Text(
                      [
                        if (candidate.winery != null &&
                            candidate.winery!.isNotEmpty)
                          candidate.winery!,
                        if (candidate.vintage != null)
                          candidate.vintage.toString(),
                      ].join(' · '),
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.s),
            Icon(Icons.arrow_forward, color: cs.primary, size: context.w * 0.05),
          ],
        ),
      ),
    );
  }
}
