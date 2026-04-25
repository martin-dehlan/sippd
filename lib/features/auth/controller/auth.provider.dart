import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../onboarding/data/onboarding_storage_keys.dart';

part 'auth.provider.g.dart';

enum SignUpOutcome { signedIn, confirmationRequired, failed }

@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<User?> build() {
    final client = ref.watch(supabaseClientProvider);
    final user = client.auth.currentUser;

    final StreamSubscription sub = client.auth.onAuthStateChange.listen((data) {
      state = AsyncValue.data(data.session?.user);
    });
    ref.onDispose(sub.cancel);

    return AsyncValue.data(user);
  }

  Future<SignUpOutcome> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(supabaseClientProvider);
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: displayName != null ? {'display_name': displayName} : null,
        emailRedirectTo: 'io.sippd://login-callback/',
      );
      if (response.session == null) {
        state = const AsyncValue.data(null);
        return SignUpOutcome.confirmationRequired;
      }
      state = AsyncValue.data(response.user);
      return SignUpOutcome.signedIn;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return SignUpOutcome.failed;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(supabaseClientProvider);
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    });
  }

  Future<void> signInWithGoogle() async {
    final client = ref.read(supabaseClientProvider);
    await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.sippd://login-callback/',
      authScreenLaunchMode: LaunchMode.inAppBrowserView,
    );
  }

  Future<void> signOut() async {
    final client = ref.read(supabaseClientProvider);
    await client.auth.signOut();
    // Wipe the pre-auth onboarding buffer so the next user on this device
    // can't see the previous user's taste answers during the auth ->
    // profile-load latency window. `onboarding_seen` stays — that flag is
    // device-scoped, not account-scoped, so we don't replay the welcome
    // funnel for someone who already saw it.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(onboardingAnswersKey);
    await prefs.remove(onboardingProfileSeedPendingKey);
    state = const AsyncValue.data(null);
  }

  Future<void> resendConfirmation(String email) async {
    final client = ref.read(supabaseClientProvider);
    await client.auth.resend(
      type: OtpType.signup,
      email: email,
      emailRedirectTo: 'io.sippd://login-callback/',
    );
  }

  Future<void> resetPassword(String email) async {
    final client = ref.read(supabaseClientProvider);
    await client.auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.sippd://login-callback/',
    );
  }

  Future<void> updatePassword(String newPassword) async {
    final client = ref.read(supabaseClientProvider);
    await client.auth.updateUser(UserAttributes(password: newPassword));
  }
}

@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.valueOrNull != null;
}

@riverpod
String? currentUserId(CurrentUserIdRef ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.valueOrNull?.id;
}

@riverpod
class PasswordRecoveryController extends _$PasswordRecoveryController {
  @override
  bool build() {
    final client = ref.watch(supabaseClientProvider);
    final StreamSubscription sub = client.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.passwordRecovery) {
        state = true;
      }
    });
    ref.onDispose(sub.cancel);
    return false;
  }

  void clear() => state = false;
}
