// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:litlens_v1/features/authentication/data/firebase_auth_repository.dart';
// import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
// import 'package:litlens_v1/features/authentication/presentation/cubits/auth_state.dart';
// import 'package:litlens_v1/features/authentication/presentation/pages/authentication_page.dart';
// import 'package:litlens_v1/features/home/presentation/pages/home_page.dart';
// import 'package:litlens_v1/features/post/data/firebase_post_repository.dart';
// import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
// import 'package:litlens_v1/features/profile/data/firebase_profile_repository.dart';
// import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
// import 'package:litlens_v1/features/search/data/firebase_search_repository.dart';
// import 'package:litlens_v1/features/search/presentation/cubits/search_cubit.dart';
// import 'package:litlens_v1/themes/light_mode.dart';

// class MainApp extends StatelessWidget {
//   // Auth repository
//   final authRepo = FirebaseAuthRepository();

//   // Perfil repository
//   final profileRepo = FirebaseProfileRepository();

//   // Post repository
//   final firebasePostRepo = FirebasePostRepository();

//   // Búsqueda repository
//   final firebaseSearchRepo = FirebaseSearchRepository();

//   MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         // Auth cubit
//         BlocProvider<AuthCubit>(
//           create: (context) => AuthCubit(authRepository: authRepo)..checkAuth(),
//         ),

//         // Perfil cubit.
//         BlocProvider<ProfileCubit>(
//           create: (context) => ProfileCubit(profileRepository: profileRepo),
//         ),

//         // Post cubit.
//         BlocProvider<PostsCubit>(
//           create: (context) => PostsCubit(firebasePostRepo),
//         ),

//         // Búsqueda cubit.
//         BlocProvider<SearchCubit>(
//           create: (context) =>
//               SearchCubit(searchRepository: firebaseSearchRepo),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: lightMode,
//         home: BlocConsumer<AuthCubit, AuthState>(
//           builder: (context, authState) {
//             // Si el usuario no está autenticado mostrar página correspondiente.
//             if (authState is Unauthenticated) {
//               return const AuthenticationPage();
//             }

//             // Si el usuario está autenticado, mostrar Home page.
//             if (authState is Authenticated) {
//               return const HomePage();
//             } else {
//               return const Scaffold(
//                 body: Center(child: CircularProgressIndicator()),
//               );
//             }
//           },
//           // Error en los campos.
//           listener: (context, state) {
//             if (state is AuthError) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.message)));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/data/firebase_auth_repository.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_cubit.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_state.dart';
import 'package:litlens_v1/features/authentication/presentation/pages/authentication_page.dart';
import 'package:litlens_v1/features/home/presentation/pages/home_page.dart';
import 'package:litlens_v1/features/post/data/firebase_post_repository.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
import 'package:litlens_v1/features/profile/data/firebase_profile_repository.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:litlens_v1/features/search/data/firebase_search_repository.dart';
import 'package:litlens_v1/features/search/presentation/cubits/search_cubit.dart';
import 'package:litlens_v1/themes/light_mode.dart';

class MainApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepository();
  final profileRepo = FirebaseProfileRepository();
  final firebasePostRepo = FirebasePostRepository();
  final firebaseSearchRepo = FirebaseSearchRepository();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepository: authRepo)..checkAuth(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(profileRepository: profileRepo),
        ),
        BlocProvider<PostsCubit>(
          create: (context) => PostsCubit(firebasePostRepo),
        ),
        BlocProvider<SearchCubit>(
          create: (context) =>
              SearchCubit(searchRepository: firebaseSearchRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Unauthenticated) {
              return const AuthenticationPage();
            }
            if (authState is Authenticated) {
              return const HomePage();
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
