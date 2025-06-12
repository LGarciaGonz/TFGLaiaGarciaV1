import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/post/domain/entities/comment.dart';
import 'package:litlens_v1/features/post/domain/entities/post.dart';
import 'package:litlens_v1/features/post/domain/repositories/post_repository.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostRepository postRepository;

  PostsCubit(this.postRepository) : super(PostsInitial());

  // Cargar todos los posts
  Future<void> fetchAllPosts() async {
    emit(PostsLoading());
    try {
      final posts = await postRepository.fetchAllPosts();
      if (posts.isEmpty) {
        emit(PostsError("No hay posts disponibles."));
      } else {
        emit(PostsLoaded(posts));
      }
    } catch (e) {
      emit(PostsError("Error al cargar los posts: $e"));
    }
  }

  // Crear un nuevo post
  Future<void> createPost(Post post) async {
    emit(PostsUploading());
    try {
      await postRepository.createPost(post);
      fetchAllPosts(); // Recargar los posts después de subir uno nuevo
    } catch (e) {
      emit(PostsError("Error al subir el post: $e"));
    }
  }

  // Eliminar un post
  Future<void> deletePost(String postId) async {
    emit(PostsUploading()); // Indica que se está actualizando
    try {
      await postRepository.deletePost(postId);
      fetchAllPosts(); // Recargar después de eliminar
    } catch (e) {
      emit(PostsError("Error al eliminar el post: $e"));
    }
  }

  // Obtener posts de un usuario específico
  Future<void> fetchPostsByUserId(String userId) async {
    emit(PostsLoading());
    try {
      final posts = await postRepository.fetchPostByUserId(userId);
      if (posts.isEmpty) {
        emit(PostsError("Este usuario no tiene posts."));
      } else {
        emit(PostsLoaded(posts));
      }
    } catch (e) {
      emit(PostsError("Error al obtener los posts del usuario: $e"));
    }
  }

  // Recuperar los likes de una publicación
  Future<void> toggleLikePost(String postId, String userId) async {
    try {
      await postRepository.toggleLikePost(postId, userId);
    } catch (e) {
      emit(PostsError("Error al recuperar los likes de la publicación: $e"));
    }
  }

  // Añadir comentario a la publicación
  Future<void> addComment(String postId, Comment comment) async {
    try {
      await postRepository.addComment(postId, comment);
      await fetchAllPosts();
    } catch (e) {
      emit(PostsError("Error al publicar comentario: $e"));
    }
  }

  // Eliminar comentario de una publicación
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await postRepository.deleteComment(postId, commentId);
      await fetchAllPosts();
    } catch (e) {
      emit(PostsError("Error al eliminar comentario: $e"));
    }
  }
}
