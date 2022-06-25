// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBO_jFXW4IPf-8kzF5sIt82jn5zd8NzFBM',
    appId: '1:516942972335:web:b539d8cbf5f64fabf25b5a',
    messagingSenderId: '516942972335',
    projectId: 'pay-qr-b5905',
    authDomain: 'pay-qr-b5905.firebaseapp.com',
    storageBucket: 'pay-qr-b5905.appspot.com',
    measurementId: 'G-1QJ4W5WVJ4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkH0ZgmlRF5Jch3W4sjmILhHtJW1MnZ6o',
    appId: '1:516942972335:android:9814a0c93acae1d1f25b5a',
    messagingSenderId: '516942972335',
    projectId: 'pay-qr-b5905',
    storageBucket: 'pay-qr-b5905.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDILDWx4mWqX_6mdmlve3uysFBhG7F8q9g',
    appId: '1:516942972335:ios:f90cd5c7de0dd926f25b5a',
    messagingSenderId: '516942972335',
    projectId: 'pay-qr-b5905',
    storageBucket: 'pay-qr-b5905.appspot.com',
    iosClientId: '516942972335-ojfduj9p1jimilk63ksn44g8omdh1i8d.apps.googleusercontent.com',
    iosBundleId: 'com.payqr.payqr.payQr',
  );
}
