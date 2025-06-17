import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:litlens_v1/configuration/firebase_options.dart';
import 'package:litlens_v1/features/splash/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("✅ Firebase inicializado correctamente");
  } catch (e) {
    debugPrint("❌ Error inicializando Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(), // Pantalla inicial
    );
  }
}
