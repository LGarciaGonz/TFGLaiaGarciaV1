import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_button.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({super.key, this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers ----
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Acción al pulsar el botón de iniciar sesión.
  void login() {
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final authCubit = context.read<AuthCubit>();

    // Validación básica de formato de email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, introduce un email válido')),
      );
      return;
    }

    // Si todo es válido, llama al cubit
    authCubit.login(email, password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Para evitar overflow al aparecer el teclado
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // LOGO
                        Image.asset(
                          'lib/assets/images/iconoLitlens.png',
                          width: 150,
                          height: 150,
                        ),

                        const SizedBox(height: 40),

                        // Texto bienvenida
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Text(
                              '¡Bienvenido otra vez! ¿Listo para dar tu propia versión de la historia?',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Campo email
                        MyTextField(
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                        ),

                        const SizedBox(height: 10),

                        // Campo contraseña
                        MyTextField(
                          controller: passwordController,
                          hintText: "Contraseña",
                          obscureText: true,
                        ),

                        const SizedBox(height: 25),

                        // Botón inicio sesión
                        MyButton(onTap: login, text: 'Iniciar sesión'),

                        const SizedBox(height: 50),

                        // Registro de nuevo usuario
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Text(
                                  '¿Todavía no te has unido a nosotros?',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: widget.togglePages,
                                  child: Text(
                                    ' Crea tu cuenta en LitLens',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.inversePrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
