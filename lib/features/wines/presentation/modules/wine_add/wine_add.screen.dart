import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/services/review/review.provider.dart';
import '../../../../../common/utils/name_normalizer.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/review_prompt.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../../promo/presentation/demo_spotlight.widget.dart';
import '../../../../promo/promo.config.dart';
import '../../../../share_cards/presentation/widgets/wine_share_prompt_sheet.dart';
import '../../../controller/expert_tasting.provider.dart';
import '../../../controller/wine.provider.dart';
import '../../../data/data_sources/expert_tasting.api.dart';
import '../../../domain/entities/canonical_wine_candidate.entity.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../../domain/entities/wine_memory.entity.dart';
import '../../../domain/entities/wine_memory_photo.entity.dart';
import '../../widgets/canonical_wine_prompt_sheet.dart';
import '../../widgets/moments_bento.widget.dart';
import '../../widgets/wine_form.widget.dart';
import '../moment_capture/moment_capture.screen.dart';

class WineAddScreen extends ConsumerStatefulWidget {
  const WineAddScreen({super.key});

  @override
  ConsumerState<WineAddScreen> createState() => _WineAddScreenState();
}

class _WineAddScreenState extends ConsumerState<WineAddScreen> {
  final GlobalKey<WineFormState> _formKey = GlobalKey<WineFormState>();
  WineFormData? _current;
  bool _allowPop = false;
  // Drafted moments captured before the wine is saved. Persisted in
  // `_save` after the wine row + canonical resolution land. Photos are
  // uploaded to storage immediately on pick (orphaned on full cancel
  // — covered by the post-launch storage sweep).
  final List<MemoryDraft> _drafts = [];

  @override
  void initState() {
    super.initState();
    if (kIsDemo) _runDemoBeats();
  }

  @override
  void dispose() {
    demoDetailBeat.value = null;
    demoScreenBusy.value = false;
    super.dispose();
  }

  /// Demo only: walk the add-wine form for a hands-free promo recording.
  /// Fills the headline fields one at a time (name → type → winery), then
  /// spotlights the rating stat and opens the rating sheet so it can
  /// animate, then closes and highlights origin. Purely visual: only
  /// local form state is touched and the rating sheet is opened — the
  /// save action is never called, so no wine is created. The busy flag
  /// keeps the central auto-tour from navigating away mid-sequence.
  Future<void> _runDemoBeats() async {
    demoScreenBusy.value = true;
    // Let the screen's first frame settle so the form key is attached.
    await Future<void>.delayed(const Duration(milliseconds: 1200));

    final form = _formKey.currentState;
    if (!mounted || form == null) return _endDemoBeats();

    // Name: spotlight, then type it in.
    demoDetailBeat.value = 0;
    await Future<void>.delayed(const Duration(milliseconds: 700));
    form.demoSetName('Château Margaux');
    await Future<void>.delayed(const Duration(milliseconds: 1300));

    // Type: spotlight, then pick "red".
    if (!mounted) return _endDemoBeats();
    demoDetailBeat.value = 1;
    await Future<void>.delayed(const Duration(milliseconds: 700));
    _formKey.currentState?.demoSetType(WineType.red);
    await Future<void>.delayed(const Duration(milliseconds: 1100));

    // Winery (lead chip in the chips row): spotlight, then fill.
    if (!mounted) return _endDemoBeats();
    demoDetailBeat.value = 4;
    await Future<void>.delayed(const Duration(milliseconds: 700));
    _formKey.currentState?.demoSetWinery('Bordeaux Estate');
    await Future<void>.delayed(const Duration(milliseconds: 1300));

    // Origin: spotlight the country/region stat (no sheet — keep it brief).
    if (!mounted) return _endDemoBeats();
    demoDetailBeat.value = 3;
    await Future<void>.delayed(const Duration(milliseconds: 1300));

    // Rating: spotlight, open the sheet, let it auto-animate, then close.
    if (!mounted) return _endDemoBeats();
    demoDetailBeat.value = 2;
    await Future<void>.delayed(const Duration(milliseconds: 900));
    final ratingState = _formKey.currentState;
    if (!mounted || ratingState == null) return _endDemoBeats();
    final ratingFuture = ratingState.demoOpenRatingSheet();
    await Future<void>.delayed(const Duration(milliseconds: 3900));
    _closeSheet();
    await ratingFuture;
    if (!mounted) return _endDemoBeats();
    await Future<void>.delayed(const Duration(milliseconds: 500));

    _endDemoBeats();
  }

