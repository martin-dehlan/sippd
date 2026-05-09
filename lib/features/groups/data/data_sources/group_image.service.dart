import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class GroupImageService {
  static const String bucket = 'group-images';

  final SupabaseClient _client;
  final ImagePicker _picker = ImagePicker();

  GroupImageService(this._client);

  Future<String?> pickAndUploadImage({
    required String groupId,
    ImageSource source = ImageSource.gallery,
  }) async {
    final photo = await _picker.pickImage(
      source: source,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 80,
      requestFullMetadata: false,
    );
    if (photo == null) return null;
    return uploadImage(groupId: groupId, filePath: photo.path);
  }

  static const _extToMime = {
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'webp': 'image/webp',
  };

  Future<String> uploadImage({
    required String groupId,
    required String filePath,
  }) async {
    final file = File(filePath);
    final rawExt = filePath.split('.').last.toLowerCase();
    // Bucket allowlist is image/jpeg|png|webp; coerce unknown/heic to jpg
    // so the contentType always matches one the bucket accepts.
    final ext = _extToMime.containsKey(rawExt) ? rawExt : 'jpg';
    final mime = _extToMime[ext]!;
    final fileName = '${const Uuid().v4()}.$ext';
    final storagePath = '$groupId/$fileName';

    await _client.storage
        .from(bucket)
        .upload(
          storagePath,
          file,
          fileOptions: FileOptions(
            cacheControl: '3600',
            upsert: true,
            contentType: mime,
          ),
        );

    return _client.storage.from(bucket).getPublicUrl(storagePath);
  }

  Future<void> deleteImage(String imageUrl) async {
    final uri = Uri.parse(imageUrl);
    final segments = uri.pathSegments;
    final bucketIndex = segments.indexOf(bucket);
    if (bucketIndex < 0) return;
    final storagePath = segments.sublist(bucketIndex + 1).join('/');
    await _client.storage.from(bucket).remove([storagePath]);
  }
}
