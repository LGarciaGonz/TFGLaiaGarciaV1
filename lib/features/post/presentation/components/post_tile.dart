import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/post/domain/entities/comment.dart';
import 'package:litlens_v1/features/post/domain/entities/post.dart';
import 'package:litlens_v1/features/post/presentation/components/comment_tile.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:litlens_v1/features/profile/presentation/pages/profile_page.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ENCABEZADO ------------
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(uid: widget.post.userId)),
            ),
            child: Container(
              color: colorScheme.tertiary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Icono
                  const Icon(Icons.person, size: 22),
                  const SizedBox(width: 10),
                  // Nombre de usuario
                  Text(
                    widget.post.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: colorScheme.inversePrimary,
                    ),
                  ),
                  const Spacer(),
                  // Botón eliminar publicación
                  if (isOwnPost)
                    IconButton(
                      onPressed: showOptions,
                      icon: Icon(
                        Icons.delete,
                        color: colorScheme.inversePrimary,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // CONTENIDO ----------------
          Container(
            width: double.infinity,
            color: colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TÍTULO ------
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
                // AUTOR ------
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

                // RESEÑA ------
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

                // PUNTUACIÓN ------
                Text(
                  'Puntuación:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),
                // ESTRELLAS ------
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

                // FECHA ------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Fecha de publicación:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('dd/MM/yyyy').format(widget.post.timestamp),
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // BOTÓN LIKE ------
                SizedBox(
                  width: 50,
                  child: Row(
                    children: [
                      if (currentUser == null)
                        SizedBox()
                      else
                        GestureDetector(
                          onTap: toggleLikePost,
                          child: Icon(
                            size: 30,
                            widget.post.likes.contains(currentUser!.uid)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.post.likes.contains(currentUser!.uid)
                                ? Colors.red
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      SizedBox(width: 5),
                      Text(
                        widget.post.likes.length.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),

                // BOTÓN COMENTARIOS ------
                GestureDetector(
                  onTap: openNewCommentBox,
                  child: Icon(
                    Icons.comment_outlined,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  widget.post.comments.length.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // SECCIÓN DE COMENTARIOS --------------
          BlocBuilder<PostsCubit, PostsState>(
            builder: (context, state) {
              // Cargado .......
              if (state is PostsLoaded) {
                // Post individual
                final post = state.posts.firstWhere(
                  (post) => (post.id == widget.post.id),
                );

                if (post.comments.isNotEmpty) {
                  // Indicar cuántos comentarios hay para mostrar
                  int showCommentCount = post.comments.length;

                  // Sección de comentarios ------------
                  return ListView.builder(
                    itemCount: showCommentCount,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // Recoger cada comentario individual
                      final comment = post.comments[index];

                      // UI
                      return CommentTile(comment: comment);
                    },
                  );
                }
              }

              // Cargando .......
              if (state is PostsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              // Error .......
              else if (state is PostsError) {
                return Center(
                  child: Text("Error cargando comentarios: ${state.message}"),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Aún no hay comentarios. ¡Sé el primero en añadir uno!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
