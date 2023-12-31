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
    apiKey: 'AIzaSyACXP0P358naFFQvb98_JOqxtoZs-aeuho',
    appId: '1:696259143481:web:bf6362a169ccd7d4fd6ae8',
    messagingSenderId: '696259143481',
    projectId: 'my-api-endpoint',
    authDomain: 'my-api-endpoint.firebaseapp.com',
    storageBucket: 'my-api-endpoint.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsmFGxromjfoir-rC8CSDU46peqpmpFaQ',
    appId: '1:696259143481:android:bc7f180b1a870427fd6ae8',
    messagingSenderId: '696259143481',
    projectId: 'my-api-endpoint',
    storageBucket: 'my-api-endpoint.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAN-11CAG6XrRlDhmmIcUcwPDVKMlngaqM',
    appId: '1:696259143481:ios:d657ff6851e63323fd6ae8',
    messagingSenderId: '696259143481',
    projectId: 'my-api-endpoint',
    storageBucket: 'my-api-endpoint.appspot.com',
    androidClientId: '696259143481-vokbfm8ih351k5tlat8nft0bq1af54oh.apps.googleusercontent.com',
    iosClientId: '696259143481-1c8243qbbt9jk6gdh8visc8snkug5n4d.apps.googleusercontent.com',
    iosBundleId: 'com.example.genderName',
  );
}
