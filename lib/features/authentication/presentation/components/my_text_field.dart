import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller; 
  final String hintText; 
  final bool obscureText;
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
  late bool _obscure; // Estado interno para controlar visibilidad del texto

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText; // Inicializa el estado con el valor recibido
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText:
          _obscure, // Oculta o muestra el texto según el estado interno
      maxLines: widget.expands ? null : widget.maxLines,
      minLines: widget.expands ? null : widget.minLines,
      expands: widget.expands,

      // Personalización visual del campo de texto
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

        // Icono para alternar visibilidad si el campo es de tipo contraseña
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure; // Cambia la visibilidad del texto
                  });
                },
              )
            : null,
      ),
    );
  }
}
