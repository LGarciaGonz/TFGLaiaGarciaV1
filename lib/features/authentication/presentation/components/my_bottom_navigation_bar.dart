import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/home/presentation/pages/home_page.dart';
import 'package:litlens_v1/features/post/presentation/pages/upload_post_page.dart';
import 'package:litlens_v1/features/profile/presentation/pages/profile_page.dart';
import 'package:litlens_v1/features/search/presentation/pages/search_page.dart';

// Enum que define las diferentes páginas del BottomNavigationBar
enum PageType { librerIA, home, upload, profile, search, settings }

class CustomBottomNavigationBar extends StatelessWidget {
  // Colores personalizados para el diseño
  final Color surface;
  final Color primary;
  final Color inversePrimary;
  final Color tertiary;

  // Página actualmente seleccionada
  final PageType currentPage;

  const CustomBottomNavigationBar({
    super.key,
    required this.surface,
    required this.primary,
    required this.inversePrimary,
    required this.tertiary,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    // Función que determina el color del ícono dependiendo de si es la página actual
    Color getColor(PageType page) {
      return currentPage == page ? Colors.black : primary;
    }

    return SafeArea( // Evita que la barra inferior se superponga con elementos del sistema (como el notch)
      child: BottomAppBar( // Barra inferior personalizada
        color: surface, // Color de fondo de la barra
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribuye uniformemente los ítems
            children: [
              // HOME
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navega y reemplaza la página actual por la HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, color: getColor(PageType.home)),
                      const SizedBox(height: 4),
                      Text(
                        "H O M E",
                        style: TextStyle(
                          color: getColor(PageType.home),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Buscar
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navega a la SearchPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: getColor(PageType.search)),
                      const SizedBox(height: 4),
                      Text(
                        "Búsqueda",
                        style: TextStyle(
                          color: getColor(PageType.search),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Upload Post (icono central flotante)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navega a la página para subir una publicación
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadPostPage()),
                    );
                  },
                  child: Center(
                    child: Container(
                      // Botón flotante central redondo
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: inversePrimary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(Icons.add, color: tertiary, size: 28),
                      ),
                    ),
                  ),
                ),
              ),

              // LibrerIA (sin navegación definida aún)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Por ahora, no navega a ninguna página
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.book, color: getColor(PageType.librerIA)),
                      const SizedBox(height: 4),
                      Text(
                        "LibrerIA",
                        style: TextStyle(
                          color: getColor(PageType.librerIA),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Mi perfil
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Obtiene el usuario autenticado desde el AuthCubit
                    final user = context.read<AuthCubit>().currentUser;
                    String? uid = user?.uid;

                    // Si hay un usuario logueado, navega a su perfil
                    if (uid != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(uid: uid),
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: getColor(PageType.profile)),
                      const SizedBox(height: 4),
                      Text(
                        "Mi perfil",
                        style: TextStyle(
                          color: getColor(PageType.profile),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
