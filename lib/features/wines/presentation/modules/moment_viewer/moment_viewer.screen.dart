import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine_memory.entity.dart';
import '../../../domain/entities/wine_memory_photo.entity.dart';
import '../moment_capture/moment_capture.screen.dart';

/// Instagram Stories-style fullscreen moment viewer. Horizontal swipe
/// moves between moments; tap left/right of the screen navigates
/// photos within the active moment. Progress segments at the top
/// reflect photo count for the moment currently in view. Bottom
/// gradient holds caption + meta; top-right ⋯ exposes edit/delete/
/// showcase actions.
Future<void> pushMomentViewer(
  BuildContext context, {
  required String wineId,
  required List<WineMemoryEntity> moments,
  required int initialIndex,
}) {
  return Navigator.of(context, rootNavigator: true).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, _, _) => MomentViewerScreen(
        wineId: wineId,
        moments: moments,
        initialIndex: initialIndex,
      ),
      transitionsBuilder: (_, anim, _, child) =>
          FadeTransition(opacity: anim, child: child),
    ),
  );
}

class MomentViewerScreen extends ConsumerStatefulWidget {
  const MomentViewerScreen({
    super.key,
    required this.wineId,
    required this.moments,
    required this.initialIndex,
  });

  final String wineId;
  final List<WineMemoryEntity> moments;
  final int initialIndex;

  @override
  ConsumerState<MomentViewerScreen> createState() => _MomentViewerScreenState();
}

class _MomentViewerScreenState extends ConsumerState<MomentViewerScreen> {
  late final PageController _momentCtrl;
  late int _momentIndex;
  // Per-moment photo cursor so swiping back to a moment resumes where
  // the user left off, IG-style.
  final Map<String, int> _photoCursor = {};

  @override
  void initState() {
    super.initState();
    _momentIndex = widget.initialIndex;
    _momentCtrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _momentCtrl.dispose();
    super.dispose();
  }

