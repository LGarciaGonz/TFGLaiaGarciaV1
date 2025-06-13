import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      height: 120,
      width: 120,
      padding: const EdgeInsets.all(25),
      child: Center(child: Icon(Icons.person, size: 90, color: theme.primary)),
    );
  }
}
