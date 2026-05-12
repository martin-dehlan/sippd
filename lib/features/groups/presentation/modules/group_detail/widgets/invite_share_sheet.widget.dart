import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/services/deep_link/deep_link.service.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/utils/share_origin.dart';
import '../../../../../../common/widgets/error_view.widget.dart';
import '../../../../../../common/widgets/inline_error.widget.dart';
import '../../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../controller/group_invitation.provider.dart';

class InviteShareSheet extends ConsumerWidget {
  final String code;
  final String groupId;
  final String groupName;

  const InviteShareSheet({
    super.key,
    required this.code,
    required this.groupId,
    required this.groupName,
  });

  static Future<void> show(
    BuildContext context, {
    required String code,
    required String groupId,
    required String groupName,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      isScrollControlled: true,
      // Render on the root navigator so the sheet covers the shell's
      // bottom nav instead of stopping above it.
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (_) =>
          InviteShareSheet(code: code, groupId: groupId, groupName: groupName),
    );
  }

  String get _inviteUri => DeepLinkService.groupInviteHttpsUri(code);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final maxH = MediaQuery.of(context).size.height * 0.85;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxH),
        child: Padding(
          padding: EdgeInsets.only(
            left: context.paddingH * 1.3,
            right: context.paddingH * 1.3,
            top: context.l,
            bottom: context.l,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: context.w * 0.1,
                  height: context.xs,
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(context.xs),
                  ),
                ),
              ),
              SizedBox(height: context.l),
              Text(
                l10n.groupInviteEyebrow,
                style: TextStyle(
                  fontSize: context.captionFont * 0.95,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: context.l),
              _CodeBlock(code: code),
              SizedBox(height: context.m),
              _ActionRow(
                onCopy: () => _copy(context),
                onShare: () => _share(context),
              ),
              SizedBox(height: context.l),
              Divider(color: cs.outlineVariant, height: 1),
              SizedBox(height: context.m),
              Text(
                l10n.groupInviteFriendsEyebrow,
                style: TextStyle(
                  fontSize: context.captionFont * 0.95,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: context.s),
              Flexible(child: _FriendList(groupId: groupId)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: code));
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.groupInviteCodeCopied),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _share(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await Share.share(
      l10n.groupInviteShareMessage(groupName, _inviteUri, code),
      subject: l10n.groupInviteShareSubject(groupName),
      sharePositionOrigin: shareOriginFor(context),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.m,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIconsRegular.key,
            color: cs.primary,
            size: context.w * 0.05,
          ),
          SizedBox(width: context.w * 0.025),
          Text(
            code,
            style: TextStyle(
              fontSize: context.bodyFont * 1.25,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
              color: cs.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final VoidCallback onCopy;
  final VoidCallback onShare;
  const _ActionRow({required this.onCopy, required this.onShare});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: _Action(
            icon: PhosphorIconsRegular.copy,
            label: l10n.groupInviteActionCopy,
            onTap: onCopy,
          ),
        ),
        SizedBox(width: context.s),
        Expanded(
          child: _Action(
            icon: PhosphorIconsRegular.shareNetwork,
            label: l10n.groupInviteActionShare,
            onTap: onShare,
            filled: true,
          ),
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;
  const _Action({
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = filled ? cs.primary : cs.surfaceContainer;
    final fg = filled ? cs.onPrimary : cs.onSurface;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.m),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fg, size: context.w * 0.045),
              SizedBox(width: context.w * 0.02),
              Text(
                label,
                style: TextStyle(
                  fontSize: context.captionFont * 1.05,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FriendList extends ConsumerWidget {
  final String groupId;
  const _FriendList({required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final friendsAsync = ref.watch(invitableFriendsForGroupProvider(groupId));

    return friendsAsync.when(
      data: (friends) {
        if (friends.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: context.m),
            child: Text(
              l10n.groupInviteFriendsEmpty,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.bodyFont * 0.95,
                color: cs.onSurfaceVariant,
              ),
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          itemCount: friends.length,
          separatorBuilder: (_, _) => SizedBox(height: context.xs),
          itemBuilder: (_, i) => _FriendRow(
            friend: friends[i],
            onInvite: () => _invite(context, ref, friends[i]),
          ),
        );
      },
      loading: () => Padding(
        padding: EdgeInsets.symmetric(vertical: context.m),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => ErrorView(
        title: l10n.groupInviteFriendsErrorLoad,
        compact: true,
        error: e,
      ),
    );
  }

  Future<void> _invite(
    BuildContext context,
    WidgetRef ref,
    FriendProfileEntity friend,
  ) async {
    final l10n = AppLocalizations.of(context);
    final name =
        friend.displayName ?? friend.username ?? l10n.groupInviteFriendFallback;
    try {
      await ref
          .read(groupInvitationControllerProvider.notifier)
          .invite(groupId: groupId, inviteeId: friend.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.groupInviteSentSnack(name))),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            describeAppError(e, fallback: l10n.groupInviteSendFailedFallback),
          ),
        ),
      );
    }
  }
}

class _FriendRow extends StatelessWidget {
  final FriendProfileEntity friend;
  final VoidCallback onInvite;

  const _FriendRow({required this.friend, required this.onInvite});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final name =
        friend.displayName ?? friend.username ?? l10n.groupInviteUnknownName;
    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onInvite,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.035,
            vertical: context.s,
          ),
          child: Row(
            children: [
              FriendAvatar(profile: friend, size: context.w * 0.11),
              SizedBox(width: context.w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (friend.username != null) ...[
                      SizedBox(height: context.xs * 0.4),
                      Text(
                        '@${friend.username}',
                        style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                PhosphorIconsRegular.paperPlaneRight,
                color: cs.primary,
                size: context.w * 0.045,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
