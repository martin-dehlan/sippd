import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/price_format.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../../common/widgets/overflow_menu.widget.dart';
import '../../../../../common/data/wine_regions.dart';
import '../../../../../common/widgets/price_input_sheet.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../friends/controller/friends.provider.dart';
import '../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../friends/presentation/widgets/friend_multi_picker.widget.dart';
import '../../../../groups/presentation/widgets/share_wine_sheet.dart';
import '../../../../paywall/controller/paywall.provider.dart';
import '../../../../profile/controller/profile.provider.dart';
import '../../../../promo/promo.config.dart';
import '../../../../promo/presentation/demo_reveal.widget.dart';
import '../../../../promo/presentation/demo_spotlight.widget.dart';
import '../../../../share_cards/controller/share_card.provider.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/expert_tasting_sheet.dart';
import '../../widgets/expert_tasting_summary.widget.dart';
import '../../widgets/friend_ratings_strip.widget.dart';
import '../../widgets/moments_bento.widget.dart';
import '../../widgets/wine_country_picker.widget.dart';
import '../../widgets/wine_detail_blocks.widget.dart';
import '../../widgets/wine_rating_sheet.dart';
import '../../widgets/wine_region_picker.widget.dart';
import '../moment_capture/moment_capture.screen.dart';
import '../wine_compare/wine_compare_flow.dart';

class WineDetailScreen extends ConsumerWidget {
  final String wineId;
  final WineEntity? initial;

