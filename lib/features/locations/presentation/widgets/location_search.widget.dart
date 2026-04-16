import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/responsive.dart';
import '../../controller/location.provider.dart';
import '../../domain/entities/location.entity.dart';

class LocationSearchWidget extends ConsumerStatefulWidget {
  final Function(LocationEntity) onLocationSelected;
  final String? initialValue;

  const LocationSearchWidget({
    super.key,
    required this.onLocationSelected,
    this.initialValue,
  });

  @override
  ConsumerState<LocationSearchWidget> createState() =>
      _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends ConsumerState<LocationSearchWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _controller.text.isEmpty) {
        setState(() => _showResults = false);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();

    if (query.isEmpty) {
      setState(() => _showResults = false);
      ref.read(locationSearchControllerProvider.notifier).clearResults();
      return;
    }

    setState(() => _showResults = true);

    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(locationSearchControllerProvider.notifier).searchLocation(query);
    });
  }

  void _onSelected(LocationEntity location) {
    _controller.text = location.shortDisplay;
    _focusNode.unfocus();
    setState(() => _showResults = false);
    ref.read(locationSearchControllerProvider.notifier).clearResults();
    widget.onLocationSelected(location);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(locationSearchControllerProvider);
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          style: TextStyle(fontSize: context.bodyFont),
          decoration: InputDecoration(
            hintText: 'Search location...',
            prefixIcon: Icon(Icons.location_on_outlined,
                color: cs.primary, size: context.w * 0.05),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear,
                        size: context.w * 0.05,
                        color: cs.onSurfaceVariant),
                    onPressed: () {
                      _controller.clear();
                      setState(() => _showResults = false);
                      ref
                          .read(locationSearchControllerProvider.notifier)
                          .clearResults();
                    },
                  )
                : null,
          ),
          onChanged: _onSearchChanged,
        ),
        if (_showResults) ...[
          SizedBox(height: context.s),
          Container(
            constraints: BoxConstraints(maxHeight: context.h * 0.3),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(context.w * 0.03),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: searchState.when(
              data: (results) => results.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(context.w * 0.06),
                      child: Center(
                        child: Text('No locations found',
                            style: TextStyle(
                                fontSize: context.captionFont,
                                color: cs.onSurfaceVariant)),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: context.xs),
                      itemCount: results.length,
                      separatorBuilder: (_, _) =>
                          Divider(height: 1, color: cs.outlineVariant),
                      itemBuilder: (context, index) {
                        final loc = results[index];
                        return ListTile(
                          dense: true,
                          leading: Icon(Icons.place,
                              color: cs.primary, size: context.w * 0.05),
                          title: Text(loc.displayName,
                              style: TextStyle(
                                  fontSize: context.captionFont,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          subtitle: loc.subtitle.isNotEmpty
                              ? Text(loc.subtitle,
                                  style: TextStyle(
                                      fontSize: context.captionFont * 0.9,
                                      color: cs.onSurfaceVariant),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)
                              : null,
                          onTap: () => _onSelected(loc),
                        );
                      },
                    ),
              loading: () => Padding(
                padding: EdgeInsets.all(context.w * 0.06),
                child: Center(
                    child:
                        CircularProgressIndicator(color: cs.primary)),
              ),
              error: (_, _) => Padding(
                padding: EdgeInsets.all(context.w * 0.06),
                child: Center(
                  child: Text('Search failed',
                      style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.error)),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
