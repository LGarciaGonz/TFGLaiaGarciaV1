import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/profile_view.dart';
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
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();
  late AppUser? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    profileCubit.fetchUserProfile(widget.uid);
  }

  void followButtonPressed() {
    final profileState = profileCubit.state;
    if (profileState is! ProfileLoaded) return;

    final profileUser = profileState.profileUser;
    final isFollowing = profileUser.followers.contains(currentUser!.uid);

    setState(() {
      isFollowing
          ? profileUser.followers.remove(currentUser!.uid)
          : profileUser.followers.add(currentUser!.uid);
    });

    profileCubit.toggleFollow(currentUser!.uid, widget.uid).catchError((error) {
      setState(() {
        isFollowing
            ? profileUser.followers.add(currentUser!.uid)
            : profileUser.followers.remove(currentUser!.uid);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isOwnProfile = (widget.uid == currentUser!.uid);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return ProfileView(
            user: state.profileUser,
            isOwnProfile: isOwnProfile,
            currentUserId: currentUser!.uid,
            onFollowPressed: followButtonPressed,
            onEditPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(user: state.profileUser),
              ),
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
