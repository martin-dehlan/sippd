import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
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
  Object? _saveError;

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
      setState(
        () => _status = available
            ? _UsernameState.available
            : _UsernameState.taken,
      );
    });
  }

  Future<void> _save() async {
    final value = _controller.text.trim().toLowerCase();
    if (_status != _UsernameState.available || _saving) return;

    setState(() {
      _saving = true;
      _saveError = null;
    });
    try {
      final notifier = ref.read(profileControllerProvider.notifier);
      // Pre-auth funnel users get a single atomic write that includes
      // username + display name + taste answers + onboarding_completed.
      // Without this, three separate UPDATEs would each invalidate the
      // profile stream and the router would briefly redirect to
      // /onboarding between them.
      if (ref.read(profileSeedPendingProvider)) {
        final answers = ref.read(onboardingAnswersControllerProvider);
        final pending = answers.displayName?.trim();
        await notifier.seedFromOnboarding(
          username: value,
          displayName: pending == null || pending.isEmpty ? null : pending,
          answers: answers,
        );
        await ref
            .read(onboardingAnswersControllerProvider.notifier)
            .clearProfileSeedPending();
      } else {
        await notifier.setUsername(value);
      }
      // Router redirect handles navigation once the profile stream emits.
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _saveError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
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
                l10n.profileChooseUsernameTitle,
                style: TextStyle(
                  fontSize: context.titleFont,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: context.s),
              Text(
                l10n.profileChooseUsernameSubtitle,
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
              if (_saveError != null) ...[
                InlineFieldError(
                  error: _saveError,
                  fallback: l10n.profileChooseUsernameSaveFailed,
                ),
                SizedBox(height: context.s),
              ],
              RetryActionButton(
                idleLabel: l10n.profileChooseUsernameContinue,
                loading: _saving,
                error: _saveError,
                onPressed: canSave || _saveError != null ? _save : null,
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
      _UsernameState.tooShort => cs.error,
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
        hintText: AppLocalizations.of(context).profileChooseUsernameHint,
        hintStyle: TextStyle(
          fontSize: context.titleFont * 1.1,
          fontWeight: FontWeight.bold,
          color: cs.outline,
        ),
        counterText: '',
        contentPadding: EdgeInsets.symmetric(
          vertical: context.m,
          horizontal: context.s,
        ),
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
    final l10n = AppLocalizations.of(context);
    final (text, color) = switch (status) {
      _UsernameState.idle => (l10n.profileUsernameHelperIdle, cs.outline),
      _UsernameState.tooShort => (l10n.profileUsernameTooShort, cs.error),
      _UsernameState.invalid => (l10n.profileUsernameInvalid, cs.error),
      _UsernameState.checking => (
        l10n.profileUsernameChecking,
        cs.onSurfaceVariant,
      ),
      _UsernameState.available => (l10n.profileUsernameAvailable, cs.primary),
      _UsernameState.taken => (l10n.profileUsernameTaken, cs.error),
    };
    return Text(
      text,
      style: TextStyle(fontSize: context.captionFont, color: color),
    );
  }
}
