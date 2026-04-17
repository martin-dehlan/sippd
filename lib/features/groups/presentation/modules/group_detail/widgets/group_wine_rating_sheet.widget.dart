import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../auth/controller/auth.provider.dart';
import '../../../../../profile/presentation/widgets/profile_avatar.widget.dart';
import '../../../../../wines/controller/wine.provider.dart';
import '../../../../../wines/domain/entities/wine.entity.dart';
import '../../../../controller/group.provider.dart';
import '../../../../domain/entities/group_wine_rating.entity.dart';

Future<void> showGroupWineRatingSheet({
  required BuildContext context,
  required String groupId,
  required WineEntity wine,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w * 0.06)),
    ),
    builder: (_) => _Sheet(groupId: groupId, wine: wine),
  );
}

class _Sheet extends ConsumerStatefulWidget {
  final String groupId;
  final WineEntity wine;
  const _Sheet({required this.groupId, required this.wine});

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  double? _myRating;
  final _notesController = TextEditingController();
  bool _saving = false;
  bool _loaded = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  bool get _isOwner {
    final uid = ref.read(currentUserIdProvider);
    return uid != null && uid == widget.wine.userId;
  }

  Future<void> _save() async {
    if (_myRating == null || _saving) return;
    setState(() => _saving = true);
    try {
      if (_isOwner) {
        final updated = widget.wine.copyWith(
          rating: _myRating!,
          notes: _notesController.text.trim().isEmpty
              ? widget.wine.notes
              : _notesController.text.trim(),
          updatedAt: DateTime.now(),
        );
        await ref.read(wineControllerProvider.notifier).updateWine(updated);
      } else {
        await ref
            .read(groupWineRatingControllerProvider.notifier)
            .upsertRating(
              groupId: widget.groupId,
              wineId: widget.wine.id,
              rating: _myRating!,
              notes: _notesController.text.trim().isEmpty
                  ? null
                  : _notesController.text.trim(),
            );
      }
      ref.invalidate(
          groupWineRatingsProvider(widget.groupId, widget.wine.id));
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    if (_isOwner) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(groupWineRatingControllerProvider.notifier)
          .deleteRating(groupId: widget.groupId, wineId: widget.wine.id);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final userId = ref.watch(currentUserIdProvider);
    final ratingsAsync = ref.watch(
        groupWineRatingsProvider(widget.groupId, widget.wine.id));

    if (!_loaded) {
      if (userId == widget.wine.userId) {
        _myRating = widget.wine.rating;
        _notesController.text = widget.wine.notes ?? '';
        _loaded = true;
      } else {
        ratingsAsync.whenData((list) {
          final mine = list.where((r) => r.userId == userId).firstOrNull;
          if (mine != null) {
            _myRating = mine.rating;
            _notesController.text = mine.notes ?? '';
          }
          _loaded = true;
        });
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        left: context.paddingH,
        right: context.paddingH,
        top: context.l,
        bottom: MediaQuery.of(context).viewInsets.bottom + context.l,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: context.w * 0.1,
              height: context.xs,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(context.xs),
              ),
            ),
          ),
          SizedBox(height: context.m),
          Text(
            widget.wine.name,
            style: TextStyle(
                fontSize: context.headingFont,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.l),
          Text('Your rating',
              style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant)),
          SizedBox(height: context.s),
          Row(
            children: [
              Text(
                _myRating?.toStringAsFixed(1) ?? '—',
                style: TextStyle(
                    fontSize: context.titleFont,
                    fontWeight: FontWeight.w800,
                    color: cs.primary,
                    height: 1,
                    letterSpacing: -1),
              ),
              SizedBox(width: context.xs),
              Padding(
                padding: EdgeInsets.only(top: context.s),
                child: Text('/10',
                    style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant)),
              ),
            ],
          ),
          Slider(
            value: _myRating ?? 5.0,
            min: 0,
            max: 10,
            divisions: 100,
            activeColor: cs.primary,
            onChanged: _saving
                ? null
                : (v) => setState(() =>
                    _myRating = double.parse(v.toStringAsFixed(1))),
          ),
          SizedBox(height: context.s),
          TextField(
            controller: _notesController,
            maxLines: 2,
            maxLength: 200,
            style: TextStyle(fontSize: context.bodyFont),
            decoration: InputDecoration(
              hintText: 'Notes (optional)',
              counterText: '',
              filled: true,
              fillColor: cs.surfaceContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.w * 0.03),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: context.m),
          Row(
            children: [
              if (!_isOwner &&
                  _loaded &&
                  ratingsAsync.valueOrNull
                          ?.any((r) => r.userId == userId) ==
                      true)
                TextButton(
                  onPressed: _saving ? null : _delete,
                  child: Text('Remove',
                      style: TextStyle(
                          fontSize: context.bodyFont, color: cs.error)),
                ),
              const Spacer(),
              FilledButton(
                onPressed: (_myRating == null || _saving) ? null : _save,
                style: FilledButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(context.w * 0.03),
                  ),
                ),
                child: _saving
                    ? SizedBox(
                        width: context.w * 0.05,
                        height: context.w * 0.05,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: cs.onPrimary))
                    : Text('Save',
                        style: TextStyle(
                            fontSize: context.bodyFont,
                            fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: context.l),
          Divider(color: cs.outlineVariant, height: 1),
          SizedBox(height: context.m),
          Text('Group ratings',
              style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant)),
          SizedBox(height: context.s),
          ratingsAsync.when(
            data: (ratings) => ratings.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: context.m),
                    child: Text('No ratings yet.',
                        style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant)),
                  )
                : ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: context.h * 0.3),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: ratings.length,
                      separatorBuilder: (_, _) => SizedBox(height: context.s),
                      itemBuilder: (_, i) => _RatingTile(r: ratings[i]),
                    ),
                  ),
            loading: () => const Padding(
              padding: EdgeInsets.all(8),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _RatingTile extends StatelessWidget {
  final GroupWineRatingEntity r;
  const _RatingTile({required this.r});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final name =
        r.username ?? r.displayName ?? r.userId.substring(0, 6);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAvatar(
          avatarUrl: r.avatarUrl,
          fallbackText: name,
          size: context.w * 0.1,
        ),
        SizedBox(width: context.s),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    r.username != null ? '@$name' : name,
                    style: TextStyle(
                        fontSize: context.bodyFont * 0.95,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    r.rating.toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w800,
                        color: cs.primary),
                  ),
                  Text('/10',
                      style: TextStyle(
                          fontSize: context.captionFont * 0.9,
                          color: cs.onSurfaceVariant)),
                ],
              ),
              if (r.notes != null && r.notes!.isNotEmpty) ...[
                SizedBox(height: context.xs),
                Text(
                  r.notes!,
                  style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
