import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/post/domain/entities/post.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onDeletePressed;
  const PostTile({
    super.key,
    required this.post,
    required this.onDeletePressed,
  });

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  // Cubits
  late final postCubit = context.read<PostsCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  // Propietario o no de la publicación
  bool isOwnPost = false;

  // Usuario actual.
  AppUser? currentUser;

  // Perfil del usuario
  ProfileUser? postUser;

  // Al iniciar:
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchPostUser();
  }

  // void getCurrentUser() {
  //   final authCubit = context.read<AuthCubit>();
  //   currentUser = authCubit.currentUser;
  //   isOwnPost = (widget.post.userId == currentUser!.uid);
  // }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.currentUser;

    if (user != null) {
      setState(() {
        currentUser = user;
        isOwnPost = (widget.post.userId == user.uid);
      });
    }
  }

  Future<void> fetchPostUser() async {
    final fetchedUser = await profileCubit.getUserProfile(widget.post.userId);
    if (fetchedUser != null) {
      setState(() {
        postUser = fetchedUser;
      });
    }
  }

  // Opciones para eliminar la publicación.
  void showOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          '¿Seguro que quieres eliminar esta reseña?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              'Cancelar',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              widget.onDeletePressed!();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Eliminar',
              style: TextStyle(
                color: Colors.grey.shade100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ENCABEZADO (usuario + botón eliminar)
          Container(
            color: colorScheme.tertiary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                const Icon(Icons.person, size: 22),
                const SizedBox(width: 10),
                Text(
                  widget.post.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: colorScheme.inversePrimary,
                  ),
                ),
                const Spacer(),
                if (isOwnPost)
                  IconButton(
                    onPressed: showOptions,
                    icon: Icon(Icons.delete, color: colorScheme.inversePrimary),
                  ),
              ],
            ),
          ),
      
          // CONTENIDO DE LA PUBLICACIÓN
          Container(
            width: double.infinity,
            color: colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TÍTULO DEL LIBRO
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Título: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: '"${widget.post.title}"',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          color: colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
      
                const SizedBox(height: 18),
      
                // AUTOR
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Autor:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.post.author,
                    style: TextStyle(
                      fontSize: 15,
                      color: colorScheme.inversePrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
      
                // RESEÑA
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reseña:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.post.review,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: colorScheme.inversePrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
      
                // PUNTUACIÓN
                Text(
                  'Puntuación:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
      
                const SizedBox(height: 8),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < widget.post.starsNumber
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: Colors.amber,
                      size: 28,
                    );
                  }),
                ),
      
                const SizedBox(height: 30),
      
                // FECHA DE PUBLICACIÓN
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Fecha de publicación:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(widget.post.timestamp),
                    style: TextStyle(
                      fontSize: 15,
                      color: colorScheme.inversePrimary,
                    ),
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
