import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/photo_error.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../friends/presentation/widgets/friend_multi_picker.widget.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../../locations/presentation/widgets/location_search.widget.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine_memory.entity.dart';
import '../../../domain/entities/wine_memory_photo.entity.dart';

/// Opens the moment capture flow. Photo-first, full-bleed canvas with
/// a single integrated bottom panel: date + place chips, caption, save.
///
/// New-moment flow shows the source picker FIRST (over the calling
/// screen) and only pushes the capture page once a photo is in hand
/// so the user never lands on an empty canvas. Edit flow goes
/// straight in.
Future<bool?> pushMomentCapture(
  BuildContext context,
  WidgetRef ref, {
  required String wineId,
  WineMemoryEntity? existing,
  List<WineMemoryPhotoEntity> existingPhotos = const [],
  String? wineLocationName,
  double? wineLocationLat,
  double? wineLocationLng,
}) async {
  String? initialUrl;
  if (existing == null && existingPhotos.isEmpty) {
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
        wineLocationName: wineLocationName,
        wineLocationLat: wineLocationLat,
        wineLocationLng: wineLocationLng,
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
    this.wineLocationName,
    this.wineLocationLat,
    this.wineLocationLng,
  });

  final String wineId;
  final WineMemoryEntity? existing;
  final List<WineMemoryPhotoEntity> existingPhotos;
  final String? initialPhotoUrl;
  // Wine's own location; used to pre-fill the place chip so a new
  // moment starts at the "initial drink ort". User can override per
  // moment via the place sheet (text or current GPS).
  final String? wineLocationName;
  final double? wineLocationLat;
  final double? wineLocationLng;

  @override
  ConsumerState<MomentCaptureScreen> createState() =>
      _MomentCaptureScreenState();
}

class _MomentCaptureScreenState extends ConsumerState<MomentCaptureScreen> {
  final List<_PhotoSlot> _photos = [];
  final TextEditingController _captionCtrl = TextEditingController();
  final TextEditingController _placeCtrl = TextEditingController();
  int _activeIndex = 0;
  bool _saving = false;
  late DateTime _occurredAt;
  // Lat/lng paired with the place name. Set either by pre-fill from
  // the wine's own location, by "Use current location" GPS, or by
  // future map picker. Null when the user typed free-text only.
  double? _placeLat;
  double? _placeLng;
  // Tagged friend IDs. RLS exposes a moment to its tagged companions
  // regardless of visibility, so this is the share-with-friend lever.
  final Set<String> _companionIds = {};

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _captionCtrl.text = e?.note ?? '';
    _occurredAt = e?.occurredAt ?? DateTime.now();
    // Pre-fill place from existing moment first; otherwise fall back
    // to the wine's own location so new moments default to "where the
    // bottle was logged" rather than empty.
    if (e?.placeName != null && e!.placeName!.isNotEmpty) {
      _placeCtrl.text = e.placeName!;
      _placeLat = e.placeLat;
      _placeLng = e.placeLng;
    } else if (widget.wineLocationName != null &&
        widget.wineLocationName!.isNotEmpty) {
      _placeCtrl.text = widget.wineLocationName!;
      _placeLat = widget.wineLocationLat;
      _placeLng = widget.wineLocationLng;
    }
    _companionIds.addAll(e?.companionUserIds ?? const []);
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

  Future<void> _editCompanions() async {
    final result = await showFriendMultiPicker(
      context: context,
      initialSelected: _companionIds,
    );
    if (result == null || !mounted) return;
    setState(() {
      _companionIds
        ..clear()
        ..addAll(result);
    });
  }

