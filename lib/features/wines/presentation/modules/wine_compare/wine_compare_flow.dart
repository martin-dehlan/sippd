import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/app.routes.dart';

Future<void> startCompareFlow(
  BuildContext context, {
  required String sourceWineId,
}) async {
  final picked = await context.push<String?>(
    AppRoutes.wineComparePickerPath(sourceWineId),
  );
  if (picked == null || picked.isEmpty) return;
  if (!context.mounted) return;
  context.push(AppRoutes.wineComparePath(sourceWineId, picked));
}
