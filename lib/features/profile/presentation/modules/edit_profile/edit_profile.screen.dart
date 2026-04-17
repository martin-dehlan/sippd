import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../controller/profile.provider.dart';
import '../../widgets/profile_avatar.widget.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _displayNameController = TextEditingController();
  bool _loadedInitial = false;
  bool _saving = false;
  bool _uploadingAvatar = false;
  String? _avatarUrl;

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final source = await _showSourceSheet(context);
    if (source == null || !mounted) return;

    final service = ref.read(profileImageServiceProvider);
    final userId = ref.read(currentUserIdProvider);
    if (service == null || userId == null) return;

    setState(() => _uploadingAvatar = true);
    try {
      final url = await service.pickAndUploadImage(
        userId: userId,
        source: source,
      );
      if (url != null) {
        await ref.read(profileControllerProvider.notifier).setAvatarUrl(url);
        if (mounted) setState(() => _avatarUrl = url);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadingAvatar = false);
    }
  }

  Future<void> _removeAvatar() async {
    setState(() => _uploadingAvatar = true);
    try {
      final service = ref.read(profileImageServiceProvider);
      if (_avatarUrl != null && service != null) {
        await service.deleteImage(_avatarUrl!);
      }
      await ref.read(profileControllerProvider.notifier).setAvatarUrl(null);
      if (mounted) setState(() => _avatarUrl = null);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadingAvatar = false);
    }
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(profileControllerProvider.notifier)
          .setDisplayName(_displayNameController.text);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final profile = ref.watch(currentProfileProvider).valueOrNull;

    if (!_loadedInitial && profile != null) {
      _displayNameController.text = profile.displayName ?? '';
      _avatarUrl = profile.avatarUrl;
      _loadedInitial = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile',
            style: TextStyle(
                fontSize: context.headingFont, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? SizedBox(
                    width: context.w * 0.05,
                    height: context.w * 0.05,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: cs.primary),
                  )
                : Text('Save',
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                        color: cs.primary)),
          ),
          SizedBox(width: context.s),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          children: [
            SizedBox(height: context.l),
            Center(
              child: _AvatarEditor(
                avatarUrl: _avatarUrl,
                loading: _uploadingAvatar,
                fallback: profile?.username ?? profile?.displayName ?? '?',
                onTap: _pickAvatar,
              ),
            ),
            SizedBox(height: context.m),
            Center(
              child: TextButton(
                onPressed: _uploadingAvatar ? null : _pickAvatar,
                child: Text(
                  _avatarUrl == null ? 'Add photo' : 'Change photo',
                  style: TextStyle(
                      fontSize: context.bodyFont,
                      color: cs.primary,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            if (_avatarUrl != null)
              Center(
                child: TextButton(
                  onPressed: _uploadingAvatar ? null : _removeAvatar,
                  child: Text('Remove photo',
                      style: TextStyle(
                          fontSize: context.captionFont, color: cs.error)),
                ),
              ),
            SizedBox(height: context.l),
            Text('Display name',
                style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant)),
            SizedBox(height: context.s),
            TextField(
              controller: _displayNameController,
              maxLength: 40,
              style: TextStyle(fontSize: context.bodyFont),
              decoration: InputDecoration(
                hintText: 'Your name',
                counterText: '',
                filled: true,
                fillColor: cs.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: context.l),
            Text('Username',
                style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant)),
            SizedBox(height: context.s),
            _UsernameRow(
              username: profile?.username,
              onTap: () => context.push(AppRoutes.chooseUsername),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarEditor extends StatelessWidget {
  final String? avatarUrl;
  final bool loading;
  final String fallback;
  final VoidCallback onTap;

  const _AvatarEditor({
    required this.avatarUrl,
    required this.loading,
    required this.fallback,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.3;

    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Stack(
        children: [
          ProfileAvatar(
            avatarUrl: avatarUrl,
            fallbackText: fallback,
            size: size,
          ),
          if (loading)
            Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(context.xs),
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
                border: Border.all(color: cs.surface, width: 2),
              ),
              child: Icon(Icons.camera_alt,
                  color: cs.onPrimary, size: context.w * 0.04),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsernameRow extends StatelessWidget {
  final String? username;
  final VoidCallback onTap;

  const _UsernameRow({required this.username, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.04, vertical: context.m),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                username != null ? '@$username' : 'Set username',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w500,
                  color: username != null ? cs.onSurface : cs.onSurfaceVariant,
                ),
              ),
            ),
            Icon(Icons.chevron_right,
                size: context.w * 0.05, color: cs.outline),
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
                leading: Icon(Icons.camera_alt_outlined, color: cs.primary),
                title: Text('Take photo',
                    style: TextStyle(fontSize: ctx.bodyFont)),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library_outlined, color: cs.primary),
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
