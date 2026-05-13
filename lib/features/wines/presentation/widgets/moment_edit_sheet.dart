import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/photo_error.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../controller/wine.provider.dart';
import '../../domain/entities/wine_memory.entity.dart';
import '../../domain/entities/wine_memory_photo.entity.dart';

/// Opens the moment add/edit sheet. Pass [existing] to enter edit
/// mode; omit for a new moment. Returns true if saved, null/false on
/// dismiss. The sheet persists itself via the moment + photo repos.
Future<bool?> showMomentEditSheet({
  required BuildContext context,
  required String wineId,
  WineMemoryEntity? existing,
  List<WineMemoryPhotoEntity> existingPhotos = const [],
  // Tasting-autofill hooks (used by tasting recap entry).
  String? prefillPlace,
  String? prefillOccasion,
  List<String>? prefillCompanionIds,
  DateTime? prefillOccurredAt,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.06),
      ),
    ),
    builder: (ctx) => _MomentEditSheet(
      wineId: wineId,
      existing: existing,
      existingPhotos: existingPhotos,
      prefillPlace: prefillPlace,
      prefillOccasion: prefillOccasion,
      prefillCompanionIds: prefillCompanionIds,
      prefillOccurredAt: prefillOccurredAt,
    ),
  );
}

const _kOccasionDinner = 'dinner';
const _kOccasionDate = 'date';
const _kOccasionCelebration = 'celebration';
const _kOccasionTasting = 'tasting';
const _kOccasionCasual = 'casual';
const _kOccasionBirthday = 'birthday';

const _kOccasionKeys = [
  _kOccasionDinner,
  _kOccasionDate,
  _kOccasionCelebration,
  _kOccasionTasting,
  _kOccasionCasual,
  _kOccasionBirthday,
];

class _MomentEditSheet extends ConsumerStatefulWidget {
  const _MomentEditSheet({
    required this.wineId,
    required this.existing,
    required this.existingPhotos,
    required this.prefillPlace,
    required this.prefillOccasion,
    required this.prefillCompanionIds,
    required this.prefillOccurredAt,
  });

  final String wineId;
  final WineMemoryEntity? existing;
  final List<WineMemoryPhotoEntity> existingPhotos;
  final String? prefillPlace;
  final String? prefillOccasion;
  final List<String>? prefillCompanionIds;
  final DateTime? prefillOccurredAt;

  @override
  ConsumerState<_MomentEditSheet> createState() => _MomentEditSheetState();
}

class _MomentEditSheetState extends ConsumerState<_MomentEditSheet> {
  // Photo drafts — mix of newly-picked local files + already-persisted
  // photos. New ones get an upload+insert on save; existing ones get
  // re-saved with refreshed positions in case order changed.
  final List<_PhotoDraft> _photos = [];

  late final TextEditingController _placeCtrl;
  late final TextEditingController _foodCtrl;
  late final TextEditingController _noteCtrl;

