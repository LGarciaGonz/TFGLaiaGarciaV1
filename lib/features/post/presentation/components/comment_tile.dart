import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/post/domain/entities/comment.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';

class CommentTile extends StatefulWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  // Usuario actual
  AppUser? currentUser;
  bool isOwnComment = false;

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  // }

  @override
  void initState() {
    super.initState();

    // Espera a que se construya completamente el widget antes de leer el context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authCubit = context.read<AuthCubit>();
      final user = authCubit.currentUser;

      if (user != null) {
        setState(() {
          currentUser = user;
          isOwnComment = (widget.comment.userId == user.uid);
        });
      }
    });
  }

  // void getCurrentUser() {
  //   final authCubit = context.read<AuthCubit>();
  //   currentUser = authCubit.currentUser;
  //   isOwnComment = (widget.comment.userId == currentUser!.uid);
  // }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.currentUser;

    if (user != null) {
      setState(() {
        currentUser = user;
        isOwnComment = (widget.comment.userId == user.uid);
      });
    }
  }

  // CONFIRMAR ELIMINACIÓN DE COMENTARIO
  void showOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          '¿Seguro que quieres eliminar este comentario?',
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
              context.read<PostsCubit>().deleteComment(
                widget.comment.postId,
                widget.comment.id,
              );
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

  // @override
  // Widget build(BuildContext context) {
  //   // UI
  //   return Padding(
  //     padding: const EdgeInsets.symmetric( horizontal: 20.0),
  //     child: Row(
  //       children: [
  //         // Nombre del usuario
  //         Text(
  //           widget.comment.userName,
  //           style: const TextStyle(fontWeight: FontWeight.bold),
  //         ),

  //         const SizedBox(width: 10),

  //         // Texto del comentario
  //         Text(widget.comment.text),

  //         const Spacer(),

  //         if (isOwnComment)
  //           GestureDetector(
  //             onTap: showOptions,
  //             child: Icon(
  //               Icons.more_horiz,
  //               color: Theme.of(context).colorScheme.primary,
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre de usuario en negrita
          Text(
            widget.comment.userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(width: 8),

          // Comentario expandible y ajustable
          Expanded(
            child: Text(
              widget.comment.text,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),

          // Botón de opciones si el comentario es del usuario
          if (isOwnComment)
            GestureDetector(
              onTap: showOptions,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
