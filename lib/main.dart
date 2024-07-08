import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_messenger/app/app.dart';
import 'package:simple_messenger/domain/firebase_api.dart';
import 'package:simple_messenger/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App(firebaseApi: FirebaseApi()));
}
