import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../utils/responsive.dart';
import 'app_snack.dart';

class PhotoErrorHandler {
  const PhotoErrorHandler._();

  static Future<void> handle(BuildContext context, Object error) async {
    final permission = _permissionDenial(error);
    if (permission != null) {
      await _showPermissionDialog(context, permission);
      return;
    }
    if (context.mounted) {
      AppSnack.error(context, 'Could not load photo. Please try again.');
    }
  }

  static _PermissionKind? _permissionDenial(Object error) {
    if (error is PlatformException) {
      switch (error.code) {
        case 'camera_access_denied':
          return _PermissionKind.camera;
        case 'photo_access_denied':
          return _PermissionKind.photos;
      }
    }
    final text = error.toString().toLowerCase();
    if (text.contains('camera_access_denied')) return _PermissionKind.camera;
    if (text.contains('photo_access_denied')) return _PermissionKind.photos;
    return null;
  }

  static Future<void> _showPermissionDialog(
    BuildContext context,
    _PermissionKind kind,
  ) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => _PermissionDialog(kind: kind),
    );
  }
}

enum _PermissionKind { camera, photos }

class _PermissionDialog extends StatelessWidget {
  final _PermissionKind kind;
  const _PermissionDialog({required this.kind});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (icon, title, body) = switch (kind) {
      _PermissionKind.camera => (
        PhosphorIconsRegular.camera,
        'Camera access off',
        'Sippd needs camera access to capture wine photos. Enable it in Settings to continue.',
      ),
      _PermissionKind.photos => (
        PhosphorIconsRegular.images,
        'Photos access off',
        'Sippd needs photo library access to attach images. Enable it in Settings to continue.',
      ),
    };

    return Dialog(
      backgroundColor: cs.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.w * 0.06),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          context.paddingH,
          context.l,
          context.paddingH,
          context.m,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: context.w * 0.16,
                height: context.w * 0.16,
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: cs.primary, size: context.w * 0.08),
              ),
            ),
            SizedBox(height: context.m),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onSurface,
                fontSize: context.headingFont,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: context.s),
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: context.bodyFont * 0.95,
                height: 1.4,
              ),
            ),
            SizedBox(height: context.l),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: EdgeInsets.symmetric(vertical: context.m),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.04),
                ),
              ),
              child: Text(
                'Got it',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
