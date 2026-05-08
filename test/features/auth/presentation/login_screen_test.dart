import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/services/connectivity/connectivity.provider.dart';
import 'package:sippd/features/auth/controller/auth.provider.dart';
import 'package:sippd/features/auth/presentation/modules/login/login.screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;

/// Recording fake — captures signIn / signUp calls so the widget test
/// can assert the form wired its inputs through correctly. Skips the
/// Supabase round-trip entirely.
class _RecordingAuth extends AuthController {
  _RecordingAuth({this.signInThrows});
  final Object? signInThrows;
  int signInCalls = 0;
  String? lastEmail;
  String? lastPassword;
  int signUpCalls = 0;

  @override
  AsyncValue<User?> build() => const AsyncValue.data(null);

  @override
  Future<void> signIn({required String email, required String password}) async {
    signInCalls++;
    lastEmail = email;
    lastPassword = password;
    if (signInThrows != null) {
      state = AsyncValue.error(signInThrows!, StackTrace.empty);
      return;
    }
    // Success: state remains data(null) — the router handles redirect
    // in the real app; here we just want to verify the call landed.
  }

  @override
  Future<SignUpOutcome> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    signUpCalls++;
    lastEmail = email;
    // Always returns signedIn so the screen does not try to navigate
    // (which needs a real GoRouter). Add a parameter if a future
    // test wants the confirmationRequired branch.
    return SignUpOutcome.signedIn;
  }
}

class _FakeConn extends ConnectivityState {
  _FakeConn(this._online);
  final bool _online;
  @override
  Future<bool> build() async => _online;
}

void main() {
  void useIPhoneViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(390 * 2, 844 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<_RecordingAuth> pumpLogin(
    WidgetTester tester, {
    Object? signInThrows,
  }) async {
    useIPhoneViewport(tester);
    final fake = _RecordingAuth(signInThrows: signInThrows);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(() => fake),
          connectivityStateProvider.overrideWith(() => _FakeConn(true)),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
    await tester.pumpAndSettle();
    return fake;
  }

  testWidgets('starts in sign-in mode with Welcome back copy', (tester) async {
    await pumpLogin(tester);
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    // Display name field is hidden in sign-in mode.
    expect(find.text('Display Name'), findsNothing);
  });

  testWidgets('toggles to sign-up mode and shows Display Name field', (
    tester,
  ) async {
    await pumpLogin(tester);
    await tester.tap(find.text('Don\'t have an account? Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('Display Name'), findsOneWidget);
  });

  testWidgets('submit calls signIn with the entered credentials', (
    tester,
  ) async {
    final fake = await pumpLogin(tester);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'me@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'hunter2',
    );
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(fake.signInCalls, 1);
    expect(fake.lastEmail, 'me@example.com');
    expect(fake.lastPassword, 'hunter2');
  });

  testWidgets('does not call signIn when validators block submission', (
    tester,
  ) async {
    final fake = await pumpLogin(tester);
    // Empty email + password → form invalid.
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();
    expect(fake.signInCalls, 0);
  });

  testWidgets('surfaces inline error when signIn fails', (tester) async {
    final fake = await pumpLogin(tester, signInThrows: StateError('bad'));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'me@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'hunter2',
    );
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(fake.signInCalls, 1);
    expect(find.textContaining('Sign-in failed'), findsOneWidget);
    // Regression guard for the RetryActionButton overflow fix —
    // narrow phones should render the retry label without throwing
    // a layout exception.
    expect(tester.takeException(), isNull);
  });

  testWidgets('sign-up submit hits signUp instead of signIn', (tester) async {
    final fake = await pumpLogin(tester);
    await tester.tap(find.text('Don\'t have an account? Sign Up'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Display Name'),
      'Martin',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'me@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'hunter22',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm Password'),
      'hunter22',
    );

    // Default fake returns SignUpOutcome.signedIn → no context.go,
    // so we don't need a real router. Lock in that signUp landed.
    await tester.tap(find.text('Create Account'));
    await tester.pumpAndSettle();

    expect(fake.signUpCalls, 1);
    expect(fake.signInCalls, 0);
  });
}
