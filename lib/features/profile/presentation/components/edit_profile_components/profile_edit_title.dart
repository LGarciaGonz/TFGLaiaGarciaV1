import 'package:flutter/material.dart';

class ProfileEditTitle extends StatelessWidget {
  const ProfileEditTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Edita la información de tu perfil",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
