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
///
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
    apiKey: 'AIzaSyCT01T2TwEykTKXpx-h56w8IoN0EN7Od14',
    appId: '1:535639872179:web:08b05fe8644049f0c556c6',
    messagingSenderId: '535639872179',
    projectId: 'new-diabuddy',
    authDomain: 'new-diabuddy.firebaseapp.com',
    storageBucket: 'new-diabuddy.appspot.com',
    measurementId: 'G-SK54CHBHCJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1Pf2G44rWXTwC3fhT6peCpiYW7XgFjbY',
    appId: '1:535639872179:android:51bcf87f57f3cab5c556c6',
    messagingSenderId: '535639872179',
    projectId: 'new-diabuddy',
    storageBucket: 'new-diabuddy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZLgbeIc4P7kFYyG9TX237XmKF_L4I7PE',
    appId: '1:535639872179:ios:15e538ce27e52217c556c6',
    messagingSenderId: '535639872179',
    projectId: 'new-diabuddy',
    storageBucket: 'new-diabuddy.appspot.com',
    androidClientId:
        '535639872179-2nf55dmhmrel1blhtbqqdd3cm7b35mhr.apps.googleusercontent.com',
    iosClientId:
        '535639872179-dh18b7q27sgktv0n0gih893gdmktq0v1.apps.googleusercontent.com',
    iosBundleId: 'com.example.diabuddy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZLgbeIc4P7kFYyG9TX237XmKF_L4I7PE',
    appId: '1:535639872179:ios:15e538ce27e52217c556c6',
    messagingSenderId: '535639872179',
    projectId: 'new-diabuddy',
    storageBucket: 'new-diabuddy.appspot.com',
    androidClientId:
        '535639872179-2nf55dmhmrel1blhtbqqdd3cm7b35mhr.apps.googleusercontent.com',
    iosClientId:
        '535639872179-dh18b7q27sgktv0n0gih893gdmktq0v1.apps.googleusercontent.com',
    iosBundleId: 'com.example.diabuddy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCT01T2TwEykTKXpx-h56w8IoN0EN7Od14',
    appId: '1:535639872179:web:c774892c8228effec556c6',
    messagingSenderId: '535639872179',
    projectId: 'new-diabuddy',
    authDomain: 'new-diabuddy.firebaseapp.com',
    storageBucket: 'new-diabuddy.appspot.com',
    measurementId: 'G-PCS7TNBS06',
  );
}
