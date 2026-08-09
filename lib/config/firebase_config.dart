import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:shom_gn/config/env.dart';
import 'package:shom_gn/config/environment.dart';


class FirebaseConfig {
  static Future<void> init(Env env) async {
    await Firebase.initializeApp();

    if (env.currentEnv == AppEnv.dev || Environment.isDev) {
      _connectToEmulators();
    }
  }

  static void _connectToEmulators() {
  
    final host = kIsWeb ? '127.0.0.1' : '10.0.2.2'; 
    FirebaseFirestore.instance.useFirestoreEmulator(host, 7080);
    // 🔐 Auth
     FirebaseAuth.instance.useAuthEmulator(host, 8099);
    // ⚡ Functions
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    //  Storage
     FirebaseStorage.instance.useStorageEmulator(host, 8199);
  }
}
