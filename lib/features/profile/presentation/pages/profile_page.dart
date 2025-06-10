import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_state.dart';

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

  // Al iniciar:
  @override
  void initState() {
    super.initState();

    // Cargar información del perfil.
    profileCubit.fetchUserProfile(widget.uid);
  }

  // INTEREFAZ ---------------
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // Cargado.
        if (state is ProfileLoaded) {
          // Obtener el usuario actual.
          final user = state.profileUser;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(user.name),
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        } else if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const Center(child: Text("No se ha encontrado el perfil"));
        }

        // Cargando.
      },
    );
  }
}
