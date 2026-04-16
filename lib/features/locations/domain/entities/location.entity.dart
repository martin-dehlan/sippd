import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.entity.freezed.dart';

@freezed
class LocationEntity with _$LocationEntity {
  const factory LocationEntity({
    double? lat,
    double? lng,
    @Default('') String locationName,
    @Default('') String road,
    @Default('') String houseNumber,
    @Default('') String postcode,
    @Default('') String borough,
    @Default('') String city,
    @Default('') String country,
  }) = _LocationEntity;
}

extension LocationEntityX on LocationEntity {
  String get displayName {
    if (locationName.isNotEmpty) return locationName;
    if (road.isNotEmpty) {
      return houseNumber.isNotEmpty ? '$road $houseNumber' : road;
    }
    if (lat != null && lng != null) {
      return '${lat!.toStringAsFixed(4)}, ${lng!.toStringAsFixed(4)}';
    }
    return 'Unknown Location';
  }

  String get subtitle {
    final parts = <String>[];
    if (city.isNotEmpty) parts.add(city);
    if (postcode.isNotEmpty) parts.add(postcode);
    if (country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }

  String get shortDisplay {
    if (locationName.isNotEmpty && city.isNotEmpty) {
      return '$locationName, $city';
    }
    if (city.isNotEmpty) return city;
    return displayName;
  }
}
