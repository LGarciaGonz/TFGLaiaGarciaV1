import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_bottom_navigation_bar.dart';
import 'package:litlens_v1/features/post/presentation/components/post_tile.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/bio_box.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/follow_button.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/profile_app_bar.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/profile_avatar.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/profile_email.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/profile_stats.dart';
import 'package:litlens_v1/features/profile/presentation/pages/follower_page.dart';

class ProfileView extends StatelessWidget {
  final ProfileUser user;
  final bool isOwnProfile;
  final String currentUserId;
  final VoidCallback onFollowPressed;
  final VoidCallback onEditPressed;

  const ProfileView({
    super.key,
    required this.user,
    required this.isOwnProfile,
    required this.currentUserId,
    required this.onFollowPressed,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: ProfileAppBar(
        userName: user.name,
        isOwnProfile: isOwnProfile,
        onEditPressed: onEditPressed,
      ),
      body: _buildProfileBody(context, theme),
      bottomNavigationBar: CustomBottomNavigationBar(
        surface: theme.surface,
        primary: theme.primary,
        inversePrimary: theme.inversePrimary,
        tertiary: theme.tertiary,
        currentPage: PageType.profile,
      ),
    );
  }

  Widget _buildProfileBody(BuildContext context, ColorScheme theme) {
    return ListView(
      children: [
        const SizedBox(height: 10),
        const ProfileAvatar(),
        const SizedBox(height: 25),
        ProfileEmail(email: user.email),
        const SizedBox(height: 35),
        _buildProfileStats(context),
        const SizedBox(height: 25),
        if (!isOwnProfile)
          FollowButton(
            onPressed: onFollowPressed,
            isFollowing: user.followers.contains(currentUserId),
          ),
        const SizedBox(height: 25),
        _buildBioSection(theme),
        const SizedBox(height: 25),
        _buildPostsSection(context, theme),
      ],
    );
  }

  Widget _buildProfileStats(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, postState) {
        final postCount = postState is PostsLoaded
            ? postState.posts.where((post) => post.userId == user.uid).length
            : 0;

        return ProfileStats(
          postCount: postCount,
          followerCount: user.followers.length,
          followingCount: user.following.length,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FollowerPage(
                followers: user.followers,
                following: user.following,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBioSection(ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "Biografía",
            style: TextStyle(color: theme.primary, fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        BioBox(text: user.bio),
      ],
    );
  }

  Widget _buildPostsSection(BuildContext context, ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 25),
          child: Text(
            "Publicaciones",
            style: TextStyle(color: theme.primary, fontSize: 16),
          ),
        ),
        BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is! PostsLoaded) {
              return Center(
                child: Text(
                  "Error al cargar publicaciones",
                  style: TextStyle(fontSize: 16, color: theme.primary),
                ),
              );
            }

            final userPosts = state.posts
                .where((post) => post.userId == user.uid)
                .toList();

            if (userPosts.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  "Aún no hay publicaciones",
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: userPosts.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final post = userPosts[index];
                return PostTile(
                  post: post,
                  onDeletePressed: () =>
                      context.read<PostsCubit>().deletePost(post.id),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
