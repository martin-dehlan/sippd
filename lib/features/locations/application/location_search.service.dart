import 'package:nominatim_flutter/model/request/search_request.dart';
import 'package:nominatim_flutter/model/response/nominatim_response.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';

import '../domain/entities/location.entity.dart';

class LocationSearchService {
  Future<List<LocationEntity>> searchLocations(
    String query, {
    int limit = 5,
    String language = 'en-US,en;q=0.5',
  }) async {
    if (query.isEmpty) return [];

    final searchRequest = SearchRequest(query: query, limit: limit);

    final response = await NominatimFlutter.instance.search(
      searchRequest: searchRequest,
      language: language,
    );

    return response
        .where((result) => result.lat != null && result.lon != null)
        .map(_toEntity)
        .toList();
  }

  LocationEntity _toEntity(NominatimResponse result) {
    return LocationEntity(
      lat: double.tryParse(result.lat ?? '0'),
      lng: double.tryParse(result.lon ?? '0'),
      locationName: _extractName(result),
      road: result.address?['road'] ?? '',
      houseNumber: result.address?['house_number'] ?? '',
      postcode: result.address?['postcode'] ?? '',
      borough: result.address?['borough'] ?? result.address?['suburb'] ?? '',
      city: result.address?['city'] ??
          result.address?['town'] ??
          result.address?['village'] ??
          '',
      country: result.address?['country'] ?? '',
    );
  }

  String _extractName(NominatimResponse result) {
    const nameKeys = [
      'amenity',
      'shop',
      'tourism',
      'building',
      'leisure',
      'historic',
    ];

    for (final key in nameKeys) {
      final name = result.address?[key];
      if (name != null && name.isNotEmpty) return name;
    }

    return result.name ?? result.displayName ?? '';
  }
}
