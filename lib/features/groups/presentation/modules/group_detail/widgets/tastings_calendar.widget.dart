import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';
import '../../../../../tastings/controller/tastings.provider.dart';
import '../../../../../tastings/domain/entities/tasting.entity.dart';

class TastingsCalendar extends ConsumerStatefulWidget {
  final String groupId;
  const TastingsCalendar({super.key, required this.groupId});

  @override
  ConsumerState<TastingsCalendar> createState() =>
      _TastingsCalendarState();
}

class _TastingsCalendarState extends ConsumerState<TastingsCalendar> {
  static const int _dayCount = 14;
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _selected = _dateOnly(DateTime.now());
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tastingsAsync =
        ref.watch(groupTastingsProvider(widget.groupId));

    return tastingsAsync.when(
      data: (tastings) {
        final today = _dateOnly(DateTime.now());
        final days = List.generate(
            _dayCount, (i) => today.add(Duration(days: i)));

        final byDay = <DateTime, List<TastingEntity>>{};
        for (final t in tastings) {
          final d = _dateOnly(t.scheduledAt.toLocal());
          byDay.putIfAbsent(d, () => []).add(t);
        }

        final selectedTastings = byDay[_selected] ?? const [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.w * 0.18,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: context.paddingH * 1.3),
                itemCount: days.length,
                separatorBuilder: (_, _) =>
                    SizedBox(width: context.w * 0.02),
                itemBuilder: (_, i) {
                  final d = days[i];
                  return _DayCell(
                    date: d,
                    isSelected: d == _selected,
                    isToday: d == today,
                    hasTasting: byDay.containsKey(d),
                    onTap: () => setState(() => _selected = d),
                  );
                },
              ),
            ),
            SizedBox(height: context.m),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.paddingH * 1.3),
              child: selectedTastings.isEmpty
                  ? Text(
                      'No tastings on ${DateFormat.MMMd().format(_selected)}.',
                      style: TextStyle(
                        fontSize: context.bodyFont * 0.95,
                        color: cs.onSurface,
                      ),
                    )
                  : Column(
                      children: [
                        for (int i = 0; i < selectedTastings.length; i++) ...[
                          if (i > 0) SizedBox(height: context.s),
                          _TastingRow(tasting: selectedTastings[i]),
                        ],
                      ],
                    ),
            ),
          ],
        );
      },
      loading: () => Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
        child: const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _DayCell extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool hasTasting;
  final VoidCallback onTap;
  const _DayCell({
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.hasTasting,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = isSelected ? cs.primary : cs.surfaceContainer;
    final fg = isSelected ? cs.onPrimary : cs.onSurface;
    final sub = isSelected
        ? cs.onPrimary.withValues(alpha: 0.75)
        : cs.onSurfaceVariant;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.w * 0.13,
        padding: EdgeInsets.symmetric(vertical: context.s),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(context.w * 0.035),
          border: isToday && !isSelected
              ? Border.all(color: cs.primary, width: 1.2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.E().format(date).substring(0, 2).toUpperCase(),
              style: TextStyle(
                fontSize: context.captionFont * 0.8,
                color: sub,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),
            SizedBox(height: context.xs * 0.5),
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: context.bodyFont * 1.05,
                fontWeight: FontWeight.w700,
                color: fg,
                height: 1,
              ),
            ),
            SizedBox(height: context.xs * 0.6),
            Container(
              width: context.w * 0.012,
              height: context.w * 0.012,
              decoration: BoxDecoration(
                color: hasTasting
                    ? (isSelected ? cs.onPrimary : cs.primary)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TastingRow extends StatelessWidget {
  final TastingEntity tasting;
  const _TastingRow({required this.tasting});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final local = tasting.scheduledAt.toLocal();
    final timeLabel = DateFormat.Hm().format(local);
    return GestureDetector(
      onTap: () =>
          context.push(AppRoutes.tastingDetailPath(tasting.id)),
      child: Container(
        padding: EdgeInsets.all(context.w * 0.04),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Container(
              width: context.w * 0.11,
              padding: EdgeInsets.symmetric(vertical: context.s * 0.7),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(context.w * 0.02),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time,
                      size: context.w * 0.04, color: cs.primary),
                  SizedBox(height: context.xs * 0.4),
                  Text(
                    timeLabel,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tasting.title,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  if (tasting.location != null) ...[
                    SizedBox(height: context.xs * 0.4),
                    Text(tasting.location!,
                        style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                size: context.w * 0.045, color: cs.outline),
          ],
        ),
      ),
    );
  }
}
