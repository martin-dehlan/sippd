import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/wine_form.widget.dart';

class WineEditScreen extends ConsumerWidget {
  final String wineId;

  const WineEditScreen({super.key, required this.wineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineAsync = ref.watch(wineDetailProvider(wineId));

    return Scaffold(
      body: SafeArea(
        child: wineAsync.when(
          data: (wine) {
            if (wine == null) {
              return const Center(child: Text('Wine not found'));
            }
            return WineForm(
              autoSave: true,
              initial: _toFormData(wine),
              onSubmit: (data) async {
                final updated = wine.copyWith(
                  name: data.name,
                  rating: data.rating,
                  type: data.type,
                  price: data.price,
                  country: data.country,
                  location: data.location?.shortDisplay,
                  latitude: data.location?.lat,
                  longitude: data.location?.lng,
                  notes: data.notes,
                  grape: data.grape,
                  vintage: data.vintage,
                  imageUrl: data.imageUrl,
                  localImagePath: data.localImagePath,
                  memoryImageUrl: data.memoryImageUrl,
                  memoryLocalImagePath: data.memoryLocalImagePath,
                  updatedAt: DateTime.now(),
                );
                await ref
                    .read(wineControllerProvider.notifier)
                    .updateWine(updated);
                ref.invalidate(wineDetailProvider(wineId));
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  WineFormData _toFormData(WineEntity wine) {
    final hasLocation = wine.location != null ||
        wine.latitude != null ||
        wine.longitude != null;
    return WineFormData(
      name: wine.name,
      rating: wine.rating,
      type: wine.type,
      price: wine.price,
      vintage: wine.vintage,
      grape: wine.grape,
      country: wine.country,
      location: hasLocation
          ? LocationEntity(
              lat: wine.latitude,
              lng: wine.longitude,
              locationName: wine.location ?? '',
            )
          : null,
      notes: wine.notes,
      imageUrl: wine.imageUrl,
      localImagePath: wine.localImagePath,
      memoryImageUrl: wine.memoryImageUrl,
      memoryLocalImagePath: wine.memoryLocalImagePath,
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  const _FloatingBackButton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'wine-edit-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => context.pop(),
        child: Icon(Icons.arrow_back_ios_new, size: context.w * 0.06),
      ),
    );
  }
}
