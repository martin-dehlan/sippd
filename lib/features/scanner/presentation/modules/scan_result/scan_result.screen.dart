import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../wines/controller/wine.provider.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/scanner.provider.dart';
import '../../../domain/entities/scanned_wine.entity.dart';

class ScanResultScreen extends ConsumerStatefulWidget {
  const ScanResultScreen({super.key});

  @override
  ConsumerState<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends ConsumerState<ScanResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeIn;

  double _rating = 5.0;
  WineType _type = WineType.red;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(scannerControllerProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: scanState.when(
          data: (data) {
            if (data == null || !data.found) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!context.mounted) return;
                context.pop();
              });
              return const SizedBox.shrink();
            }

            return FadeTransition(
              opacity: _fadeIn,
              child: _FoundView(
                data: data,
                rating: _rating,
                type: _type,
                onRatingChanged: (v) => setState(() => _rating = v),
                onTypeChanged: (v) => setState(() => _type = v),
                onSave: () => _saveWine(data),
                onEditMore: () => context.pushReplacement(AppRoutes.wineAdd),
              ),
            );
          },
          loading: () => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: cs.primary),
                SizedBox(height: context.m),
                Text('Looking up wine...',
                    style: TextStyle(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Future<void> _saveWine(ScannedWineData data) async {
    final wine = WineEntity(
      id: const Uuid().v4(),
      name: data.name ?? data.brand ?? 'Unknown Wine',
      rating: _rating,
      type: _type,
      country: data.country,
      grape: data.grape,
      vintage: data.vintage,
      imageUrl: data.imageUrl,
      userId: ref.read(currentUserIdProvider) ?? 'local_user',
      createdAt: DateTime.now(),
    );

    await ref.read(wineControllerProvider.notifier).addWine(wine);
    ref.read(scannerControllerProvider.notifier).reset();

    if (mounted) {
      context.go(AppRoutes.wines);
    }
  }
}

class _FoundView extends StatelessWidget {
  final ScannedWineData data;
  final double rating;
  final WineType type;
  final ValueChanged<double> onRatingChanged;
  final ValueChanged<WineType> onTypeChanged;
  final VoidCallback onSave;
  final VoidCallback onEditMore;

  const _FoundView({
    required this.data,
    required this.rating,
    required this.type,
    required this.onRatingChanged,
    required this.onTypeChanged,
    required this.onSave,
    required this.onEditMore,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: context.paddingH, vertical: context.l),
      children: [
        // Success indicator
        Center(
          child: Container(
            width: context.w * 0.16,
            height: context.w * 0.16,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: cs.primary, size: context.w * 0.08),
          ),
        ),
        SizedBox(height: context.m),
        Center(
          child: Text('Wine Found!',
              style: TextStyle(
                  fontSize: context.headingFont, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: context.xs),
        Center(
          child: Text('from Open Food Facts',
              style: TextStyle(
                  fontSize: context.captionFont, color: cs.onSurfaceVariant)),
        ),
        SizedBox(height: context.l),

        // Wine image
        if (data.imageUrl != null)
          Container(
            height: context.h * 0.2,
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(context.w * 0.04),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.w * 0.04),
              child: Image.network(data.imageUrl!, fit: BoxFit.contain),
            ),
          ),
        SizedBox(height: context.m),

        // Wine info card
        Container(
          padding: EdgeInsets.all(context.w * 0.04),
          decoration: BoxDecoration(
            color: cs.surfaceContainer,
            borderRadius: BorderRadius.circular(context.w * 0.04),
            border: Border.all(color: cs.outlineVariant, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.name != null)
                Text(data.name!,
                    style: TextStyle(
                        fontSize: context.bodyFont * 1.1,
                        fontWeight: FontWeight.bold)),
              if (data.brand != null) ...[
                SizedBox(height: context.xs),
                Text(data.brand!,
                    style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant)),
              ],
              SizedBox(height: context.s),
              Wrap(
                spacing: context.w * 0.02,
                runSpacing: context.xs,
                children: [
                  if (data.country != null)
                    _InfoChip(icon: Icons.flag_outlined, label: data.country!),
                  if (data.grape != null)
                    _InfoChip(icon: Icons.grass, label: data.grape!),
                  if (data.barcode != null)
                    _InfoChip(
                        icon: Icons.qr_code, label: data.barcode!),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: context.l),

        // Quick rating
        Text('Your Rating',
            style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w700,
                color: cs.primary)),
        SizedBox(height: context.s),
        Row(
          children: [
            Text('0',
                style: TextStyle(
                    fontSize: context.captionFont, color: cs.outline)),
            Expanded(
              child: Slider(
                value: rating,
                min: 0,
                max: 10,
                divisions: 20,
                label: rating.toStringAsFixed(1),
                onChanged: onRatingChanged,
              ),
            ),
            Text('10',
                style: TextStyle(
                    fontSize: context.captionFont, color: cs.outline)),
            SizedBox(width: context.w * 0.02),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.025, vertical: context.xs),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(context.w * 0.02),
              ),
              child: Text(rating.toStringAsFixed(1),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: cs.primary)),
            ),
          ],
        ),
        SizedBox(height: context.m),

        // Wine type
        Text('Type',
            style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w700,
                color: cs.primary)),
        SizedBox(height: context.s),
        SegmentedButton<WineType>(
          segments: const [
            ButtonSegment(value: WineType.red, label: Text('Red')),
            ButtonSegment(value: WineType.white, label: Text('White')),
            ButtonSegment(value: WineType.rose, label: Text('Rosé')),
            ButtonSegment(value: WineType.sparkling, label: Text('Sparkling')),
          ],
          selected: {type},
          onSelectionChanged: (v) => onTypeChanged(v.first),
        ),
        SizedBox(height: context.xl),

        // Actions
        SizedBox(
          width: double.infinity,
          height: context.h * 0.06,
          child: ElevatedButton(
            onPressed: onSave,
            child: Text('Save to Collection',
                style: TextStyle(
                    fontSize: context.bodyFont, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: context.s),
        Center(
          child: TextButton(
            onPressed: onEditMore,
            child: Text('Edit more details',
                style: TextStyle(fontSize: context.captionFont)),
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.025, vertical: context.xs),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.015),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.w * 0.035, color: cs.primary),
          SizedBox(width: context.w * 0.01),
          Text(label,
              style: TextStyle(
                  fontSize: context.captionFont * 0.9,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
