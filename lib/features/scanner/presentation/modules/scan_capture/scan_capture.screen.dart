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
import 'widgets/scan_intro.widget.dart';
import 'widgets/scan_quota_block.widget.dart';
import 'widgets/scan_scanning.widget.dart';

/// Scan-to-add entry point. Captures a label photo, runs recognition
/// through the `recognize-label` Edge Function (server-held FastCork key
/// + quota), then hands a prefilled [WineFormData] to the add-wine
/// screen. The user reviews/edits everything before saving — the normal
/// local-first save path (incl. canonical-wine linking) is unchanged.
class ScanCaptureScreen extends ConsumerStatefulWidget {
  const ScanCaptureScreen({super.key});

  @override
  ConsumerState<ScanCaptureScreen> createState() => _ScanCaptureScreenState();
}

class _ScanCaptureScreenState extends ConsumerState<ScanCaptureScreen> {
  bool _handledResult = false;

  Future<void> _capture(ImageSource source) async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: source,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
      requestFullMetadata: false,
    );
    if (photo == null || !mounted) return;

    ref
        .read(analyticsProvider)
        .capture('scan_started', properties: {'source': source.name});
    await ref.read(scannerControllerProvider.notifier).scan(File(photo.path));
  }

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
    );
    // Reset so a back-navigation to this screen starts clean.
    ref.read(scannerControllerProvider.notifier).reset();
    context.pushReplacement(AppRoutes.wineAdd, extra: formData);
  }

  /// Escape hatch — always reachable: drop into the normal add-wine form
  /// with no prefill, skipping recognition entirely.
  void _addManually() {
    ref.read(analyticsProvider).capture('scan_manual_entry');
    ref.read(scannerControllerProvider.notifier).reset();
    context.pushReplacement(AppRoutes.wineAdd);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final state = ref.watch(scannerControllerProvider);

    // React once recognition lands: navigate only when FastCork actually
    // returned usable fields. A 200-but-empty result is a non-match, not
    // a hit — stay on-screen and show the "nothing found" state instead
    // of opening an empty add-wine form.
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Text('Scan label'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.paddingH),
          child: state.when(
            loading: () => const ScanScanning(),
            error: (e, _) {
              if (e is ValidationError && e.field == 'scan_quota') {
                ref.read(analyticsProvider).capture('scan_quota_exceeded');
                return ScanQuotaBlock(onAddManually: _addManually);
              }
              ref.read(analyticsProvider).capture('scan_failed');
              // Recognition failed — offer Retry, but always keep the
              // manual escape hatch so a bad scan never blocks adding.
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ErrorView(
                      error: e,
                      title: 'Could not read the label',
                      subtitle: 'Try again with a clearer, well-lit shot.',
                      onRetry: () =>
                          ref.read(scannerControllerProvider.notifier).reset(),
                    ),
                    TextButton(
                      onPressed: _addManually,
                      child: Text(
                        'Skip — enter by hand',
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              );
            },
            data: (result) {
              // Recognition ran but found no usable wine fields.
              if (result != null && !result.hasContent) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ErrorView(
                        title: 'No wine found on that label',
                        subtitle:
                            'Try a clearer, straight-on photo — or add it '
                            'by hand.',
                        onRetry: () => ref
                            .read(scannerControllerProvider.notifier)
                            .reset(),
                      ),
                      TextButton(
                        onPressed: _addManually,
                        child: Text(
                          'Skip — enter by hand',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ScanIntro(
                remaining: quota?.remaining,
                onCamera: () => _capture(ImageSource.camera),
                onGallery: () => _capture(ImageSource.gallery),
                onManual: _addManually,
              );
            },
          ),
        ),
      ),
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
