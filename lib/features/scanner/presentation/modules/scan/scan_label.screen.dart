import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';

class ScanLabelScreen extends ConsumerStatefulWidget {
  const ScanLabelScreen({super.key});

  @override
  ConsumerState<ScanLabelScreen> createState() => _ScanLabelScreenState();
}

class _ScanLabelScreenState extends ConsumerState<ScanLabelScreen>
    with SingleTickerProviderStateMixin {
  String? _imagePath;
  bool _isCaptured = false;
  late final AnimationController _animController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    _scaleAnim = CurvedAnimation(
        parent: _animController, curve: Curves.easeOutBack);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _capturePhoto() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (photo != null && mounted) {
      setState(() {
        _imagePath = photo.path;
        _isCaptured = true;
      });
      _animController.forward();
    }
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (photo != null && mounted) {
      setState(() {
        _imagePath = photo.path;
        _isCaptured = true;
      });
      _animController.forward();
    }
  }

  void _continueToAdd() {
    // TODO: Future — send to Claude Vision API for label recognition
    // For now, go to manual add with the image path
    context.pushReplacement(AppRoutes.wineAdd);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Column(
            children: [
              // Header
              SizedBox(height: context.s),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: context.w * 0.1,
                      height: context.w * 0.1,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: context.w * 0.05),
                    ),
                  ),
                  const Spacer(),
                  Text('Wine Label',
                      style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700)),
                  const Spacer(),
                  SizedBox(width: context.w * 0.1),
                ],
              ),
              SizedBox(height: context.l),

              // Image area
              Expanded(
                child: _isCaptured
                    ? _CapturedView(
                        imagePath: _imagePath!,
                        scaleAnimation: _scaleAnim,
                        onRetake: () {
                          _animController.reset();
                          setState(() => _isCaptured = false);
                        },
                      )
                    : _CapturePrompt(
                        onCamera: _capturePhoto,
                        onGallery: _pickFromGallery,
                      ),
              ),

              // Bottom action
              if (_isCaptured) ...[
                SizedBox(height: context.m),
                SizedBox(
                  width: double.infinity,
                  height: context.h * 0.06,
                  child: ElevatedButton(
                    onPressed: _continueToAdd,
                    child: Text('Continue to Add Wine',
                        style: TextStyle(
                            fontSize: context.bodyFont,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(height: context.s),
                Center(
                  child: Text(
                    'Label recognition coming soon',
                    style: TextStyle(
                        fontSize: context.captionFont * 0.9,
                        color: cs.onSurfaceVariant),
                  ),
                ),
              ],
              SizedBox(height: context.l),
            ],
          ),
        ),
      ),
    );
  }
}

class _CapturePrompt extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const _CapturePrompt({required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: context.w * 0.25,
          height: context.w * 0.25,
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.photo_camera_outlined,
              size: context.w * 0.12, color: cs.primary),
        ),
        SizedBox(height: context.l),
        Text('Take a photo of the wine label',
            style: TextStyle(
                fontSize: context.bodyFont, fontWeight: FontWeight.w600)),
        SizedBox(height: context.xs),
        Text(
          'We\'ll help you fill in the details',
          style: TextStyle(
              fontSize: context.captionFont, color: cs.onSurfaceVariant),
        ),
        SizedBox(height: context.xl),
        SizedBox(
          width: context.w * 0.6,
          height: context.h * 0.06,
          child: ElevatedButton.icon(
            onPressed: onCamera,
            icon: const Icon(Icons.camera_alt),
            label: Text('Take Photo',
                style: TextStyle(
                    fontSize: context.bodyFont, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: context.s),
        TextButton.icon(
          onPressed: onGallery,
          icon: Icon(Icons.photo_library_outlined, size: context.w * 0.045),
          label: Text('Choose from Gallery',
              style: TextStyle(fontSize: context.captionFont)),
        ),
      ],
    );
  }
}

class _CapturedView extends StatelessWidget {
  final String imagePath;
  final Animation<double> scaleAnimation;
  final VoidCallback onRetake;

  const _CapturedView({
    required this.imagePath,
    required this.scaleAnimation,
    required this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.w * 0.04),
                border: Border.all(color: cs.primary, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.w * 0.04 - 2),
                child: Image.file(File(imagePath), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        SizedBox(height: context.m),
        TextButton.icon(
          onPressed: onRetake,
          icon: const Icon(Icons.refresh),
          label: Text('Retake',
              style: TextStyle(fontSize: context.captionFont)),
        ),
      ],
    );
  }
}
