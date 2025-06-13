import 'package:flutter/material.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';

class UploadFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController authorController;
  final TextEditingController reviewController;

  const UploadFormFields({
    super.key,
    required this.titleController,
    required this.authorController,
    required this.reviewController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          controller: titleController,
          hintText: 'Título',
          obscureText: false,
        ),
        const SizedBox(height: 12),
        MyTextField(
          controller: authorController,
          hintText: 'Autor',
          obscureText: false,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: MyTextField(
            controller: reviewController,
            hintText: 'Reseña',
            obscureText: false,
            expands: true,
          ),
        ),
      ],
    );
  }
}