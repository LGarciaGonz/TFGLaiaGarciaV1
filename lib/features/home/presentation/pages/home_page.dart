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
import 'package:litlens_v1/features/post/presentation/pages/upload_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("LitLens")),
      drawer: MyDrawer(),

      // ✅ Contenido seguro
      body: const SafeArea(child: Center(child: Text("Contenido principal"))),

      // ✅ BottomAppBar con protección contra overflow
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: theme.surface,
          child: SizedBox(
            height: 72, // Altura suficiente para icono + texto + padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 📚 LibrerIA
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book, color: theme.primary),
                        const SizedBox(height: 4),
                        Text(
                          "LibrerIA",
                          style: TextStyle(color: theme.primary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),

                // ➕ Botón central más grande y redondo
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPostPage())),
                    child: Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: theme.inversePrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: theme.tertiary,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 👤 Mi perfil
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, color: theme.primary),
                        const SizedBox(height: 4),
                        Text(
                          "Mi perfil",
                          style: TextStyle(color: theme.primary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
