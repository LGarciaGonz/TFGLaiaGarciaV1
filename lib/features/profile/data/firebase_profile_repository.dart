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
          // Recoger los seguidos y seguidores
          final followers = List<String>.from(userData['followers'] ?? []);
          final following = List<String>.from(userData['following'] ?? []);

          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'] ?? '',
            profileImageUrl: userData['profileImageUrl'].toString(),
            followers: followers,
            following: following,
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

  @override
  Future<void> toggleFollow(String currentUid, String targetUid) async {
    try {
      final currentUserDoc = await firebaseFirestore
          .collection('users')
          .doc(currentUid)
          .get();

      final targetUserDoc = await firebaseFirestore
          .collection('users')
          .doc(targetUid)
          .get();

      if (currentUserDoc.exists && targetUserDoc.exists) {
        final currentUserData = currentUserDoc.data();
        final targetUserData = targetUserDoc.data();

        if (currentUserData != null && targetUserData != null) {
          final List<String> currentFollowing = List<String>.from(
            currentUserData['following'] ?? [],
          );

          // Comprobar que el usuario actual siga al otro usuario
          if (currentFollowing.contains(targetUid)) {
            // Dejar de seguir al usuario
            await firebaseFirestore.collection('users').doc(currentUid).update({
              'following': FieldValue.arrayRemove([targetUid]),
            });

            await firebaseFirestore.collection('users').doc(targetUid).update({
              'followers': FieldValue.arrayRemove([currentUid]),
            });
          } else {
            // Seguir al usuario
            await firebaseFirestore.collection('users').doc(currentUid).update({
              'following': FieldValue.arrayUnion([targetUid]),
            });

            await firebaseFirestore.collection('users').doc(targetUid).update({
              'followers': FieldValue.arrayUnion([currentUid]),
            });
          }
        }
      }
    } catch (e) {}
  }
}
