import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
    this.radiusFactor = 0.5,
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
                    // Same lean placeholder regardless of the failure
                    // mode — keeps the row from flashing the default
                    // red-X glyph or shifting backgrounds.
                    errorBuilder: (_, _, _) => _Placeholder(size: size),
                    frameBuilder: (_, child, frame, wasSync) {
                      if (frame == null && !wasSync) {
                        return _Placeholder(size: size);
                      }
                      return child;
                    },
                  )
                : _Placeholder(size: size),
          ),
          if (cornerOverlay != null)
            Positioned(
              top: -size * 0.06,
              left: -size * 0.06,
              child: cornerOverlay!,
            ),
        ],
      ),
    );
  }
}

/// Single-source placeholder rendered for every absent / pending /
/// broken thumbnail. Same surfaceContainer bg as the parent slot and
/// a thin phosphor wine-glass at low alpha — the missing image reads
/// as "nothing here" instead of broken or styled-different.
class _Placeholder extends StatelessWidget {
  final double size;
  const _Placeholder({required this.size});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Icon(
        PhosphorIconsThin.wine,
        size: size * 0.42,
        color: cs.onSurfaceVariant.withValues(alpha: 0.45),
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
