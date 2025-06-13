import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/home/presentation/components/my_drawer_tile.dart';
import 'package:litlens_v1/features/profile/presentation/pages/profile_page.dart';
import 'package:litlens_v1/features/search/presentation/pages/search_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              // Logo LitLens Negro
              Padding(
                padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
                child: Image.asset(
                  'lib/assets/images/iconoNegro.png',
                  width: 150,
                  height: 150,
                ),
              ),

              // Divider separador
              Divider(color: Theme.of(context).colorScheme.secondary),

              // Home tile
              MyDrawerTile(
                title: "HOME",
                icon: Icons.home,
                onTap: () => Navigator.of(context).pop(),
              ),

              // Perfil tile
              MyDrawerTile(
                title: "MI PERFIL",
                icon: Icons.person,
                onTap: () {
                  // Cerrar menú.
                  Navigator.of(context).pop();

                  // Recoger el uid del usuario actual.
                  final user = context.read<AuthCubit>().currentUser;
                  String? uid = user!.uid;

                  // Navegar a la página del perfil pasando por parámetro el uid del usuario.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(uid: uid),
                    ),
                  );
                },
              ),

              // Buscar tile
              MyDrawerTile(
                title: "BÚSQUEDA",
                icon: Icons.search,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                ),
              ),

              // LibrerIA tile
              MyDrawerTile(
                title: "LibrerIA",
                icon: Icons.book,
                onTap: () {},
              ),

              const Spacer(),

              // Cerrar sesión tile
              MyDrawerTile(
                title: "CERRAR SESIÓN",
                icon: Icons.logout,
                onTap: () => context.read<AuthCubit>().logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