  String? _occasionKey;
  String _visibility = 'friends';
  late DateTime _occurredAt;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _placeCtrl = TextEditingController(
      text: e?.placeName ?? widget.prefillPlace ?? '',
    );
    _foodCtrl = TextEditingController(text: e?.foodPaired ?? '');
    _noteCtrl = TextEditingController(text: e?.note ?? '');
    _occasionKey = e?.occasion ?? widget.prefillOccasion;
    _visibility = e?.visibility ?? 'friends';
    _occurredAt =
        e?.occurredAt ??
        widget.prefillOccurredAt ??
        e?.createdAt ??
        DateTime.now();
    _photos.addAll(
      widget.existingPhotos.map(
        (p) => _PhotoDraft(id: p.id, storagePath: p.storagePath),
      ),
    );
  }

  @override
  void dispose() {
    _placeCtrl.dispose();
    _foodCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  bool get _canSave {
    final hasPhoto = _photos.isNotEmpty;
    final hasNote = _noteCtrl.text.trim().isNotEmpty;
    return hasPhoto || hasNote;
  }

  Future<void> _pickPhoto() async {
    if (_photos.length >= 10) return;
    final l10n = AppLocalizations.of(context);
    final source = await _pickSource(context, l10n);
    if (source == null || !mounted) return;
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
        requestFullMetadata: false,
      );
      if (picked == null) return;
      final userId = ref.read(currentUserIdProvider);
      final svc = ref.read(wineImageServiceProvider);
      if (svc == null || userId == null) return;
      final url = await svc.uploadImage(userId: userId, filePath: picked.path);
      if (!mounted) return;
      setState(() {
        _photos.add(_PhotoDraft(id: const Uuid().v4(), storagePath: url));
      });
    } catch (e) {
      if (mounted) await PhotoErrorHandler.handle(context, e);
    }
  }

  Future<ImageSource?> _pickSource(
    BuildContext ctx,
    AppLocalizations l10n,
  ) async {
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

  void _removePhoto(String id) {
    setState(() => _photos.removeWhere((p) => p.id == id));
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    if (!_canSave) {
      setState(() => _error = l10n.momentValidationEmpty);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) {
        setState(() => _saving = false);
        return;
      }
      final memoryRepo = ref.read(wineMemoryRepositoryProvider);
      final photoRepo = ref.read(wineMemoryPhotoRepositoryProvider);

      final now = DateTime.now();
      final memoryId = widget.existing?.id ?? const Uuid().v4();
      final entity = WineMemoryEntity(
        id: memoryId,
        wineId: widget.wineId,
        userId: userId,
        // Legacy single-photo cols stay in sync with first photo for
        // back-compat readers; phase 3 will retire them.
        imageUrl: _photos.isNotEmpty ? _photos.first.storagePath : null,
        caption: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        createdAt: widget.existing?.createdAt ?? now,
        occurredAt: _occurredAt,
        occasion: _occasionKey,
        placeName: _placeCtrl.text.trim().isEmpty
            ? null
            : _placeCtrl.text.trim(),
        foodPaired: _foodCtrl.text.trim().isEmpty
            ? null
            : _foodCtrl.text.trim(),
        companionUserIds: widget.prefillCompanionIds ?? const [],
        note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        visibility: _visibility,
        updatedAt: now,
      );

      await memoryRepo.addMemory(entity);

      // Sync photo rows. Existing photos are re-upserted with refreshed
      // positions; new photos already have a storage URL from the
      // picker upload step.
      final photoEntities = <WineMemoryPhotoEntity>[];
      for (var i = 0; i < _photos.length; i++) {
        photoEntities.add(
          WineMemoryPhotoEntity(
            id: _photos[i].id,
            memoryId: memoryId,
            storagePath: _photos[i].storagePath,
            position: i,
            createdAt: now,
          ),
        );
      }
      if (photoEntities.isNotEmpty) {
        await photoRepo.addPhotos(photoEntities);
      }

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = AppLocalizations.of(context).momentSaveError;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final viewInsets = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.m,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: context.h * 0.005,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.m),
            Text(
              widget.existing == null
                  ? l10n.momentSheetNewTitle
                  : l10n.momentSheetEditTitle,
              style: TextStyle(
                fontSize: context.titleFont,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.l),

            _SectionLabel(text: l10n.momentFieldPhotos),
            SizedBox(height: context.s),
            _PhotoStrip(
              photos: _photos,
              onAdd: _photos.length >= 10 ? null : _pickPhoto,
              onRemove: _removePhoto,
            ),
            SizedBox(height: context.l),

            _SectionLabel(text: l10n.momentFieldOccasion),
            SizedBox(height: context.s),
            Wrap(
              spacing: context.w * 0.02,
              runSpacing: context.w * 0.02,
              children: [
                for (final k in _kOccasionKeys)
                  ChoiceChip(
                    label: Text(_occasionLabel(l10n, k)),
                    selected: _occasionKey == k,
                    onSelected: (sel) =>
                        setState(() => _occasionKey = sel ? k : null),
                  ),
              ],
            ),
            SizedBox(height: context.l),

            _SectionLabel(text: l10n.momentFieldPlace),
            SizedBox(height: context.s),
            TextField(
              controller: _placeCtrl,
              decoration: InputDecoration(
                hintText: l10n.momentPlaceHint,
                border: const OutlineInputBorder(),
              ),
              maxLength: 120,
            ),
            SizedBox(height: context.m),

            _SectionLabel(text: l10n.momentFieldFood),
            SizedBox(height: context.s),
            TextField(
              controller: _foodCtrl,
              decoration: InputDecoration(
                hintText: l10n.momentFoodHint,
                border: const OutlineInputBorder(),
              ),
              maxLength: 200,
            ),
            SizedBox(height: context.m),

            _SectionLabel(text: l10n.momentFieldNote),
            SizedBox(height: context.s),
            TextField(
              controller: _noteCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: l10n.momentNoteHint,
                border: const OutlineInputBorder(),
              ),
              maxLength: 1000,
            ),
            SizedBox(height: context.m),

            _SectionLabel(text: l10n.momentFieldVisibility),
            SizedBox(height: context.s),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'friends',
                  label: Text(l10n.momentVisibilityFriends),
                  icon: const Icon(PhosphorIconsRegular.users),
                ),
                ButtonSegment(
                  value: 'private',
                  label: Text(l10n.momentVisibilityPrivate),
                  icon: const Icon(PhosphorIconsRegular.lock),
                ),
              ],
              selected: {_visibility},
              onSelectionChanged: (sel) =>
                  setState(() => _visibility = sel.first),
              showSelectedIcon: false,
            ),
            SizedBox(height: context.l),

            if (_error != null) ...[
              Text(
                _error!,
                style: TextStyle(color: cs.error, fontSize: context.bodyFont),
              ),
              SizedBox(height: context.s),
            ],

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? SizedBox(
                        width: context.w * 0.05,
                        height: context.w * 0.05,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.momentSave),
              ),
            ),
            SizedBox(height: context.m),
          ],
        ),
      ),
    );
  }

  String _occasionLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case _kOccasionDinner:
        return l10n.momentOccasionDinner;
      case _kOccasionDate:
        return l10n.momentOccasionDate;
      case _kOccasionCelebration:
        return l10n.momentOccasionCelebration;
      case _kOccasionTasting:
        return l10n.momentOccasionTasting;
      case _kOccasionCasual:
        return l10n.momentOccasionCasual;
      case _kOccasionBirthday:
        return l10n.momentOccasionBirthday;
    }
    return key;
  }
}

