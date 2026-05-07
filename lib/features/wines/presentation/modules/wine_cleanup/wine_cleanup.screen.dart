import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/canonical_merge_pair.entity.dart';

/// Manual cleanup of duplicate canonical_wine identities. Lists pairs
/// the server flagged as similar enough to potentially be the same
/// wine; user confirms which side to keep.
class WineCleanupScreen extends ConsumerWidget {
  const WineCleanupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final candidatesAsync = ref.watch(canonicalMergeCandidatesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Clean up duplicates',
          style: TextStyle(
            fontSize: context.bodyFont * 1.05,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: cs.surface,
        elevation: 0,
      ),
      body: candidatesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: ErrorView(
            title: "Couldn't load duplicates",
            onRetry: () => ref.invalidate(canonicalMergeCandidatesProvider),
            error: e,
          ),
        ),
        data: (pairs) => pairs.isEmpty
            ? const _EmptyState()
            : RefreshIndicator(
                onRefresh: () async =>
                    ref.invalidate(canonicalMergeCandidatesProvider),
                child: ListView.separated(
                  padding: EdgeInsets.all(context.paddingH),
                  itemCount: pairs.length,
                  separatorBuilder: (_, _) => SizedBox(height: context.s),
                  itemBuilder: (_, i) => _PairCard(pair: pairs[i]),
                ),
              ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.checkCircle,
              size: context.w * 0.16,
              color: cs.primary.withValues(alpha: 0.6),
            ),
            SizedBox(height: context.m),
            Text(
              'No duplicates to clean up',
              style: TextStyle(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              'Your wines are tidy. We check for near-duplicate names '
              'and winery matches automatically.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PairCard extends ConsumerWidget {
  const _PairCard({required this.pair});

  final CanonicalMergePair pair;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final pct = (pair.similarity * 100).round();
    return Container(
      padding: EdgeInsets.all(context.s * 1.5),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.xs * 1.2,
                  vertical: context.xs * 0.4,
                ),
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(context.xs),
                ),
                child: Text(
                  '$pct% match',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.s),
          _CandidateRow(
            label: 'A',
            name: pair.loserName,
            winery: pair.loserWinery,
            vintage: pair.loserVintage,
          ),
          SizedBox(height: context.xs),
          _CandidateRow(
            label: 'B',
            name: pair.winnerName,
            winery: pair.winnerWinery,
            vintage: pair.winnerVintage,
          ),
          SizedBox(height: context.s),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _confirmAndMerge(context, ref, keep: 'A'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: cs.outlineVariant),
                    foregroundColor: cs.onSurface,
                  ),
                  child: const Text('Keep A'),
                ),
              ),
              SizedBox(width: context.s),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _confirmAndMerge(context, ref, keep: 'B'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: cs.outlineVariant),
                    foregroundColor: cs.onSurface,
                  ),
                  child: const Text('Keep B'),
                ),
              ),
            ],
          ),
          SizedBox(height: context.xs),
          TextButton(
            onPressed: () {
              // No-op for now: declines appear next session unless we
              // wire a "different" decision per pair. Keep the affordance
              // visible but inert until decisions cover canonical pairs.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Skipped for now — will reappear next visit.'),
                ),
              );
            },
            child: Text(
              "They're different wines",
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: context.captionFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmAndMerge(
    BuildContext context,
    WidgetRef ref, {
    required String keep,
  }) async {
    final keepName = keep == 'A' ? pair.loserName : pair.winnerName;
    final dropName = keep == 'A' ? pair.winnerName : pair.loserName;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Merge into "$keepName"?'),
        content: Text(
          'Every rating, group share, and stat that pointed at '
          '"$dropName" will be moved over to "$keepName". '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Merge'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final winnerId = keep == 'A' ? pair.loserId : pair.winnerId;
    final loserId = keep == 'A' ? pair.winnerId : pair.loserId;
    try {
      await ref
          .read(canonicalMergeCandidatesProvider.notifier)
          .merge(loserId: loserId, winnerId: winnerId);
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Merged into "$keepName".')));
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Merge failed: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}

class _CandidateRow extends StatelessWidget {
  const _CandidateRow({
    required this.label,
    required this.name,
    required this.winery,
    required this.vintage,
  });

  final String label;
  final String name;
  final String? winery;
  final int? vintage;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.s),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.025),
      ),
      child: Row(
        children: [
          Container(
            width: context.w * 0.07,
            height: context.w * 0.07,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.captionFont * 1.1,
                fontWeight: FontWeight.w800,
                color: cs.primary,
              ),
            ),
          ),
          SizedBox(width: context.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
                if ((winery != null && winery!.isNotEmpty) || vintage != null)
                  Padding(
                    padding: EdgeInsets.only(top: context.xs * 0.5),
                    child: Text(
                      [
                        if (winery != null && winery!.isNotEmpty) winery!,
                        if (vintage != null) vintage.toString(),
                      ].join(' · '),
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
