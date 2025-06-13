
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';
import 'package:litlens_v1/features/authentication/domain/repositories/auth_repository.dart';
import 'package:litlens_v1/features/authentication/presentation/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AppUser? _currentUser;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  // Comprobar si el usuario está autenticado.
  void checkAuth() async {
    final AppUser? user = await authRepository.getCurrentUser();

    if (user == null) {
      emit(Unauthenticated());
    } else {
      _currentUser = user;
      emit(Authenticated(user));
    }
  }

  // Obtener usuario actual.
  AppUser? get currentUser => _currentUser;

  // Iniciar sesión con email y contraseña.
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepository.loginWithEmailPassword(email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        // En caso de que login retorne null (usuario no autenticado)
        emit(AuthError("Email o contraseña incorrectos"));
      }
    } catch (exc) {
      String errorMessage = "Error desconocido";

      // Informar de que alguno de los campos es incorrecto
      if (exc.toString().contains("auth")) {
        errorMessage = "Email o contraseña incorrectos";
      } else {
        errorMessage = exc.toString();
      }

      emit(AuthError(errorMessage));
      emit(Unauthenticated());
    }
  }

  // Registro con email y contraseña.
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepository.registerWithEmailPassword(
        name,
        email,
        password,
      );

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (exc) {
      emit(AuthError(exc.toString()));
      emit(Unauthenticated());
    }
  }

  // Cerrar sesión.
  Future<void> logout() async {
    authRepository.logout();
    emit(Unauthenticated());
  }
}
