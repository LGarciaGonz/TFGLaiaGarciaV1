import 'package:flutter/material.dart';

class PostActionsWidget extends StatelessWidget {
  final String? currentUserId;
  final List<String> likes;
  final int commentsCount;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;
  final ColorScheme colorScheme;

  const PostActionsWidget({
    super.key,
    required this.currentUserId,
    required this.likes,
    required this.commentsCount,
    required this.onLikePressed,
    required this.onCommentPressed,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          // BOTÓN LIKE (estructura idéntica al original)
          SizedBox(
            width: 50, // Mismo ancho fijo
            child: Row(
              children: [
                if (currentUserId == null)
                  const SizedBox()
                else
                  GestureDetector(
                    onTap: onLikePressed,
                    child: Icon(
                      size: 30,
                      likes.contains(currentUserId!)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: likes.contains(currentUserId!)
                          ? Colors.red
                          : colorScheme.primary,
                    ),
                  ),
                const SizedBox(width: 5), // Mismo espaciado
                Text(
                  likes.length.toString(),
                  style: TextStyle(color: colorScheme.primary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20), // Mismo espaciado
          // BOTÓN COMENTARIOS (estructura idéntica al original)
          GestureDetector(
            onTap: onCommentPressed,
            child: Icon(
              Icons.comment_outlined,
              size: 30,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 5), // Mismo espaciado
          Text(
            commentsCount.toString(),
            style: TextStyle(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
