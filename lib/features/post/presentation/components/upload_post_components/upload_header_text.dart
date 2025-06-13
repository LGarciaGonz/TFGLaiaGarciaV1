import 'package:flutter/material.dart';

class UploadHeaderText extends StatelessWidget {
  const UploadHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "¿Terminaste un libro? ¡Es hora de contarlo todo (sin spoilers)!",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
