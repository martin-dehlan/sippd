import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/errors/app_error.dart';
import '../../../../../common/services/analytics/analytics.provider.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../wines/controller/wine.provider.dart';
import '../../../../wines/domain/entities/canonical_grape.entity.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/scanner.provider.dart';
import '../../../domain/entities/scan_result.entity.dart';
import '../../scan_to_form.dart';
import 'widgets/scan_camera_view.widget.dart';
import 'widgets/scan_quota_block.widget.dart';

/// Scan-to-add entry point. Camera-first: opens straight into a live
/// viewfinder. A captured (or gallery) label photo runs recognition
/// through the `recognize-label` Edge Function, then hands a prefilled
/// [WineFormData] to the add-wine screen. The user reviews/edits
/// everything before saving — the normal local-first save path is
/// unchanged. Manual entry is always one tap away.
class ScanCaptureScreen extends ConsumerStatefulWidget {
  const ScanCaptureScreen({super.key});

  @override
  ConsumerState<ScanCaptureScreen> createState() => _ScanCaptureScreenState();
}

class _ScanCaptureScreenState extends ConsumerState<ScanCaptureScreen> {
  bool _handledResult = false;
  String? _capturedImagePath;

  Future<void> _scan(File image, String source) async {
    _capturedImagePath = image.path;
    ref
        .read(analyticsProvider)
        .capture('scan_started', properties: {'source': source});
    await ref.read(scannerControllerProvider.notifier).scan(image);
  }

  Future<void> _pickFromGallery() async {
    final photo = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
      requestFullMetadata: false,
    );
    if (photo == null || !mounted) return;
    await _scan(File(photo.path), 'gallery');
  }

  void _reset() => ref.read(scannerControllerProvider.notifier).reset();

  Future<void> _onRecognized(ScanResultEntity result) async {
    if (_handledResult) return;
    _handledResult = true;

    ref
        .read(analyticsProvider)
        .capture(
          'scan_success',
          properties: {
            'has_producer': result.producer != null,
            'has_vintage': result.vintage != null,
            'grape_count': result.grapes.length,
            'mock': result.isMock,
          },
        );

    // S1.6 — resolve the first recognized grape to a canonical id so it
    // feeds taste-match. Prefer FastCork's explicit wine_type; only infer
    // type from the grape's color when FastCork didn't report one.
    String? canonicalGrapeId;
    String? grapeDisplay;
    final fastcorkType = _wineTypeFromScan(result.wineType);
    var type = fastcorkType ?? WineType.red;
    if (result.grapes.isNotEmpty) {
      grapeDisplay = result.grapes.first;
      try {
        final matches = await ref
            .read(canonicalGrapeRepositoryProvider)
            .search(result.grapes.first);
        if (matches.isNotEmpty) {
          final exact = matches.firstWhere(
            (g) => g.name.toLowerCase() == result.grapes.first.toLowerCase(),
            orElse: () => matches.first,
          );
          canonicalGrapeId = exact.id;
          grapeDisplay = exact.name;
          if (fastcorkType == null && exact.color == GrapeColor.white) {
            type = WineType.white;
          }
        }
      } catch (_) {
        // Offline / sync miss — fall back to free-text grape.
      }
    }

    if (!mounted) return;
    final formData = scanToFormData(
      result,
      canonicalGrapeId: canonicalGrapeId,
      grapeDisplay: grapeDisplay,
      type: type,
      localImagePath: _capturedImagePath,
    );
    _reset();
    context.pushReplacement(AppRoutes.wineAdd, extra: formData);
  }

  void _openPaywall() {
    ref.read(analyticsProvider).capture('scan_quota_upgrade_tap');
    context.push(AppRoutes.paywall, extra: const {'source': 'wine_scan_quota'});
  }

  /// Escape hatch — always reachable: drop into the normal add-wine form
  /// with no prefill, skipping recognition entirely.
  void _addManually() {
    ref.read(analyticsProvider).capture('scan_manual_entry');
    _reset();
    context.pushReplacement(AppRoutes.wineAdd);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scannerControllerProvider);

    // React once recognition lands: navigate only when FastCork actually
    // returned usable fields. A 200-but-empty result is a non-match, not
    // a hit — stay on-screen and show the "nothing found" overlay.
    ref.listen(scannerControllerProvider, (_, next) {
      next.whenData((result) {
        if (result == null) return;
        if (result.hasContent) {
          _onRecognized(result);
        } else {
          ref.read(analyticsProvider).capture('scan_no_match');
        }
      });
    });

    final quota = ref.watch(scanQuotaProvider).valueOrNull;

    final Widget? overlay = state.when(
      loading: () => const _ScanningOverlay(),
      data: (result) {
        if (result != null && !result.hasContent) {
          return _OverlayCard(
            child: _ScanFailure(
              title: 'No wine found on that label',
              subtitle: 'Try a clearer, straight-on photo — or add it by hand.',
              onRetry: _reset,
              onManual: _addManually,
            ),
          );
        }
        return null;
      },
      error: (e, _) {
        if (e is ValidationError && e.field == 'scan_quota') {
          ref.read(analyticsProvider).capture('scan_quota_exceeded');
          return _OverlayCard(
            child: ScanQuotaBlock(
              onUpgrade: _openPaywall,
              onAddManually: _addManually,
            ),
          );
        }
        ref.read(analyticsProvider).capture('scan_failed');
        return _OverlayCard(
          child: _ScanFailure(
            error: e,
            title: 'Could not read the label',
            subtitle: 'Try again with a clearer, well-lit shot.',
            onRetry: _reset,
            onManual: _addManually,
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ScanCameraView(
            remaining: quota?.remaining,
            onCapture: (file) => _scan(file, 'camera'),
            onGallery: _pickFromGallery,
            onManual: _addManually,
            onClose: () => context.pop(),
          ),
          if (overlay != null) Positioned.fill(child: overlay),
        ],
      ),
    );
  }
}

