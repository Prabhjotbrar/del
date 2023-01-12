import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyANa2x5bDWiVw29ohJfq-7FAr08fEmAbf8",
            authDomain: "bright-gearbox-269314.firebaseapp.com",
            projectId: "bright-gearbox-269314",
            storageBucket: "bright-gearbox-269314.appspot.com",
            messagingSenderId: "300543936591",
            appId: "1:300543936591:web:ab19d0abfbbfe7c971423a",
            measurementId: "G-PYVETSFM5C"));
  } else {
    await Firebase.initializeApp();
  }
}
