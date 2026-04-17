import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../common/services/deep_link/deep_link.service.dart';
import '../../../../../../common/utils/responsive.dart';

class InviteCodePill extends StatelessWidget {
  final String code;
  final String groupName;
  const InviteCodePill({
    super.key,
    required this.code,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.1),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Share.share(
          'Join "$groupName" on Sippd: '
          '${DeepLinkService.groupInviteUri(code)}',
          subject: 'Join $groupName on Sippd',
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.04,
            vertical: context.s * 1.2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.vpn_key_outlined,
                  color: cs.primary, size: context.w * 0.045),
              SizedBox(width: context.w * 0.02),
              Text(
                code,
                style: TextStyle(
                  fontSize: context.captionFont * 1.05,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: cs.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              SizedBox(width: context.w * 0.025),
              Icon(Icons.ios_share_rounded,
                  color: cs.primary, size: context.w * 0.045),
              SizedBox(width: context.w * 0.01),
              Text(
                'Share',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w700,
                  color: cs.primary,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
