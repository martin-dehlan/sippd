import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/inline_error.widget.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../../paywall/controller/paywall.provider.dart';
import '../../controller/expert_tasting.provider.dart';
import '../../data/data_sources/expert_tasting.api.dart';
import '../../domain/entities/expert_tasting.entity.dart';
import '../../domain/entities/wine.entity.dart';
import 'expert_rating_panel.widget.dart';

/// Result of a [showWineRatingSheet] commit. [pendingExpert] is set
/// only when the user typed expert dimensions during the *initial*
/// wine creation flow — the wine doesn't yet have a canonical id, so
/// the sheet can't write to `wine_ratings_extended` itself. The caller
/// (wine_form → wine_add) is then responsible for resolving the
/// canonical id after the wine is saved and writing the dimensions.
/// In every other context (existing wine, tasting, group) the sheet
/// has saved the dimensions inline and [pendingExpert] is null.
class WineRatingResult {
  const WineRatingResult({required this.rating, this.pendingExpert});
  final double rating;
  final ExpertTastingEntity? pendingExpert;
}

/// Single source of truth for personal + tasting wine rating UX. Lean
/// editorial layout (handle, eyebrow, wine name, big hero number,
/// slider) with an optional Pro expert tasting panel that expands
/// inline. Caller persists the basic rating (its target table differs
/// per context — wines.rating, tasting_ratings.rating, etc.) via
/// [onSave]; expert dimensions are persisted internally to
/// `wine_ratings_extended` keyed by [ratingContext] + optional
/// [groupId] / [tastingId] when the wine already has a canonical id.
/// During initial wine creation the canonical id doesn't exist yet,
/// so the dimensions are returned via [WineRatingResult.pendingExpert]
/// for the caller to persist after the wine row lands.
///
/// Returns null if the user dismissed without committing.
Future<WineRatingResult?> showWineRatingSheet({
  required BuildContext context,
  required double initial,
  required String ratingContext,
  WineEntity? wine,
  WineType? wineType,
  ExpertTastingEntity? initialExpert,
  Future<void> Function(double rating)? onSave,
  String? groupId,
  String? tastingId,
}) {
  return showModalBottomSheet<WineRatingResult>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.06),
      ),
    ),
    builder: (ctx) => _WineRatingSheet(
      wine: wine,
      wineType: wineType ?? wine?.type ?? WineType.red,
      initial: initial,
      initialExpert: initialExpert,
      ratingContext: ratingContext,
      groupId: groupId,
      tastingId: tastingId,
      onSave: onSave,
    ),
  );
}

class _WineRatingSheet extends ConsumerStatefulWidget {
  const _WineRatingSheet({
    required this.wine,
    required this.wineType,
    required this.initial,
    required this.initialExpert,
    required this.ratingContext,
    required this.groupId,
    required this.tastingId,
    required this.onSave,
  });

  final WineEntity? wine;
  final WineType wineType;
  final double initial;
  final ExpertTastingEntity? initialExpert;
  final String ratingContext;
  final String? groupId;
  final String? tastingId;
  final Future<void> Function(double rating)? onSave;

  @override
  ConsumerState<_WineRatingSheet> createState() => _WineRatingSheetState();
}

class _WineRatingSheetState extends ConsumerState<_WineRatingSheet> {
  late double _value = widget.initial.clamp(0.0, 10.0);
  bool _expertExpanded = false;
  bool _expertLoading = false;
  late bool _aromasExpanded =
      (widget.initialExpert?.aromaTags ?? const []).isNotEmpty;
  bool _saving = false;
  late ExpertTastingEntity _tasting =
      widget.initialExpert ?? const ExpertTastingEntity();
  // True once the server fetch for this sheet's session has completed.
  // Subsequent collapse/expand cycles reuse the in-memory _tasting so any
  // edits the user already typed survive — the previous always-refetch
  // behaviour silently overwrote them with whatever was on the server.
  // Pre-seeded entries (initialExpert) also flip this true so the sheet
  // doesn't try to fetch over them.
  late bool _expertLoaded = widget.initialExpert != null;

  String? get _canonicalId => widget.wine?.canonicalWineId;
  String get _paywallSource => 'expert_tasting_${widget.ratingContext}';

