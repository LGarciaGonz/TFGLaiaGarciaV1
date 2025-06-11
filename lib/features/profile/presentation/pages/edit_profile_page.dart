// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
// // // import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
// // // import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
// // // import 'package:litlens_v1/features/profile/presentation/cubits/profile_state.dart';

// // // class EditProfilePage extends StatefulWidget {
// // //   final ProfileUser user;
// // //   const EditProfilePage({super.key, required this.user});

// // //   @override
// // //   State<EditProfilePage> createState() => _EditProfilePageState();
// // // }

// // // class _EditProfilePageState extends State<EditProfilePage> {
// // //   final bioTextController = TextEditingController();

// // //   void updateProfile() {
// // //     final profileCubit = context.read<ProfileCubit>();

// // //     if (bioTextController.text.isNotEmpty) {
// // //       profileCubit.updateProfile(
// // //         uid: widget.user.uid,
// // //         newBio: bioTextController.text,
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return BlocConsumer<ProfileCubit, ProfileState>(
// // //       builder: (context, state) {
// // //         if (state is ProfileLoading) {
// // //           return const Scaffold(
// // //             body: Center(
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   CircularProgressIndicator(),
// // //                   Text("Guardando cambios..."),
// // //                 ],
// // //               ),
// // //             ),
// // //           );
// // //         }
// // //         return buildEditPage();
// // //       },
// // //       listener: (context, state) {
// // //         String message = "";

// // //         if (state is ProfileLoaded) {
// // //           message = "¡Perfil actualizado correctamente!";
// // //         } else if (state is ProfileError) {
// // //           message = "Error al actualizar el perfil.";
// // //         }

// // //         if (message.isNotEmpty) {
// // //           ScaffoldMessenger.of(
// // //             context,
// // //           ).showSnackBar(SnackBar(content: Text(message)));
// // //           Navigator.pop(context); // Volver a la página anterior
// // //         }
// // //       },
// // //     );
// // //   }

// // //   Widget buildEditPage() {
// // //     final colorScheme = Theme.of(context).colorScheme;

// // //     return Scaffold(
// // //       appBar: AppBar(centerTitle: true, title: const Text("Editar perfil")),
// // //       body: SingleChildScrollView(
// // //         child: Container(
// // //           width: double.infinity,
// // //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.center,
// // //             children: [
// // //               Icon(Icons.person, size: 150, color: colorScheme.primary),
// // //               const SizedBox(height: 30),

// // //               // NOMBRE
// // //               Align(
// // //                 alignment: Alignment.centerLeft,
// // //                 child: Text(
// // //                   'Nombre:',
// // //                   style: TextStyle(
// // //                     fontSize: 15,
// // //                     fontWeight: FontWeight.w600,
// // //                     color: colorScheme.primary,
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 4),

// // //               Align(
// // //                 alignment: Alignment.centerLeft,
// // //                 child: Text(
// // //                   widget.user.name,
// // //                   style: TextStyle(
// // //                     fontSize: 15,
// // //                     color: colorScheme.inversePrimary,
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 26),

// // //               // CORREO ELECTRÓNICO
// // //               Align(
// // //                 alignment: Alignment.centerLeft,
// // //                 child: Text(
// // //                   'Correo electrónico:',
// // //                   style: TextStyle(
// // //                     fontSize: 15,
// // //                     fontWeight: FontWeight.w600,
// // //                     color: colorScheme.primary,
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 4),
// // //               Align(
// // //                 alignment: Alignment.centerLeft,
// // //                 child: Text(
// // //                   widget.user.email,
// // //                   style: TextStyle(
// // //                     fontSize: 15,
// // //                     color: colorScheme.inversePrimary,
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 30),

// // //               // BIOGRAFÍA
// // //               Align(
// // //                 alignment: Alignment.centerLeft,
// // //                 child: Text(
// // //                   'Editar biografía:',
// // //                   style: TextStyle(
// // //                     fontSize: 15,
// // //                     fontWeight: FontWeight.w600,
// // //                     color: colorScheme.primary,
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 10),
// // //               MyTextField(
// // //                 controller: bioTextController,
// // //                 hintText: widget.user.bio,
// // //                 obscureText: false,
// // //               ),

// // //               const SizedBox(height: 20),

// // //               ElevatedButton.icon(
// // //                 onPressed: updateProfile,
// // //                 icon: const Icon(Icons.upload),
// // //                 label: const Text("Guardar cambios"),
// // //                 style: ElevatedButton.styleFrom(
// // //                   padding: const EdgeInsets.symmetric(
// // //                     horizontal: 24,
// // //                     vertical: 12,
// // //                   ),
// // //                   shape: RoundedRectangleBorder(
// // //                     borderRadius: BorderRadius.circular(30),
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 30),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
// // import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
// // import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
// // import 'package:litlens_v1/features/profile/presentation/cubits/profile_state.dart';

