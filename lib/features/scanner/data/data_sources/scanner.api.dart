import 'dart:convert';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/scan_result.model.dart';

/// Raised when the user has no scans left in the rolling window. Carries
/// the quota so the UI can show the exact limit + route to the paywall.
class ScanQuotaExceeded implements Exception {
  final ScanQuotaModel quota;
  const ScanQuotaExceeded(this.quota);
}

/// Thin wrapper over the `recognize-label` Edge Function. Sends the
/// label image as base64 JSON so supabase-js carries the caller's JWT;
/// the function holds the FastCork key and enforces quota server-side.
class ScannerApi {
  final SupabaseClient _client;

  ScannerApi(this._client);

  Future<ScanResponseModel> recognize(
    File image, {
    String lang = 'en',
    bool isPro = false,
  }) async {
    final bytes = await image.readAsBytes();
    try {
      final res = await _client.functions.invoke(
        'recognize-label',
        body: {
          'image_base64': base64Encode(bytes),
          'lang': lang,
          'is_pro': isPro,
        },
      );
      final data = res.data as Map<String, dynamic>;
      return ScanResponseModel.fromJson(data);
    } on FunctionException catch (e) {
      // Edge Function returned a non-2xx with a JSON error envelope.
      final details = e.details;
      final code = details is Map ? details['error'] as String? : null;
      if (e.status == 429 || code == 'scan_quota_exceeded') {
        final q = details is Map ? details['quota'] : null;
        throw ScanQuotaExceeded(
          q is Map
              ? ScanQuotaModel.fromJson(Map<String, dynamic>.from(q))
              : const ScanQuotaModel(),
        );
      }
      rethrow;
    }
  }

  /// Read-only remaining count (does not consume a scan).
  Future<ScanQuotaModel?> quotaStatus({bool isPro = false}) async {
    final data = await _client.rpc<dynamic>(
      'scan_quota_status',
      params: {'p_is_pro': isPro},
    );
    final row = data is List && data.isNotEmpty ? data.first : data;
    if (row is! Map) return null;
    return ScanQuotaModel.fromJson(Map<String, dynamic>.from(row));
  }
}
