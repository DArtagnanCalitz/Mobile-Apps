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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAGC4I9LSlRQXSePd-5XLyXG2SukLCQSVI',
    appId: '1:710917968740:web:d57eae1c053e146d536071',
    messagingSenderId: '710917968740',
    projectId: 'cohort-confessions',
    authDomain: 'cohort-confessions.firebaseapp.com',
    storageBucket: 'cohort-confessions.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9bzoC5D9RJYErQr4nxMk1p5fcfGw6NC0',
    appId: '1:710917968740:android:b8005894003098b2536071',
    messagingSenderId: '710917968740',
    projectId: 'cohort-confessions',
    storageBucket: 'cohort-confessions.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtGq3zhe-mgaEWjsSz5uxrLF5wRB62XS4',
    appId: '1:710917968740:ios:a8ee8baec1d645fe536071',
    messagingSenderId: '710917968740',
    projectId: 'cohort-confessions',
    storageBucket: 'cohort-confessions.firebasestorage.app',
    iosBundleId: 'com.example.cohortConfessions',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtGq3zhe-mgaEWjsSz5uxrLF5wRB62XS4',
    appId: '1:710917968740:ios:a8ee8baec1d645fe536071',
    messagingSenderId: '710917968740',
    projectId: 'cohort-confessions',
    storageBucket: 'cohort-confessions.firebasestorage.app',
    iosBundleId: 'com.example.cohortConfessions',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAGC4I9LSlRQXSePd-5XLyXG2SukLCQSVI',
    appId: '1:710917968740:web:709f13fbe304fd56536071',
    messagingSenderId: '710917968740',
    projectId: 'cohort-confessions',
    authDomain: 'cohort-confessions.firebaseapp.com',
    storageBucket: 'cohort-confessions.firebasestorage.app',
  );
}
