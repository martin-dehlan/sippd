import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/auth.provider.dart';

/// Sign in with Apple button. Required by App Store guideline 4.8 wherever a
/// third-party login (Google) is offered. iOS-only — gated at the call site.
///
/// Apple's Human Interface Guidelines mandate a specific appearance (black
/// background, white Apple logo + approved label), so this is the one place we
/// deliberately step outside the theme `colorScheme`.
class AppleSignInButton extends ConsumerStatefulWidget {
  const AppleSignInButton({super.key});

  @override
  ConsumerState<AppleSignInButton> createState() => _AppleSignInButtonState();
}

class _AppleSignInButtonState extends ConsumerState<AppleSignInButton> {
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authControllerProvider.notifier).signInWithApple();
    } on SignInWithAppleAuthorizationException catch (e) {
      // User cancelled the native sheet — not an error worth surfacing.
      if (e.code == AuthorizationErrorCode.canceled) return;
      _showError();
    } catch (_) {
      _showError();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).authAppleFailed)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      width: double.infinity,
      height: context.h * 0.06,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _signIn,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.w * 0.02),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsFill.appleLogo,
                    color: Colors.white,
                    size: context.w * 0.055,
                  ),
                  SizedBox(width: context.w * 0.03),
                  Flexible(
                    child: Text(
                      l10n.authAppleContinue,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
