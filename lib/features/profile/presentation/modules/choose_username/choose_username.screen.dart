import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../onboarding/controller/onboarding.provider.dart';
import '../../../controller/profile.provider.dart';

enum _UsernameState { idle, checking, available, taken, invalid, tooShort }

class ChooseUsernameScreen extends ConsumerStatefulWidget {
  const ChooseUsernameScreen({super.key});

  @override
  ConsumerState<ChooseUsernameScreen> createState() =>
      _ChooseUsernameScreenState();
}

class _ChooseUsernameScreenState extends ConsumerState<ChooseUsernameScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  _UsernameState _status = _UsernameState.idle;
  bool _saving = false;

  static final _validRe = RegExp(r'^[a-z0-9._]+$');

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String raw) {
    final value = raw.trim().toLowerCase();
    _debounce?.cancel();

    if (value.isEmpty) {
      setState(() => _status = _UsernameState.idle);
      return;
    }
    if (value.length < 3) {
      setState(() => _status = _UsernameState.tooShort);
      return;
    }
    if (!_validRe.hasMatch(value)) {
      setState(() => _status = _UsernameState.invalid);
      return;
    }

    setState(() => _status = _UsernameState.checking);
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      final available = await ref
          .read(profileControllerProvider.notifier)
          .isAvailable(value);
      if (!mounted || _controller.text.trim().toLowerCase() != value) return;
      setState(() =>
          _status = available ? _UsernameState.available : _UsernameState.taken);
    });
  }

  Future<void> _save() async {
    final value = _controller.text.trim().toLowerCase();
    if (_status != _UsernameState.available || _saving) return;

    setState(() => _saving = true);
    try {
      final notifier = ref.read(profileControllerProvider.notifier);
      await notifier.setUsername(value);
      // Seed displayName from onboarding once per account.
      if (ref.read(profileSeedPendingProvider)) {
        final pending = ref
            .read(onboardingAnswersControllerProvider)
            .displayName
            ?.trim();
        if (pending != null && pending.isNotEmpty) {
          try {
            await notifier.setDisplayName(pending);
          } catch (_) {/* non-fatal */}
        }
        await ref
            .read(onboardingAnswersControllerProvider.notifier)
            .clearProfileSeedPending();
      }
      // Router redirect handles navigation once the profile stream emits.
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final canSave = _status == _UsernameState.available && !_saving;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.xl),
              Text(
                'Pick a username',
                style: TextStyle(
                  fontSize: context.titleFont,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: context.s),
              Text(
                'How friends will find you on Sippd.',
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant,
                ),
              ),
              SizedBox(height: context.xl),
              _UsernameField(
                controller: _controller,
                onChanged: _onChanged,
                status: _status,
              ),
              SizedBox(height: context.s),
              _StatusLine(status: _status),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: context.h * 0.06,
                child: FilledButton(
                  onPressed: canSave ? _save : null,
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                  child: _saving
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: cs.onPrimary),
                        )
                      : Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: context.bodyFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: context.l),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final _UsernameState status;

  const _UsernameField({
    required this.controller,
    required this.onChanged,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final borderColor = switch (status) {
      _UsernameState.available => cs.primary,
      _UsernameState.taken ||
      _UsernameState.invalid ||
      _UsernameState.tooShort =>
        cs.error,
      _UsernameState.idle || _UsernameState.checking => cs.outlineVariant,
    };

    return TextField(
      controller: controller,
      onChanged: onChanged,
      autofocus: true,
      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,
      maxLength: 20,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9._]')),
      ],
      style: TextStyle(
        fontSize: context.titleFont * 1.1,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: cs.onSurface,
      ),
      decoration: InputDecoration(
        prefixText: '@',
        prefixStyle: TextStyle(
          fontSize: context.titleFont * 1.1,
          fontWeight: FontWeight.bold,
          color: cs.onSurfaceVariant,
        ),
        hintText: 'username',
        hintStyle: TextStyle(
          fontSize: context.titleFont * 1.1,
          fontWeight: FontWeight.bold,
          color: cs.outline,
        ),
        counterText: '',
        contentPadding:
            EdgeInsets.symmetric(vertical: context.m, horizontal: context.s),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  final _UsernameState status;
  const _StatusLine({required this.status});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (text, color) = switch (status) {
      _UsernameState.idle =>
        ('3–20 chars · letters, numbers, . and _', cs.outline),
      _UsernameState.tooShort => ('At least 3 characters', cs.error),
      _UsernameState.invalid =>
        ('Only letters, numbers, . and _', cs.error),
      _UsernameState.checking => ('Checking…', cs.onSurfaceVariant),
      _UsernameState.available => ('Available', cs.primary),
      _UsernameState.taken => ('Already taken', cs.error),
    };
    return Text(
      text,
      style: TextStyle(fontSize: context.captionFont, color: color),
    );
  }
}
