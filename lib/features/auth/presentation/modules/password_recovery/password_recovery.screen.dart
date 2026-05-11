import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/auth.provider.dart';

class PasswordRecoveryScreen extends ConsumerStatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  ConsumerState<PasswordRecoveryScreen> createState() =>
      _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState
    extends ConsumerState<PasswordRecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isSubmitting = false;
  Object? _submitError;
  bool _obscure = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _submitError = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .updatePassword(_passwordController.text);
      ref.read(passwordRecoveryControllerProvider.notifier).clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).authResetUpdatedSnack),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      context.go(AppRoutes.wines);
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitError = e);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: context.xxl),
                _LockIcon(),
                SizedBox(height: context.xl),
                Text(
                  l10n.authResetTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.titleFont,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: context.m),
                Text(
                  l10n.authResetSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.xl),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  maxLength: 72,
                  inputFormatters: [LengthLimitingTextInputFormatter(72)],
                  decoration: InputDecoration(
                    labelText: l10n.authResetNewPasswordLabel,
                    counterText: '',
                    prefixIcon: const Icon(PhosphorIconsRegular.lockSimple),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure
                            ? PhosphorIconsRegular.eyeSlash
                            : PhosphorIconsRegular.eye,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.length < 6) {
                      return l10n.authResetPasswordMin;
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.m),
                TextFormField(
                  controller: _confirmController,
                  obscureText: _obscure,
                  maxLength: 72,
                  inputFormatters: [LengthLimitingTextInputFormatter(72)],
                  decoration: InputDecoration(
                    labelText: l10n.authResetConfirmPasswordLabel,
                    counterText: '',
                    prefixIcon: const Icon(PhosphorIconsRegular.lockSimple),
                  ),
                  validator: (v) {
                    if (v != _passwordController.text) {
                      return l10n.authResetPasswordsDontMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.xl),
                if (_submitError != null) ...[
                  InlineFieldError(
                    error: _submitError,
                    fallback: l10n.authResetFailedFallback,
                  ),
                  SizedBox(height: context.s),
                ],
                RetryActionButton(
                  idleLabel: l10n.authResetUpdateButton,
                  loading: _isSubmitting,
                  error: _submitError,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LockIcon extends StatelessWidget {
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
          PhosphorIconsRegular.lockKey,
          size: size * 0.5,
          color: cs.primary,
        ),
      ),
    );
  }
}
