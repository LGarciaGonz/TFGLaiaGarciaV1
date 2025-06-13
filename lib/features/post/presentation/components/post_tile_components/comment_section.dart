import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/post/domain/entities/comment.dart';
import 'package:litlens_v1/features/post/presentation/components/comment_tile.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_cubit.dart';
import 'package:litlens_v1/features/post/presentation/cubits/posts_state.dart';

class CommentsSectionWidget extends StatelessWidget {
  final String postId;
  final List<Comment> initialComments;

  const CommentsSectionWidget({
    super.key,
    required this.postId,
    required this.initialComments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoaded) {
          final post = state.posts.firstWhere((post) => (post.id == postId));

          if (post.comments.isNotEmpty) {
            return ListView.builder(
              itemCount: post.comments.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CommentTile(comment: post.comments[index]);
              },
            );
          }
        }

        if (state is PostsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsError) {
          return Center(
            child: Text("Error cargando comentarios: ${state.message}"),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Aún no hay comentarios. ¡Sé el primero en añadir uno!',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        }
      },
    );
  }
}
