import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../../domain/entities/wine_memory.entity.dart';
import '../../../domain/repositories/wine.repository.dart';
import '../../widgets/moments_bento.widget.dart';
import '../../widgets/wine_form.widget.dart';
import '../moment_capture/moment_capture.screen.dart';

class WineEditScreen extends ConsumerStatefulWidget {
  final String wineId;

  const WineEditScreen({super.key, required this.wineId});

  @override
  ConsumerState<WineEditScreen> createState() => _WineEditScreenState();
}

class _WineEditScreenState extends ConsumerState<WineEditScreen> {
  // Capture the repo handle while ref is still safe to use; calling
  // ref.read inside dispose() throws "Cannot use ref after the widget
  // was disposed" on Riverpod 2.x.
  WineRepository? _flushRepo;

  @override
  void initState() {
    super.initState();
    _flushRepo = ref.read(wineRepositoryProvider);
  }

  @override
  void dispose() {
    // Force-flush any debounced remote sync so the latest autosave state
    // reaches Supabase even if the user navigates away mid-debounce.
    _flushRepo?.flushPendingSync(widget.wineId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wineAsync = ref.watch(wineDetailProvider(widget.wineId));
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: wineAsync.when(
          data: (wine) {
            if (wine == null) {
              return Center(child: Text(l10n.winesEditNotFound));
            }
            return WineForm(
              autoSave: true,
              wine: wine,
              initial: _toFormData(wine),
              momentsHook: _MomentsEditHook(wine: wine),
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
                  servingTempC: data.servingTempC,
                  decantMinutes: data.decantMinutes,
                  abv: data.abv,
                  aroma: data.aroma,
                  foodPairings: data.foodPairings,
                  imageUrl: data.imageUrl,
                  localImagePath: data.localImagePath,
                  updatedAt: DateTime.now(),
                );
                await ref
                    .read(wineControllerProvider.notifier)
                    .updateWine(updated);
                ref.invalidate(wineDetailProvider(widget.wineId));
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: ErrorView(title: l10n.winesEditErrorLoad, error: e),
          ),
        ),
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  WineFormData _toFormData(WineEntity wine) {
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
      servingTempC: wine.servingTempC,
      decantMinutes: wine.decantMinutes,
      abv: wine.abv,
      aroma: wine.aroma,
      foodPairings: wine.foodPairings,
      imageUrl: wine.imageUrl,
      localImagePath: wine.localImagePath,
    );
  }
}

/// Mirrors wine_add's moments section — MOMENTS uppercase header +
/// bento mosaic. Differs from wine_add in two ways: the wine already
/// exists so [MomentsBento] gets the real wineId + real memories
/// (placeholders fill in for low counts), and tapping `+` pushes
/// moment_capture directly instead of going through a save-first dance.
class _MomentsEditHook extends ConsumerWidget {
  final WineEntity wine;
  const _MomentsEditHook({required this.wine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final memoriesAsync = ref.watch(wineMemoriesControllerProvider(wine.id));
    final memories = memoriesAsync.valueOrNull ?? const <WineMemoryEntity>[];

    // New moments on an existing wine start with an empty place — the
    // wine's "first sip" is just the bottle's anchor, not a default
    // for every subsequent moment.
    void openCapture() => pushMomentCapture(context, ref, wineId: wine.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.momentSectionHeader.toUpperCase(),
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.72),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: openCapture,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.xs,
                    vertical: context.xs,
                  ),
                  child: Icon(
                    PhosphorIconsRegular.plus,
                    size: context.w * 0.045,
                    color: cs.onSurface.withValues(alpha: 0.72),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.m),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: MomentsBento(
            memories: memories,
            wineId: wine.id,
            onAdd: openCapture,
          ),
        ),
      ],
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
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}
