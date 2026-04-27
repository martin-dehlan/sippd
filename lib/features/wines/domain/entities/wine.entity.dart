import 'package:freezed_annotation/freezed_annotation.dart';

part 'wine.entity.freezed.dart';

enum WineType { red, white, rose, sparkling }

@freezed
class WineEntity with _$WineEntity {
  const factory WineEntity({
    required String id,
    required String name,
    required double rating,
    required WineType type,
    double? price,
    @Default('EUR') String currency,
    String? country,
    String? region,
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    String? imageUrl,
    String? localImagePath,
    int? vintage,
    String? grape,
    String? winery,
    String? nameNorm,
    required String userId,
    @Default('friends') String visibility,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _WineEntity;
}
