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
  late DateTime _viewMonth;
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    final now = _dateOnly(DateTime.now());
    _selected = now;
    _viewMonth = DateTime(now.year, now.month);
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  void _prevMonth() => setState(() =>
      _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1));
  void _nextMonth() => setState(() =>
      _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tastingsAsync =
        ref.watch(groupTastingsProvider(widget.groupId));

    return tastingsAsync.when(
      data: (tastings) {
        final byDay = <DateTime, List<TastingEntity>>{};
        for (final t in tastings) {
          final d = _dateOnly(t.scheduledAt.toLocal());
          byDay.putIfAbsent(d, () => []).add(t);
        }
        for (final list in byDay.values) {
          list.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
        }

        final selectedTastings = byDay[_selected] ?? const [];
        final upcoming = tastings
            .where((t) => t.scheduledAt.isAfter(DateTime.now()))
            .toList()
          ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MonthHeader(
                month: _viewMonth,
                onPrev: _prevMonth,
                onNext: _nextMonth,
              ),
              SizedBox(height: context.m),
              _WeekdayRow(),
              SizedBox(height: context.xs),
              _MonthGrid(
                month: _viewMonth,
                selected: _selected,
                byDay: byDay,
                onTap: (d) => setState(() => _selected = d),
              ),
              SizedBox(height: context.m),
              if (selectedTastings.isNotEmpty) ...[
                Text(
                  DateFormat.yMMMMd().format(_selected),
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.s),
                for (var i = 0; i < selectedTastings.length; i++) ...[
                  if (i > 0) SizedBox(height: context.s),
                  _TastingRow(tasting: selectedTastings[i]),
                ],
              ] else if (upcoming.isNotEmpty) ...[
                Text('Upcoming',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant,
                    )),
                SizedBox(height: context.s),
                for (var i = 0; i < upcoming.take(3).length; i++) ...[
                  if (i > 0) SizedBox(height: context.s),
                  _TastingRow(tasting: upcoming[i], showDate: true),
                ],
              ] else
                Text(
                  'No tastings scheduled.',
                  style: TextStyle(
                    fontSize: context.bodyFont * 0.95,
                    color: cs.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
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

class _MonthHeader extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  const _MonthHeader(
      {required this.month, required this.onPrev, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          DateFormat.yMMMM().format(month),
          style: TextStyle(
            fontSize: context.bodyFont * 1.1,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const Spacer(),
        _NavButton(icon: Icons.chevron_left, onTap: onPrev),
        SizedBox(width: context.xs),
        _NavButton(
          icon: Icons.chevron_right,
          onTap: onNext,
          color: cs.onSurface,
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  const _NavButton({required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: context.w * 0.09,
        height: context.w * 0.09,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(icon,
            size: context.w * 0.05, color: color ?? cs.onSurface),
      ),
    );
  }
}

class _WeekdayRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const labels = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
    return Row(
      children: [
        for (final l in labels)
          Expanded(
            child: Center(
              child: Text(
                l,
                style: TextStyle(
                  fontSize: context.captionFont * 0.8,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MonthGrid extends StatelessWidget {
  final DateTime month;
  final DateTime selected;
  final Map<DateTime, List<TastingEntity>> byDay;
  final ValueChanged<DateTime> onTap;

  const _MonthGrid({
    required this.month,
    required this.selected,
    required this.byDay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final firstOfMonth = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leading = (firstOfMonth.weekday - 1) % 7; // Mon=0
    final totalCells = ((leading + daysInMonth + 6) ~/ 7) * 7;
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    return Column(
      children: [
        for (var row = 0; row < totalCells ~/ 7; row++)
          Padding(
            padding: EdgeInsets.only(bottom: context.xs),
            child: Row(
              children: [
                for (var col = 0; col < 7; col++) _buildCell(
                  context,
                  row * 7 + col,
                  leading,
                  daysInMonth,
                  firstOfMonth,
                  todayDate,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCell(
    BuildContext context,
    int index,
    int leading,
    int daysInMonth,
    DateTime firstOfMonth,
    DateTime today,
  ) {
    final dayNum = index - leading + 1;
    if (dayNum < 1 || dayNum > daysInMonth) {
      return const Expanded(child: SizedBox.shrink());
    }
    final date =
        DateTime(firstOfMonth.year, firstOfMonth.month, dayNum);
    final isSelected = date == selected;
    final isToday = date == today;
    final hasTasting = byDay.containsKey(date);
    return Expanded(
      child: _DayCell(
        date: date,
        isSelected: isSelected,
        isToday: isToday,
        hasTasting: hasTasting,
        onTap: () => onTap(date),
      ),
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
    final bg = isSelected ? cs.primary : Colors.transparent;
    final fg = isSelected
        ? cs.onPrimary
        : (isToday ? cs.primary : cs.onSurface);
    final dotColor = isSelected ? cs.onPrimary : cs.primary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: context.w * 0.11,
        margin: EdgeInsets.symmetric(horizontal: context.xs * 0.3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: isToday && !isSelected
              ? Border.all(color: cs.primary, width: 1.2)
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: context.bodyFont * 0.95,
                fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
                color: fg,
              ),
            ),
            if (hasTasting)
              Positioned(
                bottom: context.xs * 0.6,
                child: Container(
                  width: context.w * 0.012,
                  height: context.w * 0.012,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
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
  final bool showDate;
  const _TastingRow({required this.tasting, this.showDate = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final local = tasting.scheduledAt.toLocal();
    final timeLabel = DateFormat.Hm().format(local);
    return GestureDetector(
      onTap: () => context.push(AppRoutes.tastingDetailPath(tasting.id)),
      child: Container(
        padding: EdgeInsets.all(context.w * 0.04),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Container(
              width: context.w * 0.13,
              padding:
                  EdgeInsets.symmetric(vertical: context.s * 0.7),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(context.w * 0.02),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showDate)
                    Text(
                      DateFormat.MMMd().format(local),
                      style: TextStyle(
                        fontSize: context.captionFont * 0.85,
                        fontWeight: FontWeight.w700,
                        color: cs.primary,
                      ),
                    )
                  else
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
