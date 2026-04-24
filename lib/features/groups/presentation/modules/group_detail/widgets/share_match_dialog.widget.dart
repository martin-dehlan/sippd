import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../wines/domain/entities/wine.entity.dart';
import '../../../../domain/entities/share_match_candidate.entity.dart';

/// Outcome returned from the dedup-on-share dialog.
enum ShareMatchChoice { same, different, cancel }

class ShareMatchResult {
  final ShareMatchChoice choice;
  final WineEntity? canonical;
  const ShareMatchResult(this.choice, [this.canonical]);
}

Future<ShareMatchResult?> showShareMatchDialog({
  required BuildContext context,
  required WineEntity mine,
  required List<ShareMatchCandidate> candidates,
}) {
  return showModalBottomSheet<ShareMatchResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (_) => ShareMatchSheet(mine: mine, candidates: candidates),
  );
}

class ShareMatchSheet extends StatelessWidget {
  final WineEntity mine;
  final List<ShareMatchCandidate> candidates;

  const ShareMatchSheet({
    super.key,
    required this.mine,
    required this.candidates,
  });

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
              'Already in this group',
              style: TextStyle(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              '"${mine.name}" looks like a wine a member already shared. Is it the same wine?',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.m),
            for (final c in candidates) ...[
              ShareMatchCandidateCard(
                candidate: c,
                onSame: () => Navigator.pop(
                  context,
                  ShareMatchResult(ShareMatchChoice.same, c.wine),
                ),
              ),
              SizedBox(height: context.s),
            ],
            SizedBox(height: context.s),
            OutlinedButton(
              onPressed: () => Navigator.pop(
                context,
                const ShareMatchResult(ShareMatchChoice.different),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: context.s * 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                ),
                side: BorderSide(color: cs.outlineVariant),
              ),
              child: Text(
                'None of these — share separately',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: context.xs),
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                const ShareMatchResult(ShareMatchChoice.cancel),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShareMatchCandidateCard extends StatelessWidget {
  final ShareMatchCandidate candidate;
  final VoidCallback onSame;

  const ShareMatchCandidateCard({
    super.key,
    required this.candidate,
    required this.onSame,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final wine = candidate.wine;
    final meta = [
      if (wine.vintage != null) wine.vintage.toString(),
      if (wine.winery != null) wine.winery,
      if (wine.country != null) wine.country,
    ].join(' · ');

    return InkWell(
      onTap: onSame,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Container(
        padding: EdgeInsets.all(context.m),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wine.name,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (meta.isNotEmpty) ...[
                    SizedBox(height: context.xs * 0.4),
                    Text(
                      meta,
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (candidate.sharedByUsername != null) ...[
                    SizedBox(height: context.xs * 0.4),
                    Text(
                      'Shared by @${candidate.sharedByUsername}',
                      style: TextStyle(
                        fontSize: context.captionFont * 0.9,
                        color: cs.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.m),
            Icon(PhosphorIconsRegular.link, color: cs.primary),
          ],
        ),
      ),
    );
  }
}
