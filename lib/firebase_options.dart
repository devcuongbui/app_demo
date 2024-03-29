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
        return macos;
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
    apiKey: 'AIzaSyDQfhnMYXpAxsgUV38xIt0JQ9zNCXLT8Eo',
    appId: '1:35230161170:web:1f35027cdf5ac84b413bcb',
    messagingSenderId: '35230161170',
    projectId: 'flutterapp-2fd6c',
    authDomain: 'flutterapp-2fd6c.firebaseapp.com',
    storageBucket: 'flutterapp-2fd6c.appspot.com',
    measurementId: 'G-Q46HX6F1K0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCejFL6eqSfTeKFUbYsVIok8hx3z5eV28E',
    appId: '1:35230161170:android:0dde515216008bce413bcb',
    messagingSenderId: '35230161170',
    projectId: 'flutterapp-2fd6c',
    storageBucket: 'flutterapp-2fd6c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXQuGwAnUmSnGeFxBhhiveTIHYfPxytmY',
    appId: '1:35230161170:ios:018801dcc9c1b331413bcb',
    messagingSenderId: '35230161170',
    projectId: 'flutterapp-2fd6c',
    storageBucket: 'flutterapp-2fd6c.appspot.com',
    iosClientId: '35230161170-qnjjsp79r465htnfluulolusobbp8b5h.apps.googleusercontent.com',
    iosBundleId: 'com.example.demo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXQuGwAnUmSnGeFxBhhiveTIHYfPxytmY',
    appId: '1:35230161170:ios:018801dcc9c1b331413bcb',
    messagingSenderId: '35230161170',
    projectId: 'flutterapp-2fd6c',
    storageBucket: 'flutterapp-2fd6c.appspot.com',
    iosClientId: '35230161170-qnjjsp79r465htnfluulolusobbp8b5h.apps.googleusercontent.com',
    iosBundleId: 'com.example.demo',
  );
}