  Future<void> _toggleExpert() async {
    final isPro = ref.read(isProProvider);
    if (!isPro) {
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      context.push(AppRoutes.paywall, extra: {'source': _paywallSource});
      return;
    }

    if (_expertExpanded) {
      setState(() => _expertExpanded = false);
      return;
    }

    // Re-expand after a collapse: keep the locally-typed _tasting; only
    // fetch from server the first time the panel opens this session.
    // Same path applies pre-canonical (no row to fetch) — the in-memory
    // entity is the source of truth until the wine is saved.
    if (_expertLoaded || _canonicalId == null) {
      setState(() {
        _expertExpanded = true;
        _expertLoaded = true;
      });
      return;
    }

    setState(() {
      _expertExpanded = true;
      _expertLoading = true;
    });
    final api = ExpertTastingApi(ref.read(supabaseClientProvider));
    final existing = await api.getMine(
      canonicalWineId: _canonicalId!,
      context: widget.ratingContext,
      groupId: widget.groupId,
      tastingId: widget.tastingId,
    );
    if (!mounted) return;
    setState(() {
      _tasting = existing ?? const ExpertTastingEntity();
      _aromasExpanded = (existing?.aromaTags ?? const []).isNotEmpty;
      _expertLoading = false;
      _expertLoaded = true;
    });
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    HapticFeedback.lightImpact();
    ExpertTastingEntity? pending;
    try {
      // Caller's basic rating write — wines.rating / tasting_ratings /
      // group_wine_ratings, depending on the context.
      await widget.onSave?.call(_value);
      // Expert dims persist via wine_ratings_extended; only fires when
      // the panel was expanded AND the wine already has a canonical id.
      // For initial wine creation the canonical id doesn't exist yet,
      // so the dimensions come back through WineRatingResult for the
      // caller to write after the wine row lands.
      if (_expertExpanded) {
        if (_canonicalId != null) {
          final api = ExpertTastingApi(ref.read(supabaseClientProvider));
          await api.upsert(
            canonicalWineId: _canonicalId!,
            tasting: _tasting,
            context: widget.ratingContext,
            groupId: widget.groupId,
            tastingId: widget.tastingId,
          );
          // Refresh the wine-detail summary that reads the same row.
          ref.invalidate(myExpertTastingProvider(_canonicalId!));
        } else if (!_tasting.isEmpty) {
          pending = _tasting;
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              describeAppError(e, fallback: l10n.winesRatingSheetSaveError),
            ),
          ),
        );
      }
    }
    if (mounted) {
      setState(() => _saving = false);
      Navigator.of(
        context,
      ).pop(WineRatingResult(rating: _value, pendingExpert: pending));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final isPro = ref.watch(isProProvider);
    final wine = widget.wine;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH,
        vertical: context.m,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.m),
            // Always show the chip — the tap handler surfaces a "save the
            // wine first" snackbar when canonical id is missing. Hiding it
            // pre-save makes the initial rating sheet look stripped-down
            // compared to the tasting rating sheet for the same wine.
            YourRatingHeader(
              showChip: true,
              isPro: isPro,
              expanded: _expertExpanded,
              onChipTap: _toggleExpert,
            ),
            if (wine != null) ...[
              SizedBox(height: context.xs),
              Text(
                wine.name,
                style: GoogleFonts.playfairDisplay(
                  fontSize: context.titleFont * 0.9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                  height: 1.1,
                  color: cs.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            SizedBox(height: context.l),
            Center(
              child: _Hero(value: _value, cs: cs),
            ),
            SizedBox(height: context.m),
            _Slider(
              value: _value,
              onChanged: (v) => setState(() => _value = v),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: _expertExpanded
                  ? ExpertRatingPanel(
                      loading: _expertLoading,
                      wineType: widget.wineType,
                      tasting: _tasting,
                      aromasExpanded: _aromasExpanded,
                      onTastingChange: (t) => setState(() => _tasting = t),
                      onToggleAromas: () =>
                          setState(() => _aromasExpanded = !_aromasExpanded),
                    )
                  : const SizedBox(width: double.infinity),
            ),
            SizedBox(height: context.l),
            SizedBox(
              height: context.h * 0.065,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(
                  elevation: 0,
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w * 0.045),
                  ),
                ),
                child: _saving
                    ? SizedBox(
                        width: context.w * 0.045,
                        height: context.w * 0.045,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.onPrimary,
                        ),
                      )
                    : Text(
                        l10n.winesRatingSheetSaveCta,
                        style: TextStyle(
                          fontSize: context.bodyFont * 1.05,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            SizedBox(height: context.s),
            Center(
              child: TextButton(
                onPressed: _saving ? null : () => Navigator.pop(context),
                child: Text(
                  l10n.winesRatingSheetCancel,
                  style: TextStyle(
                    fontSize: context.bodyFont * 0.95,
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.value, required this.cs});
  final double value;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value.toStringAsFixed(1),
          style: GoogleFonts.playfairDisplay(
            fontSize: context.titleFont * 2.2,
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
            height: 1,
            fontFeatures: tabularFigures,
          ),
        ),
        SizedBox(width: context.w * 0.015),
        Text(
          AppLocalizations.of(context).winesFormStatRatingUnit,
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4,
        activeTrackColor: cs.primary,
        inactiveTrackColor: cs.outlineVariant,
        thumbColor: cs.primary,
        overlayColor: cs.primary.withValues(alpha: 0.12),
        valueIndicatorColor: cs.primary,
        valueIndicatorTextStyle: TextStyle(
          fontSize: context.bodyFont,
          color: cs.onPrimary,
          fontWeight: FontWeight.w700,
        ),
        showValueIndicator: ShowValueIndicator.onDrag,
      ),
      child: Slider(
        min: 0,
        max: 10,
        divisions: 20,
        value: value,
        label: value.toStringAsFixed(1),
        onChanged: onChanged,
      ),
    );
  }
}
