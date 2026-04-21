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
  bool _showPast = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tastingsAsync =
        ref.watch(groupTastingsProvider(widget.groupId));

    return tastingsAsync.when(
      data: (tastings) {
        final now = DateTime.now();
        final upcoming = tastings
            .where((t) => !t.scheduledAt.isBefore(_dayStart(now)))
            .toList()
          ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
        final past = tastings
            .where((t) => t.scheduledAt.isBefore(_dayStart(now)))
            .toList()
          ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));

        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (upcoming.isEmpty && past.isEmpty)
                Text(
                  'No tastings yet. Tap Plan to create one.',
                  style: TextStyle(
                    fontSize: context.bodyFont * 0.95,
                    color: cs.onSurfaceVariant,
                  ),
                )
              else ...[
                for (var i = 0; i < upcoming.length; i++) ...[
                  if (i > 0) SizedBox(height: context.s),
                  _TastingTile(tasting: upcoming[i]),
                ],
                if (past.isNotEmpty) ...[
                  SizedBox(height: context.l),
                  _PastToggle(
                    open: _showPast,
                    count: past.length,
                    onTap: () => setState(() => _showPast = !_showPast),
                  ),
                  if (_showPast) ...[
                    SizedBox(height: context.s),
                    for (var i = 0; i < past.length; i++) ...[
                      if (i > 0) SizedBox(height: context.s),
                      _TastingTile(tasting: past[i], past: true),
                    ],
                  ],
                ],
              ],
            ],
          ),
        );
      },
      loading: () => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
        child: const _TastingSkeleton(),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  DateTime _dayStart(DateTime d) => DateTime(d.year, d.month, d.day);
}

class _TastingTile extends StatelessWidget {
  final TastingEntity tasting;
  final bool past;
  const _TastingTile({required this.tasting, this.past = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final local = tasting.scheduledAt.toLocal();
    final now = DateTime.now();
    final isToday = local.year == now.year &&
        local.month == now.month &&
        local.day == now.day;

    final bg = isToday
        ? cs.primary.withValues(alpha: 0.08)
        : cs.surfaceContainer;
    final borderColor = isToday ? cs.primary : Colors.transparent;

    return Opacity(
      opacity: past ? 0.55 : 1,
      child: GestureDetector(
        onTap: () =>
            context.push(AppRoutes.tastingDetailPath(tasting.id)),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.w * 0.035, vertical: context.s),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(context.w * 0.035),
            border: Border(
              left: BorderSide(color: borderColor, width: context.w * 0.008),
            ),
          ),
          child: Row(
            children: [
              _DateChip(date: local, highlighted: isToday),
              SizedBox(width: context.w * 0.035),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tasting.title,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.xs * 0.5),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: context.w * 0.035,
                            color: cs.onSurfaceVariant),
                        SizedBox(width: context.xs * 0.8),
                        Text(
                          DateFormat.Hm().format(local),
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        if (tasting.location != null) ...[
                          Text(
                            '  ·  ',
                            style: TextStyle(
                              fontSize: context.captionFont,
                              color: cs.outline,
                            ),
                          ),
                          Icon(Icons.place_outlined,
                              size: context.w * 0.035,
                              color: cs.onSurfaceVariant),
                          SizedBox(width: context.xs * 0.8),
                          Flexible(
                            child: Text(
                              tasting.location!,
                              style: TextStyle(
                                fontSize: context.captionFont,
                                color: cs.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  size: context.w * 0.045, color: cs.outline),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final DateTime date;
  final bool highlighted;
  const _DateChip({required this.date, required this.highlighted});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = highlighted ? cs.primary : cs.surfaceContainerHighest;
    final fg = highlighted ? cs.onPrimary : cs.onSurface;
    final sub = highlighted
        ? cs.onPrimary.withValues(alpha: 0.75)
        : cs.onSurfaceVariant;
    return Container(
      width: context.w * 0.13,
      padding: EdgeInsets.symmetric(vertical: context.s),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(context.w * 0.025),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat.MMM().format(date).toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.8,
              fontWeight: FontWeight.w700,
              color: sub,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: context.xs * 0.4),
          Text(
            date.day.toString(),
            style: TextStyle(
              fontSize: context.bodyFont * 1.25,
              fontWeight: FontWeight.w800,
              color: fg,
              height: 1,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PastToggle extends StatelessWidget {
  final bool open;
  final int count;
  final VoidCallback onTap;

  const _PastToggle({
    required this.open,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(
            open ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
            size: context.w * 0.045,
            color: cs.onSurfaceVariant,
          ),
          SizedBox(width: context.xs),
          Text(
            'Past tastings ($count)',
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TastingSkeleton extends StatelessWidget {
  const _TastingSkeleton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(context.w * 0.035);
    final block = cs.surfaceContainer;
    final subBlock = cs.surfaceContainerHighest;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < 2; i++) ...[
          if (i > 0) SizedBox(height: context.s),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.035, vertical: context.s),
            decoration: BoxDecoration(color: block, borderRadius: radius),
            child: Row(
              children: [
                Container(
                  width: context.w * 0.13,
                  height: context.w * 0.13,
                  decoration: BoxDecoration(
                    color: subBlock,
                    borderRadius: BorderRadius.circular(context.w * 0.025),
                  ),
                ),
                SizedBox(width: context.w * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: context.bodyFont,
                        width: context.w * 0.45,
                        decoration: BoxDecoration(
                          color: subBlock,
                          borderRadius: BorderRadius.circular(context.w * 0.01),
                        ),
                      ),
                      SizedBox(height: context.xs),
                      Container(
                        height: context.captionFont,
                        width: context.w * 0.3,
                        decoration: BoxDecoration(
                          color: subBlock,
                          borderRadius: BorderRadius.circular(context.w * 0.01),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
