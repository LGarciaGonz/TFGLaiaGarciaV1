// // import 'package:flutter/material.dart';

// // class MyTextField extends StatelessWidget {
// //   final TextEditingController controller;
// //   final String hintText;
// //   final bool obscureText;

// //   const MyTextField({
// //     super.key,
// //     required this.controller,
// //     required this.hintText,
// //     required this.obscureText,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return TextField(
// //       controller: controller,
// //       obscureText: obscureText,
// //       decoration: InputDecoration(
// //         // Borde campo no seleccionado.
// //         enabledBorder: OutlineInputBorder(
// //           borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
// //           borderRadius: BorderRadius.circular(12),
// //         ),

// //         // Borde campo seleccionado.
// //         focusedBorder: OutlineInputBorder(
// //           borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
// //           borderRadius: BorderRadius.circular(12),
// //         ),

// //         hintText: hintText,
// //         hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
// //         fillColor: Theme.of(context).colorScheme.secondary,
// //         filled: true
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class MyTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool obscureText;

//   // Nuevas propiedades opcionales
//   final int? maxLines;
//   final int? minLines;
//   final bool expands;

//   const MyTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//     this.maxLines = 1,
//     this.minLines,
//     this.expands = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       maxLines: expands ? null : maxLines,
//       minLines: expands ? null : minLines,
//       expands: expands,
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         hintText: hintText,
//         hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
//         fillColor: Theme.of(context).colorScheme.secondary,
//         filled: true,
//         contentPadding: const EdgeInsets.all(12),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  // Nuevas propiedades opcionales
  final int? maxLines;
  final int? minLines;
  final bool expands;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      maxLines: widget.expands ? null : widget.maxLines,
      minLines: widget.expands ? null : widget.minLines,
      expands: widget.expands,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        contentPadding: const EdgeInsets.all(12),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
