import 'package:geolocator/geolocator.dart';
import 'package:nominatim_flutter/model/request/reverse_request.dart';
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

  /// Resolve the device's current GPS position into a [LocationEntity].
  ///
  /// Handles permission prompts; throws on denial or when location services
  /// are off so the caller can surface a user-facing message.
  Future<LocationEntity> resolveCurrentLocation({
    String language = 'en-US,en;q=0.5',
  }) async {
    final servicesEnabled = await Geolocator.isLocationServiceEnabled();
    if (!servicesEnabled) {
      throw const LocationUnavailable(LocationUnavailableReason.servicesOff);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw const LocationUnavailable(
        LocationUnavailableReason.permissionDenied,
      );
    }

    return _resolveCurrentEntity(language: language);
  }

  /// Best-effort current location that NEVER prompts: returns it only when
  /// permission is already granted and services are on, else null. Used to
  /// silently prefill a new wine's place without nagging the user.
  Future<LocationEntity?> resolveCurrentLocationIfPermitted({
    String language = 'en-US,en;q=0.5',
  }) async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;
      final permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
      return _resolveCurrentEntity(language: language);
    } catch (_) {
      // Prefill is best-effort — a GPS/network hiccup must never break the
      // form. The user can still set the place by hand.
      return null;
    }
  }

  Future<LocationEntity> _resolveCurrentEntity({
    required String language,
  }) async {
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 12),
      ),
    );

    final reverse = await NominatimFlutter.instance.reverse(
      reverseRequest: ReverseRequest(
        lat: pos.latitude,
        lon: pos.longitude,
        addressDetails: true,
        extraTags: false,
        nameDetails: false,
      ),
      language: language,
    );

    final entity = _toEntity(reverse);
    // Reverse response sometimes omits parsed lat/lng — fall back to GPS.
    return entity.copyWith(
      lat: entity.lat ?? pos.latitude,
      lng: entity.lng ?? pos.longitude,
    );
  }

  LocationEntity _toEntity(NominatimResponse result) {
    final address = result.address;
    return LocationEntity(
      lat: double.tryParse(result.lat ?? '0'),
      lng: double.tryParse(result.lon ?? '0'),
      locationName: _extractName(result),
      road: _str(address?['road']),
      houseNumber: _str(address?['house_number']),
      postcode: _str(address?['postcode']),
      borough: _str(address?['borough']).isNotEmpty
          ? _str(address?['borough'])
          : _str(address?['suburb']),
      city: [
        _str(address?['city']),
        _str(address?['town']),
        _str(address?['village']),
      ].firstWhere((v) => v.isNotEmpty, orElse: () => ''),
      country: _str(address?['country']),
    );
  }

  // Nominatim's `address` map carries dynamic values; coerce to a String.
  String _str(Object? value) => value is String ? value : '';

  String _extractName(NominatimResponse result) {
    const nameKeys = [
      'amenity',
      'shop',
      'tourism',
      'building',
      'leisure',
      'historic',
    ];

    final address = result.address;
    for (final key in nameKeys) {
      final name = address?[key];
      if (name is String && name.isNotEmpty) return name;
    }

    return result.name ?? result.displayName ?? '';
  }
}

enum LocationUnavailableReason { servicesOff, permissionDenied }

class LocationUnavailable implements Exception {
  final LocationUnavailableReason reason;
  const LocationUnavailable(this.reason);

  @override
  String toString() => 'LocationUnavailable(${reason.name})';
}
