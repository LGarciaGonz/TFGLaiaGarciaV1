import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/profile/domain/repositories/profile_repository.dart';
import 'package:litlens_v1/features/profile/presentation/cubits/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository}) : super(ProfileInitial());

  // Buscar perfil de usuario usando el repositorio.
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepository.fetchUserProfile(uid);

      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("No se ha encontrado el usuario"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Actualizar bio y foto de perfil.
  Future<void> updateProfile({required String uid, String? newBio}) async {
    emit(ProfileLoading());
    try {
      // Buscar el perfil actual.
      final currentUser = await profileRepository.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError("Error al buscar el perfil actualizado."));
        return;
      }

      // Actualizar foto de perfil.

      // Actualizar el perfil.
      final updatedProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
      );

      // Actualizar perfil en el repositorio.
      await profileRepository.updateProfile(updatedProfile);

      // Buscar de nuevo el perfil del usuario.
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError("Error actualizando el perfil: $e"));
    }
  }
}
