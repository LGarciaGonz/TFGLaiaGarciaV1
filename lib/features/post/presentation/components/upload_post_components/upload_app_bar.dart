import 'package:flutter/material.dart';

class UploadAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UploadAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true, title: const Text("Nueva publicación"));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