  const WineDetailScreen({super.key, required this.wineId, this.initial});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineAsync = ref.watch(wineDetailProvider(wineId));
    final currentUserId = ref.watch(currentUserIdProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: wineAsync.when(
        data: (wine) {
          // Local lookup may miss for wines owned by other group members.
          // Fall back to the entity passed via go_router extra.
          final resolved = wine ?? initial;
          if (resolved == null) {
            return Center(child: Text(l10n.winesDetailNotFound));
          }
          final isOwner = resolved.userId == currentUserId;
          return WineDetailBody(
            wine: resolved,
            isOwner: isOwner,
            onDelete: isOwner
                ? () async {
                    await ref
                        .read(wineControllerProvider.notifier)
                        .deleteWine(wineId);
                    if (context.mounted) Navigator.pop(context);
                  }
                : null,
          );
        },
        loading: () {
          if (initial != null) {
            return WineDetailBody(
              wine: initial!,
              isOwner: initial!.userId == currentUserId,
              onDelete: null,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
        error: (e, _) {
          if (initial != null) {
            return WineDetailBody(
              wine: initial!,
              isOwner: initial!.userId == currentUserId,
              onDelete: null,
            );
          }
          return Center(
            child: ErrorView(title: l10n.winesDetailErrorLoad, error: e),
          );
        },
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class WineDetailBody extends ConsumerStatefulWidget {
  final WineEntity wine;
  final bool isOwner;
  final VoidCallback? onDelete;

  const WineDetailBody({
    super.key,
    required this.wine,
    required this.isOwner,
    required this.onDelete,
  });

  @override
  ConsumerState<WineDetailBody> createState() => _WineDetailBodyState();
}

class _WineDetailBodyState extends ConsumerState<WineDetailBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
    _animController.forward();
    if (kIsDemo) _runDemoBeats();
  }

  /// Demo only: after the entrance settles, spotlight each hero feature once
  /// (image → rating → price → origin), then briefly reveal the deeper edit
  /// menus (rating sheet, then price sheet) so the tour shows them too. The
  /// busy flag keeps the auto-tour from navigating away mid-sequence.
  Future<void> _runDemoBeats() async {
    demoScreenBusy.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    for (var beat = 0; beat <= 3; beat++) {
      if (!mounted) return _endDemoBeats();
      demoDetailBeat.value = beat;
      await Future<void>.delayed(const Duration(milliseconds: 1150));
    }

    // Tap the rating, then the price — reveal the deeper menus, auto-closed.
    if (widget.isOwner) {
      if (!mounted) return _endDemoBeats();
      demoDetailBeat.value = 1;
      // ignore: use_build_context_synchronously
      final ratingFuture = showWineRatingSheet(
        context: context,
        initial: widget.wine.rating,
        ratingContext: 'personal',
        wine: widget.wine,
        wineType: widget.wine.type,
      );
      await Future<void>.delayed(const Duration(milliseconds: 2400));
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      await ratingFuture;

      if (!mounted) return _endDemoBeats();
      await Future<void>.delayed(const Duration(milliseconds: 500));
      demoDetailBeat.value = 2;
      final priceFuture = showPriceInputSheet(
        // ignore: use_build_context_synchronously
        context: context,
        initial: widget.wine.price,
      );
      await Future<void>.delayed(const Duration(milliseconds: 2200));
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      await priceFuture;
    }

    _endDemoBeats();
  }

  void _endDemoBeats() {
    if (mounted) demoDetailBeat.value = null;
    demoScreenBusy.value = false;
  }

  @override
  void dispose() {
    demoDetailBeat.value = null;
    demoScreenBusy.value = false;
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasCoords =
        widget.wine.latitude != null && widget.wine.longitude != null;

    return SafeArea(
      child: FadeTransition(
        opacity: _fadeIn,
        child: SlideTransition(
          position: _slideUp,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: context.xl * 1.5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: WineDetailTitle(name: widget.wine.name)),
                  if (widget.isOwner)
                    Padding(
                      padding: EdgeInsets.only(right: context.paddingH * 0.7),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Consumer(
                            builder: (context, ref, _) => _WineOverflowMenu(
                              onCompare: () => startCompareFlow(
                                context,
                                sourceWineId: widget.wine.id,
                              ),
                              onShareToGroup: () => showShareWineSheet(
                                context: context,
                                wineId: widget.wine.id,
                              ),
                              onShareToFriend: () =>
                                  _shareToFriend(context, ref),
                              onShareImage: () {
                                final username = ref
                                    .read(currentProfileProvider)
                                    .valueOrNull
                                    ?.username;
                                ref
                                    .read(shareCardProvider)
                                    .shareWineRatingCard(
                                      context: context,
                                      wine: widget.wine,
                                      username: username,
                                      source: 'wine_detail',
                                    );
                              },
                              onEdit: () => context.push(
                                AppRoutes.wineEditPath(widget.wine.id),
                              ),
                              onDelete: () => _confirmDelete(context),
                              onTastingNotes: () {
                                final isPro = ref.read(isProProvider);
                                if (!isPro) {
                                  context.push(
                                    AppRoutes.paywall,
                                    extra: const {'source': 'expert_tasting'},
                                  );
                                  return;
                                }
                                showExpertTastingSheet(
                                  context: context,
                                  wine: widget.wine,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: context.s),
              WineDetailMetaLine(
                type: widget.wine.type,
                winery: widget.wine.winery,
                vintage: widget.wine.vintage,
                canonicalGrapeId: widget.wine.canonicalGrapeId,
                grapeFreetext: widget.wine.grapeFreetext,
                legacyGrape: widget.wine.grape,
              ),
              SizedBox(height: context.l),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.paddingH),
                child: SizedBox(
                  height: context.h * 0.26,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: DemoBeatHighlight(
                          beat: 0,
                          activeScale: 1.1,
                          child: DemoReveal(
                            delay: const Duration(milliseconds: 520),
                            fromScale: 0.82,
                            child: WineDetailImage(wine: widget.wine),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: _StatsColumn(
                          wine: widget.wine,
                          isOwner: widget.isOwner,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Rating-app priority: rating depth (notes + expert
              // tasting + friend ratings) sits directly after the
              // hero so the wine's identity reads first. Moments are
              // the memory/journal layer — they live below the rating
              // story, before places.
              if (widget.wine.notes != null &&
                  widget.wine.notes!.isNotEmpty) ...[
                SizedBox(height: context.xl),
                WineDetailSectionHeader(
                  label: AppLocalizations.of(context).winesDetailSectionNotes,
                ),
                SizedBox(height: context.m),
                _NotesBlock(notes: widget.wine.notes!),
              ],
              if (widget.wine.canonicalWineId != null) ...[
                SizedBox(height: context.xl),
                // Read-only display of the user's own expert tasting
                // dimensions for this wine. Renders nothing when empty,
                // so non-Pro / unfilled wines stay clean.
                ExpertTastingSummary(
                  canonicalWineId: widget.wine.canonicalWineId!,
                  onEdit: () {
                    final isPro = ref.read(isProProvider);
                    if (!isPro) {
                      context.push(
                        AppRoutes.paywall,
                        extra: const {'source': 'expert_tasting_summary'},
                      );
                      return;
                    }
                    showExpertTastingSheet(context: context, wine: widget.wine);
                  },
                ),
                SizedBox(height: context.l),
                FriendRatingsStrip(
                  canonicalWineId: widget.wine.canonicalWineId!,
                ),
              ],
              _MemoriesSection(wine: widget.wine),
              SizedBox(height: context.xl),
              WineDetailSectionHeader(
                label: AppLocalizations.of(context).winesDetailSectionPlace,
              ),
              SizedBox(height: context.s),
              SizedBox(
                height: context.h * 0.28,
                child: _PlaceSection(wine: widget.wine, hasCoords: hasCoords),
              ),
              SizedBox(height: context.xxl * 1.5),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareToFriend(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final selected = await showFriendMultiPicker(
      context: context,
      initialSelected: const {},
      title: l10n.winesSharePickFriendsTitle,
    );
    if (selected == null || selected.isEmpty || !context.mounted) return;

    final friends =
        ref.read(friendsListProvider).valueOrNull ??
        const <FriendProfileEntity>[];
    final byId = {for (final f in friends) f.id: f};
    final repo = ref.read(wineRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    final sharedNames = <String>[];
    for (final friendId in selected) {
      try {
        await repo.shareToFriend(friendId: friendId, wineId: widget.wine.id);
        final f = byId[friendId];
        sharedNames.add(
          f?.displayName ?? f?.username ?? friendId.substring(0, 6),
        );
      } catch (_) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.winesShareError)));
        return;
      }
    }
    if (sharedNames.isNotEmpty) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.winesShareSuccess(sharedNames.join(', ')))),
      );
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.winesDetailDeleteTitle),
        content: Text(l10n.winesDetailDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.winesDetailDeleteCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.winesDetailDeleteConfirm,
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) widget.onDelete?.call();
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
        heroTag: 'wine-detail-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => Navigator.pop(context),
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}

class _WineOverflowMenu extends StatelessWidget {
  final VoidCallback onCompare;
  final VoidCallback onShareToGroup;
  final VoidCallback onShareToFriend;
  final VoidCallback onShareImage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTastingNotes;

  const _WineOverflowMenu({
    required this.onCompare,
    required this.onShareToGroup,
    required this.onShareToFriend,
    required this.onShareImage,
    required this.onEdit,
    required this.onDelete,
    this.onTastingNotes,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return OverflowMenu(
      circleBackground: true,
      groups: [
        [
          OverflowMenuItem(
            icon: PhosphorIconsRegular.swap,
            label: l10n.winesDetailMenuCompare,
            onTap: onCompare,
          ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.megaphoneSimple,
            label: l10n.winesDetailMenuShareRating,
            onTap: onShareImage,
          ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.usersThree,
            label: l10n.winesDetailMenuShareToGroup,
            onTap: onShareToGroup,
          ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.userPlus,
            label: l10n.winesShareToFriend,
            onTap: onShareToFriend,
          ),
        ],
        [
          OverflowMenuItem(
            icon: PhosphorIconsRegular.pencilSimple,
            label: l10n.winesDetailMenuEdit,
            onTap: onEdit,
          ),
          if (onTastingNotes != null)
            OverflowMenuItem(
              icon: PhosphorIconsRegular.notebook,
              label: l10n.winesDetailMenuTastingNotesPro,
              onTap: onTastingNotes!,
            ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.trash,
            label: l10n.winesDetailMenuDelete,
            destructive: true,
            onTap: onDelete,
          ),
        ],
      ],
    );
  }
}

class _StatsColumn extends ConsumerWidget {
  final WineEntity wine;
  final bool isOwner;
  const _StatsColumn({required this.wine, required this.isOwner});

  Future<void> _editRating(BuildContext context, WidgetRef ref) async {
    final result = await showWineRatingSheet(
      context: context,
      initial: wine.rating,
      ratingContext: 'personal',
      wine: wine,
      wineType: wine.type,
    );
    if (result == null) return;
    await ref
        .read(wineControllerProvider.notifier)
        .updateWine(
          wine.copyWith(rating: result.rating, updatedAt: DateTime.now()),
        );
    ref.invalidate(wineDetailProvider(wine.id));
  }

  Future<void> _editPrice(BuildContext context, WidgetRef ref) async {
    final result = await showPriceInputSheet(
      context: context,
      initial: wine.price,
    );
    if (result == null) return;
    final parsed = result.isEmpty
        ? null
        : double.tryParse(result.replaceAll(',', '.'));
    await ref
        .read(wineControllerProvider.notifier)
        .updateWine(wine.copyWith(price: parsed, updatedAt: DateTime.now()));
    ref.invalidate(wineDetailProvider(wine.id));
  }

  void _editOrigin(BuildContext context, WidgetRef ref) {
    showWineCountryPicker(
      context: context,
      selected: wine.country,
      onChanged: (c) async {
        final countryChanged = c != wine.country;
        await ref
            .read(wineControllerProvider.notifier)
            .updateWine(
              wine.copyWith(
                country: c,
                region: countryChanged ? null : wine.region,
                updatedAt: DateTime.now(),
              ),
            );
        ref.invalidate(wineDetailProvider(wine.id));
        if (c != null && hasRegionsFor(c) && context.mounted) {
          Future.microtask(() {
            if (!context.mounted) return;
            showWineRegionPicker(
              context: context,
              country: c,
              selected: countryChanged ? null : wine.region,
              onChanged: (r) async {
                await ref
                    .read(wineControllerProvider.notifier)
                    .updateWine(
                      wine.copyWith(region: r, updatedAt: DateTime.now()),
                    );
                ref.invalidate(wineDetailProvider(wine.id));
              },
            );
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _StatItem(
            label: l10n.winesDetailStatRating,
            value: wine.rating.toStringAsFixed(1),
            unit: l10n.winesDetailStatRatingUnit,
            onTap: isOwner ? () => _editRating(context, ref) : null,
            revealDelay: const Duration(milliseconds: 700),
            beat: 1,
          ),
          SizedBox(height: context.l),
          if (wine.price != null) ...[
            _StatItem(
              label: l10n.winesDetailStatPrice,
              value: formatPrice(wine.price!),
              unit: wine.currency,
              onTap: isOwner ? () => _editPrice(context, ref) : null,
              revealDelay: const Duration(milliseconds: 820),
              beat: 2,
            ),
            SizedBox(height: context.l),
          ] else if (isOwner) ...[
            _StatItem(
              label: l10n.winesDetailStatPrice,
              value: '—',
              isText: true,
              onTap: () => _editPrice(context, ref),
            ),
            SizedBox(height: context.l),
          ],
          if (wine.region != null)
            _StatItem(
              label: l10n.winesDetailStatRegion,
              value: wine.region!,
              isText: true,
              onTap: isOwner ? () => _editOrigin(context, ref) : null,
              revealDelay: const Duration(milliseconds: 940),
              beat: 3,
            )
          else if (wine.country != null)
            _StatItem(
              label: l10n.winesDetailStatCountry,
              value: wine.country!,
              isText: true,
              onTap: isOwner ? () => _editOrigin(context, ref) : null,
              revealDelay: const Duration(milliseconds: 940),
              beat: 3,
            )
          else if (isOwner)
            _StatItem(
              label: l10n.winesDetailStatCountry,
              value: '—',
              isText: true,
              onTap: () => _editOrigin(context, ref),
            ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final bool isText;
  final VoidCallback? onTap;

  /// Demo-only: staggers this stat's pop-in so rating/price/region
  /// highlight one after another. Ignored in production.
  final Duration revealDelay;

  /// Demo-only: the tour's feature-beat index this stat lights up on.
  final int? beat;

  const _StatItem({
    required this.label,
    required this.value,
    this.unit,
    this.isText = false,
    this.onTap,
    this.revealDelay = Duration.zero,
    this.beat,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: context.captionFont * 0.95,
            fontWeight: FontWeight.w700,
            color: cs.onSurface.withValues(alpha: 0.72),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: context.xs * 0.3),
        if (isText)
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: context.headingFont * 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unit != null) ...[
                SizedBox(width: context.w * 0.01),
                Text(
                  unit!,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
      ],
    );
    final result = onTap == null
        ? column
        : InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(context.w * 0.02),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.xs),
              child: column,
            ),
          );
    final highlighted = beat == null
        ? result
        : DemoBeatHighlight(beat: beat!, child: result);
    return DemoReveal(delay: revealDelay, child: highlighted);
  }
}

class _NotesBlock extends StatelessWidget {
  final String notes;
  const _NotesBlock({required this.notes});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 2, color: cs.outlineVariant),
            SizedBox(width: context.w * 0.035),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.xs),
                child: Text(
                  notes,
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.02,
                    height: 1.55,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceSection extends ConsumerStatefulWidget {
  final WineEntity wine;
  final bool hasCoords;

  const _PlaceSection({required this.wine, required this.hasCoords});

  @override
  ConsumerState<_PlaceSection> createState() => _PlaceSectionState();
}

class _PlaceSectionState extends ConsumerState<_PlaceSection>
    with TickerProviderStateMixin {
  late final MapController _mapCtrl = MapController();
  // Track the active mark so its pill reads as selected. -1 = whole
  // bounds (default). Tapping a pill flies the camera + selects.
  int _selectedIndex = -1;
  AnimationController? _flyCtrl;

  @override
  void dispose() {
    _flyCtrl?.dispose();
    _mapCtrl.dispose();
    super.dispose();
  }

  /// Smooth camera fly from current center+zoom to the target. Drops
  /// any in-flight animation so back-to-back pill taps feel snappy.
  void _flyTo(LatLng target, double zoom) {
    _flyCtrl?.dispose();
    final start = _mapCtrl.camera.center;
    final startZoom = _mapCtrl.camera.zoom;
    final ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    final latTween = Tween<double>(begin: start.latitude, end: target.latitude);
    final lngTween = Tween<double>(
      begin: start.longitude,
      end: target.longitude,
    );
    final zoomTween = Tween<double>(begin: startZoom, end: zoom);
    final anim = CurvedAnimation(parent: ctrl, curve: Curves.easeOutCubic);
    anim.addListener(() {
      _mapCtrl.move(
        LatLng(latTween.evaluate(anim), lngTween.evaluate(anim)),
        zoomTween.evaluate(anim),
      );
    });
    _flyCtrl = ctrl;
    ctrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final memoriesAsync = ref.watch(
      wineMemoriesControllerProvider(widget.wine.id),
    );
    final momentPoints = (memoriesAsync.valueOrNull ?? const [])
        .where((m) => m.placeLat != null && m.placeLng != null)
        .toList();

    final winePoint = widget.hasCoords
        ? LatLng(widget.wine.latitude!, widget.wine.longitude!)
        : null;

    if (winePoint == null && momentPoints.isEmpty) {
      return _EmptyPlace(location: widget.wine.location);
    }

    final palette = <Color>[
      cs.primary,
      cs.tertiary,
      const Color(0xFFE3A6BA),
      const Color(0xFFB7C7DC),
      const Color(0xFFE8D9A1),
      cs.secondary,
    ];
    final marks = <_PlaceMark>[
      if (winePoint != null)
        _PlaceMark(
          label: widget.wine.location ?? '',
          point: winePoint,
          color: palette[0],
          glyph: PhosphorIconsFill.wine,
        ),
      for (var i = 0; i < momentPoints.length; i++)
        _PlaceMark(
          label: momentPoints[i].placeName ?? '·',
          point: LatLng(momentPoints[i].placeLat!, momentPoints[i].placeLng!),
          color: palette[(i + 1) % palette.length],
          number: i + 1,
        ),
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.paddingH),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapCtrl,
            options: MapOptions(
              initialCameraFit: marks.length == 1
                  ? null
                  : CameraFit.bounds(
                      bounds: LatLngBounds.fromPoints(
                        marks.map((m) => m.point).toList(),
                      ),
                      padding: EdgeInsets.all(context.w * 0.1),
                    ),
              initialCenter: marks.first.point,
              initialZoom: 14,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'xyz.sippd.app',
              ),
              MarkerLayer(
                markers: [
                  for (var i = 0; i < marks.length; i++)
                    Marker(
                      point: marks[i].point,
                      width: context.w * (i == _selectedIndex ? 0.095 : 0.075),
                      height: context.w * (i == _selectedIndex ? 0.095 : 0.075),
                      alignment: Alignment.bottomCenter,
                      child: _MapPin(
                        mark: marks[i],
                        selected: i == _selectedIndex,
                      ),
                    ),
                ],
              ),
            ],
          ),
          // Bottom pill row — tap a pill to fly the camera to its pin.
          Positioned(
            left: context.s,
            right: context.s,
            bottom: context.m,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: context.s),
              child: Row(
                children: [
                  for (var i = 0; i < marks.length; i++) ...[
                    if (i != 0) SizedBox(width: context.xs * 1.5),
                    _PlacePill(
                      mark: marks[i],
                      selected: i == _selectedIndex,
                      onTap: () {
                        setState(() => _selectedIndex = i);
                        _flyTo(marks[i].point, 15);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceMark {
  final String label;
  final LatLng point;
  final Color color;
  final IconData? glyph;
  final int? number;

  const _PlaceMark({
    required this.label,
    required this.point,
    required this.color,
    this.glyph,
    this.number,
  });
}

class _MapPin extends StatelessWidget {
  final _PlaceMark mark;
  final bool selected;
  const _MapPin({required this.mark, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: mark.color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: selected ? 3 : 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: selected ? 0.45 : 0.25),
            blurRadius: selected ? 8 : 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: mark.glyph != null
          ? Icon(
              mark.glyph,
              color: Colors.white,
              size: context.w * (selected ? 0.046 : 0.04),
            )
          : Text(
              '${mark.number}',
              style: TextStyle(
                color: Colors.white,
                fontSize: context.w * (selected ? 0.038 : 0.034),
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
    );
  }
}

class _PlacePill extends StatelessWidget {
  final _PlaceMark mark;
  final bool selected;
  final VoidCallback onTap;
  const _PlacePill({
    required this.mark,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final label = mark.label.isEmpty ? '·' : mark.label;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(context.w * 0.05),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: context.s,
            vertical: context.xs,
          ),
          decoration: BoxDecoration(
            color: selected ? mark.color : cs.surface.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(context.w * 0.05),
            border: Border.all(
              color: selected ? mark.color : cs.outlineVariant,
              width: selected ? 1.5 : 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: context.w * 0.05,
                height: context.w * 0.05,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : mark.color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: mark.glyph != null
                    ? Icon(
                        mark.glyph,
                        color: selected ? mark.color : Colors.white,
                        size: context.w * 0.03,
                      )
                    : Text(
                        '${mark.number}',
                        style: TextStyle(
                          color: selected ? mark.color : Colors.white,
                          fontSize: context.w * 0.025,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
              ),
              SizedBox(width: context.xs * 1.5),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.w * 0.4),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : cs.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemoriesSection extends ConsumerWidget {
  final WineEntity wine;
  const _MemoriesSection({required this.wine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineId = wine.id;
    final memoriesAsync = ref.watch(wineMemoriesControllerProvider(wineId));
    final memories = memoriesAsync.valueOrNull ?? const [];
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final padH = context.paddingH * 1.3;

    // New moments on an existing wine start with an empty place — the
    // wine's "first sip" location is just the bottle's anchor, not a
    // default for every subsequent moment.
    void openCapture() => pushMomentCapture(context, ref, wineId: wineId);

    return Padding(
      padding: EdgeInsets.only(top: context.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header row matches WineDetailSectionHeader styling (dim
          // tracked uppercase) so the section sits in the same visual
          // tier as TASTING-NOTES / ORTE. Add affordance is a quiet
          // + glyph at the trailing edge — same colour as the label,
          // not a primary pill.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padH),
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
            padding: EdgeInsets.symmetric(horizontal: padH),
            child: MomentsBento(
              memories: memories,
              wineId: wineId,
              onAdd: openCapture,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPlace extends StatelessWidget {
  final String? location;
  const _EmptyPlace({required this.location});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.paddingH),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIconsRegular.mapTrifold,
              size: context.w * 0.12,
              color: cs.outline,
            ),
            SizedBox(height: context.s),
            Text(
              location ?? AppLocalizations.of(context).winesDetailPlaceEmpty,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
