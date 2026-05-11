import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import 'widgets/wine_compare_panel.widget.dart';

class WineCompareScreen extends ConsumerWidget {
  final String? leftId;
  final String? rightId;

  const WineCompareScreen({super.key, this.leftId, this.rightId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    if (leftId == null || rightId == null || leftId == rightId) {
      return Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.surface,
          elevation: 0,
          title: const Text('Compare'),
        ),
        body: _MissingState(
          sameWine: leftId != null && leftId == rightId,
        ),
      );
    }

    final leftAsync = ref.watch(wineDetailProvider(leftId!));
    final rightAsync = ref.watch(wineDetailProvider(rightId!));

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        title: const Text('Compare'),
        actions: [
          IconButton(
            tooltip: 'Swap',
            icon: const Icon(PhosphorIconsRegular.swap),
            onPressed: () => context.pushReplacement(
              AppRoutes.wineComparePath(rightId!, leftId!),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _Body(leftAsync: leftAsync, rightAsync: rightAsync),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final AsyncValue<WineEntity?> leftAsync;
  final AsyncValue<WineEntity?> rightAsync;

  const _Body({required this.leftAsync, required this.rightAsync});

  @override
  Widget build(BuildContext context) {
    if (leftAsync.isLoading || rightAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final leftErr = leftAsync.hasError ? leftAsync.error : null;
    final rightErr = rightAsync.hasError ? rightAsync.error : null;
    if (leftErr != null || rightErr != null) {
      return _ErrorView(error: leftErr ?? rightErr!);
    }
    final left = leftAsync.valueOrNull;
    final right = rightAsync.valueOrNull;
    if (left == null || right == null) {
      return const _MissingState(sameWine: false);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH,
        vertical: context.m,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WineComparePanelWidget(wine: left, slotLabel: 'WINE A'),
          SizedBox(height: context.m),
          _VsDivider(),
          SizedBox(height: context.m),
          WineComparePanelWidget(wine: right, slotLabel: 'WINE B'),
          SizedBox(height: context.l),
        ],
      ),
    );
  }
}

class _VsDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(child: Divider(color: cs.outlineVariant, thickness: 0.5)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s),
          child: Text(
            'vs',
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w800,
              color: cs.outline,
              letterSpacing: 2,
            ),
          ),
        ),
        Expanded(child: Divider(color: cs.outlineVariant, thickness: 0.5)),
      ],
    );
  }
}

class _MissingState extends StatelessWidget {
  final bool sameWine;
  const _MissingState({required this.sameWine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final msg = sameWine
        ? 'Pick a different wine to compare.'
        : "Couldn't load both wines.";
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.wine,
              size: context.w * 0.16,
              color: cs.outline,
            ),
            SizedBox(height: context.m),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final Object error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.paddingH),
        child: Text(
          describeAppError(error, fallback: "Couldn't load wines."),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: context.captionFont, color: cs.error),
        ),
      ),
    );
  }
}
