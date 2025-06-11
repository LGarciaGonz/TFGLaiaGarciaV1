import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlens_v1/features/post/domain/entities/post.dart';
import 'package:litlens_v1/features/post/domain/repositories/post_repository.dart';

class FirebasePostRepository implements PostRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Almacenar los posts en una colección.
  final CollectionReference postCollection = FirebaseFirestore.instance
      .collection('posts');

  @override
  Future<void> createPost(Post post) async {
    try {
      if (post.id.isEmpty ||
          post.userId.isEmpty ||
          post.title.isEmpty ||
          post.review.isEmpty) {
        throw Exception("Datos insuficientes para crear el post");
      }
      await postCollection.doc(post.id).set(post.toJson());
    } catch (e) {
      throw Exception("Error creando el nuevo post: $e");
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await postCollection.doc(postId).delete();
    } catch (e) {
      throw Exception("Error eliminando el post: $e");
    }
  }

  @override
  Future<List<Post>> fetchAllPosts() async {
    try {
      // Recoger todos los posts con el más reciente al principio.
      final postSnapshot = await postCollection
          .orderBy('timestamp', descending: true)
          .get();

      // Convertir de JSON a lista de posts.
      return postSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Error buscando los posts: $e");
    }
  }

  @override
  Future<List<Post>> fetchPostByUserId(
    String userId, {
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = postCollection
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final postsSnapshot = await query.get();

      return postsSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Error recogiendo los posts del usuario: $e");
    }
  }
}
