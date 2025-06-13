import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostContentWidget extends StatelessWidget {
  final String title;
  final String author;
  final String review;
  final int starsNumber;
  final DateTime timestamp;
  final ColorScheme colorScheme;

  const PostContentWidget({
    super.key,
    required this.title,
    required this.author,
    required this.review,
    required this.starsNumber,
    required this.timestamp,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: colorScheme.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Importante para alineación general
        children: [
          // TÍTULO (centrado exactamente como en el original)
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Título: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: '"$title"',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center, // Centrado exacto como en original
            ),
          ),
          const SizedBox(height: 18),

          // AUTOR (alineación izquierda exacta)
          Text(
            'Autor:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            author,
            style: TextStyle(fontSize: 15, color: colorScheme.inversePrimary),
          ),
          const SizedBox(height: 16),

          // RESEÑA (alineación izquierda exacta)
          Text(
            'Reseña:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            review,
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              color: colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 20),

          // PUNTUACIÓN (centrado exacto)
          Center(
            child: Text(
              'Puntuación:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // ESTRELLAS (centrado exacto)
          Center(
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Importante para centrado preciso
              children: List.generate(5, (index) {
                return Icon(
                  index < starsNumber
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: Colors.amber,
                  size: 28,
                );
              }),
            ),
          ),
          const SizedBox(height: 30),

          // FECHA (centrado exacto)
          Center(
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Importante para centrado preciso
              children: [
                Text(
                  'Fecha de publicación:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('dd/MM/yyyy').format(timestamp),
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
