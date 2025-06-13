import 'package:flutter/material.dart';

class EditProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true, title: const Text("Editar perfil"));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
