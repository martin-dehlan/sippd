import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'share_card_branding.widget.dart';

const _bg = Color(0xFF14101A);
const _onBg = Color(0xFFEFE8F1);
const _onBgMuted = Color(0xFF8A7E92);
const _accent = Color(0xFF6B3A51);
const _divider = Color(0xFF2A2330);

/// Render data for the friend invite card. Built outside the widget so
/// callers can stay clear of presentation concerns (avatar resolution,
/// etc).
class FriendInviteCardData {
  const FriendInviteCardData({
    required this.displayName,
    this.username,
    this.avatarUrl,
  });

  final String displayName;
  final String? username;
  final String? avatarUrl;
}

/// 1080×1920 IG-story friend invite. Lean editorial layout — single
/// accent, generous whitespace, no decorative chrome — so the artifact
/// reads as a personal note rather than ad creative. Big claim
/// ("Let's taste together"), the inviter's identity in a small avatar
/// row, and the brand lockup at the bottom anchored by the footer
/// rule used across all share cards.
class FriendInviteCard extends StatelessWidget {
  const FriendInviteCard({super.key, required this.data});

  final FriendInviteCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: shareCardWidth,
      height: shareCardHeight,
      color: _bg,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Eyebrow(),
          const Spacer(flex: 2),
          const _Hero(),
          const SizedBox(height: 28),
          const _Sub(),
          const Spacer(flex: 3),
          _Inviter(data: data),
          const Spacer(flex: 1),
          const _Footer(),
        ],
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(PhosphorIconsRegular.wine, color: _accent, size: 38),
        const SizedBox(width: 16),
        Text(
          'AN INVITATION',
          style: TextStyle(
            fontSize: 28,
            color: _onBgMuted,
            letterSpacing: 4,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Let's taste\ntogether.",
      style: GoogleFonts.playfairDisplay(
        fontSize: 168,
        height: 1.0,
        fontWeight: FontWeight.w800,
        color: _onBg,
        letterSpacing: -2.5,
      ),
    );
  }
}

class _Sub extends StatelessWidget {
  const _Sub();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Rate it. Remember it. Share it.',
      style: TextStyle(
        fontSize: 38,
        height: 1.3,
        color: _onBgMuted,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _Inviter extends StatelessWidget {
  const _Inviter({required this.data});
  final FriendInviteCardData data;

  @override
  Widget build(BuildContext context) {
    final hasAvatar =
        data.avatarUrl != null && data.avatarUrl!.trim().isNotEmpty;
    final initials = data.displayName.trim().isEmpty
        ? '?'
        : data.displayName.trim()[0].toUpperCase();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: _accent.withValues(alpha: 0.20),
            shape: BoxShape.circle,
            image: hasAvatar
                ? DecorationImage(
                    image: NetworkImage(data.avatarUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: hasAvatar
              ? null
              : Text(
                  initials,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 54,
                    fontWeight: FontWeight.w800,
                    color: _onBg,
                    height: 1,
                  ),
                ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 44,
                  fontWeight: FontWeight.w700,
                  color: _onBg,
                  height: 1.05,
                ),
              ),
              if ((data.username ?? '').trim().isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  '@${data.username!}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 28,
                    color: _onBgMuted,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
              const SizedBox(height: 6),
              Text(
                'wants to taste with you',
                style: TextStyle(
                  fontSize: 26,
                  color: _onBgMuted,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Footer lockup — divider + brand glyph beside SIPPD wordmark on the
/// left, CTA tagline on the right. Same shape as the compass card so
/// every Sippd share artifact lands with the same end-frame.
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 1, color: _divider),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/branding/logo_icon.png',
                  height: 70,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
                const SizedBox(width: 12),
                Text(
                  'SIPPD',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: _onBg,
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                ),
              ],
            ),
            Text(
              'join at $shareCardUrl',
              style: TextStyle(
                fontSize: 28,
                color: _onBg,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
