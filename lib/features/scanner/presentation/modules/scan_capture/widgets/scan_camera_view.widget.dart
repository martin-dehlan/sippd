import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';

/// Live camera preview with a lean capture overlay. Camera-first: opens
/// straight into the viewfinder. Controls are drawn in white over the
/// live feed (a deliberate exception to the theme-colour rule — text/icons
/// must read against arbitrary camera content). Falls back to gallery +
/// manual entry when camera permission is denied or unavailable.
class ScanCameraView extends StatefulWidget {
  final int? remaining;
  final void Function(File image) onCapture;
  final VoidCallback onGallery;
  final VoidCallback onManual;
  final VoidCallback onClose;

  const ScanCameraView({
    super.key,
    required this.remaining,
    required this.onCapture,
    required this.onGallery,
    required this.onManual,
    required this.onClose,
  });

  @override
  State<ScanCameraView> createState() => _ScanCameraViewState();
}

class _ScanCameraViewState extends State<ScanCameraView>
    with WidgetsBindingObserver {
  CameraController? _controller;
  bool _initializing = true;
  bool _unavailable = false;
  bool _capturing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setup();
  }

  Future<void> _setup() async {
    setState(() {
      _initializing = true;
      _unavailable = false;
    });
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) throw CameraException('no_camera', 'none');
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _initializing = false;
      });
    } catch (_) {
      // Permission denied / no camera / init failure → graceful fallback.
      if (mounted) {
        setState(() {
          _unavailable = true;
          _initializing = false;
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final c = _controller;
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _controller = null;
      c?.dispose();
    } else if (state == AppLifecycleState.resumed && c == null) {
      _setup();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _capture() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized || _capturing) return;
    setState(() => _capturing = true);
    try {
      final shot = await c.takePicture();
      if (mounted) widget.onCapture(File(shot.path));
    } catch (_) {
      // Swallow — a failed shutter just lets the user try again.
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final Widget background;
    if (_initializing) {
      background = const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    } else if (_unavailable || controller == null) {
      background = _CameraUnavailable(
        onGallery: widget.onGallery,
        onManual: widget.onManual,
      );
    } else {
      background = SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller.value.previewSize?.height ?? context.w,
            height: controller.value.previewSize?.width ?? context.h,
            child: CameraPreview(controller),
          ),
        ),
      );
    }

    final live = controller != null && !_unavailable;
    return Stack(
      fit: StackFit.expand,
      children: [
        background,
        if (live) const _FramingGuide(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.paddingH),
            child: Column(
              children: [
                _TopBar(remaining: widget.remaining, onClose: widget.onClose),
                const Spacer(),
                if (live)
                  _BottomControls(
                    capturing: _capturing,
                    onCapture: _capture,
                    onGallery: widget.onGallery,
                    onManual: widget.onManual,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  final int? remaining;
  final VoidCallback onClose;
  const _TopBar({required this.remaining, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _RoundButton(icon: PhosphorIconsRegular.x, onTap: onClose),
        if (remaining != null)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.w * 0.03,
              vertical: context.xs * 1.2,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(context.w * 0.05),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIconsRegular.scan,
                  size: context.bodyFont,
                  color: Colors.white,
                ),
                SizedBox(width: context.w * 0.015),
                Text(
                  '$remaining',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _FramingGuide extends StatelessWidget {
  const _FramingGuide();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.w * 0.7,
        height: context.h * 0.42,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.7),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
      ),
    );
  }
}

class _BottomControls extends StatelessWidget {
  final bool capturing;
  final VoidCallback onCapture;
  final VoidCallback onGallery;
  final VoidCallback onManual;
  const _BottomControls({
    required this.capturing,
    required this.onCapture,
    required this.onGallery,
    required this.onManual,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RoundButton(icon: PhosphorIconsRegular.image, onTap: onGallery),
            SizedBox(width: context.w * 0.12),
            _ShutterButton(capturing: capturing, onTap: onCapture),
            SizedBox(width: context.w * 0.12),
            SizedBox(width: context.w * 0.12), // balance the gallery button
          ],
        ),
        SizedBox(height: context.m),
        TextButton(
          onPressed: onManual,
          child: Text(
            'Skip — enter by hand',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: context.captionFont,
            ),
          ),
        ),
      ],
    );
  }
}

class _ShutterButton extends StatelessWidget {
  final bool capturing;
  final VoidCallback onTap;
  const _ShutterButton({required this.capturing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = context.w * 0.18;
    return GestureDetector(
      onTap: capturing ? null : onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.w * 0.012),
          child: capturing
              ? const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = context.w * 0.12;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.45),
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.45),
      ),
    );
  }
}

class _CameraUnavailable extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onManual;
  const _CameraUnavailable({required this.onGallery, required this.onManual});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.paddingH * 1.4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.cameraSlash,
              size: context.w * 0.16,
              color: Colors.white70,
            ),
            SizedBox(height: context.l),
            Text(
              'Camera unavailable',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              'Grant camera access in Settings, pick a photo from your '
              'gallery, or add the wine by hand.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: context.captionFont,
              ),
            ),
            SizedBox(height: context.xl),
            FilledButton.icon(
              onPressed: onGallery,
              icon: const Icon(PhosphorIconsRegular.image),
              label: const Text('Choose from gallery'),
            ),
            SizedBox(height: context.s),
            TextButton(
              onPressed: onManual,
              child: Text(
                'Skip — enter by hand',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
