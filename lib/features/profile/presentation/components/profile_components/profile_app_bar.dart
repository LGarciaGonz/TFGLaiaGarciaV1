import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final bool isOwnProfile;
  final VoidCallback onEditPressed;

  const ProfileAppBar({
    super.key,
    required this.userName,
    required this.isOwnProfile,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(userName),
      actions: [
        if (isOwnProfile)
          IconButton(
            onPressed: onEditPressed,
            icon: const Icon(Icons.settings),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
