import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../controller/auth.provider.dart';
import '../../widgets/google_sign_in_button.widget.dart';
import '../../widgets/or_divider.widget.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = ref.read(authControllerProvider.notifier);

    if (_isSignUp) {
      await auth.signUp(
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

    final state = ref.read(authControllerProvider);
    if (state.hasError && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error.toString()),
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

    // Redirect if authenticated
    ref.listen(authControllerProvider, (_, next) {
      if (next.valueOrNull != null) {
        context.go(AppRoutes.wines);
      }
    });

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
                  Icon(Icons.wine_bar,
                      size: context.w * 0.15, color: cs.primary),
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
                        prefixIcon: Icon(Icons.person_outline),
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
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (v) {
                      if (v == null || !v.contains('@')) return 'Valid email required';
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
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (v) {
                      if (v == null || v.length < 6) return 'Min 6 characters';
                      return null;
                    },
                  ),
                  SizedBox(height: context.xl),

                  // Submit
                  SizedBox(
                    width: double.infinity,
                    height: context.h * 0.06,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: cs.onPrimary),
                            )
                          : Text(
                              _isSignUp ? 'Create Account' : 'Sign In',
                              style: TextStyle(
                                  fontSize: context.bodyFont,
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
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

                  // Skip (continue without account)
                  SizedBox(height: context.s),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.wines),
                    child: Text(
                      'Continue without account',
                      style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.outline),
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
