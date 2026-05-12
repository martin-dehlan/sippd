import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../../../../common/errors/app_error.dart';
import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';
import '../../../../../auth/controller/auth.provider.dart';
import '../../../../../paywall/controller/paywall.provider.dart';
import '../../../../../profile/presentation/widgets/profile_avatar.widget.dart';
import '../../../../../wines/controller/wine.provider.dart';
import '../../../../../wines/data/data_sources/expert_tasting.api.dart';
import '../../../../../wines/domain/entities/expert_tasting.entity.dart';
import '../../../../../wines/domain/entities/wine.entity.dart';
import '../../../../../wines/presentation/widgets/expert_rating_panel.widget.dart';
import '../../../../controller/group.provider.dart';
import '../../../../domain/entities/group_wine_rating.entity.dart';

Future<void> showGroupWineRatingSheet({
  required BuildContext context,
  required String groupId,
  required WineEntity wine,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.06),
      ),
    ),
    builder: (_) => _Sheet(groupId: groupId, wine: wine),
  );
}

class _Sheet extends ConsumerStatefulWidget {
  final String groupId;
  final WineEntity wine;
  const _Sheet({required this.groupId, required this.wine});

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  double? _myRating;
  double? _savedRating;
  String _savedNotes = '';
  final _notesController = TextEditingController();
  bool _saving = false;
  bool _loaded = false;
  bool _justSaved = false;
  Object? _saveError;
  Timer? _savedTimer;
  bool _expertExpanded = false;
  bool _expertLoading = false;
  bool _aromasExpanded = false;
  ExpertTastingEntity _tasting = const ExpertTastingEntity();
  ExpertTastingEntity _savedTasting = const ExpertTastingEntity();
  // First-fetch latch — see wine_rating_sheet for rationale. Without it
  // every collapse/re-expand re-pulls from the server and overwrites the
  // user's locally-typed dimensions before they hit Save.
  bool _expertLoaded = false;

  @override
  void initState() {
    super.initState();
    _notesController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _savedTimer?.cancel();
    _notesController.removeListener(_onTextChanged);
    _notesController.dispose();
    super.dispose();
  }

  bool get _isOwner {
    final uid = ref.read(currentUserIdProvider);
    return uid != null && uid == widget.wine.userId;
  }

