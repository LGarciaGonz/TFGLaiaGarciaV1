// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/user_tile.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';

class FollowerPage extends StatelessWidget {
  final List<String> followers;
  final List<String> following;

  const FollowerPage({
    super.key,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedLabelColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.inversePrimary,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: "Seguidores"),
              Tab(text: "Seguidos"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            _buildUserList(followers, "No hay seguidores", context),
            _buildUserList(following, "No hay seguidos", context),
          ],
        ),
      ),
    );
  }
}

// Construcción de las listas
Widget _buildUserList(
  List<String> uids,
  String emptyMessage,
  BuildContext context,
) {
  return uids.isEmpty
      ? Center(child: Text(emptyMessage))
      : ListView.builder(
          itemCount: uids.length,
          itemBuilder: (context, index) {
            // Recoger cada uid
            final uid = uids[index];
            return FutureBuilder(
              future: context.read<ProfileCubit>().getUserProfile(uid),
              builder: (context, snapshot) {
                // Usuario cargado .....
                if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return UserTile(user: user);
                }
                // Cargando .....
                else if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListTile(title: Text("Cargando..."));
                }
                // No encontrado .....
                else {
                  return ListTile(title: Text("Usuario no encontrado"));
                }
              },
            );
          },
        );
}
