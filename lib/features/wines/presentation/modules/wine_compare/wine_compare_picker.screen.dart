import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../controller/wine.provider.dart';
import '../../widgets/wine_card.widget.dart';

class WineComparePickerScreen extends ConsumerWidget {
  final String? excludeId;

  const WineComparePickerScreen({super.key, this.excludeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(wineControllerProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        title: const Text('Pick a wine to compare'),
      ),
      body: SafeArea(
        child: winesAsync.when(
          data: (wines) {
            final filtered = wines.where((w) => w.id != excludeId).toList()
              ..sort((a, b) => b.rating.compareTo(a.rating));
            if (filtered.isEmpty) {
              return _EmptyState();
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: context.paddingH,
                vertical: context.m,
              ),
              itemCount: filtered.length,
              separatorBuilder: (_, _) => SizedBox(height: context.s),
              itemBuilder: (_, i) {
                final wine = filtered[i];
                return WineCardWidget(
                  wine: wine,
                  rank: i + 1,
                  compact: true,
                  hideRatingIfEmpty: true,
                  onTap: () => context.pop(wine.id),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Padding(
              padding: EdgeInsets.all(context.paddingH),
              child: Text(
                describeAppError(e, fallback: "Couldn't load wines."),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.error,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wine_bar_outlined,
              size: context.w * 0.16,
              color: cs.outline,
            ),
            SizedBox(height: context.m),
            Text(
              'No other wines yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              'Add at least one more wine to compare.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

