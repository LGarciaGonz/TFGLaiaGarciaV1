import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_bottom_navigation_bar.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/post/presentation/components/post_tile.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';
import 'package:litlens_v1/features/profile/presentation/components/bio_box.dart';
import 'package:litlens_v1/features/profile/presentation/components/follow_button.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_state.dart';
import 'package:litlens_v1/features/profile/presentation/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Cubits
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  // Usuario actual registrado
  late AppUser? currentUser = authCubit.currentUser;

  // Número de posts publicados
  int postCount = 0;

  // Al iniciar:
  @override
  void initState() {
    super.initState();

    // Cargar información del perfil.
    profileCubit.fetchUserProfile(widget.uid);
  }

  // SEGUIR / DEJAR DE SEGUIR
  void followButtonPressed() {
    final profileState = profileCubit.state;
    if (profileState is! ProfileLoaded) {
      return; // Retornar si el perfil no está cargado
    }

    final profileUser = profileState.profileUser;
    final isFollowing = profileUser.followers.contains(currentUser!.uid);

    

    profileCubit.toggleFollow(currentUser!.uid, widget.uid);
  }

  // INTEREFAZ ---------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    bool isOwnProfile = (widget.uid == currentUser!.uid);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // Cargado.
        if (state is ProfileLoaded) {
          // Obtener el usuario actual.
          final user = state.profileUser;

          // SCAFFOLD ------------------
          return Scaffold(
            // APP BAR ------------------
            appBar: AppBar(
              centerTitle: true,
              title: Text(user.name),
              actions: [
                // Botón editar perfil ----
                if (isOwnProfile)
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(user: user),
                      ),
                    ),
                    icon: Icon(Icons.settings),
                  ),
              ],
            ),

            // BODY ------------------
            body: ListView(
              children: [
                const SizedBox(height: 40),
                // Foto de perfil ----
                Container(
                  decoration: BoxDecoration(
                    // color: theme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 120,
                  width: 120,
                  padding: const EdgeInsets.all(25),
                  child: Center(
                    child: Icon(Icons.person, size: 90, color: theme.primary),
                  ),
                ),

                const SizedBox(height: 25),

                // ICONO E EMAIL ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, size: 30, color: theme.primary),
                    const SizedBox(width: 8),
                    Text(
                      user.email,
                      style: TextStyle(color: theme.primary, fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // Botón seguir / dejar de seguir
                if (!isOwnProfile)
                  FollowButton(
                    onPressed: followButtonPressed,
                    isFollowing: user.followers.contains(currentUser!.uid),
                  ),

                const SizedBox(height: 25),

                // Bio ----
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Text(
                        "Biografía",
                        style: TextStyle(color: theme.primary, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                BioBox(text: user.bio),

                const SizedBox(height: 25),

                // Publicaciones ----
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  child: Row(
                    children: [
                      Text(
                        "Publicaciones",
                        style: TextStyle(color: theme.primary, fontSize: 16),
                      ),
                    ],
                  ),
                ),

                // Lista de publicaciones del usuario
                BlocBuilder<PostsCubit, PostsState>(
                  builder: (context, state) {
                    // Posts cargados ......
                    if (state is PostsLoaded) {
                      // Filtrar posts por id del usuario
                      final userPosts = state.posts
                          .where((post) => post.userId == widget.uid)
                          .toList();

                      postCount = userPosts.length;

                      return ListView.builder(
                        itemCount: postCount,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // Recoger cada post individualmente
                          final post = userPosts[index];

                          // Retornar publicación
                          return PostTile(
                            post: post,
                            onDeletePressed: () =>
                                context.read<PostsCubit>().deletePost(post.id),
                          );
                        },
                      );
                    }
                    // Cargando ......
                    else if (state is PostsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                        child: Text(
                          "Aún no hay publicaciones",
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

            bottomNavigationBar: CustomBottomNavigationBar(
              surface: theme.surface,
              primary: theme.primary,
              inversePrimary: theme.inversePrimary,
              tertiary: theme.tertiary,
              currentPage: PageType.profile,
            ),
          );
        } else if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const Center(child: Text("No se ha encontrado el perfil"));
        }
      },
    );
  }
}
