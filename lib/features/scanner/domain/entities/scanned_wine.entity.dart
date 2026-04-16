import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanned_wine.entity.freezed.dart';

enum ScanSource { barcode, label, manual }

@freezed
class ScannedWineData with _$ScannedWineData {
  const factory ScannedWineData({
    String? barcode,
    String? name,
    String? brand,
    String? country,
    String? grape,
    int? vintage,
    String? imageUrl,
    String? labelImagePath,
    @Default(ScanSource.manual) ScanSource source,
    @Default(false) bool found,
  }) = _ScannedWineData;
}