class _PhotoDraft {
  final String id;
  // For new photos this is a remote URL fresh out of the uploader.
  // For existing photos it's the saved storage URL.
  final String storagePath;
  _PhotoDraft({required this.id, required this.storagePath});
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        fontSize: context.captionFont,
        fontWeight: FontWeight.w600,
        color: cs.onSurfaceVariant,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _PhotoStrip extends StatelessWidget {
  final List<_PhotoDraft> photos;
  final VoidCallback? onAdd;
  final ValueChanged<String> onRemove;
  const _PhotoStrip({
    required this.photos,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.22;
    return SizedBox(
      height: size,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final p in photos) ...[
            GestureDetector(
              onLongPress: () => onRemove(p.id),
              child: Container(
                width: size,
                height: size,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.only(right: context.w * 0.02),
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                  border: Border.all(color: cs.outlineVariant, width: 0.5),
                ),
                child: _photoImage(p.storagePath),
              ),
            ),
          ],
          if (onAdd != null)
            GestureDetector(
              onTap: onAdd,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                  border: Border.all(color: cs.outlineVariant, width: 0.5),
                ),
                child: Icon(
                  PhosphorIconsRegular.plus,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _photoImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover);
    }
    return Image.file(File(path), fit: BoxFit.cover);
  }
}
