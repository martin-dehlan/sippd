import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/painting.dart' show imageCache;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/services/analytics/analytics.provider.dart';
import '../../onboarding/data/onboarding_storage_keys.dart';
import '../../wines/controller/wine.provider.dart';

part 'auth.provider.g.dart';

// Public Google OAuth client IDs (shipped in the app binary anyway, not secret).
// iOS uses the native token flow; the web client is the `serverClientId` so the
// returned ID token's audience matches what Supabase validates.
const _googleIosClientId =
    '1063134331798-pki7uhuaqgsc9qj6cpdgrfmccs2ao4b4.apps.googleusercontent.com';
const _googleWebClientId =
    '1063134331798-uddscjps15f47qn1al66rsc0dheklqua.apps.googleusercontent.com';

// GoogleSignIn.instance.initialize must run once per app lifecycle.
bool _googleSignInInitialized = false;

enum SignUpOutcome {
  signedIn,
  confirmationRequired,
  emailAlreadyRegistered,
  failed,
}

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

    final StreamSubscription<AuthState> sub = client.auth.onAuthStateChange
        .listen((data) {
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
      // Supabase anti-enumeration: when the email is already registered and
      // email confirmation is on, signUp succeeds with an obfuscated user
      // whose `identities` list is empty (and no session). Detect that so
      // the UI can steer the user to log in instead of waiting for a
      // confirmation mail that never arrives.
      final identities = response.user?.identities;
      if (identities != null && identities.isEmpty) {
        state = const AsyncValue.data(null);
        ref
            .read(analyticsProvider)
            .capture(
              'auth_signup',
              properties: const {'email_already_registered': true},
            );
        return SignUpOutcome.emailAlreadyRegistered;
      }
      if (response.session == null) {
        state = const AsyncValue.data(null);
        ref
            .read(analyticsProvider)
            .capture(
              'auth_signup',
              properties: const {'confirmation_required': true},
            );
        return SignUpOutcome.confirmationRequired;
      }
      state = AsyncValue.data(response.user);
      ref
          .read(analyticsProvider)
          .capture(
            'auth_signup',
            properties: const {'confirmation_required': false},
          );
      return SignUpOutcome.signedIn;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return SignUpOutcome.failed;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(supabaseClientProvider);
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    });
    if (!state.hasError) {
      ref
          .read(analyticsProvider)
          .capture('auth_login', properties: const {'method': 'email'});
    }
  }

  Future<void> signInWithGoogle() async {
    final client = ref.read(supabaseClientProvider);
    ref
        .read(analyticsProvider)
        .capture('auth_login_attempt', properties: const {'method': 'google'});
    // iOS uses the native ID-token flow. The previous web-OAuth flow
    // (SFSafariViewController + custom-scheme redirect) hung indefinitely on
    // iPad because the io.sippd:// callback never returned to the app.
    if (Platform.isIOS) {
      await _signInWithGoogleNative(client);
      return;
    }
    // Android keeps the web-OAuth flow (Chrome Custom Tabs returns reliably).
    await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.sippd://login-callback/',
      authScreenLaunchMode: LaunchMode.inAppBrowserView,
    );
  }

  Future<void> _signInWithGoogleNative(SupabaseClient client) async {
    final signIn = GoogleSignIn.instance;
    if (!_googleSignInInitialized) {
      await signIn.initialize(
        clientId: _googleIosClientId,
        serverClientId: _googleWebClientId,
      );
      _googleSignInInitialized = true;
    }
    final account = await signIn.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw const AuthException('Google sign-in returned no identity token.');
    }
    await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
    ref
        .read(analyticsProvider)
        .capture('auth_login', properties: const {'method': 'google'});
  }

  /// Native Sign in with Apple (iOS). Required by App Store guideline 4.8
  /// whenever a third-party login (Google) is offered.
  Future<void> signInWithApple() async {
    final client = ref.read(supabaseClientProvider);
    ref
        .read(analyticsProvider)
        .capture('auth_login_attempt', properties: const {'method': 'apple'});
    // Apple verifies the SHA-256 hash of a per-attempt raw nonce; Supabase
    // then checks the raw nonce against the token to prevent replay.
    final rawNonce = _generateNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: const [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );
    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException('Apple sign-in returned no identity token.');
    }
    await client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
    ref
        .read(analyticsProvider)
        .capture('auth_login', properties: const {'method': 'apple'});
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  Future<void> signOut() async {
    final client = ref.read(supabaseClientProvider);
    final uid = client.auth.currentUser?.id;
    ref.read(analyticsProvider).capture('auth_logout');
    await client.auth.signOut();
    // Wipe the pre-auth onboarding buffer so the next user on this device
    // can't see the previous user's taste answers during the auth ->
    // profile-load latency window. `onboarding_seen` stays — that flag is
    // device-scoped, not account-scoped, so we don't replay the welcome
    // funnel for someone who already saw it.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(onboardingAnswersKey);
    await prefs.remove(onboardingProfileSeedPendingKey);
    // Drop the cached profile too — same reason as the SharedPreferences
    // wipe above. Without this, the next sign-in on this device would
    // briefly see the previous user's profile while the new one syncs.
    if (uid != null) {
      await ref.read(appDatabaseProvider).profilesDao.deleteById(uid);
    }
    // Wipe Flutter's in-memory image cache so the next account on this
    // device cannot scroll back through the previous user's wine photos
    // and avatars before the new session pulls fresh URLs.
    imageCache.clear();
    imageCache.clearLiveImages();
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
    final StreamSubscription<AuthState> sub = client.auth.onAuthStateChange
        .listen((data) {
          if (data.event == AuthChangeEvent.passwordRecovery) {
            state = true;
          }
        });
    ref.onDispose(sub.cancel);
    return false;
  }

  void clear() => state = false;
}
