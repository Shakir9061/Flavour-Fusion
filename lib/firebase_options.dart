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
    apiKey: 'AIzaSyBjzsN_7F5BPDlzePlC8S8NU1S788YTHww',
    appId: '1:611692685384:web:d60f487e829ccd8d5f107d',
    messagingSenderId: '611692685384',
    projectId: 'flavourfusion-3b9da',
    authDomain: 'flavourfusion-3b9da.firebaseapp.com',
    storageBucket: 'flavourfusion-3b9da.appspot.com',
    measurementId: 'G-MK2S9VFX6X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPANYLeYN7XyqNmigw0eDK-rYhbqisAN4',
    appId: '1:611692685384:android:dba889f8b53d1d495f107d',
    messagingSenderId: '611692685384',
    projectId: 'flavourfusion-3b9da',
    storageBucket: 'flavourfusion-3b9da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZljyYzuK1yAZRzqW3ukb9pWagvaiJko8',
    appId: '1:611692685384:ios:9b016e3e5d6019005f107d',
    messagingSenderId: '611692685384',
    projectId: 'flavourfusion-3b9da',
    storageBucket: 'flavourfusion-3b9da.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZljyYzuK1yAZRzqW3ukb9pWagvaiJko8',
    appId: '1:611692685384:ios:9b016e3e5d6019005f107d',
    messagingSenderId: '611692685384',
    projectId: 'flavourfusion-3b9da',
    storageBucket: 'flavourfusion-3b9da.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBjzsN_7F5BPDlzePlC8S8NU1S788YTHww',
    appId: '1:611692685384:web:e87783881a0beb9b5f107d',
    messagingSenderId: '611692685384',
    projectId: 'flavourfusion-3b9da',
    authDomain: 'flavourfusion-3b9da.firebaseapp.com',
    storageBucket: 'flavourfusion-3b9da.appspot.com',
    measurementId: 'G-1X51NEE418',
  );
}