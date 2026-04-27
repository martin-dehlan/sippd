import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../controller/wine_stats.provider.dart';
import '../../../../domain/entities/wine.entity.dart';

class WineLocationsMap extends ConsumerWidget {
  const WineLocationsMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wines = ref.watch(statsWinesWithLocationProvider);
    final cs = Theme.of(context).colorScheme;
    final height = context.h * 0.32;

    if (wines.isEmpty) {
      return _MapEmptyState(height: height, cs: cs);
    }

    final bounds = _bounds(wines);

    return ClipRRect(
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCameraFit: CameraFit.bounds(
                  bounds: bounds,
                  padding: EdgeInsets.all(context.w * 0.08),
                ),
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom |
                      InteractiveFlag.drag |
                      InteractiveFlag.doubleTapZoom,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'xyz.sippd.app',
                  tileBuilder: _darkTileBuilder,
                ),
                MarkerLayer(
                  markers: [
                    for (final w in wines)
                      Marker(
                        point: LatLng(w.latitude!, w.longitude!),
                        width: context.w * 0.07,
                        height: context.w * 0.07,
                        child: _WinePin(rating: w.rating, cs: cs),
                      ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: context.s,
              right: context.s,
              child: _CountBadge(count: wines.length, cs: cs),
            ),
          ],
        ),
      ),
    );
  }

  LatLngBounds _bounds(List<WineEntity> wines) {
    if (wines.length == 1) {
      // Pad a single point so flutter_map gets a non-zero bounds.
      final lat = wines.first.latitude!;
      final lng = wines.first.longitude!;
      return LatLngBounds(
        LatLng(lat - 1.5, lng - 1.5),
        LatLng(lat + 1.5, lng + 1.5),
      );
    }
    final lats = wines.map((w) => w.latitude!);
    final lngs = wines.map((w) => w.longitude!);
    return LatLngBounds(
      LatLng(lats.reduce((a, b) => a < b ? a : b),
          lngs.reduce((a, b) => a < b ? a : b)),
      LatLng(lats.reduce((a, b) => a > b ? a : b),
          lngs.reduce((a, b) => a > b ? a : b)),
    );
  }

  /// Subtle dark filter on OSM tiles so the bright default tile artwork
  /// doesn't clash with the rest of the dark UI.
  Widget _darkTileBuilder(BuildContext context, Widget tile, _) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        0.55, 0, 0, 0, 0,
        0, 0.55, 0, 0, 0,
        0, 0, 0.55, 0, 0,
        0, 0, 0, 1, 0,
      ]),
      child: tile,
    );
  }
}

class _WinePin extends StatelessWidget {
  final double rating;
  final ColorScheme cs;
  const _WinePin({required this.rating, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cs.primary,
        shape: BoxShape.circle,
        border: Border.all(color: cs.onPrimary, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          PhosphorIconsFill.wine,
          color: cs.onPrimary,
          size: context.w * 0.04,
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  final ColorScheme cs;
  const _CountBadge({required this.count, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Text(
        '$count ${count == 1 ? 'place' : 'places'}',
        style: TextStyle(
          fontSize: context.captionFont,
          fontWeight: FontWeight.w700,
          color: cs.onSurface,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _MapEmptyState extends StatelessWidget {
  final double height;
  final ColorScheme cs;
  const _MapEmptyState({required this.height, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIconsRegular.mapTrifold,
            size: context.w * 0.14,
            color: cs.outline,
          ),
          SizedBox(height: context.s),
          Text(
            'Add places to your wines to see them here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