  void _closeSheet() {
    if (mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  void _endDemoBeats() {
    if (mounted) demoDetailBeat.value = null;
    demoScreenBusy.value = false;
  }

  bool get _isDirty {
    final d = _current;
    final hasFormData =
        d != null &&
        (d.name.isNotEmpty ||
            d.rating != 5.0 ||
            d.type != WineType.red ||
            d.price != null ||
            d.vintage != null ||
            (d.grape?.isNotEmpty ?? false) ||
            (d.winery?.isNotEmpty ?? false) ||
            (d.country?.isNotEmpty ?? false) ||
            d.location != null ||
            (d.notes?.isNotEmpty ?? false) ||
            d.imageUrl != null ||
            d.localImagePath != null);
    return hasFormData || _drafts.isNotEmpty;
  }

  /// Renders a [MemoryDraft] into a stand-in [WineMemoryEntity] purely
  /// for bento tile display (the bento itself doesn't care about the
  /// difference). Persistence still goes through the real entity built
  /// inside [_save] when the wineId exists.
  WineMemoryEntity _draftAsEntity(MemoryDraft d) => WineMemoryEntity(
    id: d.id,
    wineId: '',
    userId: '',
    imageUrl: d.primaryPhotoUrl,
    caption: d.caption,
    createdAt: d.occurredAt,
    occurredAt: d.occurredAt,
    placeName: d.placeName,
    placeLat: d.placeLat,
    placeLng: d.placeLng,
    companionUserIds: d.companionUserIds,
    note: d.note,
    visibility: d.visibility,
  );

  Future<void> _addMomentDraft() async {
    final draft = await pushMomentCaptureDraft(
      context,
      ref,
      wineLocationName: _current?.location?.shortDisplay,
      wineLocationLat: _current?.location?.lat,
      wineLocationLng: _current?.location?.lng,
    );
    if (draft == null || !mounted) return;
    setState(() => _drafts.add(draft));
  }

  Future<void> _editMomentDraft(int index) async {
    final existing = _drafts[index];
    final updated = await pushMomentCaptureDraft(
      context,
      ref,
      existing: existing,
    );
    if (updated == null || !mounted) return;
    setState(() => _drafts[index] = updated);
  }

  Future<bool> _confirmDiscard() async {
    if (!_isDirty) return true;
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return AlertDialog(
          title: Text(l10n.winesAddDiscardTitle),
          content: Text(l10n.winesAddDiscardBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.winesAddDiscardKeepEditing),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(
                l10n.winesAddDiscardConfirm,
                style: TextStyle(color: cs.error),
              ),
            ),
          ],
        );
      },
    );
    return confirmed ?? false;
  }

  Future<void> _save() async {
    final data = _current;
    if (data == null) return;

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    // Same-bottle guard: warn before creating a second journal entry
    // with the same name + winery + vintage + grape. Sippd is a
    // journal so dupes aren't *forbidden* (different occasion, fresh
    // notes), but creating one by accident is a much more common
    // mistake than intentional re-logging.
    final dupe = await ref
        .read(appDatabaseProvider)
        .winesDao
        .findDuplicate(
          userId: userId,
          nameNorm: normalizeName(data.name),
          wineryNorm: data.winery == null ? null : normalizeName(data.winery),
          vintage: data.vintage,
          canonicalGrapeId: data.canonicalGrapeId,
          grapeFreetext: data.grapeFreetext ?? data.grape,
        );
    if (dupe != null && mounted) {
      final action = await _showDuplicatePrompt(dupe.name);
      if (!mounted) return;
      if (action == _DupeAction.cancel) return;
      if (action == _DupeAction.openExisting) {
        setState(() => _allowPop = true);
        context.pushReplacement(AppRoutes.wineDetailPath(dupe.id));
        return;
      }
      // _DupeAction.addAnyway → fall through to normal save flow.
    }

    // Tier 2 prompt: ask the user before creating a near-duplicate
    // canonical. Only fires when the suggestion RPC returns fuzzy
    // candidates (no exact match exists). Decision is recorded so
    // we never re-prompt the same input pair.
    final canonicalApi = ref.read(canonicalWineApiProvider);
    String? linkedCanonicalId;
    if (canonicalApi != null) {
      // Offline-first: a failure here (Supabase down, no network, RPC error)
      // must not block the save. Skip the fuzzy-prompt and let the local
      // insert proceed; the post-insert trigger will still resolve canonical
      // on the server when sync catches up.
      var suggestions = const <CanonicalWineCandidate>[];
      try {
        suggestions = await canonicalApi.suggestMatch(
          name: data.name,
          winery: data.winery,
          vintage: data.vintage,
        );
      } catch (_) {
        // Swallow — offline path. No fuzzy prompt this round.
      }
      final fuzzy = suggestions.where((c) => !c.isExact).toList();
      if (fuzzy.isNotEmpty && mounted) {
        final result = await showCanonicalWinePromptSheet(
          context: context,
          inputName: data.name,
          inputWinery: data.winery,
          inputVintage: data.vintage,
          candidates: fuzzy,
        );
        if (result != null) {
          if (result.isLinked) {
            linkedCanonicalId = result.linkedCandidateId;
          }
          // Record the decision against every candidate the sheet
          // showed so each one is remembered.
          for (final c in fuzzy) {
            await canonicalApi.recordDecision(
              inputName: data.name,
              inputWinery: data.winery,
              inputVintage: data.vintage,
              candidateId: c.id,
              linked: result.isLinked && c.id == result.linkedCandidateId,
            );
          }
        }
      }
    }

    final wineId = const Uuid().v4();
    final wine = WineEntity(
      id: wineId,
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
      canonicalWineId: linkedCanonicalId,
      winery: data.winery,
      vintage: data.vintage,
      imageUrl: data.imageUrl,
      localImagePath: data.localImagePath,
      userId: userId,
      createdAt: DateTime.now(),
    );
    await ref.read(wineControllerProvider.notifier).addWine(wine);

    // If the user typed expert tasting dimensions in the rating sheet
    // before the wine was ever saved, the canonical_wine_id wasn't yet
    // known. Resolve it now (server RPC — same lookup the post-insert
    // trigger uses) and write the dimensions. Best-effort: a failure
    // here doesn't block the rest of the save flow.
    final pending = data.pendingExpertTasting;
    if (pending != null && !pending.isEmpty && canonicalApi != null) {
      try {
        final resolvedCanonical =
            linkedCanonicalId ??
            await canonicalApi.resolve(
              name: data.name,
              winery: data.winery,
              vintage: data.vintage,
              type: data.type.name,
              country: data.country,
              region: data.region,
              canonicalGrapeId: data.canonicalGrapeId,
              userId: userId,
            );
        if (resolvedCanonical != null) {
          await ExpertTastingApi(
            ref.read(supabaseClientProvider),
          ).upsert(canonicalWineId: resolvedCanonical, tasting: pending);
          ref.invalidate(myExpertTastingProvider(resolvedCanonical));
        }
      } catch (_) {
        // Non-fatal — wine save already succeeded.
      }
    }

    // Persist any moments the user drafted before saving. Each draft
    // becomes one WineMemoryEntity + N WineMemoryPhotoEntity rows
    // under the freshly-created wineId. Failures here are non-fatal:
    // the wine is already saved; orphaned drafts are easier to lose
    // than to wedge the save flow.
    if (_drafts.isNotEmpty) {
      try {
        final memoryRepo = ref.read(wineMemoryRepositoryProvider);
        final photoRepo = ref.read(wineMemoryPhotoRepositoryProvider);
        for (final d in _drafts) {
          final now = DateTime.now();
          await memoryRepo.addMemory(
            WineMemoryEntity(
              id: d.id,
              wineId: wineId,
              userId: userId,
              imageUrl: d.primaryPhotoUrl,
              caption: d.caption,
              createdAt: now,
              occurredAt: d.occurredAt,
              occasion: d.occasion,
              placeName: d.placeName,
              placeLat: d.placeLat,
              placeLng: d.placeLng,
              foodPaired: d.foodPaired,
              companionUserIds: d.companionUserIds,
              note: d.note,
              visibility: d.visibility,
              updatedAt: now,
            ),
          );
          if (d.photoUrls.isNotEmpty) {
            await photoRepo.addPhotos([
              for (var i = 0; i < d.photoUrls.length; i++)
                WineMemoryPhotoEntity(
                  id: const Uuid().v4(),
                  memoryId: d.id,
                  storagePath: d.photoUrls[i],
                  position: i,
                  createdAt: now,
                ),
            ]);
          }
        }
      } catch (_) {
        // Swallow — wine save already succeeded.
      }
    }

    if (!mounted) return;
    setState(() => _allowPop = true);
    // Nudge to share before bouncing back to the list. Sheet always
    // dismisses (share, "Maybe later", or drag) so the post-save pop
    // still runs whatever the user chose.
    await showWineSharePromptSheet(
      context: context,
      wine: wine,
      triggerSource: 'wine_add_post_save',
    );
    // After the share nudge clears, surface the one-time review soft ask
    // for users who've created enough wines to have an opinion.
    if (mounted) {
      final reviewCtrl = ref.read(reviewPromptControllerProvider.notifier);
      if (reviewCtrl.shouldPrompt()) {
        await reviewCtrl.markSurfaced();
        if (mounted) await showReviewPromptSheet(context: context);
      }
    }
    if (mounted) context.pop();
  }

  Future<_DupeAction> _showDuplicatePrompt(String existingName) async {
    final l10n = AppLocalizations.of(context);
    final result = await showDialog<_DupeAction>(
      context: context,
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return AlertDialog(
          title: Text(l10n.winesAddDuplicateTitle),
          content: Text(l10n.winesAddDuplicateBody(existingName)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, _DupeAction.cancel),
              child: Text(l10n.winesAddDuplicateCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, _DupeAction.addAnyway),
              child: Text(
                l10n.winesAddDuplicateAddAnyway,
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, _DupeAction.openExisting),
              child: Text(l10n.winesAddDuplicateOpenExisting),
            ),
          ],
        );
      },
    );
    return result ?? _DupeAction.cancel;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopScope(
      canPop: _allowPop || !_isDirty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final ok = await _confirmDiscard();
        if (!ok || !mounted) return;
        setState(() => _allowPop = true);
        // ignore: use_build_context_synchronously
        context.pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              WineForm(
                key: _formKey,
                submitLabel: l10n.winesAddSaveLabel,
                showInlineSubmit: false,
                onChanged: (data) => setState(() => _current = data),
                onSubmit: (_) => _save(),
                momentsHook: _MomentsAddHook(
                  drafts: _drafts.map(_draftAsEntity).toList(),
                  onAdd: _addMomentDraft,
                  onEdit: _editMomentDraft,
                ),
              ),
              Positioned(
                right: context.paddingH,
                bottom: context.m,
                child: _SaveWineFab(
                  onPressed: () => _formKey.currentState?.submit(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _FloatingBackButton(
          onPressed: () async {
            final ok = await _confirmDiscard();
            if (!ok || !mounted) return;
            setState(() => _allowPop = true);
            // ignore: use_build_context_synchronously
            context.pop();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _FloatingBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'wine-add-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}

/// Mirrors the wine_detail moments section visually — uppercase MOMENTS
/// header + bento mosaic. Receives the drafted-but-not-yet-saved
/// moments so the user sees them as real tiles while filling in the
/// rest of the wine. Tap a placeholder → [onAdd] (new draft); tap a
/// real tile → [onEdit] (re-open in moment_capture).
class _MomentsAddHook extends StatelessWidget {
  final List<WineMemoryEntity> drafts;
  final VoidCallback onAdd;
  final ValueChanged<int> onEdit;

  const _MomentsAddHook({
    required this.drafts,
    required this.onAdd,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
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
                onTap: onAdd,
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
            memories: drafts,
            wineId: '',
            viewerEnabled: false,
            onAdd: onAdd,
            onMemoryTap: onEdit,
          ),
        ),
      ],
    );
  }
}

enum _DupeAction { cancel, openExisting, addAnyway }

class _SaveWineFab extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveWineFab({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final height = context.w * 0.16;
    return SizedBox(
      height: height,
      child: FloatingActionButton.extended(
        heroTag: 'wine-add-save',
        onPressed: onPressed,
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 4,
        extendedIconLabelSpacing: context.w * 0.025,
        extendedPadding: EdgeInsets.symmetric(horizontal: context.w * 0.06),
        shape: const StadiumBorder(),
        icon: Icon(PhosphorIconsBold.check, size: context.w * 0.05),
        label: Text(
          l10n.winesAddSaveLabel,
          style: TextStyle(
            fontSize: context.bodyFont * 1.02,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
