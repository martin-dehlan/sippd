import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'share_card_branding.widget.dart';

const _bg = Color(0xFF14101A);
const _onBg = Color(0xFFEFE8F1);
const _onBgMuted = Color(0xFF8A7E92);
const _primary = Color(0xFF6B3A51);
const _divider = Color(0xFF2A2330);

/// Lightweight value type for what the share-card needs. Built once
/// from the recap providers + group + attendee counts; kept separate
/// from the on-screen entity model so the card stays presentation-pure.
class TastingRecapCardData {
  final String groupName;
  final String? groupAvatarUrl;
  final String tastingTitle;
  final DateTime date;
  final String? location;
  final String? topWineName;
  final String? topWineWinery;
  final int? topWineVintage;
  final double? topWineAvg;
  final String? topWineImageUrl;
  final List<TastingRecapCardLine> ranked;
  final int attendeeCount;

  const TastingRecapCardData({
    required this.groupName,
    this.groupAvatarUrl,
    required this.tastingTitle,
    required this.date,
    this.location,
    this.topWineName,
    this.topWineWinery,
    this.topWineVintage,
    this.topWineAvg,
    this.topWineImageUrl,
    required this.ranked,
    required this.attendeeCount,
  });
}

class TastingRecapCardLine {
  final String name;
  final double? avg;
  const TastingRecapCardLine({required this.name, this.avg});
}

