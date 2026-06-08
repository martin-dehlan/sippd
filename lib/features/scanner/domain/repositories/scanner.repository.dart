import 'dart:io';

import '../entities/scan_quota.entity.dart';
import '../entities/scan_result.entity.dart';

/// Wine-label recognition. The implementation proxies through the
/// `recognize-label` Supabase Edge Function (server-held FastCork key +
/// per-user quota); the UI never touches FastCork directly.
abstract class ScannerRepository {
  /// Recognize a wine from a label photo. Consumes one scan from the
  /// user's quota. Throws [AppError.validation] with field `scan_quota`
  /// when the quota is exhausted, or a mapped [AppError] on failure.
  Future<ScanResultEntity> recognize(File image, {String lang = 'en'});

  /// Remaining scans without consuming one (powers the "N scans left"
  /// counter). Returns null when the count can't be fetched (offline).
  Future<ScanQuotaEntity?> quotaStatus();
}
