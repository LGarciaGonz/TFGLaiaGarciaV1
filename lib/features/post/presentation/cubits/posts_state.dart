import 'package:litlens_v1/features/post/domain/entities/post.dart';

abstract class PostsState {}

// Inicial
class PostsInitial extends PostsState {}

// Cargando
class PostsLoading extends PostsState {}

// Actualizando
class PostsUploading extends PostsState {}

// Error
class PostsError extends PostsState {
  final String message;
  PostsError(this.message);
}

// Cargados
class PostsLoaded extends PostsState {
  final List<Post> posts;
  PostsLoaded(this.posts);
}

// Post creado
class PostCreated extends PostsState {}
