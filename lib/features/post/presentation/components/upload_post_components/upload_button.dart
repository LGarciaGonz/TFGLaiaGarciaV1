import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final bool isFormValid;
  final VoidCallback onPressed;

  const UploadButton({
    super.key,
    required this.isFormValid,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isFormValid ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFormValid
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.tertiary,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text('Publicar reseña', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
