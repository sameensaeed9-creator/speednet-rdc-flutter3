import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android: return android;
      case TargetPlatform.iOS: return ios;
      default: return web;
    }
  }
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBLg1HGurlnnZdV7w8Zx324e1XSv9SBFtE',
    appId: '1:450808358538:web:8dcff3f95bb0f29137ef73',
    messagingSenderId: '450808358538',
    projectId: 'speednet-web',
    authDomain: 'speednet-web.firebaseapp.com',
    storageBucket: 'speednet-web.firebasestorage.app',
  );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLg1HGurlnnZdV7w8Zx324e1XSv9SBFtE',
    appId: '1:450808358538:android:8dcff3f95bb0f29137ef73',
    messagingSenderId: '450808358538',
    projectId: 'speednet-web',
    storageBucket: 'speednet-web.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLg1HGurlnnZdV7w8Zx324e1XSv9SBFtE',
    appId: '1:450808358538:ios:8dcff3f95bb0f29137ef73',
    messagingSenderId: '450808358538',
    projectId: 'speednet-web',
    storageBucket: 'speednet-web.firebasestorage.app',
    iosBundleId: 'com.speednet.rdc',
  );
}
