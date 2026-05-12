import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/app_snack.dart';
import '../../controller/group_invitation.provider.dart';
import '../../domain/entities/group_invitation.entity.dart';

class GroupInvitationsInbox extends ConsumerWidget {
  const GroupInvitationsInbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final invitesAsync = ref.watch(myGroupInvitationsProvider);
    final invites = invitesAsync.valueOrNull ?? const [];
    if (invites.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: context.s),
            child: Text(
              l10n.groupInvitationsHeader,
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          for (final inv in invites) ...[
            _InviteCard(item: inv),
            SizedBox(height: context.s),
          ],
          SizedBox(height: context.s),
        ],
      ),
    );
  }
}

class _InviteCard extends ConsumerWidget {
  final GroupInvitationInboxItem item;
  const _InviteCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final inviter = item.inviterDisplayName ??
        item.inviterUsername ??
        l10n.groupInvitationsInviterFallback;
    final size = context.w * 0.12;

    return Container(
      padding: EdgeInsets.all(context.w * 0.035),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: item.groupImageUrl == null
                      ? cs.primaryContainer
                      : cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(context.w * 0.025),
                  image: item.groupImageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(item.groupImageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: item.groupImageUrl == null
                    ? Icon(
                        PhosphorIconsRegular.wine,
                        color: cs.primary,
                        size: size * 0.5,
                      )
                    : null,
              ),
              SizedBox(width: context.w * 0.035),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.groupName,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.xs * 0.5),
                    Text(
                      l10n.groupInvitationsInvitedBy(inviter),
                      style: TextStyle(
                        fontSize: context.captionFont * 0.95,
                        color: cs.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.s),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _decline(context, ref),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: cs.onSurfaceVariant,
                    side: BorderSide(color: cs.outlineVariant),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.025),
                    ),
                  ),
                  child: Text(l10n.groupInvitationsDecline),
                ),
              ),
              SizedBox(width: context.s),
              Expanded(
                child: FilledButton(
                  onPressed: () => _accept(context, ref),
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.025),
                    ),
                  ),
                  child: Text(l10n.groupInvitationsAccept),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _accept(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    try {
      await ref
          .read(groupInvitationControllerProvider.notifier)
          .accept(item.invitation);
      if (!context.mounted) return;
      AppSnack.success(context, l10n.groupInvitationsJoinedSnack(item.groupName));
    } catch (e) {
      if (!context.mounted) return;
      AppSnack.error(context, l10n.groupInvitationsAcceptFailed);
    }
  }

  Future<void> _decline(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(groupInvitationControllerProvider.notifier)
          .decline(item.invitation);
    } catch (_) {}
  }
}
