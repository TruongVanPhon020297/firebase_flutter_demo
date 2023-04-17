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
    apiKey: 'AIzaSyDgaPaoJiN5Hq0hAyYiWL8RXRORDZ1ZqA0',
    appId: '1:146317087657:web:ba75d32af94ba845812ab8',
    messagingSenderId: '146317087657',
    projectId: 'fir-message-64134',
    authDomain: 'fir-message-64134.firebaseapp.com',
    storageBucket: 'fir-message-64134.appspot.com',
    measurementId: 'G-5R0V8LC0F0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMzxZ8n2fXeVz6JYsg1zeb_IozLm7u0DE',
    appId: '1:146317087657:android:b238e614dc750103812ab8',
    messagingSenderId: '146317087657',
    projectId: 'fir-message-64134',
    storageBucket: 'fir-message-64134.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXIk0AU2MXBL65h2RzOGe0QCWBLjK2SR4',
    appId: '1:146317087657:ios:ad81f5199182d73d812ab8',
    messagingSenderId: '146317087657',
    projectId: 'fir-message-64134',
    storageBucket: 'fir-message-64134.appspot.com',
    androidClientId: '146317087657-r3gghpn00s5839p8660ejof7dtihes7g.apps.googleusercontent.com',
    iosClientId: '146317087657-4km8ec68cea2hl2tagf2b34etg8gf4dc.apps.googleusercontent.com',
    iosBundleId: 'com.example.message',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXIk0AU2MXBL65h2RzOGe0QCWBLjK2SR4',
    appId: '1:146317087657:ios:ad81f5199182d73d812ab8',
    messagingSenderId: '146317087657',
    projectId: 'fir-message-64134',
    storageBucket: 'fir-message-64134.appspot.com',
    androidClientId: '146317087657-r3gghpn00s5839p8660ejof7dtihes7g.apps.googleusercontent.com',
    iosClientId: '146317087657-4km8ec68cea2hl2tagf2b34etg8gf4dc.apps.googleusercontent.com',
    iosBundleId: 'com.example.message',
  );
}
