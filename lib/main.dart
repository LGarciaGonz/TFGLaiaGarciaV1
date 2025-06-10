import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:litlens_v1/app.dart';
import 'package:litlens_v1/configuration/firebase_options.dart';

void main() async {
  // Firebase setup.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run app.
  runApp(MainApp());
}
