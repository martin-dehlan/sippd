import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../../domain/entities/wine_memory.entity.dart';
import '../../widgets/wine_form.widget.dart';

class WineAddScreen extends ConsumerStatefulWidget {
  const WineAddScreen({super.key});

  @override
  ConsumerState<WineAddScreen> createState() => _WineAddScreenState();
}

class _WineAddScreenState extends ConsumerState<WineAddScreen> {
  WineFormData? _current;
  bool _allowPop = false;

  bool get _isDirty {
    final d = _current;
    if (d == null) return false;
    return d.name.isNotEmpty ||
        d.rating != 5.0 ||
        d.type != WineType.red ||
        d.price != null ||
        d.vintage != null ||
        (d.grape?.isNotEmpty ?? false) ||
        (d.winery?.isNotEmpty ?? false) ||
        (d.country?.isNotEmpty ?? false) ||
        d.location != null ||
        (d.notes?.isNotEmpty ?? false) ||
        d.imageUrl != null ||
        d.localImagePath != null ||
        d.memories.isNotEmpty;
  }

  Future<bool> _confirmDiscard() async {
    if (!_isDirty) return true;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return AlertDialog(
          title: const Text('Discard new wine?'),
          content: const Text(
            "You haven't saved this wine yet. Leaving now will discard your changes.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Keep editing'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text('Discard', style: TextStyle(color: cs.error)),
            ),
          ],
        );
      },
    );
    return confirmed ?? false;
  }

  Future<void> _save() async {
    final data = _current;
    if (data == null) return;

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final wineId = const Uuid().v4();
    final wine = WineEntity(
      id: wineId,
      name: data.name,
      rating: data.rating,
      type: data.type,
      price: data.price,
      country: data.country,
      region: data.region,
      location: data.location?.shortDisplay,
      latitude: data.location?.lat,
      longitude: data.location?.lng,
      notes: data.notes,
      grape: data.grape,
      winery: data.winery,
      vintage: data.vintage,
      imageUrl: data.imageUrl,
      localImagePath: data.localImagePath,
      userId: userId,
      createdAt: DateTime.now(),
    );
    await ref.read(wineControllerProvider.notifier).addWine(wine);

    final repo = ref.read(wineMemoryRepositoryProvider);
    for (final m in data.memories) {
      await repo.addMemory(
        WineMemoryEntity(
          id: m.id,
          wineId: wineId,
          userId: userId,
          imageUrl: m.imageUrl,
          localImagePath: m.localImagePath,
          createdAt: DateTime.now(),
        ),
      );
    }
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _allowPop || !_isDirty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final ok = await _confirmDiscard();
        if (!ok || !mounted) return;
        setState(() => _allowPop = true);
        // ignore: use_build_context_synchronously
        context.pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: WineForm(
            submitLabel: 'Save wine',
            onChanged: (data) => setState(() => _current = data),
            onSubmit: (_) => _save(),
          ),
        ),
        floatingActionButton: _FloatingBackButton(
          onPressed: () async {
            final ok = await _confirmDiscard();
            if (!ok || !mounted) return;
            setState(() => _allowPop = true);
            // ignore: use_build_context_synchronously
            context.pop();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
        heroTag: 'wine-add-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}
