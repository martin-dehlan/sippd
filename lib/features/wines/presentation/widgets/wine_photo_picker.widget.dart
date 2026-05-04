import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/photo_error.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../controller/wine.provider.dart';

class WinePhotoPicker extends ConsumerStatefulWidget {
  final String? imageUrl;
  final String? localPath;
  final String label;
  final IconData placeholderIcon;
  final ValueChanged<({String? imageUrl, String? localPath})> onChanged;

  const WinePhotoPicker({
    super.key,
    required this.imageUrl,
    required this.localPath,
    required this.label,
    required this.placeholderIcon,
    required this.onChanged,
  });

  @override
  ConsumerState<WinePhotoPicker> createState() => _WinePhotoPickerState();
}

class _WinePhotoPickerState extends ConsumerState<WinePhotoPicker> {
  bool _isLoading = false;

  Future<void> _pick() async {
    final source = await _showSourceSheet(context);
    if (source == null || !mounted) return;

    setState(() => _isLoading = true);
    try {
      final picker = ImagePicker();
      final photo = await picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
        requestFullMetadata: false,
      );
      if (photo == null) return;

      final imageService = ref.read(wineImageServiceProvider);
      final userId = ref.read(currentUserIdProvider);

      if (imageService != null && userId != null) {
        final url = await imageService.uploadImage(
          userId: userId,
          filePath: photo.path,
        );
        widget.onChanged((imageUrl: url, localPath: null));
      } else {
        widget.onChanged((imageUrl: null, localPath: photo.path));
      }
    } catch (e) {
      if (mounted) await PhotoErrorHandler.handle(context, e);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clear() => widget.onChanged((imageUrl: null, localPath: null));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasPhoto = widget.imageUrl != null || widget.localPath != null;

    return GestureDetector(
      onTap: _isLoading ? null : _pick,
      child: Container(
        height: context.h * 0.22,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
          border: Border.all(color: cs.outlineVariant, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (hasPhoto) _PreviewImage(
              imageUrl: widget.imageUrl,
              localPath: widget.localPath,
            )
            else _EmptyState(
              label: widget.label,
              icon: widget.placeholderIcon,
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.4),
                child: const Center(child: CircularProgressIndicator()),
              ),
            if (hasPhoto && !_isLoading)
              Positioned(
                top: context.s,
                right: context.s,
                child: _ClearButton(onTap: _clear),
              ),
          ],
        ),
      ),
    );
  }
}

Future<ImageSource?> _showSourceSheet(BuildContext context) {
  return showModalBottomSheet<ImageSource>(
    context: context,
    builder: (ctx) {
      final cs = Theme.of(ctx).colorScheme;
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ctx.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(PhosphorIconsRegular.camera, color: cs.primary),
                title: Text('Take photo',
                    style: TextStyle(fontSize: ctx.bodyFont)),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              ListTile(
                leading: Icon(PhosphorIconsRegular.images, color: cs.primary),
                title: Text('Choose from gallery',
                    style: TextStyle(fontSize: ctx.bodyFont)),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _PreviewImage extends StatelessWidget {
  final String? imageUrl;
  final String? localPath;

  const _PreviewImage({required this.imageUrl, required this.localPath});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (localPath != null) {
      return Image.file(File(localPath!), fit: BoxFit.cover);
    }
    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: cs.surfaceContainer,
        alignment: Alignment.center,
        child: Icon(
          PhosphorIconsRegular.wine,
          size: 40,
          color: cs.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String label;
  final IconData icon;
  const _EmptyState({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: context.w * 0.1, color: cs.outline),
        SizedBox(height: context.s),
        Text(label,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.outline,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}

class _ClearButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ClearButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.xs),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(PhosphorIconsRegular.x,
            color: Colors.white, size: context.w * 0.05),
      ),
    );
  }
}
