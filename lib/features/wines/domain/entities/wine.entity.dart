import 'package:freezed_annotation/freezed_annotation.dart';

part 'wine.entity.freezed.dart';

enum WineType { red, white, rose }

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
    String? location,
    String? notes,
    String? imageUrl,
    String? localImagePath,
    int? vintage,
    String? grape,
    required String userId,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _WineEntity;
}
