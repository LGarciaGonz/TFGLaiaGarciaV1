// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
// import 'package:litlens_v1/features/post/presentation/pages/upload_post_page.dart';
// import 'package:litlens_v1/features/profile/presentation/pages/profile_page.dart';

// class CustomBottomNavigationBar extends StatelessWidget {
//   final Color surface;
//   final Color primary;
//   final Color inversePrimary;
//   final Color tertiary;

//   const CustomBottomNavigationBar({
//     super.key,
//     required this.surface,
//     required this.primary,
//     required this.inversePrimary,
//     required this.tertiary,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: BottomAppBar(
//         color: surface,
//         child: SizedBox(
//           height: 72,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     // TODO Navegar a LibrerIA

//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.book, color: primary),
//                       const SizedBox(height: 4),
//                       Text(
//                         "LibrerIA",
//                         style: TextStyle(color: primary, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => UploadPostPage()),
//                   ),
//                   child: Center(
//                     child: Container(
//                       width: 56,
//                       height: 56,
//                       decoration: BoxDecoration(
//                         color: inversePrimary,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Icon(Icons.add, color: tertiary, size: 28),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     final user = context.read<AuthCubit>().currentUser;
//                     String? uid = user?.uid;
//                     if (uid != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ProfilePage(uid: uid),
//                         ),
//                       );
//                     }
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.person, color: primary),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Mi perfil",
//                         style: TextStyle(color: primary, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/post/presentation/pages/upload_post_page.dart';
import 'package:litlens_v1/features/profile/presentation/pages/profile_page.dart';

enum PageType { librerIA, home, upload, profile }

class CustomBottomNavigationBar extends StatelessWidget {
  final Color surface;
  final Color primary;
  final Color inversePrimary;
  final Color tertiary;
  final PageType currentPage; // Página activa

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
    Color getColor(PageType page) {
      // Si la página es la actual, el color es negro, si no el color primario
      return currentPage == page ? Colors.black : primary;
    }

    return SafeArea(
      child: BottomAppBar(
        color: surface,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                   
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
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadPostPage()),
                    );
                  },
                  child: Center(
                    child: Container(
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
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final user = context.read<AuthCubit>().currentUser;
                    String? uid = user?.uid;
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
