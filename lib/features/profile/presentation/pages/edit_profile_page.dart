import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/edit_profile_view.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/profile_loading_view.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final bioTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bioTextController.text = widget.user.bio;
    bioTextController.addListener(_onFieldsChanged);
  }

  @override
  void dispose() {
    bioTextController.dispose();
    super.dispose();
  }

  void _onFieldsChanged() => setState(() {});

  bool get _isFormValid =>
      bioTextController.text.trim().isNotEmpty &&
      bioTextController.text.trim() != widget.user.bio.trim();

  void updateProfile() {
    if (!_isFormValid) return;

    context.read<ProfileCubit>().updateProfile(
      uid: widget.user.uid,
      newBio: bioTextController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const ProfileLoadingView();
        }
        return EditProfileView(
          user: widget.user,
          bioController: bioTextController,
          isFormValid: _isFormValid,
          onSavePressed: updateProfile,
        );
      },
      listener: (context, state) {
        if (state is ProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("¡Perfil actualizado correctamente!")),
          );
          Navigator.pop(context);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error al actualizar el perfil.")),
          );
        }
      },
    );
  }
}
