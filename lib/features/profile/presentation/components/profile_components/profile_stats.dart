import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  final int postCount;
  final int followerCount;
  final int followingCount;
  final void Function()? onTap;

  const ProfileStats({
    super.key,
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    // ESTILOS DE TEXTO ------
    var countTextStyle = TextStyle(
      fontSize: 20,
      color: Theme.of(context).colorScheme.inversePrimary,
      fontWeight: FontWeight.bold
    );

    var textTextStyle = TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Número de publicaciones
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(postCount.toString(), style: countTextStyle),
                Text("Publicaciones", style: textTextStyle),
              ],
            ),
          ),
      
          // Número de seguidores
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(followerCount.toString(), style: countTextStyle),
                Text("Seguidores", style: textTextStyle),
              ],
            ),
          ),
      
          // Número de seguidos
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(followingCount.toString(), style: countTextStyle),
                Text("Seguidos", style: textTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
