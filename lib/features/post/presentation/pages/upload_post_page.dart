import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_bottom_navigation_bar.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/post/domain/entities/post.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // Controladores de texto
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final reviewController = TextEditingController();

  int starsNumber = 0;
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();

    // Agregar listeners para actualizar estado y habilitar/deshabilitar botón
    titleController.addListener(_onFieldsChanged);
    authorController.addListener(_onFieldsChanged);
    reviewController.addListener(_onFieldsChanged);
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  void _onFieldsChanged() {
    setState(() {
      // Se reconstruye para evaluar si el botón debe habilitarse
    });
  }

  bool get _isFormValid {
    return titleController.text.trim().isNotEmpty &&
        authorController.text.trim().isNotEmpty &&
        reviewController.text.trim().isNotEmpty &&
        starsNumber > 0;
  }

  void uploadPost() {
    if (currentUser == null) {
      log("No hay usuario autenticado");
      return;
    }
    if (!_isFormValid) {
      return;
    }

    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUser!.uid,
      userName: currentUser!.name,
      title: titleController.text.trim(),
      author: authorController.text.trim(),
      review: reviewController.text.trim(),
      starsNumber: starsNumber,
      timestamp: DateTime.now(),
      likes: [],
      comments: [],
    );

    final postCubit = context.read<PostsCubit>();
    postCubit.createPost(newPost);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return buildUploadPage();
      },

      listener: (context, state) {
        if (state is PostsLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('¡Tu reseña se publicó correctamente!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          Navigator.pop(
            context,
          ); // Esto puede ir antes o después del snackbar, según UX
        } else if (state is PostsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Ocurrió un error al publicar. Inténtalo de nuevo.',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );
  }

  Widget buildUploadPage() {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Nueva publicación")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ), // Más separación desde el borde superior
              Text(
                "¿Terminaste un libro? ¡Es hora de contarlo todo (sin spoilers)!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 30),

              MyTextField(
                controller: titleController,
                hintText: 'Título',
                obscureText: false,
              ),
              const SizedBox(height: 12),
              MyTextField(
                controller: authorController,
                hintText: 'Autor',
                obscureText: false,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: MyTextField(
                  controller: reviewController,
                  hintText: 'Reseña',
                  obscureText: false,
                  expands: true,
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Puntuación:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 8),
              buildStarsSelector(),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFormValid ? uploadPost : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid
                        ? Theme.of(context)
                              .colorScheme
                              .primary // Gris más oscuro
                        : Theme.of(
                            context,
                          ).colorScheme.tertiary, // Gris más claro
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.inversePrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Publicar reseña',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        surface: theme.surface,
        primary: theme.primary,
        inversePrimary: theme.inversePrimary,
        tertiary: theme.tertiary,
        currentPage: PageType.upload,
      ),
    );
  }

  Widget buildStarsSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        int starIndex = index + 1;
        return IconButton(
          icon: Icon(
            starsNumber >= starIndex ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 32,
          ),
          onPressed: () {
            setState(() {
              starsNumber = starIndex;
            });
          },
        );
      }),
    );
  }
}
