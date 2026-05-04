import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/auth.provider.dart';

enum EmailConfirmationPurpose { confirmSignup, resetPassword }

class EmailConfirmationScreen extends ConsumerStatefulWidget {
  final String email;
  final EmailConfirmationPurpose purpose;

  const EmailConfirmationScreen({
    super.key,
    required this.email,
    this.purpose = EmailConfirmationPurpose.confirmSignup,
  });

  @override
  ConsumerState<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState
    extends ConsumerState<EmailConfirmationScreen> {
  static const _cooldownSeconds = 60;

  Timer? _timer;
  int _secondsLeft = 0;
  bool _isSending = false;
  Object? _resendError;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool get _isReset =>
      widget.purpose == EmailConfirmationPurpose.resetPassword;

  void _startCooldown() {
    _timer?.cancel();
    setState(() => _secondsLeft = _cooldownSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_secondsLeft <= 1) {
        t.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  Future<void> _resend() async {
    if (_secondsLeft > 0 || _isSending) return;
    setState(() {
      _isSending = true;
      _resendError = null;
    });
    try {
      final auth = ref.read(authControllerProvider.notifier);
      if (_isReset) {
        await auth.resetPassword(widget.email);
      } else {
        await auth.resendConfirmation(widget.email);
      }
      if (!mounted) return;
      _startCooldown();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email sent.'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _resendError = e);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _openMailApp() async {
    final uri = Uri.parse('mailto:');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _backToLogin() => context.go(AppRoutes.login);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final canResend = _secondsLeft == 0 && !_isSending;
    final resendLabel = _secondsLeft > 0
        ? 'Resend in ${_secondsLeft}s'
        : (_isSending ? 'Sending…' : 'Resend email');

    final title = _isReset ? 'Reset link sent' : 'Check your inbox';
    final intro = _isReset
        ? 'We sent a password reset link to'
        : 'We sent a confirmation link to';
    final outro = _isReset
        ? '.\nTap it to set a new password.'
        : '.\nTap it to activate your account.';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: context.m),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(PhosphorIconsRegular.arrowLeft),
                  onPressed: _backToLogin,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _MailIcon(isReset: _isReset),
                    SizedBox(height: context.xl),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.titleFont,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: context.m),
                    _Subtitle(
                      email: widget.email,
                      intro: intro,
                      outro: outro,
                    ),
                    SizedBox(height: context.xxl),
                    SizedBox(
                      height: context.h * 0.06,
                      child: ElevatedButton.icon(
                        onPressed: _openMailApp,
                        icon: const Icon(PhosphorIconsRegular.envelope),
                        label: Text(
                          'Open mail app',
                          style: TextStyle(
                            fontSize: context.bodyFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.m),
                    SizedBox(
                      height: context.h * 0.06,
                      child: OutlinedButton(
                        onPressed: canResend ? _resend : null,
                        child: Text(
                          resendLabel,
                          style: TextStyle(
                            fontSize: context.bodyFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (_resendError != null)
                      InlineFieldError(
                        error: _resendError,
                        fallback: "Couldn't send. Try again in a moment.",
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: context.m),
                child: TextButton(
                  onPressed: _backToLogin,
                  child: Text(
                    'Back to sign in',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.outline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MailIcon extends StatelessWidget {
  final bool isReset;
  const _MailIcon({required this.isReset});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.24;
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isReset
              ? PhosphorIconsRegular.lockKey
              : PhosphorIconsRegular.envelopeOpen,
          size: size * 0.5,
          color: cs.primary,
        ),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  final String email;
  final String intro;
  final String outro;

  const _Subtitle({
    required this.email,
    required this.intro,
    required this.outro,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: context.bodyFont,
          color: cs.onSurfaceVariant,
          height: 1.5,
        ),
        children: [
          TextSpan(text: '$intro\n'),
          TextSpan(
            text: email,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          TextSpan(text: outro),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
