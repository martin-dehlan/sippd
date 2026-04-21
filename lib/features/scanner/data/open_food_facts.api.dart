import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../domain/entities/scanned_wine.entity.dart';

class OpenFoodFactsApi {
  final Dio _dio;

  OpenFoodFactsApi({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: 'https://world.openfoodfacts.org/api/v2',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ));

  Future<ScannedWineData> lookupBarcode(String barcode) async {
    try {
      final response = await _dio.get(
        '/product/$barcode',
        queryParameters: {
          'fields':
              'product_name,brands,countries_tags,categories_tags,image_url,labels_tags',
        },
      );

      final data = response.data;
      debugPrint(
          '[OFF] $barcode → status=${data is Map ? data['status'] : 'n/a'}');
      if (data == null || data['status'] != 1 || data['product'] == null) {
        return ScannedWineData(
          barcode: barcode,
          source: ScanSource.barcode,
          found: false,
        );
      }

      final product = data['product'] as Map<String, dynamic>;

      return ScannedWineData(
        barcode: barcode,
        name: _cleanName(product['product_name'] as String?),
        brand: product['brands'] as String?,
        country: _extractCountry(product['countries_tags'] as List?),
        grape: _extractGrape(product),
        imageUrl: product['image_url'] as String?,
        source: ScanSource.barcode,
        found: true,
      );
    } on DioException catch (e) {
      debugPrint('[OFF] $barcode → DioException ${e.type} '
          'status=${e.response?.statusCode}');
      return ScannedWineData(
        barcode: barcode,
        source: ScanSource.barcode,
        found: false,
      );
    }
  }

  String? _cleanName(String? name) {
    if (name == null || name.isEmpty) return null;
    // Remove brand prefix if duplicated in name
    return name.trim();
  }

  String? _extractCountry(List? tags) {
    if (tags == null || tags.isEmpty) return null;
    // Tags look like "en:france", "en:italy"
    final countryMap = {
      'en:france': 'France',
      'en:italy': 'Italy',
      'en:spain': 'Spain',
      'en:germany': 'Germany',
      'en:portugal': 'Portugal',
      'en:argentina': 'Argentina',
      'en:chile': 'Chile',
      'en:australia': 'Australia',
      'en:south-africa': 'South Africa',
      'en:austria': 'Austria',
      'en:united-states': 'USA',
      'en:new-zealand': 'New Zealand',
      'en:greece': 'Greece',
      'en:georgia': 'Georgia',
      'en:hungary': 'Hungary',
    };

    for (final tag in tags) {
      final country = countryMap[tag.toString()];
      if (country != null) return country;
    }

    // Fallback: clean the first tag
    final first = tags.first.toString();
    if (first.startsWith('en:')) {
      return first
          .substring(3)
          .split('-')
          .map((w) => w[0].toUpperCase() + w.substring(1))
          .join(' ');
    }
    return null;
  }

  String? _extractGrape(Map<String, dynamic> product) {
    // Open Food Facts sometimes has grape info in labels or categories
    final labels = product['labels_tags'] as List?;
    if (labels == null) return null;

    final grapeKeywords = [
      'cabernet',
      'merlot',
      'pinot',
      'chardonnay',
      'sauvignon',
      'syrah',
      'shiraz',
      'riesling',
      'tempranillo',
      'malbec',
      'grenache',
      'sangiovese',
      'nebbiolo',
      'zinfandel',
    ];

    for (final label in labels) {
      final l = label.toString().toLowerCase();
      for (final grape in grapeKeywords) {
        if (l.contains(grape)) {
          return grape[0].toUpperCase() + grape.substring(1);
        }
      }
    }
    return null;
  }
}
