import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/wine.provider.dart';
import '../../domain/entities/wine.entity.dart';

class WineDetailTitle extends StatelessWidget {
  final String name;
  const WineDetailTitle({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.paddingH * 1.3,
        right: context.paddingH * 1.3,
      ),
      child: Text(
        name.toUpperCase(),
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.playfairDisplay(
          fontSize: context.titleFont * 1.2,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          height: 1.05,
        ),
      ),
    );
  }
}

class WineDetailMetaLine extends ConsumerWidget {
  final WineType type;
  final String? winery;
  final int? vintage;
  final String? canonicalGrapeId;
  final String? grapeFreetext;
  final String? legacyGrape;

  const WineDetailMetaLine({
    super.key,
    required this.type,
    required this.winery,
    required this.vintage,
    required this.canonicalGrapeId,
    required this.grapeFreetext,
    required this.legacyGrape,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final typeLabel = switch (type) {
      WineType.red => l10n.wineTypeRed,
      WineType.white => l10n.wineTypeWhite,
      WineType.rose => l10n.wineTypeRose,
      WineType.sparkling => l10n.wineTypeSparkling,
    };

    String? grapeText;
    if (canonicalGrapeId != null) {
      final asyncGrape = ref.watch(canonicalGrapeProvider(canonicalGrapeId!));
      grapeText = asyncGrape.valueOrNull?.name ?? legacyGrape;
    } else if (grapeFreetext != null && grapeFreetext!.isNotEmpty) {
      grapeText = grapeFreetext;
    } else if (legacyGrape != null && legacyGrape!.isNotEmpty) {
      grapeText = legacyGrape;
    }

    final fixedParts = <String>[
      typeLabel,
      if (winery != null && winery!.isNotEmpty) winery!,
      if (vintage != null) vintage.toString(),
    ];

    final spans = <InlineSpan>[];
    for (var i = 0; i < fixedParts.length; i++) {
      if (i > 0) {
        spans.add(
          TextSpan(
            text: '  ·  ',
            style: TextStyle(color: cs.outline),
          ),
        );
      }
      spans.add(TextSpan(text: fixedParts[i]));
    }
    if (grapeText != null) {
      if (spans.isNotEmpty) {
        spans.add(
          TextSpan(
            text: '  ·  ',
            style: TextStyle(color: cs.outline),
          ),
        );
      }
      spans.add(TextSpan(text: grapeText));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: context.bodyFont * 0.95,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            height: 1.4,
            color: cs.onSurfaceVariant,
          ),
          children: spans,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class WineDetailImage extends StatelessWidget {
  final WineEntity wine;
  const WineDetailImage({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFF8B2252),
      WineType.white => const Color(0xFFB8A04A),
      WineType.rose => const Color(0xFFB5658A),
      WineType.sparkling => const Color(0xFFB8923B),
    };

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              width: context.w * 0.35,
              height: context.w * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: typeColor.withValues(alpha: 0.3),
                    blurRadius: 60,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        wine.imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(context.w * 0.05),
                child: SizedBox.expand(
                  child: Image.network(
                    wine.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Icon(
                      PhosphorIconsRegular.wine,
                      size: context.w * 0.25,
                      color: typeColor.withValues(alpha: 0.6),
                    ),
                    frameBuilder: (_, child, frame, wasSync) {
                      if (frame == null && !wasSync) {
                        return Icon(
                          PhosphorIconsRegular.wine,
                          size: context.w * 0.25,
                          color: typeColor.withValues(alpha: 0.6),
                        );
                      }
                      return child;
                    },
                  ),
                ),
              )
            : Icon(
                PhosphorIconsRegular.wine,
                size: context.w * 0.25,
                color: typeColor.withValues(alpha: 0.6),
              ),
      ],
    );
  }
}

class WineDetailSectionHeader extends StatelessWidget {
  final String label;
  const WineDetailSectionHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.captionFont * 0.95,
          fontWeight: FontWeight.w700,
          color: cs.onSurface.withValues(alpha: 0.72),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
