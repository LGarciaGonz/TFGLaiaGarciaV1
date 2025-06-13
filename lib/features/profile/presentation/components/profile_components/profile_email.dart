import 'package:flutter/material.dart';

class ProfileEmail extends StatelessWidget {
  final String email;

  const ProfileEmail({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.email, size: 30, color: theme.primary),
        const SizedBox(width: 8),
        Text(email, style: TextStyle(color: theme.primary, fontSize: 16)),
      ],
    );
  }
}
