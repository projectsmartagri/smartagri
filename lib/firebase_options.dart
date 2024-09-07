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
    apiKey: 'AIzaSyAi4ryjeCtOp3j-ObEQWbAdILMyELILOeE',
    appId: '1:550051993011:web:9929470f374f6ad00527c6',
    messagingSenderId: '550051993011',
    projectId: 'smart-agri-21658',
    authDomain: 'smart-agri-21658.firebaseapp.com',
    storageBucket: 'smart-agri-21658.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZqDTaAAP_AOS00cr-SuzW0uJZNIVWteI',
    appId: '1:550051993011:android:90d727d368e17fe50527c6',
    messagingSenderId: '550051993011',
    projectId: 'smart-agri-21658',
    storageBucket: 'smart-agri-21658.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWy6I98vsQQGVqtyrnbmPJ9yoqAs2OYL8',
    appId: '1:550051993011:ios:ba59e66478fc31b20527c6',
    messagingSenderId: '550051993011',
    projectId: 'smart-agri-21658',
    storageBucket: 'smart-agri-21658.appspot.com',
    iosBundleId: 'com.example.smartagri',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWy6I98vsQQGVqtyrnbmPJ9yoqAs2OYL8',
    appId: '1:550051993011:ios:ba59e66478fc31b20527c6',
    messagingSenderId: '550051993011',
    projectId: 'smart-agri-21658',
    storageBucket: 'smart-agri-21658.appspot.com',
    iosBundleId: 'com.example.smartagri',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAi4ryjeCtOp3j-ObEQWbAdILMyELILOeE',
    appId: '1:550051993011:web:7959e99c966eb8a00527c6',
    messagingSenderId: '550051993011',
    projectId: 'smart-agri-21658',
    authDomain: 'smart-agri-21658.firebaseapp.com',
    storageBucket: 'smart-agri-21658.appspot.com',
  );
}
