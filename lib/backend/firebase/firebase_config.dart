import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC--fyZMWdI-v_3DT4UVLDMtrefbN8YtZw",
            authDomain: "mapstracking-13463.firebaseapp.com",
            projectId: "mapstracking-13463",
            storageBucket: "mapstracking-13463.appspot.com",
            messagingSenderId: "803333276564",
            appId: "1:803333276564:web:2ae864d2c4e75a32d04581"));
  } else {
    await Firebase.initializeApp();
  }
}
