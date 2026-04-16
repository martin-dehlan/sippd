import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/wine_card.widget.dart';
import '../../widgets/wine_type_filter.widget.dart';

class WineListScreen extends ConsumerWidget {
  const WineListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(wineControllerProvider);
    final typeFilter = ref.watch(wineTypeFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sippd',
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Column(
            children: [
              SizedBox(height: context.s),
              const WineTypeFilterBar(),
              SizedBox(height: context.m),
              Expanded(
                child: winesAsync.when(
                  data: (wines) {
                    final filtered = typeFilter == null
                        ? wines
                        : wines
                            .where((w) => w.type == typeFilter)
                            .toList();

                    if (filtered.isEmpty) {
                      return WineEmptyState(hasFilter: typeFilter != null);
                    }

                    final sorted = List<WineEntity>.from(filtered)
                      ..sort((a, b) => b.rating.compareTo(a.rating));

                    return ListView.separated(
                      itemCount: sorted.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: context.s),
                      itemBuilder: (context, index) => WineCardWidget(
                        wine: sorted[index],
                        rank: index + 1,
                        onTap: () => context
                            .push(AppRoutes.wineDetailPath(sorted[index].id)),
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(
                    child: Text('Error: $error'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.wineAdd),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class WineEmptyState extends StatelessWidget {
  final bool hasFilter;
  const WineEmptyState({super.key, this.hasFilter = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wine_bar_outlined,
            size: context.w * 0.15,
            color: Theme.of(context).colorScheme.outline,
          ),
          SizedBox(height: context.m),
          Text(
            hasFilter ? 'No wines match filter' : 'No wines yet',
            style: TextStyle(
              fontSize: context.bodyFont,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (!hasFilter) ...[
            SizedBox(height: context.s),
            Text(
              'Tap + to add your first wine',
              style: TextStyle(
                fontSize: context.captionFont,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
