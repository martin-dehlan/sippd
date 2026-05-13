import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/photo_error.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine_memory.entity.dart';
import '../../../domain/entities/wine_memory_photo.entity.dart';

/// Opens the moment capture flow. Lean photo-first surface modeled on
/// Instagram Stories: picker fires immediately, full-bleed preview
/// with a thin caption overlay, single save action. Heavier context
/// fields (occasion / place / food / companions) move to an edit menu
/// reachable from the story viewer — capture itself stays minimal.
///
/// New-moment flow shows the source picker FIRST (over the calling
/// screen) and only pushes the capture page once a photo is in hand,
/// so the user never sees an empty black canvas behind the bottom
/// sheet. Edit flow skips the picker and goes straight in.
///
/// Returns true if at least one moment was saved.
Future<bool?> pushMomentCapture(
  BuildContext context,
  WidgetRef ref, {
  required String wineId,
  WineMemoryEntity? existing,
  List<WineMemoryPhotoEntity> existingPhotos = const [],
}) async {
  String? initialUrl;
  if (existing == null && existingPhotos.isEmpty) {
    // Source picker over the caller, not over an empty capture page.
    final source = await _showSourceSheet(context);
    if (source == null) return false;
    if (!context.mounted) return false;
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
        requestFullMetadata: false,
      );
      if (picked == null) return false;
      final userId = ref.read(currentUserIdProvider);
      final svc = ref.read(wineImageServiceProvider);
      if (userId == null || svc == null) return false;
      initialUrl = await svc.uploadImage(userId: userId, filePath: picked.path);
    } catch (e) {
      if (context.mounted) await PhotoErrorHandler.handle(context, e);
      return false;
    }
  }
  if (!context.mounted) return false;
  return Navigator.of(context, rootNavigator: true).push<bool>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => MomentCaptureScreen(
        wineId: wineId,
        existing: existing,
        existingPhotos: existingPhotos,
        initialPhotoUrl: initialUrl,
      ),
    ),
  );
}

Future<ImageSource?> _showSourceSheet(BuildContext ctx) {
  final l10n = AppLocalizations.of(ctx);
  return showModalBottomSheet<ImageSource>(
    context: ctx,
    backgroundColor: Theme.of(ctx).colorScheme.surface,
    builder: (sheetCtx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(PhosphorIconsRegular.camera),
            title: Text(l10n.winesPhotoSourceTake),
            onTap: () => Navigator.pop(sheetCtx, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(PhosphorIconsRegular.image),
            title: Text(l10n.winesPhotoSourceGallery),
            onTap: () => Navigator.pop(sheetCtx, ImageSource.gallery),
          ),
        ],
      ),
    ),
  );
}

class MomentCaptureScreen extends ConsumerStatefulWidget {
  const MomentCaptureScreen({
    super.key,
    required this.wineId,
    this.existing,
    this.existingPhotos = const [],
    this.initialPhotoUrl,
  });

  final String wineId;
  final WineMemoryEntity? existing;
  final List<WineMemoryPhotoEntity> existingPhotos;
  final String? initialPhotoUrl;

  @override
  ConsumerState<MomentCaptureScreen> createState() =>
      _MomentCaptureScreenState();
}

