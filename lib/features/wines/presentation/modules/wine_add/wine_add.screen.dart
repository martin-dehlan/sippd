import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/name_normalizer.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../../share_cards/presentation/widgets/wine_share_prompt_sheet.dart';
import '../../../controller/expert_tasting.provider.dart';
import '../../../controller/wine.provider.dart';
import '../../../data/data_sources/expert_tasting.api.dart';
import '../../../domain/entities/canonical_wine_candidate.entity.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/canonical_wine_prompt_sheet.dart';
import '../../widgets/wine_form.widget.dart';

class WineAddScreen extends ConsumerStatefulWidget {
  const WineAddScreen({super.key});

  @override
  ConsumerState<WineAddScreen> createState() => _WineAddScreenState();
}

class _WineAddScreenState extends ConsumerState<WineAddScreen> {
  final GlobalKey<WineFormState> _formKey = GlobalKey<WineFormState>();
  WineFormData? _current;
  bool _allowPop = false;

  bool get _isDirty {
    final d = _current;
    if (d == null) return false;
    return d.name.isNotEmpty ||
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
        d.localImagePath != null;
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

    if (!mounted) return;
    // Nudge to share before bouncing back to the list. Sheet always
    // dismisses (share, "Maybe later", or drag) so the post-save pop
    // still runs whatever the user chose.
    setState(() => _allowPop = true);
    await showWineSharePromptSheet(
      context: context,
      wine: wine,
      triggerSource: 'wine_add_post_save',
    );
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
