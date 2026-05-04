import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/app_logo.widget.dart';
import '../../../../../common/widgets/inline_error.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/auth.provider.dart';
import '../../widgets/google_sign_in_button.widget.dart';
import '../../widgets/or_divider.widget.dart';
import '../email_confirmation/email_confirmation.screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSignUp = false;
  final _displayNameController = TextEditingController();
  Object? _submitError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitError = null);

    final auth = ref.read(authControllerProvider.notifier);

    SignUpOutcome? signUpOutcome;
    if (_isSignUp) {
      signUpOutcome = await auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: _displayNameController.text.trim().isNotEmpty
            ? _displayNameController.text.trim()
            : null,
      );
    } else {
      await auth.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }

    if (!mounted) return;

    if (signUpOutcome == SignUpOutcome.confirmationRequired) {
      context.go(
        AppRoutes.emailConfirmation,
        extra: {
          'email': _emailController.text.trim(),
          'purpose': EmailConfirmationPurpose.confirmSignup,
        },
      );
      return;
    }

    final state = ref.read(authControllerProvider);
    if (state.hasError) {
      setState(() => _submitError = state.error);
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Enter your email above first.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    try {
      await ref.read(authControllerProvider.notifier).resetPassword(email);
      if (!mounted) return;
      context.go(
        AppRoutes.emailConfirmation,
        extra: {
          'email': email,
          'purpose': EmailConfirmationPurpose.resetPassword,
        },
      );
    } catch (e) {
      if (!mounted) return;
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
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo area
                  AppLogo(size: context.w * 0.28),
                  SizedBox(height: context.m),
                  Text(
                    'Sippd',
                    style: TextStyle(
                      fontSize: context.titleFont * 1.2,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: context.xs),
                  Text(
                    _isSignUp ? 'Create your account' : 'Welcome back',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: context.xl * 1.5),

                  // Display name (signup only)
                  if (_isSignUp) ...[
                    TextFormField(
                      controller: _displayNameController,
                      decoration: const InputDecoration(
                        labelText: 'Display Name',
                        prefixIcon: Icon(PhosphorIconsRegular.user),
                      ),
                    ),
                    SizedBox(height: context.m),
                  ],

                  // Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(PhosphorIconsRegular.envelope),
                    ),
                    validator: (v) {
                      if (v == null || !v.contains('@'))
                        return 'Valid email required';
                      return null;
                    },
                  ),
                  SizedBox(height: context.m),

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(PhosphorIconsRegular.lockSimple),
                    ),
                    validator: (v) {
                      if (v == null || v.length < 6) return 'Min 6 characters';
                      return null;
                    },
                  ),

                  // Forgot password (sign-in only)
                  if (!_isSignUp)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _forgotPassword,
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.outline,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: _isSignUp ? context.xl : context.s),

                  if (_submitError != null) ...[
                    InlineFieldError(
                      error: _submitError,
                      fallback: _isSignUp
                          ? "Couldn't create account. Try again."
                          : "Sign-in failed. Check your details.",
                    ),
                    SizedBox(height: context.s),
                  ],
                  RetryActionButton(
                    idleLabel: _isSignUp ? 'Create Account' : 'Sign In',
                    loading: isLoading,
                    error: _submitError,
                    onPressed: _submit,
                  ),
                  SizedBox(height: context.m),

                  const OrDivider(),
                  SizedBox(height: context.m),
                  const GoogleSignInButton(),
                  SizedBox(height: context.m),

                  // Toggle
                  TextButton(
                    onPressed: () => setState(() => _isSignUp = !_isSignUp),
                    child: Text(
                      _isSignUp
                          ? 'Already have an account? Sign In'
                          : 'Don\'t have an account? Sign Up',
                      style: TextStyle(fontSize: context.captionFont),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
