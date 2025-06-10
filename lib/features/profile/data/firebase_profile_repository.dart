import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
import 'package:litlens_v1/features/profile/domain/repositories/profile_repository.dart';

class FirebaseProfileRepository implements ProfileRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc = await firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'] ?? '',
            profileImageUrl: userData['profileImageUrl'].toString(),
          );
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ProfileUser?> updateProfile(ProfileUser updatedProfile) async {
    try {
      // Convertir perfil actualizado en json para almacenar en firestore.
      await firebaseFirestore
          .collection('users')
          .doc(updatedProfile.uid)
          .update({
            'bio': updatedProfile.bio,
            'profileImageUrl': updatedProfile.profileImageUrl,
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
