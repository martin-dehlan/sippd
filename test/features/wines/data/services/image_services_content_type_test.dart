import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/features/groups/data/data_sources/group_image.service.dart';
import 'package:sippd/features/profile/data/data_sources/profile_image.service.dart';
import 'package:sippd/features/wines/data/data_sources/wine_image.service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class _MockSupabaseClient extends Mock implements SupabaseClient {}

class _MockStorage extends Mock implements SupabaseStorageClient {}

class _MockBucket extends Mock implements StorageFileApi {}

void main() {
  setUpAll(() {
    registerFallbackValue(File('dummy.jpg'));
    registerFallbackValue(const FileOptions());
  });

  late _MockSupabaseClient client;
  late _MockStorage storage;
  late _MockBucket bucket;
  late File tmpFile;

  setUp(() async {
    client = _MockSupabaseClient();
    storage = _MockStorage();
    bucket = _MockBucket();
    when(() => client.storage).thenReturn(storage);
    when(() => storage.from(any())).thenReturn(bucket);
    when(
      () => bucket.upload(any(), any(), fileOptions: any(named: 'fileOptions')),
    ).thenAnswer((_) async => 'ok');
    when(() => bucket.getPublicUrl(any())).thenReturn('https://x/y.jpg');

    tmpFile = await File(
      '${Directory.systemTemp.path}/heic_${DateTime.now().microsecondsSinceEpoch}.heic',
    ).create();
    await tmpFile.writeAsBytes([0]);
  });

  tearDown(() async {
    if (await tmpFile.exists()) await tmpFile.delete();
  });

  FileOptions captureOpts() {
    final captured = verify(
      () => bucket.upload(
        any(),
        any(),
        fileOptions: captureAny(named: 'fileOptions'),
      ),
    ).captured;
    return captured.single as FileOptions;
  }

  test('WineImageService forces image/jpeg contentType', () async {
    await WineImageService(
      client,
    ).uploadImage(userId: 'u', filePath: tmpFile.path);
    expect(captureOpts().contentType, 'image/jpeg');
  });

  test('ProfileImageService forces image/jpeg contentType', () async {
    await ProfileImageService(
      client,
    ).uploadImage(userId: 'u', filePath: tmpFile.path);
    expect(captureOpts().contentType, 'image/jpeg');
  });

  test('GroupImageService forces image/jpeg contentType', () async {
    await GroupImageService(
      client,
    ).uploadImage(groupId: 'g', filePath: tmpFile.path);
    expect(captureOpts().contentType, 'image/jpeg');
  });
}
