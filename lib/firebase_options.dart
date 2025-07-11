// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBK8iVbaVfoU7THXyKAxgZJESKrhbtoAas',
    appId: '1:434905090125:web:2674d4262c1911dd897404',
    messagingSenderId: '434905090125',
    projectId: 'fruits-hub-f1a55',
    authDomain: 'fruits-hub-f1a55.firebaseapp.com',
    storageBucket: 'fruits-hub-f1a55.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1fBp92g1WPt7tRs1ccCwaso9R4DYEOCw',
    appId: '1:434905090125:android:a1c9f5a099275c9d897404',
    messagingSenderId: '434905090125',
    projectId: 'fruits-hub-f1a55',
    storageBucket: 'fruits-hub-f1a55.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD01NktX30rWfRFUxBTnrcBDxs50mseWC4',
    appId: '1:434905090125:ios:264b092851581f41897404',
    messagingSenderId: '434905090125',
    projectId: 'fruits-hub-f1a55',
    storageBucket: 'fruits-hub-f1a55.firebasestorage.app',
    iosBundleId: 'com.example.fruitsHub',
  );
}
