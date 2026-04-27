import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ProfileImageService {
  final SupabaseClient _client;
  final ImagePicker _picker = ImagePicker();

  ProfileImageService(this._client);

  Future<String?> pickAndUploadImage({
    required String userId,
    ImageSource source = ImageSource.gallery,
  }) async {
    final photo = await _picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );
    if (photo == null) return null;
    return uploadImage(userId: userId, filePath: photo.path);
  }

  Future<String> uploadImage({
    required String userId,
    required String filePath,
  }) async {
    final file = File(filePath);
    final ext = filePath.split('.').last;
    final fileName = '${const Uuid().v4()}.$ext';
    final storagePath = '$userId/$fileName';

    await _client.storage
        .from('avatars')
        .upload(
          storagePath,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );

    return _client.storage.from('avatars').getPublicUrl(storagePath);
  }

  Future<void> deleteImage(String imageUrl) async {
    final uri = Uri.parse(imageUrl);
    final segments = uri.pathSegments;
    final bucketIndex = segments.indexOf('avatars');
    if (bucketIndex < 0) return;
    final storagePath = segments.sublist(bucketIndex + 1).join('/');
    await _client.storage.from('avatars').remove([storagePath]);
  }
}
