import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Persists the PKCE code verifier in the platform secure store
/// (Android Keystore / iOS Keychain).
///
/// SharedPreferences is async-on-write on Android. If the OS reclaims the
/// app process while the OAuth Custom Tab is foregrounded — which happens
/// under memory pressure — the verifier write may not have hit disk and
/// the redirect callback can't exchange the auth code, surfacing as
/// `AuthException(message: Code verifier could not be found in local
/// storage)`. Keystore/Keychain writes are committed before the call
/// returns, so the verifier survives a process restart.
class SecurePkceStorage extends GotrueAsyncStorage {
  SecurePkceStorage({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> getItem({required String key}) => _storage.read(key: key);

  @override
  Future<void> setItem({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> removeItem({required String key}) => _storage.delete(key: key);
}
