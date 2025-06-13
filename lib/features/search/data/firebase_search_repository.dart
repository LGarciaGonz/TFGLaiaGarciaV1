import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';
import 'package:litlens_v1/features/search/domain/search_repository.dart';

class FirebaseSearchRepository implements SearchRepository {
  @override
  Future<List<ProfileUser?>> searchUsers(String query) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("users")
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();
      print("✅ Resultados obtenidos: ${result}");

      // return result.docs
      //     .map((doc) => ProfileUser.fromJson(doc.data()))
      //     .toList();

      return result.docs
          .map((doc) {
            final data = doc.data();
            if (data == null) {
              print("⚠️ Documento con ID '${doc.id}' tiene data null");
              return null;
            }
            try {
              return ProfileUser.fromJson(data);
            } catch (e) {
              print("❌ Error parseando documento '${doc.id}': $e");
              return null;
            }
          })
          .where((user) => user != null)
          .toList();
    } catch (e) {
      print("❌ Error dentro de searchUsers: $e");

      throw Exception("Error buscando usuarios: $e");
    }
  }
}