  Future<void> _toggleExpert() async {
    final canonicalId = widget.wine.canonicalWineId;
    if (canonicalId == null) {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.groupWineRatingSaveFirstSnack)),
      );
      return;
    }
    final isPro = ref.read(isProProvider);
    if (!isPro) {
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      context.push(
        AppRoutes.paywall,
        extra: const {'source': 'expert_tasting_group'},
      );
      return;
    }
    if (_expertExpanded) {
      setState(() => _expertExpanded = false);
      return;
    }
    if (_expertLoaded) {
      setState(() => _expertExpanded = true);
      return;
    }
    setState(() {
      _expertExpanded = true;
      _expertLoading = true;
    });
    final api = ExpertTastingApi(ref.read(supabaseClientProvider));
    final existing = await api.getMine(
      canonicalWineId: canonicalId,
      context: 'group',
      groupId: widget.groupId,
    );
    if (!mounted) return;
    setState(() {
      _tasting = existing ?? const ExpertTastingEntity();
      _savedTasting = _tasting;
      _aromasExpanded = (existing?.aromaTags ?? const []).isNotEmpty;
      _expertLoading = false;
      _expertLoaded = true;
    });
  }

  Future<void> _save() async {
    if (_myRating == null || _saving) return;
    setState(() {
      _saving = true;
      _saveError = null;
    });
    HapticFeedback.selectionClick();
    try {
      final notes = _notesController.text.trim();
      // Owners ALSO need a group_wine_ratings row — otherwise drinking
      // partners / shared bottles can't see them (those features only
      // count group / tasting context). Personal rating still rides on
      // wines.rating so the wine_detail summary stays in sync.
      if (_isOwner) {
        final fresh =
            await ref
                .read(wineRepositoryProvider)
                .getWineById(widget.wine.id) ??
            widget.wine;
        final updated = fresh.copyWith(
          rating: _myRating!,
          notes: notes.isEmpty ? fresh.notes : notes,
          updatedAt: DateTime.now(),
        );
        await ref.read(wineControllerProvider.notifier).updateWine(updated);
        ref.invalidate(groupWinesProvider(widget.groupId));
        ref.invalidate(wineDetailProvider(widget.wine.id));
      }
      final canonicalId = widget.wine.canonicalWineId;
      if (canonicalId == null) {
        throw Exception('Wine has no canonical identity yet — try again.');
      }
      await ref
          .read(groupWineRatingControllerProvider.notifier)
          .upsertRating(
            groupId: widget.groupId,
            canonicalWineId: canonicalId,
            rating: _myRating!,
            notes: notes.isEmpty ? null : notes,
          );
      ref.invalidate(groupWineRatingsProvider(widget.groupId, canonicalId));
      // Expert dims piggyback on the same save tap. Persisted only when
      // the user expanded the panel during this sheet open — collapsed
      // means "didn't engage with expert", same convention as the
      // unified wine rating sheet.
      if (_expertExpanded) {
        final api = ExpertTastingApi(ref.read(supabaseClientProvider));
        await api.upsert(
          canonicalWineId: canonicalId,
          tasting: _tasting,
          context: 'group',
          groupId: widget.groupId,
        );
      }
      if (mounted) {
        HapticFeedback.lightImpact();
        setState(() {
          _savedRating = _myRating;
          _savedNotes = notes;
          _savedTasting = _tasting;
          _justSaved = true;
        });
        _savedTimer?.cancel();
        _savedTimer = Timer(const Duration(milliseconds: 1500), () {
          if (mounted) setState(() => _justSaved = false);
        });
      }
    } catch (e) {
      if (mounted) setState(() => _saveError = e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    setState(() => _saving = true);
    try {
      // Removes only the group_wine_ratings row. Owners' personal
      // wines.rating is left intact — that's still their general
      // opinion of the wine, even if they no longer want to surface
      // their group-context rating.
      final canonicalId = widget.wine.canonicalWineId;
      if (canonicalId == null) return;
      await ref
          .read(groupWineRatingControllerProvider.notifier)
          .deleteRating(groupId: widget.groupId, canonicalWineId: canonicalId);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirmUnshare() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.groupWineRatingUnshareDialogTitle),
        content: Text(
          l10n.groupWineRatingUnshareDialogBody(widget.wine.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.groupWineRatingUnshareCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.groupWineRatingUnshareConfirm,
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() {
      _saving = true;
      _saveError = null;
    });
    try {
      final canonicalId = widget.wine.canonicalWineId;
      if (canonicalId == null) {
        throw Exception('Wine has no canonical identity yet.');
      }
      await ref
          .read(groupControllerProvider.notifier)
          .unshareWineFromGroup(
            groupId: widget.groupId,
            canonicalWineId: canonicalId,
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) setState(() => _saveError = e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserIdProvider);
    final canonicalId = widget.wine.canonicalWineId ?? widget.wine.id;
    final ratingsAsync = ref.watch(
      groupWineRatingsProvider(widget.groupId, canonicalId),
    );

    if (!_loaded) {
      if (userId == widget.wine.userId) {
        final localAsync = ref.watch(wineDetailProvider(widget.wine.id));
        localAsync.whenData((local) {
          final source = local ?? widget.wine;
          _myRating = source.rating;
          _savedRating = source.rating;
          _notesController.text = source.notes ?? '';
          _savedNotes = source.notes ?? '';
          _loaded = true;
        });
      } else {
        ratingsAsync.whenData((list) {
          final mine = list.where((r) => r.userId == userId).firstOrNull;
          if (mine != null) {
            _myRating = mine.rating;
            _savedRating = mine.rating;
            _notesController.text = mine.notes ?? '';
            _savedNotes = mine.notes ?? '';
          }
          _loaded = true;
        });
      }
    }

    final hasExistingRating =
        _loaded &&
        ratingsAsync.valueOrNull?.any((r) => r.userId == userId) == true;

    final isDirty =
        _myRating != null &&
        (_myRating != _savedRating ||
            _notesController.text.trim() != _savedNotes.trim() ||
            (_expertExpanded && _tasting != _savedTasting));

    return Padding(
      padding: EdgeInsets.only(
        left: context.paddingH,
        right: context.paddingH,
        top: context.m,
        bottom: MediaQuery.of(context).viewInsets.bottom + context.xl,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _GrabHandle(),
            SizedBox(height: context.m),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _Header(wine: widget.wine)),
                _UnshareMenu(
                  groupId: widget.groupId,
                  canonicalWineId: canonicalId,
                  onRemove: _saving ? null : _confirmUnshare,
                ),
              ],
            ),
            SizedBox(height: context.m),
            const _SectionDivider(),
            SizedBox(height: context.m),
            _GroupZone(ratingsAsync: ratingsAsync, currentUserId: userId),
            SizedBox(height: context.m),
            const _SectionDivider(),
            SizedBox(height: context.m),
            YourRatingHeader(
              // Mirror the unified rating sheet — chip is always visible
              // and the tap handler shows a "save the wine first" snackbar
              // when canonical id is missing.
              showChip: true,
              isPro: ref.watch(isProProvider),
              expanded: _expertExpanded,
              onChipTap: _toggleExpert,
            ),
            SizedBox(height: context.s),
            _RateZone(
              rating: _myRating,
              enabled: !_saving,
              onChanged: (v) => setState(() => _myRating = v),
              notesController: _notesController,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: _expertExpanded
                  ? ExpertRatingPanel(
                      loading: _expertLoading,
                      wineType: widget.wine.type,
                      tasting: _tasting,
                      aromasExpanded: _aromasExpanded,
                      onTastingChange: (t) => setState(() => _tasting = t),
                      onToggleAromas: () =>
                          setState(() => _aromasExpanded = !_aromasExpanded),
                    )
                  : const SizedBox(width: double.infinity),
            ),
            SizedBox(height: context.l),
            _SaveButton(
              enabled: (isDirty || _saveError != null) && !_saving,
              saving: _saving,
              justSaved: _justSaved,
              error: _saveError,
              onTap: _save,
            ),
            if (hasExistingRating) ...[
              SizedBox(height: context.s),
              _RemoveButton(onTap: _saving ? null : _delete),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 1,
      color: cs.outlineVariant.withValues(alpha: 0.7),
    );
  }
}

class _GrabHandle extends StatelessWidget {
  const _GrabHandle();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        width: context.w * 0.1,
        height: context.xs,
        decoration: BoxDecoration(
          color: cs.outlineVariant,
          borderRadius: BorderRadius.circular(context.xs),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final WineEntity wine;
  const _Header({required this.wine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          wine.name,
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            height: 1.15,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (wine.winery != null && wine.winery!.isNotEmpty) ...[
          SizedBox(height: context.xs),
          Text(
            wine.winery!,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

class _RateZone extends StatelessWidget {
  final double? rating;
  final bool enabled;
  final ValueChanged<double> onChanged;
  final TextEditingController notesController;
  const _RateZone({
    required this.rating,
    required this.enabled,
    required this.onChanged,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Spacer(),
            Text(
              rating?.toStringAsFixed(1) ?? '—',
              style: TextStyle(
                fontSize: context.titleFont * 0.95,
                fontWeight: FontWeight.w800,
                color: cs.primary,
                height: 1,
                letterSpacing: -0.6,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            SizedBox(width: context.xs * 0.8),
            Text(
              '/10',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: context.xs),
        _Slider(value: rating, enabled: enabled, onChanged: onChanged),
        SizedBox(height: context.s),
        _NotesField(controller: notesController, enabled: enabled),
      ],
    );
  }
}

class _Slider extends StatelessWidget {
  final double? value;
  final bool enabled;
  final ValueChanged<double> onChanged;
  const _Slider({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: context.xs * 2.2,
        activeTrackColor: cs.primary,
        inactiveTrackColor: cs.surfaceContainer,
        // Match enabled colors so the brief disabled flash during save
        // doesn't visibly recolor the track / thumb.
        disabledActiveTrackColor: cs.primary,
        disabledInactiveTrackColor: cs.surfaceContainer,
        disabledThumbColor: cs.primary,
        thumbColor: cs.primary,
        overlayColor: cs.primary.withValues(alpha: 0.12),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: context.w * 0.04),
        overlayShape: RoundSliderOverlayShape(overlayRadius: context.w * 0.065),
        trackShape: const RoundedRectSliderTrackShape(),
        showValueIndicator: ShowValueIndicator.never,
      ),
      child: Slider(
        value: value ?? 5.0,
        min: 0,
        max: 10,
        onChanged: enabled ? (v) => onChanged((v * 2).round() / 2) : null,
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  const _NotesField({required this.controller, required this.enabled});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return TextField(
      controller: controller,
      enabled: enabled,
      maxLines: 2,
      minLines: 1,
      maxLength: 200,
      style: TextStyle(fontSize: context.captionFont),
      decoration: InputDecoration(
        hintText: l10n.groupWineRatingNotesHint,
        hintStyle: TextStyle(color: cs.outline, fontSize: context.captionFont),
        counterText: '',
        filled: true,
        fillColor: cs.surfaceContainer,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.s * 1.5,
          vertical: context.s * 1.2,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide(color: cs.primary, width: 1.2),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool enabled;
  final bool saving;
  final bool justSaved;
  final Object? error;
  final VoidCallback onTap;
  const _SaveButton({
    required this.enabled,
    required this.saving,
    required this.justSaved,
    required this.onTap,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final hasError = error != null;
    final label = hasError
        ? (error is OfflineError || error is NetworkError
              ? l10n.groupWineRatingOfflineRetry
              : l10n.groupWineRatingSaveFailedRetry)
        : (justSaved ? l10n.groupWineRatingSaved : l10n.groupWineRatingSaveCta);
    return SizedBox(
      height: context.h * 0.055,
      child: FilledButton(
        onPressed: enabled ? onTap : null,
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: hasError ? cs.errorContainer : null,
          foregroundColor: hasError ? cs.onErrorContainer : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.w * 0.04),
            side: hasError
                ? BorderSide(color: cs.error.withValues(alpha: 0.4), width: 1)
                : BorderSide.none,
          ),
        ),
        child: saving
            ? SizedBox(
                width: context.w * 0.05,
                height: context.w * 0.05,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: cs.onPrimary,
                ),
              )
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Text(
                  label,
                  key: ValueKey(label),
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _RemoveButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Center(
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: context.m,
            vertical: context.xs,
          ),
        ),
        child: Text(
          l10n.groupWineRatingRemoveMine,
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.error,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _GroupZone extends StatelessWidget {
  final AsyncValue<List<GroupWineRatingEntity>> ratingsAsync;
  final String? currentUserId;
  const _GroupZone({required this.ratingsAsync, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final raw = ratingsAsync.valueOrNull ?? const <GroupWineRatingEntity>[];
    final sorted = [...raw]..sort((a, b) => b.rating.compareTo(a.rating));
    final isSoloMe =
        sorted.length == 1 &&
        currentUserId != null &&
        sorted.first.userId == currentUserId;
    final showBars = sorted.isNotEmpty && !isSoloMe;
    final avg = sorted.isEmpty
        ? null
        : sorted.map((r) => r.rating).reduce((a, b) => a + b) / sorted.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              sorted.isEmpty
                  ? 'Ratings'
                  : sorted.length == 1
                  ? '1 rating'
                  : '${sorted.length} ratings',
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
                letterSpacing: 0.3,
              ),
            ),
            const Spacer(),
            if (avg != null && sorted.length > 1) ...[
              Text(
                'avg ',
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant,
                ),
              ),
              Text(
                avg.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: context.s * 1.4),
        ratingsAsync.when(
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          data: (_) {
            if (sorted.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: context.s),
                child: Text(
                  'Be the first to rate',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.outline,
                  ),
                ),
              );
            }
            if (!showBars) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: context.s),
                child: Text(
                  "You're the first · invite others to rate",
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.outline,
                  ),
                ),
              );
            }
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: context.h * 0.32),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: sorted.length,
                separatorBuilder: (_, _) => SizedBox(height: context.s * 1.4),
                itemBuilder: (_, i) => _RankingBar(
                  key: ValueKey(sorted[i].userId),
                  r: sorted[i],
                  isMe: sorted[i].userId == currentUserId,
                  isFirst: i == 0,
                ),
              ),
            );
          },
          loading: () => Padding(
            padding: EdgeInsets.symmetric(vertical: context.s),
            child: SizedBox(
              height: context.w * 0.05,
              width: context.w * 0.05,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          error: (_, _) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _RankingBar extends StatelessWidget {
  final GroupWineRatingEntity r;
  final bool isMe;
  final bool isFirst;
  const _RankingBar({
    super.key,
    required this.r,
    required this.isMe,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final name = r.username ?? r.displayName ?? r.userId.substring(0, 6);
    final pct = (r.rating / 10).clamp(0.0, 1.0);
    final barH = context.w * 0.08;
    final avatarSize = barH;
    final fillColor = isMe
        ? cs.primary
        : isFirst
        ? cs.tertiary
        : cs.onSurfaceVariant.withValues(alpha: 0.35);

    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (_, c) {
              final trackW = c.maxWidth;
              return TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 550),
                curve: Curves.easeOutCubic,
                tween: Tween(begin: 0.0, end: pct),
                builder: (_, animPct, _) {
                  final fillW = (trackW * animPct).clamp(avatarSize, trackW);
                  final avatarLeft = (fillW - avatarSize).clamp(
                    0.0,
                    trackW - avatarSize,
                  );
                  return SizedBox(
                    width: trackW,
                    height: barH,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: cs.surfaceContainer,
                              borderRadius: BorderRadius.circular(barH / 2),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          width: fillW,
                          child: Container(
                            decoration: BoxDecoration(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(barH / 2),
                            ),
                          ),
                        ),
                        Positioned(
                          left: avatarLeft,
                          top: 0,
                          bottom: 0,
                          width: avatarSize,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cs.surface,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: ClipOval(
                              child: ProfileAvatar(
                                avatarUrl: r.avatarUrl,
                                fallbackText: name,
                                size: avatarSize - 6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(width: context.s),
        SizedBox(
          width: context.w * 0.1,
          child: Text(
            r.rating.toStringAsFixed(1),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w800,
              color: isMe ? cs.primary : cs.onSurfaceVariant,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}

class _UnshareMenu extends ConsumerWidget {
  final String groupId;
  final String canonicalWineId;
  final VoidCallback? onRemove;

  const _UnshareMenu({
    required this.groupId,
    required this.canonicalWineId,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(currentUserIdProvider);
    if (uid == null) return const SizedBox.shrink();

    final sharedBy = ref
        .watch(groupWineShareMetaProvider(groupId, canonicalWineId))
        .valueOrNull;
    final group = ref
        .watch(groupControllerProvider)
        .valueOrNull
        ?.where((g) => g.id == groupId)
        .firstOrNull;
    final isSharer = sharedBy != null && sharedBy == uid;
    final isOwner = group != null && group.createdBy == uid;
    if (!isSharer && !isOwner) return const SizedBox.shrink();

    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<bool>(
      icon: Icon(
        PhosphorIconsRegular.dotsThree,
        size: context.w * 0.055,
        color: cs.outline,
      ),
      tooltip: l10n.groupWineRatingMoreTooltip,
      padding: EdgeInsets.zero,
      color: cs.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      onSelected: (_) => onRemove?.call(),
      itemBuilder: (_) => [
        PopupMenuItem<bool>(
          // PopupMenuButton's onSelected only fires for non-null values —
          // a void/null-valued item pops as null and routes through
          // onCanceled instead, silently swallowing the tap.
          value: true,
          enabled: onRemove != null,
          child: Row(
            children: [
              Icon(
                PhosphorIconsRegular.minusCircle,
                size: context.w * 0.045,
                color: cs.error,
              ),
              SizedBox(width: context.s),
              Text(
                l10n.groupWineRatingUnshareMenu,
                style: TextStyle(color: cs.error),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