  @override
  void dispose() {
    _captionCtrl.dispose();
    _placeCtrl.dispose();
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

  Future<void> _confirmRemovePhoto() async {
    if (_photos.isEmpty) return;
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.winesMemoriesRemoveTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.winesMemoriesRemoveCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.winesMemoriesRemoveConfirm,
              style: TextStyle(color: cs.error),
            ),
          ),
        ],
      ),
    );
    if (ok != true) return;
    setState(() {
      _photos.removeAt(_activeIndex);
      if (_activeIndex >= _photos.length) {
        _activeIndex = (_photos.length - 1).clamp(0, _photos.length);
      }
    });
  }

  Future<void> _editDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _occurredAt,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_occurredAt),
    );
    if (time == null || !mounted) return;
    setState(() {
      _occurredAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _editPlace() async {
    final l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: context.paddingH,
            right: context.paddingH,
            top: context.l,
            bottom: MediaQuery.viewInsetsOf(ctx).bottom + context.l,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.momentFieldPlace,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: context.s),
              // Reuses the shared LocationSearchWidget — debounced
              // Nominatim typeahead + "Use my location" GPS in one
              // surface. Closes itself when a result is picked.
              LocationSearchWidget(
                initialValue: _placeCtrl.text,
                onLocationSelected: (loc) {
                  setState(() {
                    _placeCtrl.text = loc.shortDisplay;
                    _placeLat = loc.lat;
                    _placeLng = loc.lng;
                  });
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
    if (mounted) setState(() {});
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
      final place = _placeCtrl.text.trim();
      final entity = WineMemoryEntity(
        id: memoryId,
        wineId: widget.wineId,
        userId: userId,
        imageUrl: _photos.isNotEmpty ? _photos.first.url : null,
        caption: caption.isEmpty ? null : caption,
        createdAt: widget.existing?.createdAt ?? now,
        occurredAt: _occurredAt,
        occasion: widget.existing?.occasion,
        placeName: place.isEmpty ? null : place,
        placeLat: place.isEmpty ? null : _placeLat,
        placeLng: place.isEmpty ? null : _placeLng,
        foodPaired: widget.existing?.foodPaired,
        companionUserIds: _companionIds.toList(),
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

    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateLabel = _formatDateLabel(_occurredAt, locale);
    final placeLabel = _placeCtrl.text.trim().isEmpty
        ? l10n.momentFieldPlace
        : _placeCtrl.text.trim();
    final placeIsEmpty = _placeCtrl.text.trim().isEmpty;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: [
              // Photo area
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onLongPress: activePhoto == null ? null : _confirmRemovePhoto,
                  onTapUp: (d) {
                    if (_photos.length < 2) return;
                    final w = MediaQuery.of(context).size.width;
                    setState(() {
                      if (d.localPosition.dx < w / 2) {
                        _activeIndex = (_activeIndex - 1).clamp(
                          0,
                          _photos.length - 1,
                        );
                      } else {
                        _activeIndex = (_activeIndex + 1).clamp(
                          0,
                          _photos.length - 1,
                        );
                      }
                    });
                  },
                  child: Center(
                    child: activePhoto == null
                        ? Icon(
                            PhosphorIconsThin.image,
                            color: Colors.white.withValues(alpha: 0.25),
                            size: context.w * 0.25,
                          )
                        : Image.network(activePhoto.url, fit: BoxFit.contain),
                  ),
                ),
              ),

              // Top: progress bar segments only (no chunky chrome).
              if (_photos.length > 1)
                Positioned(
                  top: MediaQuery.paddingOf(context).top + context.s,
                  left: context.m,
                  right: context.w * 0.16,
                  child: Row(
                    children: [
                      for (var i = 0; i < _photos.length; i++) ...[
                        Expanded(
                          child: Container(
                            height: 2,
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

              // Top-right close — flat, no glass pill.
              Positioned(
                top: MediaQuery.paddingOf(context).top + context.xs,
                right: context.s,
                child: IconButton(
                  icon: const Icon(PhosphorIconsRegular.x, color: Colors.white),
                  iconSize: context.w * 0.055,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),

              // Bottom integrated panel — meta chips, caption, action row.
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
                    bottom: MediaQuery.paddingOf(context).bottom + context.s,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _MetaChip(
                              icon: PhosphorIconsRegular.clock,
                              label: dateLabel,
                              onTap: _editDateTime,
                            ),
                            SizedBox(width: context.s),
                            _MetaChip(
                              icon: PhosphorIconsRegular.mapPin,
                              label: placeLabel,
                              dimmed: placeIsEmpty,
                              onTap: _editPlace,
                            ),
                            SizedBox(width: context.s),
                            _MetaChip(
                              icon: PhosphorIconsRegular.users,
                              label: _companionIds.isEmpty
                                  ? l10n.momentFieldCompanions
                                  : '${l10n.momentFieldCompanions} · ${_companionIds.length}',
                              dimmed: _companionIds.isEmpty,
                              onTap: _editCompanions,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.s),
                      TextField(
                        controller: _captionCtrl,
                        maxLines: 3,
                        minLines: 1,
                        maxLength: 1000,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.bodyFont,
                          height: 1.3,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          counterText: '',
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: context.s,
                          ),
                          border: InputBorder.none,
                          hintText: l10n.momentNoteHint,
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: context.bodyFont,
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      Container(
                        height: 1,
                        margin: EdgeInsets.only(bottom: context.s),
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              PhosphorIconsRegular.plus,
                              color: _photos.length >= 10
                                  ? Colors.white24
                                  : Colors.white,
                              size: context.w * 0.055,
                            ),
                            onPressed: _photos.length >= 10 ? null : _addPhoto,
                            tooltip: l10n.momentAddPhoto,
                          ),
                          if (_photos.length > 1) ...[
                            SizedBox(width: context.xs),
                            Text(
                              '${_activeIndex + 1}/${_photos.length}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: context.captionFont,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          const Spacer(),
                          _SaveButton(
                            label: l10n.momentSave,
                            saving: _saving,
                            enabled: canSave,
                            onTap: _save,
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

  String _formatDateLabel(DateTime when, String locale) {
    // Locale-aware "13. Mai · 13:52" / "May 13 · 1:52 PM" style. Short
    // enough to live in a chip, no special "Today" label — relies on
    // recency being obvious from the date itself.
    return DateFormat.MMMd(locale).add_Hm().format(when);
  }
}

class _PhotoSlot {
  final String id;
  final String url;
  _PhotoSlot({required this.id, required this.url});
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool dimmed;
  final VoidCallback onTap;
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.dimmed = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.white.withValues(alpha: dimmed ? 0.55 : 0.95);
    final borderColor = Colors.white.withValues(alpha: dimmed ? 0.14 : 0.28);
    final radius = BorderRadius.circular(context.w * 0.08);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.s * 1.4,
            vertical: context.xs * 1.4,
          ),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: borderColor, width: 0.8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: context.w * 0.04),
              SizedBox(width: context.xs * 1.3),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w500,
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

class _SaveButton extends StatelessWidget {
  final String label;
  final bool saving;
  final bool enabled;
  final VoidCallback onTap;
  const _SaveButton({
    required this.label,
    required this.saving,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return FilledButton.icon(
      onPressed: enabled ? onTap : null,
      style: FilledButton.styleFrom(
        backgroundColor: enabled
            ? cs.primary
            : Colors.white.withValues(alpha: 0.18),
        foregroundColor: enabled
            ? cs.onPrimary
            : Colors.white.withValues(alpha: 0.55),
        padding: EdgeInsets.symmetric(
          horizontal: context.m,
          vertical: context.s * 1.1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.w * 0.06),
        ),
        elevation: 0,
      ),
      icon: saving
          ? SizedBox(
              width: context.w * 0.04,
              height: context.w * 0.04,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: cs.onPrimary,
              ),
            )
          : Icon(PhosphorIconsRegular.check, size: context.w * 0.045),
      label: Text(
        label,
        style: TextStyle(
          fontSize: context.captionFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
