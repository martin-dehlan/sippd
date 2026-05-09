import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/inline_error.widget.dart';
import '../../../../controller/group.provider.dart';
import '../../../../domain/entities/group.entity.dart';

class EditGroupSheet extends ConsumerStatefulWidget {
  final GroupEntity group;
  const EditGroupSheet({super.key, required this.group});

  static Future<void> show(BuildContext context, GroupEntity group) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (_) => EditGroupSheet(group: group),
    );
  }

  @override
  ConsumerState<EditGroupSheet> createState() => _EditGroupSheetState();
}

class _EditGroupSheetState extends ConsumerState<EditGroupSheet> {
  late final TextEditingController _nameController;
  late String? _imageUrl;
  bool _busy = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final initialName = widget.group.name.length > 30
        ? widget.group.name.substring(0, 30)
        : widget.group.name;
    _nameController = TextEditingController(text: initialName);
    _imageUrl = widget.group.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final source = await _pickSource();
    if (source == null || !mounted) return;

    setState(() => _busy = true);
    try {
      final service = ref.read(groupImageServiceProvider);
      final url = await service.pickAndUploadImage(
        groupId: widget.group.id,
        source: source,
      );
      if (url != null && mounted) {
        setState(() => _imageUrl = url);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(describeAppError(e, fallback: 'Upload failed.')),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _removeImage() async {
    setState(() => _busy = true);
    try {
      final service = ref.read(groupImageServiceProvider);
      if (_imageUrl != null) {
        await service.deleteImage(_imageUrl!);
      }
      if (mounted) setState(() => _imageUrl = null);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(describeAppError(e, fallback: 'Delete failed.')),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<ImageSource?> _pickSource() async {
    final cs = Theme.of(context).colorScheme;
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: cs.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.05),
        ),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: context.s),
            ListTile(
              leading: const Icon(PhosphorIconsRegular.camera),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(PhosphorIconsRegular.images),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            if (_imageUrl != null)
              ListTile(
                leading: Icon(PhosphorIconsRegular.trash, color: cs.error),
                title: Text('Remove photo', style: TextStyle(color: cs.error)),
                onTap: () {
                  Navigator.pop(ctx);
                  _removeImage();
                },
              ),
            SizedBox(height: context.m),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final changedName = name != widget.group.name;
    final changedImage = _imageUrl != widget.group.imageUrl;
    if (!changedName && !changedImage) {
      Navigator.pop(context);
      return;
    }

    setState(() {
      _busy = true;
      _errorMessage = null;
    });
    try {
      await ref
          .read(groupControllerProvider.notifier)
          .updateGroup(
            groupId: widget.group.id,
            name: changedName ? name : null,
            imageUrl: changedImage && _imageUrl != null ? _imageUrl : null,
            clearImage: changedImage && _imageUrl == null,
          );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Save failed: $e');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final avatarSize = context.w * 0.28;

    return Padding(
      padding: EdgeInsets.only(
        left: context.paddingH * 1.3,
        right: context.paddingH * 1.3,
        top: context.l,
        bottom: MediaQuery.of(context).viewInsets.bottom + context.l,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: context.w * 0.1,
              height: context.xs,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(context.xs),
              ),
            ),
          ),
          SizedBox(height: context.l),
          Text(
            'Edit group',
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.l),
          Center(
            child: GestureDetector(
              onTap: _busy ? null : _pickImage,
              child: Stack(
                children: [
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.surfaceContainer,
                      image: _imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(_imageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _imageUrl == null
                        ? Icon(
                            PhosphorIconsRegular.usersThree,
                            size: avatarSize * 0.45,
                            color: cs.onSurfaceVariant,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(context.xs * 1.4),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: cs.surface, width: 2),
                      ),
                      child: Icon(
                        PhosphorIconsRegular.camera,
                        size: context.w * 0.04,
                        color: cs.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.l),
          Text(
            'Name',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.s),
          TextField(
            controller: _nameController,
            enabled: !_busy,
            textCapitalization: TextCapitalization.words,
            maxLength: 30,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            decoration: InputDecoration(
              filled: true,
              fillColor: cs.surfaceContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.w * 0.03),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.w * 0.04,
                vertical: context.m,
              ),
            ),
          ),
          if (_errorMessage != null) ...[
            SizedBox(height: context.m),
            Text(
              _errorMessage!,
              style: TextStyle(color: cs.error, fontSize: context.captionFont),
            ),
          ],
          SizedBox(height: context.xl),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _busy ? null : _save,
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: context.m),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                ),
              ),
              child: _busy
                  ? SizedBox(
                      height: context.m,
                      width: context.m,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
