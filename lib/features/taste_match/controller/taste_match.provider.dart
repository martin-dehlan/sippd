import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/controller/auth.provider.dart';
import '../data/data_sources/taste_match.api.dart';
import '../data/models/shared_bottle.model.dart';
import '../data/models/taste_compass.model.dart';
import '../data/models/taste_match.model.dart';
import '../domain/entities/shared_bottle.entity.dart';
import '../domain/entities/taste_compass.entity.dart';
import '../domain/entities/taste_match.entity.dart';
import '../domain/entities/user_grape_share.entity.dart';
import '../domain/entities/user_style_dna.entity.dart';

part 'taste_match.provider.g.dart';

@riverpod
TasteMatchApi tasteMatchApi(TasteMatchApiRef ref) {
  return TasteMatchApi(ref.watch(supabaseClientProvider));
}

@riverpod
Future<TasteCompassEntity> tasteCompass(
  TasteCompassRef ref,
  String userId,
) async {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return const TasteCompassEntity(totalCount: 0);
  final api = ref.watch(tasteMatchApiProvider);
  final model = await api.getCompass(userId);
  return model.toEntity();
}

@riverpod
Future<List<SharedBottleEntity>> sharedBottles(
  SharedBottlesRef ref,
  String otherUserId,
) async {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return const [];
  final api = ref.watch(tasteMatchApiProvider);
  final models = await api.getSharedBottles(otherUserId);
  return models.map((m) => m.toEntity()).toList(growable: false);
}

@riverpod
Future<TasteMatchEntity> tasteMatch(
  TasteMatchRef ref,
  String otherUserId,
) async {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return const TasteMatchEntity();
  final api = ref.watch(tasteMatchApiProvider);
  final model = await api.getMatch(otherUserId);
  return model.toEntity();
}

@riverpod
Future<List<UserGrapeShare>> userTopGrapes(
  UserTopGrapesRef ref,
  String userId,
) async {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return const [];
  final api = ref.watch(tasteMatchApiProvider);
  return api.getTopGrapes(userId);
}

@riverpod
Future<UserStyleDna> userStyleDna(
  UserStyleDnaRef ref,
  String userId,
) async {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) {
    return const UserStyleDna(values: {}, attributedCount: 0, confidence: 0);
  }
  final api = ref.watch(tasteMatchApiProvider);
  return api.getStyleDna(userId);
}
