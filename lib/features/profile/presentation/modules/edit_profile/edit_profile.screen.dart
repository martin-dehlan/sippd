import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../controller/profile.provider.dart';
import '../../widgets/profile_avatar.widget.dart';

enum _UsernameState {
  idle,
  checking,
  available,
  taken,
  invalid,
  tooShort,
  unchanged,
}

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _displayNameController = TextEditingController();
  final _usernameController = TextEditingController();
  Timer? _usernameDebounce;
  _UsernameState _usernameStatus = _UsernameState.unchanged;
  bool _loadedInitial = false;
  bool _saving = false;
  bool _uploadingAvatar = false;
  String? _avatarUrl;

  static final _validUsernameRe = RegExp(r'^[a-z0-9._]+$');

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _usernameDebounce?.cancel();
    super.dispose();
  }

  void _onUsernameChanged(String raw) {
    final value = raw.trim().toLowerCase();
    _usernameDebounce?.cancel();

    final current =
        ref.read(currentProfileProvider).valueOrNull?.username ?? '';
    if (value == current) {
      setState(() => _usernameStatus = _UsernameState.unchanged);
      return;
    }
    if (value.isEmpty) {
      setState(() => _usernameStatus = _UsernameState.idle);
      return;
    }
    if (value.length < 3) {
      setState(() => _usernameStatus = _UsernameState.tooShort);
      return;
    }
    if (!_validUsernameRe.hasMatch(value)) {
      setState(() => _usernameStatus = _UsernameState.invalid);
      return;
    }

    setState(() => _usernameStatus = _UsernameState.checking);
    _usernameDebounce = Timer(const Duration(milliseconds: 350), () async {
      final available = await ref
          .read(profileControllerProvider.notifier)
          .isAvailable(value);
      if (!mounted || _usernameController.text.trim().toLowerCase() != value) {
        return;
      }
      setState(() => _usernameStatus =
          available ? _UsernameState.available : _UsernameState.taken);
    });
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

  Future<void> _saveAndPop() async {
    if (_saving) {
      if (mounted) context.pop();
      return;
    }
    final profile = ref.read(currentProfileProvider).valueOrNull;
    final typedName = _displayNameController.text.trim();
    final currentName = (profile?.displayName ?? '').trim();
    final typedUsername = _usernameController.text.trim().toLowerCase();
    final currentUsername = profile?.username ?? '';

    final nameChanged = typedName != currentName;
    final usernameChanged = typedUsername != currentUsername &&
        _usernameStatus == _UsernameState.available;

    if (!nameChanged && !usernameChanged) {
      if (mounted) context.pop();
      return;
    }

    setState(() => _saving = true);
    try {
      final notifier = ref.read(profileControllerProvider.notifier);
      if (usernameChanged) await notifier.setUsername(typedUsername);
      if (nameChanged) await notifier.setDisplayName(typedName);
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
      _usernameController.text = profile.username ?? '';
      _avatarUrl = profile.avatarUrl;
      _loadedInitial = true;
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          children: [
            SizedBox(height: context.xl),
            Center(
              child: Text(
                'Edit profile',
                style: TextStyle(
                  fontSize: context.headingFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
            Text('Username',
                style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant)),
            SizedBox(height: context.s),
            _UsernameField(
              controller: _usernameController,
              status: _usernameStatus,
              onChanged: _onUsernameChanged,
            ),
            SizedBox(height: context.xs),
            _UsernameStatusLine(status: _usernameStatus),
            SizedBox(height: context.l),
            Row(
              children: [
                Text('Display name',
                    style: TextStyle(
                        fontSize: context.captionFont,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurfaceVariant)),
                SizedBox(width: context.xs),
                Text('(optional)',
                    style: TextStyle(
                        fontSize: context.captionFont, color: cs.outline)),
              ],
            ),
            SizedBox(height: context.s),
            TextField(
              controller: _displayNameController,
              maxLength: 40,
              style: TextStyle(fontSize: context.bodyFont),
              decoration: InputDecoration(
                hintText: profile?.username != null
                    ? 'e.g. ${profile!.username}'
                    : 'How should we call you?',
                counterText: '',
                filled: true,
                fillColor: cs.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              'Shown in groups and tastings. Leave empty to use your username.',
              style: TextStyle(
                  fontSize: context.captionFont * 0.9, color: cs.outline),
            ),
            SizedBox(height: context.xxl),
          ],
        ),
      ),
      floatingActionButton: _FloatingBackButton(onPressed: _saveAndPop),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final _UsernameState status;
  final ValueChanged<String> onChanged;

  const _UsernameField({
    required this.controller,
    required this.status,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasError = status == _UsernameState.taken ||
        status == _UsernameState.invalid ||
        status == _UsernameState.tooShort;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,
      maxLength: 20,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9._]')),
      ],
      style: TextStyle(
        fontSize: context.bodyFont,
        fontWeight: FontWeight.w500,
        color: cs.onSurface,
      ),
      decoration: InputDecoration(
        prefixText: '@',
        prefixStyle: TextStyle(
          fontSize: context.bodyFont,
          fontWeight: FontWeight.w500,
          color: cs.onSurfaceVariant,
        ),
        counterText: '',
        filled: true,
        fillColor: cs.surfaceContainer,
        suffixIcon: _usernameSuffix(context, status),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: hasError
              ? BorderSide(color: cs.error, width: 1)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide(
            color: hasError ? cs.error : cs.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

Widget? _usernameSuffix(BuildContext context, _UsernameState status) {
  final cs = Theme.of(context).colorScheme;
  return switch (status) {
    _UsernameState.checking => Padding(
        padding: EdgeInsets.all(context.w * 0.035),
        child: SizedBox(
          width: context.w * 0.04,
          height: context.w * 0.04,
          child: CircularProgressIndicator(
              strokeWidth: 2, color: cs.onSurfaceVariant),
        ),
      ),
    _UsernameState.available =>
      Icon(Icons.check_circle, color: cs.primary, size: context.w * 0.05),
    _ => null,
  };
}

class _UsernameStatusLine extends StatelessWidget {
  final _UsernameState status;
  const _UsernameStatusLine({required this.status});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (text, color) = switch (status) {
      _UsernameState.tooShort => ('At least 3 characters', cs.error),
      _UsernameState.invalid =>
        ('Only letters, numbers, . and _', cs.error),
      _UsernameState.taken => ('Already taken', cs.error),
      _ => ('', cs.outline),
    };
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.02),
      child: Text(
        text,
        style: TextStyle(fontSize: context.captionFont * 0.9, color: color),
      ),
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _FloatingBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'edit-profile-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Icon(Icons.arrow_back_ios_new, size: context.w * 0.06),
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
