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
import 'package:litlens_v1/features/home/presentation/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(centerTitle: true, title: const Text("LitLens")),
      // DRAWER
      drawer: MyDrawer(),
      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                // Acción para ayuda/interrogación
              },
            ),
            const SizedBox(width: 40), // Espacio para el botón central
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Acción para perfil de usuario
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar contenido
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
