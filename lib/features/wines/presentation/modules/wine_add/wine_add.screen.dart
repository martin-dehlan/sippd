import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/wine_form.widget.dart';

class WineAddScreen extends ConsumerWidget {
  const WineAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: WineForm(
          submitLabel: 'Save wine',
          onSubmit: (data) async {
            final wine = WineEntity(
              id: const Uuid().v4(),
              name: data.name,
              rating: data.rating,
              type: data.type,
              price: data.price,
              country: data.country,
              location: data.location?.shortDisplay,
              latitude: data.location?.lat,
              longitude: data.location?.lng,
              notes: data.notes,
              grape: data.grape,
              vintage: data.vintage,
              imageUrl: data.imageUrl,
              localImagePath: data.localImagePath,
              memoryImageUrl: data.memoryImageUrl,
              memoryLocalImagePath: data.memoryLocalImagePath,
              userId: ref.read(currentUserIdProvider) ?? 'local_user',
              createdAt: DateTime.now(),
            );
            await ref.read(wineControllerProvider.notifier).addWine(wine);
            if (context.mounted) context.pop();
          },
        ),
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  const _FloatingBackButton();

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
        onPressed: () => context.pop(),
        child: Icon(Icons.arrow_back_ios_new, size: context.w * 0.06),
      ),
    );
  }
}
