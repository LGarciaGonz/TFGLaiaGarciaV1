import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/components/pers_button.dart';
import 'package:litlens_v1/features/authentication/presentation/components/pers_text_field.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controllers ----
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Pulsación del botón de registro.
  void register() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        authCubit.register(name, email, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Las contraseñas no coinciden")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        // LOGO LITLENS
                        Image.asset(
                          'lib/assets/images/iconoLitlens.png',
                          width: 150,
                          height: 150,
                        ),

                        const SizedBox(height: 40),

                        // Texto crear cuenta
                        Center(
                          child: Text(
                            '¡Crea tu cuenta y únete a la familia LitLens!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Campo nombre
                        PersTextField(
                          controller: nameController,
                          hintText: "Nombre",
                          obscureText: false,
                        ),

                        const SizedBox(height: 10),

                        // Campo email
                        PersTextField(
                          controller: emailController,
                          hintText: "Email",
                          obscureText: false,
                        ),

                        const SizedBox(height: 10),

                        // Campo contraseña
                        PersTextField(
                          controller: passwordController,
                          hintText: "Contraseña",
                          obscureText: true,
                        ),

                        const SizedBox(height: 10),

                        // Campo confirmar contraseña
                        PersTextField(
                          controller: confirmPasswordController,
                          hintText: "Confirmar contraseña",
                          obscureText: true,
                        ),

                        const SizedBox(height: 25),

                        // Botón crear cuenta
                        PersButton(onTap: register, text: 'Crear cuenta'),

                        const SizedBox(height: 50),

                        // Ya tienes cuenta
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              '¿Ya eres miembro?',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.togglePages,
                              child: Text(
                                ' Inicia sesión con tu cuenta',
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
