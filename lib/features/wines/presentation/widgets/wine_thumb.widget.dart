import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/wine.entity.dart';

/// Resolves the best available image for a wine — prefers a local file
/// (faster, no network) and falls back to the remote URL. Returns null
/// when neither is set so callers can render a typographic placeholder.
ImageProvider? resolveWineImage(WineEntity wine) {
  final local = wine.localImagePath;
  if (local != null && local.isNotEmpty) {
    final file = File(local);
    if (file.existsSync()) return FileImage(file);
  }
  final url = wine.imageUrl;
  if (url != null && url.isNotEmpty) return NetworkImage(url);
  return null;
}

/// Square wine thumbnail used across stats surfaces. Renders the wine's
/// photo when available; otherwise a typographic block tinted by wine
/// type with the first letter of the name. An optional [cornerOverlay]
/// (rank pill, crown, icon) sits in the top-left corner.
class WineThumb extends StatelessWidget {
  final WineEntity wine;
  final double size;
  final Widget? cornerOverlay;
  final double radiusFactor;

  const WineThumb({
    super.key,
    required this.wine,
    required this.size,
    this.cornerOverlay,
    this.radiusFactor = 0.22,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final image = resolveWineImage(wine);
    final radius = BorderRadius.circular(size * radiusFactor);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: radius,
              border: Border.all(color: cs.outlineVariant, width: 0.5),
            ),
            clipBehavior: Clip.antiAlias,
            child: image != null
                ? Image(
                    image: image,
                    fit: BoxFit.cover,
                    // Broken URL / 404 / expired storage — fall back to
                    // the typographic monogram instead of Flutter's
                    // default red-X broken-image glyph.
                    errorBuilder: (_, __, ___) =>
                        _Typographic(wine: wine, size: size),
                    // While the network image is in flight, show the
                    // monogram so the row never flashes empty.
                    frameBuilder: (_, child, frame, wasSync) {
                      if (frame == null && !wasSync) {
                        return _Typographic(wine: wine, size: size);
                      }
                      return child;
                    },
                  )
                : _Typographic(wine: wine, size: size),
          ),
          if (cornerOverlay != null)
            Positioned(top: -size * 0.06, left: -size * 0.06, child: cornerOverlay!),
        ],
      ),
    );
  }
}

class _Typographic extends StatelessWidget {
  final WineEntity wine;
  final double size;
  const _Typographic({required this.wine, required this.size});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final initial = (wine.name.trim().isNotEmpty
            ? wine.name.trim()[0]
            : '?')
        .toUpperCase();
    return Container(
      color: wineTypeColor(wine.type, cs).withValues(alpha: 0.22),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: GoogleFonts.playfairDisplay(
          fontSize: size * 0.52,
          fontWeight: FontWeight.w900,
          color: cs.onSurface,
          letterSpacing: -0.5,
          height: 1,
        ),
      ),
    );
  }
}

/// Single source of truth for the four wine-type accent colours used in
/// stats surfaces (donut, type breakdown, fallback thumbs).
Color wineTypeColor(WineType type, ColorScheme cs) {
  switch (type) {
    case WineType.red:
      return cs.primary;
    case WineType.white:
      return const Color(0xFFE8D9A1);
    case WineType.rose:
      return const Color(0xFFE3A6BA);
    case WineType.sparkling:
      return const Color(0xFFB7C7DC);
  }
}
