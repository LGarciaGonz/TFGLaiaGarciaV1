import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isFollowing;
  const FollowButton({
    super.key,
    required this.onPressed,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding exterior
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      // Botón
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MaterialButton(
          onPressed: onPressed,

          // Padding interior
          padding: const EdgeInsets.all(15),

          // Color del botón
          color: isFollowing
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.tertiary,

          // Texto del botón
          child: Text(isFollowing ? 'Dejar de seguir' : 'Seguir', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
