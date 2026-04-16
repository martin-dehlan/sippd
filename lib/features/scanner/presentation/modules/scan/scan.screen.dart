import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/scanner.provider.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final _mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  bool _isProcessing = false;

  @override
  void dispose() {
    _mobileScannerController.dispose();
    super.dispose();
  }

  Future<void> _onBarcodeDetected(BarcodeCapture capture) async {
    if (_isProcessing) return;
    final barcode = capture.barcodes.firstOrNull?.rawValue;
    if (barcode == null || barcode.isEmpty) return;

    setState(() => _isProcessing = true);
    await _mobileScannerController.stop();

    await ref
        .read(scannerControllerProvider.notifier)
        .lookupBarcode(barcode);
    if (!mounted) return;

    final data = ref.read(scannerControllerProvider).valueOrNull;
    if (data != null && data.found) {
      context.push(AppRoutes.scanResult);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Couldn't find this wine. Add it manually?"),
        action: SnackBarAction(
          label: 'Add',
          onPressed: () => context.push(AppRoutes.wineAdd),
        ),
      ),
    );
    ref.read(scannerControllerProvider.notifier).reset();
    setState(() => _isProcessing = false);
    await _mobileScannerController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera
          MobileScanner(
            controller: _mobileScannerController,
            onDetect: _onBarcodeDetected,
          ),

          // Overlay
          ScanOverlay(isProcessing: _isProcessing),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.w * 0.03, vertical: context.s),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ScanButton(
                      icon: Icons.close,
                      onTap: () => Navigator.pop(context),
                    ),
                    Text(
                      'Scan Barcode',
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    _ScanButton(
                      icon: Icons.flash_on,
                      onTap: () => _mobileScannerController.toggleTorch(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.paddingH),
                child: Column(
                  children: [
                    Text(
                      'Point at wine barcode',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: context.m),
                    Row(
                      children: [
                        Expanded(
                          child: _BottomAction(
                            icon: Icons.camera_alt_outlined,
                            label: 'Scan Label',
                            onTap: () =>
                                context.push(AppRoutes.scanLabel),
                          ),
                        ),
                        SizedBox(width: context.w * 0.03),
                        Expanded(
                          child: _BottomAction(
                            icon: Icons.edit_outlined,
                            label: 'Add Manually',
                            onTap: () => context.push(AppRoutes.wineAdd),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScanOverlay extends StatelessWidget {
  final bool isProcessing;
  const ScanOverlay({super.key, required this.isProcessing});

  @override
  Widget build(BuildContext context) {
    final scanArea = context.w * 0.7;

    return CustomPaint(
      painter: _ScanOverlayPainter(
        scanAreaSize: scanArea,
        borderColor:
            isProcessing ? Theme.of(context).colorScheme.primary : Colors.white,
      ),
      child: isProcessing
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(height: context.m),
                  Text('Looking up wine...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: context.captionFont)),
                ],
              ),
            )
          : const SizedBox.expand(),
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  final double scanAreaSize;
  final Color borderColor;

  _ScanOverlayPainter({required this.scanAreaSize, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 40),
      width: scanAreaSize,
      height: scanAreaSize,
    );

    // Dark overlay with cutout
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(16)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(
        path, Paint()..color = Colors.black.withValues(alpha: 0.6));

    // Corner brackets
    final cornerLength = scanAreaSize * 0.12;
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Top-left
    canvas.drawLine(
        Offset(rect.left, rect.top + cornerLength), rect.topLeft, paint);
    canvas.drawLine(
        rect.topLeft, Offset(rect.left + cornerLength, rect.top), paint);

    // Top-right
    canvas.drawLine(Offset(rect.right - cornerLength, rect.top),
        rect.topRight, paint);
    canvas.drawLine(
        rect.topRight, Offset(rect.right, rect.top + cornerLength), paint);

    // Bottom-left
    canvas.drawLine(Offset(rect.left, rect.bottom - cornerLength),
        rect.bottomLeft, paint);
    canvas.drawLine(rect.bottomLeft,
        Offset(rect.left + cornerLength, rect.bottom), paint);

    // Bottom-right
    canvas.drawLine(Offset(rect.right - cornerLength, rect.bottom),
        rect.bottomRight, paint);
    canvas.drawLine(rect.bottomRight,
        Offset(rect.right, rect.bottom - cornerLength), paint);
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter old) =>
      old.borderColor != borderColor;
}

class _ScanButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ScanButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.w * 0.1,
        height: context.w * 0.1,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: context.w * 0.05),
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.m),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: context.w * 0.06),
            SizedBox(height: context.xs),
            Text(label,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