class _MomentCaptureScreenState extends ConsumerState<MomentCaptureScreen> {
  final List<_PhotoSlot> _photos = [];
  final TextEditingController _captionCtrl = TextEditingController();
  int _activeIndex = 0;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _captionCtrl.text = widget.existing?.note ?? '';
    _photos.addAll(
      widget.existingPhotos.map(
        (p) => _PhotoSlot(id: p.id, url: p.storagePath),
      ),
    );
    if (widget.initialPhotoUrl != null) {
      _photos.add(
        _PhotoSlot(id: const Uuid().v4(), url: widget.initialPhotoUrl!),
      );
    }
  }

  @override
  void dispose() {
    _captionCtrl.dispose();
    super.dispose();
  }

  Future<void> _addPhoto() async {
    if (_photos.length >= 10) return;
    final source = await _showSourceSheet(context);
    if (source == null || !mounted) return;
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
        requestFullMetadata: false,
      );
      if (picked == null) return;
      final userId = ref.read(currentUserIdProvider);
      final svc = ref.read(wineImageServiceProvider);
      if (userId == null || svc == null) return;
      final url = await svc.uploadImage(userId: userId, filePath: picked.path);
      if (!mounted) return;
      setState(() {
        _photos.add(_PhotoSlot(id: const Uuid().v4(), url: url));
        _activeIndex = _photos.length - 1;
      });
    } catch (e) {
      if (mounted) await PhotoErrorHandler.handle(context, e);
    }
  }

  void _removeActive() {
    if (_photos.isEmpty) return;
    setState(() {
      _photos.removeAt(_activeIndex);
      if (_activeIndex >= _photos.length) {
        _activeIndex = (_photos.length - 1).clamp(0, _photos.length);
      }
    });
  }

  Future<void> _save() async {
    if (_photos.isEmpty && _captionCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);
    try {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) return;
      final memoryRepo = ref.read(wineMemoryRepositoryProvider);
      final photoRepo = ref.read(wineMemoryPhotoRepositoryProvider);
      final now = DateTime.now();
      final memoryId = widget.existing?.id ?? const Uuid().v4();
      final caption = _captionCtrl.text.trim();
      final entity = WineMemoryEntity(
        id: memoryId,
        wineId: widget.wineId,
        userId: userId,
        // Keep legacy single-photo cols mirrored to first photo for
        // back-compat readers; phase 3 retires them.
        imageUrl: _photos.isNotEmpty ? _photos.first.url : null,
        caption: caption.isEmpty ? null : caption,
        createdAt: widget.existing?.createdAt ?? now,
        occurredAt: widget.existing?.occurredAt ?? now,
        occasion: widget.existing?.occasion,
        placeName: widget.existing?.placeName,
        foodPaired: widget.existing?.foodPaired,
        companionUserIds: widget.existing?.companionUserIds ?? const [],
        note: caption.isEmpty ? null : caption,
        visibility: widget.existing?.visibility ?? 'friends',
        updatedAt: now,
      );
      await memoryRepo.addMemory(entity);

      final photoEntities = <WineMemoryPhotoEntity>[];
      for (var i = 0; i < _photos.length; i++) {
        photoEntities.add(
          WineMemoryPhotoEntity(
            id: _photos[i].id,
            memoryId: memoryId,
            storagePath: _photos[i].url,
            position: i,
            createdAt: now,
          ),
        );
      }
      if (photoEntities.isNotEmpty) await photoRepo.addPhotos(photoEntities);
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final activePhoto = _photos.isEmpty ? null : _photos[_activeIndex];
    final canSave =
        !_saving && (_photos.isNotEmpty || _captionCtrl.text.trim().isNotEmpty);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapUp: (d) {
                    if (_photos.length < 2) return;
                    final w = MediaQuery.of(context).size.width;
                    if (d.localPosition.dx < w / 2) {
                      setState(() {
                        _activeIndex = (_activeIndex - 1).clamp(
                          0,
                          _photos.length - 1,
                        );
                      });
                    } else {
                      setState(() {
                        _activeIndex = (_activeIndex + 1).clamp(
                          0,
                          _photos.length - 1,
                        );
                      });
                    }
                  },
                  child: Center(
                    child: activePhoto == null
                        ? _BlackPlaceholder(label: l10n.momentAddPhoto)
                        : Image.network(activePhoto.url, fit: BoxFit.contain),
                  ),
                ),
              ),
              // Top progress bar segments (IG-style)
              if (_photos.length > 1)
                Positioned(
                  top: MediaQuery.paddingOf(context).top + context.s,
                  left: context.m,
                  right: context.m,
                  child: Row(
                    children: [
                      for (var i = 0; i < _photos.length; i++) ...[
                        Expanded(
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: i <= _activeIndex
                                  ? Colors.white
                                  : Colors.white24,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        if (i != _photos.length - 1) const SizedBox(width: 3),
                      ],
                    ],
                  ),
                ),
              // Top-right close
              Positioned(
                top: MediaQuery.paddingOf(context).top + context.s,
                right: context.s,
                child: _Glyph(
                  icon: PhosphorIconsRegular.x,
                  onTap: () => Navigator.of(context).pop(false),
                ),
              ),
              // Top-left photo remove (only when a photo is active)
              if (activePhoto != null)
                Positioned(
                  top: MediaQuery.paddingOf(context).top + context.s,
                  left: context.s,
                  child: _Glyph(
                    icon: PhosphorIconsRegular.trash,
                    onTap: _removeActive,
                  ),
                ),
              // Bottom overlay — caption + add-more + save
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
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: context.paddingH,
                    right: context.paddingH,
                    top: context.l,
                    bottom: MediaQuery.paddingOf(context).bottom + context.m,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _CaptionInput(controller: _captionCtrl),
                      SizedBox(height: context.m),
                      Row(
                        children: [
                          _SmallChip(
                            icon: PhosphorIconsRegular.plus,
                            label: l10n.momentAddPhoto,
                            onTap: _photos.length >= 10
                                ? null
                                : () => _addPhoto(),
                          ),
                          const Spacer(),
                          FilledButton(
                            onPressed: canSave ? _save : null,
                            child: _saving
                                ? SizedBox(
                                    width: context.w * 0.05,
                                    height: context.w * 0.05,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(l10n.momentSave),
                          ),
                        ],
                      ),
                    ],
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

class _PhotoSlot {
  final String id;
  final String url;
  _PhotoSlot({required this.id, required this.url});
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

class _CaptionInput extends StatelessWidget {
  final TextEditingController controller;
  const _CaptionInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      padding: EdgeInsets.symmetric(horizontal: context.m, vertical: context.s),
      child: TextField(
        controller: controller,
        maxLines: 3,
        minLines: 1,
        maxLength: 1000,
        style: TextStyle(color: Colors.white, fontSize: context.bodyFont),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          isCollapsed: true,
          hintText: l10n.momentNoteHint,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: context.bodyFont,
          ),
        ),
      ),
    );
  }
}

class _SmallChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _SmallChip({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.m,
          vertical: context.s,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(context.w * 0.05),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: context.w * 0.04, color: Colors.white),
            SizedBox(width: context.xs * 1.5),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: context.captionFont,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlackPlaceholder extends StatelessWidget {
  final String label;
  const _BlackPlaceholder({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: context.bodyFont,
        ),
      ),
    );
  }
}
