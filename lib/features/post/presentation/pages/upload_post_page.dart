import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_bottom_navigation_bar.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/post/domain/entities/post.dart';
import 'package:litlens_v1/features/post/presentation/components/upload_post_components/rating_title.dart';
import 'package:litlens_v1/features/post/presentation/components/upload_post_components/stars_selector.dart';
import 'package:litlens_v1/features/post/presentation/components/upload_post_components/upload_app_bar.dart';
import 'package:litlens_v1/features/post/presentation/components/upload_post_components/upload_button.dart';
import 'package:litlens_v1/features/post/presentation/components/upload_post_components/upload_form_fields.dart';
import 'package:litlens_v1/features/post/presentation/components/upload_post_components/upload_header_text.dart';
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
        if (state is PostsLoading || state is PostsUploading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return buildUploadPage();
      },
      listener: (context, state) {
        if (state is PostCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('¡Tu reseña se publicó correctamente!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          // Limpia campos si quieres, opcional:
          titleController.clear();
          authorController.clear();
          reviewController.clear();
          setState(() {
            starsNumber = 0;
          });

          // Reseteamos el estado para que no se repita el mensaje
          context.read<PostsCubit>().resetState();

          // Navegamos hacia atrás o a otra página si quieres
          Navigator.pop(context);
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
      appBar: const UploadAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const UploadHeaderText(),
              const SizedBox(height: 30),
              UploadFormFields(
                titleController: titleController,
                authorController: authorController,
                reviewController: reviewController,
              ),
              const SizedBox(height: 20),
              const RatingTitle(),
              const SizedBox(height: 8),
              StarsSelector(
                starsNumber: starsNumber,
                onStarSelected: (index) => setState(() => starsNumber = index),
              ),
              const SizedBox(height: 30),
              UploadButton(isFormValid: _isFormValid, onPressed: uploadPost),
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
}
