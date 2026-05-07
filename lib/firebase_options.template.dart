// Placeholder copy of the FlutterFire-generated `firebase_options.dart`,
// committed so CI can satisfy `import 'firebase_options.dart'` in
// main.dart without a real Firebase configure pass. Local development
// and release builds use the real `firebase_options.dart` produced by
// `flutterfire configure` (gitignored).
//
// CI workflow copies this file to `lib/firebase_options.dart` before
// running `flutter analyze` / `dart format` / `flutter test`. None of
// these phases need real Firebase credentials.
//
// Do NOT put real API keys here — anything in this file is public.

// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'PLACEHOLDER_FOR_CI_ONLY',
    appId: '1:0000000000:android:0000000000',
    messagingSenderId: '0000000000',
    projectId: 'placeholder-project',
    storageBucket: 'placeholder-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'PLACEHOLDER_FOR_CI_ONLY',
    appId: '1:0000000000:ios:0000000000',
    messagingSenderId: '0000000000',
    projectId: 'placeholder-project',
    storageBucket: 'placeholder-project.appspot.com',
    iosBundleId: 'xyz.sippd.app',
  );
}
