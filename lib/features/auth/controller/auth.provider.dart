import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth.provider.g.dart';

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

    // Listen to auth state changes
    client.auth.onAuthStateChange.listen((data) {
      state = AsyncValue.data(data.session?.user);
    });

    return AsyncValue.data(user);
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(supabaseClientProvider);
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: displayName != null ? {'display_name': displayName} : null,
      );
      return response.user;
    });
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

  Future<void> signOut() async {
    final client = ref.read(supabaseClientProvider);
    await client.auth.signOut();
    state = const AsyncValue.data(null);
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