// // class EditProfilePage extends StatefulWidget {
// //   final ProfileUser user;
// //   const EditProfilePage({super.key, required this.user});

// //   @override
// //   State<EditProfilePage> createState() => _EditProfilePageState();
// // }

// // class _EditProfilePageState extends State<EditProfilePage> {
// //   final bioTextController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     bioTextController.text = widget.user.bio; // Establecer texto inicial
// //     bioTextController.addListener(_onFieldsChanged);
// //   }

// //   @override
// //   void dispose() {
// //     bioTextController.dispose();
// //     super.dispose();
// //   }

// //   void _onFieldsChanged() {
// //     setState(() {}); // Fuerza la reconstrucción para el botón
// //   }

// //   bool get _isFormValid {
// //     return bioTextController.text.trim().isNotEmpty &&
// //         bioTextController.text.trim() != widget.user.bio.trim();
// //   }

// //   void updateProfile() {
// //     if (!_isFormValid) return;

// //     final profileCubit = context.read<ProfileCubit>();
// //     profileCubit.updateProfile(
// //       uid: widget.user.uid,
// //       newBio: bioTextController.text.trim(),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocConsumer<ProfileCubit, ProfileState>(
// //       builder: (context, state) {
// //         if (state is ProfileLoading) {
// //           return const Scaffold(
// //             body: Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   CircularProgressIndicator(),
// //                   Text("Guardando cambios..."),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }
// //         return buildEditPage();
// //       },
// //       listener: (context, state) {
// //         if (state is ProfileLoaded) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text("¡Perfil actualizado correctamente!")),
// //           );
// //           Navigator.pop(context);
// //         } else if (state is ProfileError) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text("Error al actualizar el perfil.")),
// //           );
// //         }
// //       },
// //     );
// //   }

// //   Widget buildEditPage() {
// //     final colorScheme = Theme.of(context).colorScheme;

// //     return Scaffold(
// //       appBar: AppBar(centerTitle: true, title: const Text("Editar perfil")),
// //       body: SingleChildScrollView(
// //         child: Container(
// //           width: double.infinity,
// //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Icon(Icons.person, size: 150, color: colorScheme.primary),
// //               const SizedBox(height: 30),

// //               _buildReadOnlyField("Nombre:", widget.user.name, colorScheme),
// //               const SizedBox(height: 26),
// //               _buildReadOnlyField(
// //                 "Correo electrónico:",
// //                 widget.user.email,
// //                 colorScheme,
// //               ),
// //               const SizedBox(height: 30),

// //               Align(
// //                 alignment: Alignment.centerLeft,
// //                 child: Text(
// //                   'Editar biografía:',
// //                   style: TextStyle(
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.w600,
// //                     color: colorScheme.primary,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               MyTextField(
// //                 controller: bioTextController,
// //                 hintText: "Introduce tu nueva biografía",
// //                 obscureText: false,
// //               ),
// //               const SizedBox(height: 20),

// //               ElevatedButton.icon(
// //                 onPressed: _isFormValid ? updateProfile : null,
// //                 icon: const Icon(Icons.upload),
// //                 label: const Text("Guardar cambios"),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: _isFormValid
// //                       ? colorScheme.primary
// //                       : colorScheme.tertiary,
// //                   foregroundColor: colorScheme.inversePrimary,
// //                   padding: const EdgeInsets.symmetric(
// //                     horizontal: 24,
// //                     vertical: 12,
// //                   ),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 30),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildReadOnlyField(
// //     String label,
// //     String value,
// //     ColorScheme colorScheme,
// //   ) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: TextStyle(
// //             fontSize: 15,
// //             fontWeight: FontWeight.w600,
// //             color: colorScheme.primary,
// //           ),
// //         ),
// //         const SizedBox(height: 4),
// //         Text(
// //           value,
// //           style: TextStyle(fontSize: 15, color: colorScheme.inversePrimary),
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
// import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
// import 'package:litlens_v1/features/profile/presentation/cubits/profile_cubit.dart';
// import 'package:litlens_v1/features/profile/presentation/cubits/profile_state.dart';

// class EditProfilePage extends StatefulWidget {
//   final ProfileUser user;
//   const EditProfilePage({super.key, required this.user});

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final bioTextController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     bioTextController.text = widget.user.bio;
//     bioTextController.addListener(_onFieldsChanged);
//   }

