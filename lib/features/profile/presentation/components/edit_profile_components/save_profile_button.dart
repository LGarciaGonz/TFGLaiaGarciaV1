import 'package:flutter/material.dart';

class SaveProfileButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const SaveProfileButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      onPressed: isEnabled ? onPressed : null,
      icon: const Icon(Icons.upload),
      label: const Text("Guardar cambios"),
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? colorScheme.primary : colorScheme.tertiary,
        foregroundColor: colorScheme.inversePrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
