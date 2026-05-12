import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../application/location_search.service.dart';
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
  bool _gpsBusy = false;

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
    // Drop the system-wide primary focus, not just our node — otherwise
    // the focus jumps back to whichever TextField on the calling screen
    // was active before the sheet opened, and the keyboard re-appears
    // after the pop.
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _showResults = false);
    ref.read(locationSearchControllerProvider.notifier).clearResults();
    widget.onLocationSelected(location);
  }

  Future<void> _useCurrentLocation() async {
    if (_gpsBusy) return;
    setState(() => _gpsBusy = true);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final l10n = AppLocalizations.of(context);
    try {
      final service = ref.read(locationSearchServiceProvider);
      final loc = await service.resolveCurrentLocation();
      if (!mounted) return;
      _onSelected(loc);
    } on LocationUnavailable catch (e) {
      final message = switch (e.reason) {
        LocationUnavailableReason.servicesOff => l10n.locServicesDisabled,
        LocationUnavailableReason.permissionDenied => l10n.locPermissionDenied,
      };
      messenger?.showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {
      messenger?.showSnackBar(
        SnackBar(content: Text(l10n.locReadCurrentFailed)),
      );
    } finally {
      if (mounted) setState(() => _gpsBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(locationSearchControllerProvider);
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLength: 120,
          inputFormatters: [LengthLimitingTextInputFormatter(120)],
          style: TextStyle(fontSize: context.bodyFont),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.locSearchHint,
            prefixIcon: Icon(
              PhosphorIconsRegular.mapPin,
              color: cs.primary,
              size: context.w * 0.05,
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      PhosphorIconsRegular.x,
                      size: context.w * 0.05,
                      color: cs.onSurfaceVariant,
                    ),
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
        SizedBox(height: context.s),
        _UseMyLocationButton(busy: _gpsBusy, onTap: _useCurrentLocation),
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
                        child: Text(
                          l10n.locNoResults,
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
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
                          leading: Icon(
                            PhosphorIconsRegular.mapPin,
                            color: cs.primary,
                            size: context.w * 0.05,
                          ),
                          title: Text(
                            loc.displayName,
                            style: TextStyle(
                              fontSize: context.captionFont,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: loc.subtitle.isNotEmpty
                              ? Text(
                                  loc.subtitle,
                                  style: TextStyle(
                                    fontSize: context.captionFont * 0.9,
                                    color: cs.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : null,
                          onTap: () => _onSelected(loc),
                        );
                      },
                    ),
              loading: () => Padding(
                padding: EdgeInsets.all(context.w * 0.06),
                child: Center(
                  child: CircularProgressIndicator(color: cs.primary),
                ),
              ),
              error: (_, _) => Padding(
                padding: EdgeInsets.all(context.w * 0.06),
                child: Center(
                  child: Text(
                    l10n.locSearchFailed,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.error,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _UseMyLocationButton extends StatelessWidget {
  final bool busy;
  final VoidCallback onTap;

  const _UseMyLocationButton({required this.busy, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Material(
      color: cs.surfaceContainer,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: InkWell(
        onTap: busy ? null : onTap,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.04,
            vertical: context.s * 1.5,
          ),
          child: Row(
            children: [
              SizedBox(
                width: context.w * 0.05,
                height: context.w * 0.05,
                child: busy
                    ? CircularProgressIndicator(
                        strokeWidth: 2,
                        color: cs.primary,
                      )
                    : Icon(
                        PhosphorIconsRegular.crosshairSimple,
                        size: context.w * 0.05,
                        color: cs.primary,
                      ),
              ),
              SizedBox(width: context.w * 0.03),
              Expanded(
                child: Text(
                  busy ? l10n.locFindingLocation : l10n.locUseMyLocation,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                size: context.w * 0.05,
                color: cs.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
