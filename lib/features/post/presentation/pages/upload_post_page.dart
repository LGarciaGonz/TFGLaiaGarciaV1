// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
// import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
// import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
// import 'package:litlens_v1/features/post/domain/entities/post.dart';
// import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
// import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';

// class UploadPostPage extends StatefulWidget {
//   const UploadPostPage({super.key});

//   @override
//   State<UploadPostPage> createState() => _UploadPostPageState();
// }

// class _UploadPostPageState extends State<UploadPostPage> {
//   // Text controller
//   final textController = TextEditingController();

//   // Usuario actual
//   AppUser? currentUser;

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   // Obtener el usuario actual
//   void getCurrentUser() {
//     final authCubit = context.read<AuthCubit>();
//     currentUser = authCubit.currentUser;
//   }

//   void uploadPost() {
//     final newPost = Post(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       userId: currentUser!.uid,
//       userName: currentUser!.name,
//       title: title,
//       author: author,
//       review: review,
//       starsNumber: starsNumber,
//       timestamp: DateTime.now(),
//     );

//     final postCubit = context.read<PostsCubit>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // BLOC CONSUMER
//     return BlocConsumer<PostsCubit, PostsState>(
//       builder: (context, state) {
//         if (state is PostsLoading) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         return buildUploadPage();
//       },

//       // Volver a la página anterior cuando se sube y carga la publicación
//       listener: (context, state) {
//         if (state is PostsLoaded) {
//           Navigator.pop(context);
//         }
//       },
//     );
//   }

//   Widget buildUploadPage() {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Nueva publicación"),
//         foregroundColor: Theme.of(context).colorScheme.primary,
//       ),

//       // BODY
//       body: Center(
//         child: Column(children: [
//           MyTextField(controller: textController, hintText: 'Título', obscureText: false);
//         ],),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
// // import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
// // import 'package:litlens_v1/features/post/domain/entities/post.dart';
// // import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
// // import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';
// // import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';

// // class UploadPostPage extends StatefulWidget {
// //   const UploadPostPage({super.key});

// //   @override
// //   State<UploadPostPage> createState() => _UploadPostPageState();
// // }

// // class _UploadPostPageState extends State<UploadPostPage> {
// //   final TextEditingController _titleController = TextEditingController();
// //   final TextEditingController _authorController = TextEditingController();
// //   final TextEditingController _reviewController = TextEditingController();

// //   int starsNumber = 0;
// //   AppUser? currentUser;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCurrentUser();
// //   }

// //   void _getCurrentUser() {
// //     final authCubit = context.read<AuthCubit>();
// //     currentUser = authCubit.currentUser;
// //   }

// //   Widget _buildStar(int index) {
// //     return IconButton(
// //       onPressed: () {
// //         setState(() {
// //           starsNumber = index + 1;
// //         });
// //       },
// //       icon: Icon(
// //         Icons.star,
// //         color: index < starsNumber ? Colors.amber : Colors.grey,
// //         size: 32,
// //       ),
// //       splashRadius: 24,
// //       tooltip: '${index + 1} estrellas',
// //     );
// //   }

// //   void _uploadPost() {
// //     if (currentUser == null) {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(const SnackBar(content: Text("Usuario no autenticado")));
// //       return;
// //     }

// //     final newPost = Post(
// //       id: DateTime.now().millisecondsSinceEpoch.toString(),
// //       userId: currentUser!.uid,
// //       userName: currentUser!.name,
// //       title: _titleController.text.trim(),
// //       author: _authorController.text.trim(),
// //       review: _reviewController.text.trim(),
// //       starsNumber: starsNumber,
// //       timestamp: DateTime.now(),
// //     );

// //     context.read<PostsCubit>().createPost(newPost);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocConsumer<PostsCubit, PostsState>(
// //       listener: (context, state) {
// //         if (state is PostsUploading) {
// //           // Nada aquí, porque el loading se muestra en builder
// //         } else if (state is PostsLoaded) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text("Publicación subida con éxito")),
// //           );
// //           _titleController.clear();
// //           _authorController.clear();
// //           _reviewController.clear();
// //           setState(() {
// //             starsNumber = 0;
// //           });
// //           Navigator.pop(context); // Volver atrás tras éxito
// //         } else if (state is PostsError) {
// //           ScaffoldMessenger.of(
// //             context,
// //           ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
// //         }
// //       },
// //       builder: (context, state) {
// //         if (state is PostsUploading) {
// //           return const Scaffold(
// //             body: Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   CircularProgressIndicator(),
// //                   SizedBox(height: 16),
// //                   Text("Subiendo publicación..."),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }

// //         return Scaffold(
// //           appBar: AppBar(
// //             centerTitle: true,
// //             title: const Text("Nueva publicación"),
// //             actions: [
// //               IconButton(
// //                 icon: const Icon(Icons.upload),
// //                 onPressed: _uploadPost,
// //                 tooltip: "Subir publicación",
// //               ),
// //             ],
// //           ),
// //           body: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text("Título"),
// //                 const SizedBox(height: 8),
// //                 MyTextField(
// //                   controller: _titleController,
// //                   hintText: "Introduce el título",
// //                   obscureText: false,
// //                 ),
// //                 const SizedBox(height: 20),

// //                 const Text("Autor"),
// //                 const SizedBox(height: 8),
// //                 MyTextField(
// //                   controller: _authorController,
// //                   hintText: "Introduce el autor",
// //                   obscureText: false,
// //                 ),
// //                 const SizedBox(height: 20),

// //                 const Text("Valoración"),
// //                 Row(children: List.generate(5, (index) => _buildStar(index))),
// //                 const SizedBox(height: 20),

// //                 const Text("Reseña"),
// //                 const SizedBox(height: 8),
// //                 MyTextField(
// //                   controller: _reviewController,
// //                   hintText: "Escribe tu reseña",
// //                   obscureText: false,
// //                   // maxLines: 5,
// //                   // minLines: 3,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _titleController.dispose();
// //     _authorController.dispose();
// //     _reviewController.dispose();
// //     super.dispose();
// //   }
// // }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
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
      // Protección extra, aunque el botón ya debería estar deshabilitado
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
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildUploadPage() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Nueva publicación"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              MyTextField(
                controller: reviewController,
                hintText: 'Reseña',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              buildStarsSelector(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFormValid ? uploadPost : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Publicar', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
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
