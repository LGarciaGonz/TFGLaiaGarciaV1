import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    // INICIO DE SESIÓN -----------------
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Crear usuario.
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      // Retornar usuario.
      return user;
    } catch (exc) {
      throw Exception('Error al iniciar sesión: $exc'); // Informar del error en el login.
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    // REGISTRO DE USUARIO -----------------
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Crear usuario.
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // Guardar usuario en la base de datos de Firestore.
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      // Retornar usuario.
      return user;
    } catch (exc) {
      throw Exception('Error al iniciar sesión: $exc'); // Informar del error en el login.
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // Obtener usuario loggeado desde Firebase
    final firebaseUser = firebaseAuth.currentUser;

    // Si no hay usuario loggeado:
    if (firebaseUser == null) return null;

    // Si hay usuario loggeado:
    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!, name: '');
  }
}
