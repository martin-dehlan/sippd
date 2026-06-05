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
    // feeds taste-match, and infer wine type from the grape's color.
    String? canonicalGrapeId;
    String? grapeDisplay;
    var type = WineType.red;
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
          if (exact.color == GrapeColor.white) type = WineType.white;
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

  void _openPaywall() {
    context.push(AppRoutes.paywall, extra: const {'source': 'wine_scan_quota'});
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final state = ref.watch(scannerControllerProvider);

    // Navigate out of build once recognition lands.
    ref.listen(scannerControllerProvider, (_, next) {
      next.whenData((result) {
        if (result != null) _onRecognized(result);
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
                return ScanQuotaBlock(onUpgrade: _openPaywall);
              }
              ref.read(analyticsProvider).capture('scan_failed');
              return ErrorView(
                error: e,
                title: 'Could not read the label',
                subtitle: 'Try again with a clearer, well-lit shot.',
                onRetry: () =>
                    ref.read(scannerControllerProvider.notifier).reset(),
              );
            },
            data: (result) => ScanIntro(
              remaining: quota?.remaining,
              onCamera: () => _capture(ImageSource.camera),
              onGallery: () => _capture(ImageSource.gallery),
            ),
          ),
        ),
      ),
    );
  }
}
