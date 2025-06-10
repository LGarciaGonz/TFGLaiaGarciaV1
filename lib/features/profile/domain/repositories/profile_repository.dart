import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepository {
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser updatedProfile);
}
