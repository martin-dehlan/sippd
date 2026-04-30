import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../../share_cards/presentation/widgets/wine_share_prompt_sheet.dart';
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
  final GlobalKey<WineFormState> _formKey = GlobalKey<WineFormState>();
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
      canonicalGrapeId: data.canonicalGrapeId,
      grapeFreetext: data.grapeFreetext,
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
    if (!mounted) return;
    // Nudge to share before bouncing back to the list. Sheet always
    // dismisses (share, "Maybe later", or drag) so the post-save pop
    // still runs whatever the user chose.
    setState(() => _allowPop = true);
    await showWineSharePromptSheet(
      context: context,
      wine: wine,
      triggerSource: 'wine_add_post_save',
    );
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
          child: Stack(
            children: [
              WineForm(
                key: _formKey,
                submitLabel: 'Save wine',
                showInlineSubmit: false,
                onChanged: (data) => setState(() => _current = data),
                onSubmit: (_) => _save(),
              ),
              Positioned(
                right: context.paddingH,
                bottom: context.m,
                child: _SaveWineFab(
                  onPressed: () => _formKey.currentState?.submit(),
                ),
              ),
            ],
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

class _SaveWineFab extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveWineFab({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final height = context.w * 0.16;
    return SizedBox(
      height: height,
      child: FloatingActionButton.extended(
        heroTag: 'wine-add-save',
        onPressed: onPressed,
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 4,
        extendedIconLabelSpacing: context.w * 0.025,
        extendedPadding: EdgeInsets.symmetric(horizontal: context.w * 0.06),
        shape: const StadiumBorder(),
        icon: Icon(
          PhosphorIconsBold.check,
          size: context.w * 0.05,
        ),
        label: Text(
          'Save wine',
          style: TextStyle(
            fontSize: context.bodyFont * 1.02,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
