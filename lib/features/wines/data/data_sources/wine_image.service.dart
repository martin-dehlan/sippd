import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class WineImageService {
  final SupabaseClient _client;
  final ImagePicker _picker = ImagePicker();

  WineImageService(this._client);

  Future<String?> pickAndUploadImage({
    required String userId,
    ImageSource source = ImageSource.camera,
  }) async {
    final photo = await _picker.pickImage(
      source: source,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 80,
      requestFullMetadata: false,
    );

    if (photo == null) return null;

    return uploadImage(userId: userId, filePath: photo.path);
  }

  static const _extToMime = {
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'webp': 'image/webp',
  };

  Future<String> uploadImage({
    required String userId,
    required String filePath,
  }) async {
    final file = File(filePath);
    final rawExt = filePath.split('.').last.toLowerCase();
    // Bucket allowlist is image/jpeg|png|webp; coerce unknown/heic to jpg
    // so the contentType always matches one the bucket accepts.
    final ext = _extToMime.containsKey(rawExt) ? rawExt : 'jpg';
    final mime = _extToMime[ext]!;
    final fileName = '${const Uuid().v4()}.$ext';
    final storagePath = '$userId/$fileName';

    final size = await file.length();
    // ignore: avoid_print
    print('[wine_image] upload path=$storagePath mime=$mime size=$size '
        'rawExt=$rawExt');
    try {
      await _client.storage
          .from('wine-images')
          .upload(
            storagePath,
            file,
            fileOptions: FileOptions(
              cacheControl: '3600',
              upsert: true,
              contentType: mime,
            ),
          );
    } catch (e, st) {
      // ignore: avoid_print
      print('[wine_image] UPLOAD FAILED: $e\n$st');
      rethrow;
    }

    final publicUrl = _client.storage
        .from('wine-images')
        .getPublicUrl(storagePath);

    return publicUrl;
  }

  Future<void> deleteImage(String imageUrl) async {
    // Extract path from URL
    final uri = Uri.parse(imageUrl);
    final segments = uri.pathSegments;
    // URL: .../storage/v1/object/public/wine-images/userId/fileName
    final bucketIndex = segments.indexOf('wine-images');
    if (bucketIndex < 0) return;

    final storagePath = segments.sublist(bucketIndex + 1).join('/');

    await _client.storage.from('wine-images').remove([storagePath]);
  }
}
