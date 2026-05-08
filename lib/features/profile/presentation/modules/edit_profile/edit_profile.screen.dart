import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../controller/profile.provider.dart';
import '../../widgets/profile_avatar.widget.dart';
import '../../widgets/taste_profile_editor.widget.dart';

enum _UsernameState {
  idle,
  checking,
  available,
  taken,
  invalid,
  tooShort,
  unchanged,
}

enum _AvatarAction { camera, gallery, remove }

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
  Object? _saveError;
  Object? _avatarError;
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
      setState(
        () => _usernameStatus = available
            ? _UsernameState.available
            : _UsernameState.taken,
      );
    });
  }

  Future<void> _pickAvatar() async {
    final action = await _showSourceSheet(
      context,
      hasAvatar: _avatarUrl != null,
    );
    if (action == null || !mounted) return;

    if (action == _AvatarAction.remove) {
      await _removeAvatar();
      return;
    }

    final source = action == _AvatarAction.camera
        ? ImageSource.camera
        : ImageSource.gallery;

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _uploadingAvatar = false);
    }
  }

  Future<void> _removeAvatar() async {
    setState(() {
      _uploadingAvatar = true;
      _avatarError = null;
    });
    try {
      final service = ref.read(profileImageServiceProvider);
      if (_avatarUrl != null && service != null) {
        await service.deleteImage(_avatarUrl!);
      }
      await ref.read(profileControllerProvider.notifier).setAvatarUrl(null);
      if (mounted) setState(() => _avatarUrl = null);
    } catch (e) {
      if (mounted) setState(() => _avatarError = e);
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
    final usernameChanged =
        typedUsername != currentUsername &&
        _usernameStatus == _UsernameState.available;

    if (!nameChanged && !usernameChanged) {
      if (mounted) context.pop();
      return;
    }

    setState(() {
      _saving = true;
      _saveError = null;
    });
    try {
      final notifier = ref.read(profileControllerProvider.notifier);
      if (usernameChanged) await notifier.setUsername(typedUsername);
      if (nameChanged) await notifier.setDisplayName(typedName);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) setState(() => _saveError = e);
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
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            PhosphorIconsRegular.arrowLeft,
            size: context.w * 0.05,
            color: cs.onSurface,
          ),
          onPressed: _saveAndPop,
        ),
        centerTitle: true,
        title: Text(
          'Edit profile',
          style: TextStyle(
            fontSize: context.bodyFont * 1.1,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          children: [
            SizedBox(height: context.s),
            Center(
              child: _AvatarEditor(
                avatarUrl: _avatarUrl,
                loading: _uploadingAvatar,
                fallback: profile?.username ?? profile?.displayName ?? '?',
                onTap: _pickAvatar,
              ),
            ),
            if (_avatarError != null)
              Center(
                child: InlineFieldError(
                  error: _avatarError,
                  fallback: "Couldn't update photo. Try again.",
                ),
              ),
            if (_saveError != null)
              InlineFieldError(
                error: _saveError,
                fallback: "Couldn't save changes. Try again.",
              ),
            SizedBox(height: context.xl),
            _SectionHeader(text: 'Profile'),
            SizedBox(height: context.m),
            _FieldLabel(text: 'Username'),
            SizedBox(height: context.s),
            _UsernameField(
              controller: _usernameController,
              status: _usernameStatus,
              onChanged: _onUsernameChanged,
            ),
            SizedBox(height: context.xs),
            _UsernameStatusLine(status: _usernameStatus),
            SizedBox(height: context.l),
            _FieldLabel(text: 'Display name', optional: true),
            SizedBox(height: context.s),
            TextField(
              controller: _displayNameController,
              maxLength: 30,
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
              'Shown in groups and tastings. Leave empty to use your '
              'username.',
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                color: cs.outline,
              ),
            ),
            SizedBox(height: context.xl * 1.2),
            _SectionHeader(
              text: 'Your taste',
              subtitle: 'Tune what Sippd learns about you. Change anytime.',
            ),
            SizedBox(height: context.m),
            const TasteProfileEditor(),
            SizedBox(height: context.xxl),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  final String? subtitle;
  const _SectionHeader({required this.text, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: context.headingFont * 0.85,
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
            letterSpacing: -0.3,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: context.xs),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool optional;
  const _FieldLabel({required this.text, this.optional = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w600,
            color: cs.onSurfaceVariant,
          ),
        ),
        if (optional) ...[
          SizedBox(width: context.xs),
          Text(
            '(optional)',
            style: TextStyle(fontSize: context.captionFont, color: cs.outline),
          ),
        ],
      ],
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
    final hasError =
        status == _UsernameState.taken ||
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
          strokeWidth: 2,
          color: cs.onSurfaceVariant,
        ),
      ),
    ),
    _UsernameState.available => Icon(
      PhosphorIconsRegular.checkCircle,
      color: cs.primary,
      size: context.w * 0.05,
    ),
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
      _UsernameState.invalid => ('Only letters, numbers, . and _', cs.error),
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
              child: Icon(
                PhosphorIconsRegular.camera,
                color: cs.onPrimary,
                size: context.w * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<_AvatarAction?> _showSourceSheet(
  BuildContext context, {
  required bool hasAvatar,
}) {
  return showModalBottomSheet<_AvatarAction>(
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
                title: Text(
                  'Take photo',
                  style: TextStyle(fontSize: ctx.bodyFont),
                ),
                onTap: () => Navigator.pop(ctx, _AvatarAction.camera),
              ),
              ListTile(
                leading: Icon(PhosphorIconsRegular.images, color: cs.primary),
                title: Text(
                  'Choose from gallery',
                  style: TextStyle(fontSize: ctx.bodyFont),
                ),
                onTap: () => Navigator.pop(ctx, _AvatarAction.gallery),
              ),
              if (hasAvatar) ...[
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: cs.outlineVariant,
                  indent: ctx.paddingH,
                  endIndent: ctx.paddingH,
                ),
                ListTile(
                  leading: Icon(PhosphorIconsRegular.trash, color: cs.error),
                  title: Text(
                    'Remove photo',
                    style: TextStyle(fontSize: ctx.bodyFont, color: cs.error),
                  ),
                  onTap: () => Navigator.pop(ctx, _AvatarAction.remove),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}
