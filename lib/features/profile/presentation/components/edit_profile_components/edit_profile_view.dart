import 'package:flutter/material.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_bottom_navigation_bar.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/bio_editor_title.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/bio_textfield.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/edit_profile_app_bar.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/profile_avatar.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/profile_edit_subtitle.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/profile_edit_title.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/save_profile_button.dart';
import 'package:litlens_v1/features/profile/presentation/components/edit_profile_components/user_info_row.dart';

class EditProfileView extends StatelessWidget {
  final ProfileUser user;
  final TextEditingController bioController;
  final bool isFormValid;
  final VoidCallback onSavePressed;

  const EditProfileView({
    super.key,
    required this.user,
    required this.bioController,
    required this.isFormValid,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const EditProfileAppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.surfaceVariant.withOpacity(0.1),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfileAvatar(),
              const SizedBox(height: 20),
              const ProfileEditTitle(),
              const SizedBox(height: 10),
              const ProfileEditSubtitle(),
              const SizedBox(height: 30),
              const Divider(thickness: 1.2),
              const SizedBox(height: 30),
              UserInfoRow(
                icon: Icons.person,
                label: "Nombre",
                value: user.name,
              ),
              const SizedBox(height: 24),
              UserInfoRow(
                icon: Icons.email,
                label: "Correo electrónico",
                value: user.email,
              ),
              const SizedBox(height: 40),
              const BioEditorTitle(),
              const SizedBox(height: 16),
              BioTextField(controller: bioController),
              const SizedBox(height: 32),
              SaveProfileButton(
                isEnabled: isFormValid,
                onPressed: onSavePressed,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        surface: colorScheme.surface,
        primary: colorScheme.primary,
        inversePrimary: colorScheme.inversePrimary,
        tertiary: colorScheme.tertiary,
        currentPage: PageType.settings,
      ),
    );
  }
}