//   @override
//   void dispose() {
//     bioTextController.dispose();
//     super.dispose();
//   }

//   void _onFieldsChanged() {
//     setState(() {});
//   }

//   bool get _isFormValid {
//     return bioTextController.text.trim().isNotEmpty &&
//         bioTextController.text.trim() != widget.user.bio.trim();
//   }

//   void updateProfile() {
//     if (!_isFormValid) return;

//     final profileCubit = context.read<ProfileCubit>();
//     profileCubit.updateProfile(
//       uid: widget.user.uid,
//       newBio: bioTextController.text.trim(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProfileCubit, ProfileState>(
//       builder: (context, state) {
//         if (state is ProfileLoading) {
//           return const Scaffold(
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text("Guardando cambios..."),
//                 ],
//               ),
//             ),
//           );
//         }
//         return buildEditPage();
//       },
//       listener: (context, state) {
//         if (state is ProfileLoaded) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("¡Perfil actualizado correctamente!")),
//           );
//           Navigator.pop(context);
//         } else if (state is ProfileError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Error al actualizar el perfil.")),
//           );
//         }
//       },
//     );
//   }

//   Widget buildEditPage() {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Scaffold(
//       appBar: AppBar(centerTitle: true, title: const Text("Editar perfil")),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 colorScheme.surfaceVariant.withOpacity(0.1),
//                 Colors.transparent,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Icon(Icons.account_circle_rounded, size: 100),
//               const SizedBox(height: 20),
//               Text(
//                 "Edita la información de tu perfil",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme.primary,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Divider(color: colorScheme.outline, thickness: 1.2),
//               const SizedBox(height: 30),

//               _buildIconTextRow(
//                 Icons.person,
//                 "Nombre",
//                 widget.user.name,
//                 colorScheme,
//               ),
//               const SizedBox(height: 24),
//               _buildIconTextRow(
//                 Icons.email,
//                 "Correo electrónico",
//                 widget.user.email,
//                 colorScheme,
//               ),
//               const SizedBox(height: 40),

//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Editar biografía:',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: colorScheme.primary,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               MyTextField(
//                 controller: bioTextController,
//                 hintText: "Introduce tu nueva biografía",
//                 obscureText: false,
//               ),
//               const SizedBox(height: 32),

//               ElevatedButton.icon(
//                 onPressed: _isFormValid ? updateProfile : null,
//                 icon: const Icon(Icons.upload),
//                 label: const Text("Guardar cambios"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _isFormValid
//                       ? colorScheme.primary
//                       : colorScheme.tertiary,
//                   foregroundColor: colorScheme.inversePrimary,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 14,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildIconTextRow(
//     IconData icon,
//     String label,
//     String value,
//     ColorScheme colorScheme,
//   ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, color: colorScheme.primary),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: colorScheme.primary,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 value,
//                 style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_text_field.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
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

  void _onFieldsChanged() {
    setState(() {});
  }

  bool get _isFormValid {
    return bioTextController.text.trim().isNotEmpty &&
        bioTextController.text.trim() != widget.user.bio.trim();
  }

  void updateProfile() {
    if (!_isFormValid) return;

    final profileCubit = context.read<ProfileCubit>();
    profileCubit.updateProfile(
      uid: widget.user.uid,
      newBio: bioTextController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Guardando cambios..."),
                ],
              ),
            ),
          );
        }
        return buildEditPage();
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
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

  Widget buildEditPage() {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Editar perfil")),
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
              const Icon(Icons.account_circle_rounded, size: 100),
              const SizedBox(height: 20),
              Text(
                "Edita la información de tu perfil",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Tu perfil es el prólogo. ¡Haz que los demás quieran seguir leyendo!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 30),
              Divider(color: colorScheme.outline, thickness: 1.2),
              const SizedBox(height: 30),

              _buildIconTextRow(
                Icons.person,
                "Nombre",
                widget.user.name,
                colorScheme,
              ),
              const SizedBox(height: 24),
              _buildIconTextRow(
                Icons.email,
                "Correo electrónico",
                widget.user.email,
                colorScheme,
              ),
              const SizedBox(height: 40),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Editar biografía:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MyTextField(
                controller: bioTextController,
                hintText: "Introduce tu nueva biografía",
                obscureText: false,
              ),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: _isFormValid ? updateProfile : null,
                icon: const Icon(Icons.upload),
                label: const Text("Guardar cambios"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid
                      ? colorScheme.primary
                      : colorScheme.tertiary,
                  foregroundColor: colorScheme.inversePrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconTextRow(
    IconData icon,
    String label,
    String value,
    ColorScheme colorScheme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