  void _advancePhoto(int delta, List<WineMemoryPhotoEntity> photos) {
    final m = widget.moments[_momentIndex];
    final current = _photoCursor[m.id] ?? 0;
    final next = current + delta;
    if (next < 0) {
      if (_momentIndex > 0) {
        _momentCtrl.previousPage(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
        );
      }
      return;
    }
    if (next >= photos.length) {
      if (_momentIndex < widget.moments.length - 1) {
        _momentCtrl.nextPage(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
        );
      }
      return;
    }
    setState(() => _photoCursor[m.id] = next);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        // Swipe down to dismiss.
        onVerticalDragEnd: (d) {
          if ((d.primaryVelocity ?? 0) > 200) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            top: false,
            child: PageView.builder(
              controller: _momentCtrl,
              itemCount: widget.moments.length,
              onPageChanged: (i) => setState(() => _momentIndex = i),
              itemBuilder: (_, i) {
                final moment = widget.moments[i];
                final photosAsync = ref.watch(_photosFamilyProvider(moment.id));
                return photosAsync.when(
                  data: (photos) => _MomentPage(
                    moment: moment,
                    photos: _resolvePhotos(moment, photos),
                    photoIndex: _photoCursor[moment.id] ?? 0,
                    onTapLeft: () =>
                        _advancePhoto(-1, _resolvePhotos(moment, photos)),
                    onTapRight: () =>
                        _advancePhoto(1, _resolvePhotos(moment, photos)),
                    onClose: () => Navigator.of(context).pop(),
                    onMenu: () => _openMenu(moment, photos),
                  ),
                  loading: () => _MomentPage(
                    moment: moment,
                    photos: _legacyOnly(moment),
                    photoIndex: 0,
                    onTapLeft: () {},
                    onTapRight: () {},
                    onClose: () => Navigator.of(context).pop(),
                    onMenu: () {},
                  ),
                  error: (_, _) => _MomentPage(
                    moment: moment,
                    photos: _legacyOnly(moment),
                    photoIndex: 0,
                    onTapLeft: () {},
                    onTapRight: () {},
                    onClose: () => Navigator.of(context).pop(),
                    onMenu: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Photos from `wine_memory_photos` are authoritative when present.
  /// When the moment was created in the legacy single-photo era and
  /// has no sibling rows yet, fall back to the inline `imageUrl` /
  /// `localImagePath` cols so older entries still render.
  List<WineMemoryPhotoEntity> _resolvePhotos(
    WineMemoryEntity moment,
    List<WineMemoryPhotoEntity> photos,
  ) {
    if (photos.isNotEmpty) return photos;
    return _legacyOnly(moment);
  }

  List<WineMemoryPhotoEntity> _legacyOnly(WineMemoryEntity moment) {
    final legacy = moment.imageUrl ?? moment.localImagePath;
    if (legacy == null) return const [];
    return [
      WineMemoryPhotoEntity(
        id: 'legacy-${moment.id}',
        memoryId: moment.id,
        storagePath: legacy,
        position: 0,
        createdAt: moment.createdAt,
      ),
    ];
  }

  Future<void> _openMenu(
    WineMemoryEntity moment,
    List<WineMemoryPhotoEntity> photos,
  ) async {
    final l10n = AppLocalizations.of(context);
    final action = await showModalBottomSheet<_MenuAction>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(PhosphorIconsRegular.pencilSimple),
              title: Text(l10n.momentEdit),
              onTap: () => Navigator.pop(ctx, _MenuAction.edit),
            ),
            ListTile(
              leading: const Icon(PhosphorIconsRegular.star),
              title: Text(l10n.momentUseAsShowcase),
              enabled: photos.isNotEmpty || moment.imageUrl != null,
              onTap: () => Navigator.pop(ctx, _MenuAction.showcase),
            ),
            ListTile(
              leading: Icon(
                PhosphorIconsRegular.trash,
                color: Theme.of(ctx).colorScheme.error,
              ),
              title: Text(
                l10n.momentDelete,
                style: TextStyle(color: Theme.of(ctx).colorScheme.error),
              ),
              onTap: () => Navigator.pop(ctx, _MenuAction.delete),
            ),
          ],
        ),
      ),
    );
    if (action == null || !mounted) return;
    switch (action) {
      case _MenuAction.edit:
        await pushMomentCapture(
          context,
          wineId: widget.wineId,
          existing: moment,
          existingPhotos: photos,
        );
      case _MenuAction.delete:
        final confirmed = await _confirmDelete();
        if (!confirmed || !mounted) return;
        await ref.read(wineMemoryRepositoryProvider).deleteMemory(moment.id);
        if (mounted) Navigator.of(context).pop();
      case _MenuAction.showcase:
        final url = photos.isNotEmpty
            ? photos.first.storagePath
            : moment.imageUrl;
        if (url == null) return;
        final wine = await ref
            .read(wineRepositoryProvider)
            .getWineById(widget.wineId);
        if (wine == null) return;
        await ref
            .read(wineControllerProvider.notifier)
            .updateWine(wine.copyWith(imageUrl: url, localImagePath: null));
    }
  }

  Future<bool> _confirmDelete() async {
    final l10n = AppLocalizations.of(context);
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.momentDeleteConfirmTitle),
        content: Text(l10n.momentDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.winesMemoriesRemoveCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.momentDelete,
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

enum _MenuAction { edit, delete, showcase }

/// Lazily-built family provider so each moment page subscribes to its
/// own photos stream. Lives at file-scope as a manual StreamProvider
/// to keep this viewer self-contained without touching wine.provider.
final _photosFamilyProvider = StreamProvider.autoDispose
    .family<List<WineMemoryPhotoEntity>, String>((ref, memoryId) {
      return ref
          .watch(wineMemoryPhotoRepositoryProvider)
          .watchByMemory(memoryId);
    });

class _MomentPage extends StatelessWidget {
  final WineMemoryEntity moment;
  final List<WineMemoryPhotoEntity> photos;
  final int photoIndex;
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
  final VoidCallback onClose;
  final VoidCallback onMenu;

  const _MomentPage({
    required this.moment,
    required this.photos,
    required this.photoIndex,
    required this.onTapLeft,
    required this.onTapRight,
    required this.onClose,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    final activePhoto = photos.isEmpty || photoIndex >= photos.length
        ? null
        : photos[photoIndex];
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (d) {
              final w = MediaQuery.of(context).size.width;
              if (d.localPosition.dx < w / 2) {
                onTapLeft();
              } else {
                onTapRight();
              }
            },
            child: Center(
              child: activePhoto == null
                  ? Icon(
                      PhosphorIconsRegular.image,
                      color: Colors.white.withValues(alpha: 0.4),
                      size: 80,
                    )
                  : InteractiveViewer(
                      minScale: 1,
                      maxScale: 4,
                      child: _photoImage(activePhoto.storagePath),
                    ),
            ),
          ),
        ),
        // Progress segments for photos in this moment
        if (photos.length > 1)
          Positioned(
            top: MediaQuery.paddingOf(context).top + context.s,
            left: context.m,
            right: context.m,
            child: Row(
              children: [
                for (var i = 0; i < photos.length; i++) ...[
                  Expanded(
                    child: Container(
                      height: 2.5,
                      decoration: BoxDecoration(
                        color: i <= photoIndex ? Colors.white : Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  if (i != photos.length - 1) const SizedBox(width: 3),
                ],
              ],
            ),
          ),
        // Top-right close + menu
        Positioned(
          top: MediaQuery.paddingOf(context).top + context.s,
          right: context.s,
          child: Row(
            children: [
              _Glyph(icon: PhosphorIconsRegular.dotsThree, onTap: onMenu),
              SizedBox(width: context.xs),
              _Glyph(icon: PhosphorIconsRegular.x, onTap: onClose),
            ],
          ),
        ),
        // Bottom meta overlay
        if (_hasMeta(moment))
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.85),
                  ],
                ),
              ),
              padding: EdgeInsets.only(
                left: context.paddingH,
                right: context.paddingH,
                top: context.xl,
                bottom: MediaQuery.paddingOf(context).bottom + context.m,
              ),
              child: _MetaLine(moment: moment),
            ),
          ),
      ],
    );
  }

  bool _hasMeta(WineMemoryEntity m) =>
      (m.note ?? m.caption)?.isNotEmpty == true ||
      (m.placeName?.isNotEmpty ?? false) ||
      (m.foodPaired?.isNotEmpty ?? false) ||
      (m.occasion?.isNotEmpty ?? false);

  Widget _photoImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.contain);
    }
    return Image.asset(path, fit: BoxFit.contain);
  }
}

class _Glyph extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _Glyph({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.s),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: context.w * 0.055),
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  final WineMemoryEntity moment;
  const _MetaLine({required this.moment});

  @override
  Widget build(BuildContext context) {
    final caption = (moment.note ?? moment.caption)?.trim();
    final pieces = <String>[
      if (moment.placeName?.isNotEmpty ?? false) moment.placeName!,
      if (moment.foodPaired?.isNotEmpty ?? false) '🍴 ${moment.foodPaired}',
    ];
    final meta = pieces.join(' · ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (caption != null && caption.isNotEmpty)
          Text(
            caption,
            style: TextStyle(
              color: Colors.white,
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        if (meta.isNotEmpty) ...[
          SizedBox(height: context.xs),
          Text(
            meta,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: context.captionFont,
            ),
          ),
        ],
      ],
    );
  }
}
