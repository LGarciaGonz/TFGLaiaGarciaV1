import 'package:flutter/material.dart';

class ProfileEditSubtitle extends StatelessWidget {
  const ProfileEditSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Tu perfil es el prólogo. ¡Haz que los demás quieran seguir leyendo!",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
