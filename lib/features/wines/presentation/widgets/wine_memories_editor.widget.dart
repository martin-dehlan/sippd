import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/photo_error.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../controller/wine.provider.dart';

class MemoryDraft {
  final String id;
  final String? imageUrl;
  final String? localImagePath;

  const MemoryDraft({
    required this.id,
    this.imageUrl,
    this.localImagePath,
  });
}

class WineMemoriesEditor extends ConsumerStatefulWidget {
  final List<MemoryDraft> memories;
  final ValueChanged<List<MemoryDraft>> onChanged;

  const WineMemoriesEditor({
    super.key,
    required this.memories,
    required this.onChanged,
  });

  @override
  ConsumerState<WineMemoriesEditor> createState() =>
      _WineMemoriesEditorState();
}

class _WineMemoriesEditorState extends ConsumerState<WineMemoriesEditor> {
  bool _isUploading = false;

  Future<void> _pickAndAdd() async {
    final source = await _showSourceSheet(context);
    if (source == null || !mounted) return;

    setState(() => _isUploading = true);
    try {
      final picker = ImagePicker();
      final photo = await picker.pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (photo == null) return;

      final imageService = ref.read(wineImageServiceProvider);
      final userId = ref.read(currentUserIdProvider);

      String? imageUrl;
      String? localPath;
      if (imageService != null && userId != null) {
        imageUrl = await imageService.uploadImage(
          userId: userId,
          filePath: photo.path,
        );
      } else {
        localPath = photo.path;
      }

      final next = [
        ...widget.memories,
        MemoryDraft(
          id: const Uuid().v4(),
          imageUrl: imageUrl,
          localImagePath: localPath,
        ),
      ];
      widget.onChanged(next);
    } catch (e) {
      if (mounted) await PhotoErrorHandler.handle(context, e);
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _remove(String id) {
    widget.onChanged(widget.memories.where((m) => m.id != id).toList());
  }

  Future<void> _confirmRemove(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove memory?'),
        content: const Text('This will remove this photo from the wine.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Remove',
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) _remove(id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MemoriesHeader(count: widget.memories.length),
          SizedBox(height: context.s),
          Wrap(
            spacing: context.w * 0.025,
            runSpacing: context.w * 0.025,
            children: [
              for (final m in widget.memories)
                _MemoryThumb(
                  memory: m,
                  onRemove: () => _confirmRemove(m.id),
                ),
              _AddTile(
                isLoading: _isUploading,
                onTap: _isUploading ? null : _pickAndAdd,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemoriesHeader extends StatelessWidget {
  final int count;
  const _MemoriesHeader({required this.count});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(
          PhosphorIconsRegular.images,
          size: context.w * 0.045,
          color: cs.onSurfaceVariant,
        ),
        SizedBox(width: context.w * 0.02),
        Text(
          count == 0 ? 'Memories' : 'Memories ($count)',
          style: TextStyle(
            fontSize: context.bodyFont,
            fontWeight: FontWeight.w600,
            color: cs.onSurface,
          ),
        ),
      ],
    );
  }
}

class _MemoryThumb extends StatelessWidget {
  final MemoryDraft memory;
  final VoidCallback onRemove;

  const _MemoryThumb({required this.memory, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.22;
    return GestureDetector(
      onTap: onRemove,
      child: Container(
        width: size,
        height: size,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (memory.localImagePath != null)
              Image.file(File(memory.localImagePath!), fit: BoxFit.cover)
            else if (memory.imageUrl != null)
              Image.network(memory.imageUrl!, fit: BoxFit.cover)
            else
              Icon(PhosphorIconsRegular.imageBroken,
                  color: cs.outline, size: size * 0.4),
            Positioned(
              top: context.xs,
              right: context.xs,
              child: Container(
                padding: EdgeInsets.all(context.xs * 0.6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIconsRegular.x,
                  size: context.w * 0.035,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onTap;

  const _AddTile({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.22;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(color: cs.outlineVariant, width: 1),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: context.w * 0.06,
                height: context.w * 0.06,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: cs.primary,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(PhosphorIconsRegular.cameraPlus,
                      size: context.w * 0.07, color: cs.outline),
                  SizedBox(height: context.xs),
                  Text(
                    'Add',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.85,
                      color: cs.outline,
                      fontWeight: FontWeight.w500,
                    ),
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
                leading:
                    Icon(PhosphorIconsRegular.images, color: cs.primary),
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
