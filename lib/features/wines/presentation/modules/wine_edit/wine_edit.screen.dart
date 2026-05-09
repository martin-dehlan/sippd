import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../../domain/entities/wine_memory.entity.dart';
import '../../widgets/wine_form.widget.dart';
import '../../widgets/wine_memories_editor.widget.dart';

class WineEditScreen extends ConsumerStatefulWidget {
  final String wineId;

  const WineEditScreen({super.key, required this.wineId});

  @override
  ConsumerState<WineEditScreen> createState() => _WineEditScreenState();
}

class _WineEditScreenState extends ConsumerState<WineEditScreen> {
  @override
  void dispose() {
    // Force-flush any debounced remote sync so the latest autosave state
    // reaches Supabase even if the user navigates away mid-debounce.
    ref.read(wineRepositoryProvider).flushPendingSync(widget.wineId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wineAsync = ref.watch(wineDetailProvider(widget.wineId));
    final memoriesAsync = ref.watch(
      wineMemoriesControllerProvider(widget.wineId),
    );

    return Scaffold(
      body: SafeArea(
        child: wineAsync.when(
          data: (wine) {
            if (wine == null) {
              return const Center(child: Text('Wine not found'));
            }
            return memoriesAsync.when(
              data: (memories) => WineForm(
                autoSave: true,
                wine: wine,
                initial: _toFormData(wine, memories),
                onSubmit: (data) async {
                  final updated = wine.copyWith(
                    name: data.name,
                    rating: data.rating,
                    type: data.type,
                    price: data.price,
                    country: data.country,
                    region: data.region,
                    location: data.location?.shortDisplay,
                    latitude: data.location?.lat,
                    longitude: data.location?.lng,
                    notes: data.notes,
                    grape: data.grape,
                    canonicalGrapeId: data.canonicalGrapeId,
                    grapeFreetext: data.grapeFreetext,
                    winery: data.winery,
                    vintage: data.vintage,
                    imageUrl: data.imageUrl,
                    localImagePath: data.localImagePath,
                    updatedAt: DateTime.now(),
                  );
                  await ref
                      .read(wineControllerProvider.notifier)
                      .updateWine(updated);
                  await _syncMemories(ref, wine, data.memories);
                  ref.invalidate(wineDetailProvider(widget.wineId));
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: ErrorView(title: "Couldn't load memories", error: e),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: ErrorView(title: "Couldn't load wine", error: e),
          ),
        ),
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  WineFormData _toFormData(WineEntity wine, List<WineMemoryEntity> memories) {
    final hasLocation =
        wine.location != null ||
        wine.latitude != null ||
        wine.longitude != null;
    return WineFormData(
      name: wine.name,
      rating: wine.rating,
      type: wine.type,
      price: wine.price,
      vintage: wine.vintage,
      grape: wine.grape,
      canonicalGrapeId: wine.canonicalGrapeId,
      grapeFreetext:
          wine.grapeFreetext ??
          (wine.canonicalGrapeId == null ? wine.grape : null),
      winery: wine.winery,
      country: wine.country,
      region: wine.region,
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
      memories: memories
          .map(
            (m) => MemoryDraft(
              id: m.id,
              imageUrl: m.imageUrl,
              localImagePath: m.localImagePath,
            ),
          )
          .toList(),
    );
  }

  Future<void> _syncMemories(
    WidgetRef ref,
    WineEntity wine,
    List<MemoryDraft> next,
  ) async {
    final repo = ref.read(wineMemoryRepositoryProvider);
    final current = await repo.getByWine(wine.id);
    final currentIds = current.map((m) => m.id).toSet();
    final nextIds = next.map((m) => m.id).toSet();

    for (final m in next) {
      if (!currentIds.contains(m.id)) {
        await repo.addMemory(
          WineMemoryEntity(
            id: m.id,
            wineId: wine.id,
            userId: wine.userId,
            imageUrl: m.imageUrl,
            localImagePath: m.localImagePath,
            createdAt: DateTime.now(),
          ),
        );
      }
    }
    for (final m in current) {
      if (!nextIds.contains(m.id)) {
        await repo.deleteMemory(m.id);
      }
    }
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
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}