/// 1080×1920 IG-story share card for a concluded tasting. Typographic
/// only — tastings rarely have a single hero photo, and the pure-type
/// treatment matches the editorial voice of the rest of the brand.
class TastingRecapCard extends StatelessWidget {
  final TastingRecapCardData data;
  const TastingRecapCard({super.key, required this.data});

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
          _Header(date: data.date, location: data.location),
          const Spacer(flex: 1),
          _GroupHeading(
            groupName: data.groupName,
            groupAvatarUrl: data.groupAvatarUrl,
            tastingTitle: data.tastingTitle,
          ),
          const Spacer(flex: 1),
          if (data.topWineName != null) _TopWineBlock(data: data),
          const Spacer(flex: 1),
          if (data.ranked.isNotEmpty) _LineupBlock(data: data),
          const Spacer(flex: 1),
          _AttendeesLine(count: data.attendeeCount),
          const SizedBox(height: 36),
          const ShareCardFooter(
            textColor: _onBg,
            dividerColor: _divider,
            tagline: 'host yours at $shareCardUrl',
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final DateTime date;
  final String? location;
  const _Header({required this.date, this.location});

  @override
  Widget build(BuildContext context) {
    final loc = (location ?? '').trim();
    final dateStamp = DateFormat('d MMM yyyy').format(date).toUpperCase();
    final stamp = loc.isEmpty ? dateStamp : '$dateStamp · ${loc.toUpperCase()}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ShareCardWordmark(color: _onBg, size: 44),
        Flexible(
          child: Text(
            stamp,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 26,
              color: _onBgMuted,
              letterSpacing: 4,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _GroupHeading extends StatelessWidget {
  final String groupName;
  final String? groupAvatarUrl;
  final String tastingTitle;
  const _GroupHeading({
    required this.groupName,
    required this.groupAvatarUrl,
    required this.tastingTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GROUP TASTING',
          style: TextStyle(
            fontSize: 28,
            color: _onBgMuted,
            letterSpacing: 4,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          tastingTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.playfairDisplay(
            fontSize: 110,
            fontWeight: FontWeight.w900,
            color: _onBg,
            height: 1,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 22),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _GroupAvatar(url: groupAvatarUrl, name: groupName),
            const SizedBox(width: 18),
            Flexible(
              child: Text(
                groupName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 44,
                  fontStyle: FontStyle.italic,
                  color: _onBgMuted,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Small circular group portrait next to the group name in the heading.
/// Falls back to a typographic monogram on the brand-primary swatch
/// when no avatar exists, so the heading still reads as a group tile
/// rather than a bare line of italic text.
class _GroupAvatar extends StatelessWidget {
  final String? url;
  final String name;
  const _GroupAvatar({required this.url, required this.name});

  @override
  Widget build(BuildContext context) {
    const size = 64.0;
    final hasUrl = (url ?? '').trim().isNotEmpty;
    final initial = name.trim().isEmpty ? '·' : name.trim()[0].toUpperCase();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _primary,
        image: hasUrl
            ? DecorationImage(image: NetworkImage(url!), fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.center,
      child: hasUrl
          ? null
          : Text(
              initial,
              style: GoogleFonts.playfairDisplay(
                fontSize: 34,
                color: _onBg,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
    );
  }
}

class _TopWineBlock extends StatelessWidget {
  final TastingRecapCardData data;
  const _TopWineBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      if ((data.topWineWinery ?? '').isNotEmpty) data.topWineWinery!,
      if (data.topWineVintage != null) data.topWineVintage.toString(),
    ].join(' · ');
    final hasImage = (data.topWineImageUrl ?? '').trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
      decoration: BoxDecoration(
        color: _primary,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(PhosphorIconsFill.trophy, color: _onBg, size: 56),
              const SizedBox(width: 16),
              Text(
                'TOP WINE OF THE NIGHT',
                style: TextStyle(
                  fontSize: 24,
                  color: _onBg.withValues(alpha: 0.85),
                  letterSpacing: 4,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasImage) ...[
                _TopWinePhoto(url: data.topWineImageUrl!),
                const SizedBox(width: 32),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.topWineName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: hasImage ? 64 : 80,
                        fontWeight: FontWeight.w900,
                        color: _onBg,
                        height: 1,
                        letterSpacing: -1.5,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 28,
                          color: _onBg.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (data.topWineAvg != null) ...[
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data.topWineAvg!.toStringAsFixed(1),
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 120,
                              fontWeight: FontWeight.w900,
                              color: _onBg,
                              height: 1,
                              letterSpacing: -5,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 22),
                            child: Text(
                              '/ 10',
                              style: TextStyle(
                                fontSize: 36,
                                color: _onBg.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopWinePhoto extends StatelessWidget {
  final String url;
  const _TopWinePhoto({required this.url});

  @override
  Widget build(BuildContext context) {
    const size = 260.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _bg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(28),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}

class _LineupBlock extends StatelessWidget {
  final TastingRecapCardData data;
  const _LineupBlock({required this.data});

  @override
  Widget build(BuildContext context) {
    final visible = data.ranked.take(5).toList();
    final remaining = data.ranked.length - visible.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LINEUP',
          style: TextStyle(
            fontSize: 26,
            color: _onBgMuted,
            letterSpacing: 4,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 24),
        for (var i = 0; i < visible.length; i++) ...[
          if (i > 0) const SizedBox(height: 18),
          _LineupRow(rank: i + 1, line: visible[i]),
        ],
        if (remaining > 0) ...[
          const SizedBox(height: 24),
          Text(
            '+ $remaining more',
            style: TextStyle(
              fontSize: 30,
              color: _onBgMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

class _LineupRow extends StatelessWidget {
  final int rank;
  final TastingRecapCardLine line;
  const _LineupRow({required this.rank, required this.line});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        SizedBox(
          width: 64,
          child: Text(
            '$rank.',
            style: TextStyle(
              fontSize: 38,
              color: _onBgMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            line.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(
              fontSize: 42,
              fontWeight: FontWeight.w700,
              color: _onBg,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Text(
          line.avg?.toStringAsFixed(1) ?? '–',
          style: GoogleFonts.playfairDisplay(
            fontSize: 42,
            fontWeight: FontWeight.w800,
            color: _onBg,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _AttendeesLine extends StatelessWidget {
  final int count;
  const _AttendeesLine({required this.count});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    return Row(
      children: [
        const Icon(
          PhosphorIconsRegular.usersThree,
          color: _onBgMuted,
          size: 32,
        ),
        const SizedBox(width: 12),
        Text(
          count == 1 ? '1 taster' : '$count tasters',
          style: TextStyle(
            fontSize: 30,
            color: _onBgMuted,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}
