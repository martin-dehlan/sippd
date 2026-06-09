import 'dart:io';

import '../../../../common/errors/app_error.dart';
import '../../domain/entities/scan_quota.entity.dart';
import '../../domain/entities/scan_result.entity.dart';
import '../../domain/repositories/scanner.repository.dart';
import '../data_sources/scanner.api.dart';
import '../models/scan_result.model.dart';

class ScannerRepositoryImpl implements ScannerRepository {
  final ScannerApi _api;

  ScannerRepositoryImpl(this._api);

  @override
  Future<ScanResultEntity> recognize(File image, {String lang = 'en'}) async {
    try {
      final model = await _api.recognize(image, lang: lang);
      return model.toEntity();
    } on ScanQuotaExceeded {
      // Surfaced as a typed validation error the UI keys on to show the
      // daily-limit block + manual-entry fallback (field == 'scan_quota').
      throw const AppError.validation(
        message: 'Daily scan limit reached.',
        field: 'scan_quota',
      );
    }
  }

  @override
  Future<ScanQuotaEntity?> quotaStatus() async {
    try {
      final model = await _api.quotaStatus();
      return model?.toEntity();
    } catch (_) {
      // Best-effort counter — offline / RPC failure just hides the badge.
      return null;
    }
  }
}
