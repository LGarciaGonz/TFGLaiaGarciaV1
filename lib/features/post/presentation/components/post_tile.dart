import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/post/domain/entities/comment.dart';
import 'package:litlens_v1/features/post/domain/entities/post.dart';
import 'package:litlens_v1/features/post/presentation/components/post_tile_components/comment_section.dart';
import 'package:litlens_v1/features/post/presentation/components/post_tile_components/post_actions.dart';
import 'package:litlens_v1/features/post/presentation/components/post_tile_components/post_content.dart';
import 'package:litlens_v1/features/post/presentation/components/post_tile_components/post_header.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<AuthCubit>().currentUser;
      if (user != null && mounted) {
        setState(() {
          currentUser = user;
          isOwnPost = widget.post.userId == user.uid;
        });
      }
    });
    fetchPostUser();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.currentUser;

    if (user != null && mounted) {
      // Verificación para evitar setState después del dispose
      setState(() {
        currentUser = user;
        isOwnPost = (widget.post.userId == user.uid);
      });
    }
  }

  Future<void> fetchPostUser() async {
    final fetchedUser = await profileCubit.getUserProfile(widget.post.userId);

    if (!mounted) return; // Evita llamar setState si el widget ya fue destruido
    if (fetchedUser != null) {
      setState(() {
        postUser = fetchedUser;
      });
    }
  }

  /**
  * LIKES DE LA PUBLICACIÓN
  */

  void toggleLikePost() {
    final isLiked = widget.post.likes.contains(currentUser!.uid);

    setState(() {
      if (isLiked) {
        widget.post.likes.remove(currentUser!.uid);
      } else {
        widget.post.likes.add(currentUser!.uid);
      }
    });

    postCubit.toggleLikePost(widget.post.id, currentUser!.uid).catchError((
      error,
    ) {
      setState(() {
        if (isLiked) {
          widget.post.likes.add(currentUser!.uid);
        } else {
          widget.post.likes.remove(currentUser!.uid);
        }
      });
    });
  }

  /**
 * COMENTARIOS
 */
  // Text controller para el comentario
  final commentTextController = TextEditingController();

  // Abrir box de comentario
  void openNewCommentBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Añade un comentario',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 18,
          ),
        ),
        content: MyTextField(
          controller: commentTextController,
          hintText: "Escribe tu comentario",
          obscureText: false,
        ),

        actions: [
          // Botón cancelar ----
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              'Cancelar',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),

          // Botón Publicar comentario ----
          ElevatedButton(
            onPressed: () {
              addComment();
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
              'Publicar',
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

  // CREAR NUEVO COMENTARIO
  void addComment() {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: widget.post.id,
      userId: currentUser!.uid,
      userName: currentUser!.name,
      text: commentTextController.text,
      timestamp: DateTime.now(),
    );

    // Añadir comentario con cubit
    if (commentTextController.text.isNotEmpty) {
      postCubit.addComment(widget.post.id, newComment);
    }
  }

  @override
  void dispose() {
    commentTextController.dispose();
    super.dispose();
  }

  // CONFIRMAR ELIMINACIÓN DE POST
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
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alineación general izquierda
        children: [
          PostHeaderWidget(
            userId: widget.post.userId,
            userName: widget.post.userName,
            isOwnPost: isOwnPost,
            onDeletePressed: showOptions,
            colorScheme: colorScheme,
          ),

          PostContentWidget(
            title: widget.post.title,
            author: widget.post.author,
            review: widget.post.review,
            starsNumber: widget.post.starsNumber,
            timestamp: widget.post.timestamp,
            colorScheme: colorScheme,
          ),

          PostActionsWidget(
            currentUserId: currentUser?.uid,
            likes: widget.post.likes,
            commentsCount: widget.post.comments.length,
            onLikePressed: toggleLikePost,
            onCommentPressed: openNewCommentBox,
            colorScheme: colorScheme,
          ),

          CommentsSectionWidget(
            postId: widget.post.id,
            initialComments: widget.post.comments,
          ),
        ],
      ),
    );
  }

  //               if (state is PostsLoading) {
  //                 return const Center(child: CircularProgressIndicator());
  //               }
  //               // Error .......
  //               else if (state is PostsError) {
  //                 return Center(
  //                   child: Text("Error cargando comentarios: ${state.message}"),
  //                 );
  //               } else {
  //                 return Padding(
  //                   padding: const EdgeInsets.only(left: 15.0),
  //                   child: Text(
  //                     'Aún no hay comentarios. ¡Sé el primero en añadir uno!',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       color: Theme.of(context).colorScheme.primary,
  //                       fontStyle: FontStyle.italic,
  //                     ),
  //                   ),
  //                 );
  //               }
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
}