/// Full-screen scrim with a spinner while recognition runs.
class _ScanningOverlay extends StatelessWidget {
  const _ScanningOverlay();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            SizedBox(height: context.l),
            Text(
              'Reading the label…',
              style: TextStyle(color: Colors.white, fontSize: context.bodyFont),
            ),
          ],
        ),
      ),
    );
  }
}

/// Scrim + themed card hosting a recognition outcome (error / not-found /
/// quota), so the existing content widgets stay readable over the camera.
class _OverlayCard extends StatelessWidget {
  final Widget child;
  const _OverlayCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.6),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(context.paddingH * 1.5),
          padding: EdgeInsets.all(context.paddingH * 1.2),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(context.w * 0.04),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ScanFailure extends StatelessWidget {
  final Object? error;
  final String title;
  final String subtitle;
  final VoidCallback onRetry;
  final VoidCallback onManual;
  const _ScanFailure({
    this.error,
    required this.title,
    required this.subtitle,
    required this.onRetry,
    required this.onManual,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ErrorView(
          error: error,
          title: title,
          subtitle: subtitle,
          onRetry: onRetry,
        ),
        TextButton(
          onPressed: onManual,
          child: Text(
            'Skip — enter by hand',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

/// Map FastCork's free-form `wine_type` string onto the app's [WineType].
/// Returns null when absent/unrecognized so the caller can fall back to
/// grape-colour inference.
WineType? _wineTypeFromScan(String? raw) {
  switch (raw?.trim().toLowerCase()) {
    case 'white':
      return WineType.white;
    case 'red':
      return WineType.red;
    case 'rose':
    case 'rosé':
    case 'rosado':
    case 'rosato':
      return WineType.rose;
    case 'sparkling':
    case 'champagne':
    case 'cremant':
    case 'crémant':
    case 'sekt':
    case 'prosecco':
    case 'cava':
      return WineType.sparkling;
    default:
      return null;
  }
}
