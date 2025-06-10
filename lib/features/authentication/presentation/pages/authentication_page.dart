import 'package:flutter/material.dart';
import 'package:litlens_v1/features/authentication/presentation/pages/login_page.dart';
import 'package:litlens_v1/features/authentication/presentation/pages/register_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
  
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  // Mostrar inicialmente la página de inicio de sesión.
  bool showLoginPage = true;

  // Toggle entre páginas.
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(togglePages: togglePages,);
    } else {
      return RegisterPage(togglePages: togglePages,);
    }
  }
}
