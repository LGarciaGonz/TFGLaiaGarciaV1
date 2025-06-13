import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';

abstract class ProfileState {}

// State inicial.
class ProfileInitial extends ProfileState {}

// Cargando.
class ProfileLoading extends ProfileState {}

// Cargado.
class ProfileLoaded extends ProfileState {
  final ProfileUser profileUser;
  ProfileLoaded(this.profileUser);
}

// Perfil modificado.
class ProfileUpdated extends ProfileState {}

// Error.
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
