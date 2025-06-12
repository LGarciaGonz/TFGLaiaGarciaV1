// import 'package:flutter/material.dart';
// import 'package:litlens_v1/features/home/presentation/components/my_drawer.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     // SCAFFOLD
//     return Scaffold(
//       // APPBAR
//       appBar: AppBar(centerTitle: true, title: const Text("LitLens")),
//       // DRAWER
//       drawer: MyDrawer(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_bottom_navigation_bar.dart';
import 'package:litlens_v1/features/post/presentation/components/post_tile.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/home/presentation/components/my_drawer.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';
import 'package:litlens_v1/features/post/presentation/pages/upload_post_page.dart';
import 'package:litlens_v1/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Post cubit
  late final postCubit = context.read<PostsCubit>();

  // Al iniciar:
  @override
  void initState() {
    super.initState();

    // Cargar todos los posts
    fetchAllPosts();
  }

  // Cargar todos los posts.
  void fetchAllPosts() {
    postCubit.fetchAllPosts();
  }

  // Eliminar post.
  // void deletePost(String postId) {
  //   postCubit.deletePost(postId);
  //   fetchAllPosts();
  // }

  void deletePost(String postId) async {
    try {
      await postCubit.deletePost(postId); // Espera a que se elimine el post
      fetchAllPosts(); // Actualiza la lista

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Publicación eliminada correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar la publicación'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("LitLens")),
      drawer: MyDrawer(),
      body: SafeArea(
        child: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            // Cargando.
            if (state is PostsLoading || state is PostsUploading) {
              return const Center(child: CircularProgressIndicator());
            }
            // Cargado.
            else if (state is PostsLoaded) {
              final allPosts = state.posts;
              if (allPosts.isEmpty) {
                return const Center(
                  child: Text('No hay publicaciones disponibles'),
                );
              }
              return ListView.builder(
                itemCount: allPosts.length,
                itemBuilder: (context, index) {
                  // Obtener cada uno de los posts por separado.
                  final post = allPosts[index];

                  // Mostrar publicación.
                  return PostTile(
                    post: post,
                    onDeletePressed: () => deletePost(post.id),
                  );
                },
              );
            }
            // Error.
            else if (state is PostsError) {
              return Center(child: Text("Error al cargar las publicaciones. Revise su conexión a internet"));
              // return Center(child: Text(state.message));
            } else {
              return SizedBox();
            }
          },
        ),
      ),

      // ✅ Contenido seguro

      // ✅ BottomAppBar con protección contra overflow
      bottomNavigationBar: CustomBottomNavigationBar(
        surface: theme.surface,
        primary: theme.primary,
        inversePrimary: theme.inversePrimary,
        tertiary: theme.tertiary,
        currentPage: PageType.home,
      ),
    );
  }
}
