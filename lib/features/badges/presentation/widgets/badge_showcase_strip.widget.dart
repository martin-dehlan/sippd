import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/badges.provider.dart';
import '../badge_visuals.dart';
import 'badge_detail_sheet.widget.dart';

/// Earned-badge strip for a profile (own or friend). Hidden entirely when the
/// user has none. RLS already restricts a friend's rows to earned-only.
class BadgeShowcaseStrip extends ConsumerWidget {
  const BadgeShowcaseStrip({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final badgesAsync = ref.watch(earnedBadgesProvider(userId));

    return badgesAsync.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: (badges) {
        if (badges.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.badgesTitle,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                ),
                SizedBox(width: context.w * 0.02),
                Text(
                  '${badges.length}',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.s),
            SizedBox(
              height: context.w * 0.15,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: badges.length,
                separatorBuilder: (_, _) => SizedBox(width: context.w * 0.03),
                itemBuilder: (context, i) {
                  final b = badges[i];
                  final accent = cs.secondary; // gold seal tone (was category)
                  return GestureDetector(
                    onTap: () => showBadgeDetailSheet(context, b),
                    child: Container(
                      width: context.w * 0.13,
                      height: context.w * 0.13,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.16),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: accent.withValues(alpha: 0.5),
                          width: 0.5,
                        ),
                      ),
                      child: Icon(
                        badgeIcon(b.icon),
                        color: accent,
                        size: context.w * 0.065,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
