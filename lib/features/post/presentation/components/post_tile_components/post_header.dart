import 'package:flutter/material.dart';
import 'package:litlens_v1/features/profile/presentation/pages/profile_page.dart';

class PostHeaderWidget extends StatelessWidget {
  final String userId;
  final String userName;
  final bool isOwnPost;
  final VoidCallback onDeletePressed;
  final ColorScheme colorScheme;

  const PostHeaderWidget({
    super.key,
    required this.userId,
    required this.userName,
    required this.isOwnPost,
    required this.onDeletePressed,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage(uid: userId)),
      ),
      child: Container(
        color: colorScheme.tertiary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Icon(Icons.person, size: 22),
            const SizedBox(width: 10),
            Text(
              userName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: colorScheme.inversePrimary,
              ),
            ),
            const Spacer(),
            if (isOwnPost)
              IconButton(
                onPressed: onDeletePressed,
                icon: Icon(Icons.delete, color: colorScheme.inversePrimary),
              ),
          ],
        ),
      ),
    );
  }
}
