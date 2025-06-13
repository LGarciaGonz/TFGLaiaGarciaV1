import 'package:flutter/material.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';

class BioTextField extends StatelessWidget {
  final TextEditingController controller;

  const BioTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: controller,
      hintText: "Introduce tu nueva biografía",
      obscureText: false,
    );
  }
}
