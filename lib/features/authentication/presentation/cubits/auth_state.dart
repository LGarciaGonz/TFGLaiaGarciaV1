import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';

abstract class AuthState {}

// Inicial.
class AuthInitial extends AuthState {}

// Cargando.
class AuthLoading extends AuthState {}

// Autenticado.
class Authenticated extends AuthState {
  final AppUser user;

  Authenticated(this.user);
}

// No autenticado.
class Unauthenticated extends AuthState {}

// Errores.
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
