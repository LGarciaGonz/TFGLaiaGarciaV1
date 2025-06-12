import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlens_v1/features/post/domain/entities/comment.dart';

class Post {
  final String id;
  final String userId;
  final String userName;
  final String title;
  final String author;
  final String review;
  final int starsNumber;
  final DateTime timestamp;
  final List<String> likes;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.title,
    required this.author,
    required this.review,
    required this.starsNumber,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  Post copyWith({
    String? title,
    String? author,
    String? review,
    int? starsNumber,
  }) {
    return Post(
      id: id,
      userId: userId,
      userName: userName,
      title: title ?? this.title,
      author: author ?? this.author,
      review: review ?? this.review,
      starsNumber: starsNumber ?? this.starsNumber,
      timestamp: timestamp,
      likes: likes,
      comments: comments,
    );
  }

  // Convertir post a json.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': userName,
      'title': title,
      'author': author,
      'review': review,
      'starsNumber': starsNumber,
      'timestamp': Timestamp.fromDate(timestamp),
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  // Convertir json a post.
  factory Post.fromJson(Map<String, dynamic> json) {
    // Preparar los comentarios
    final List<Comment> comments =
        (json['comments'] as List<dynamic>?)
            ?.map((commentJson) => Comment.fromJson(commentJson))
            .toList() ??
        [];

    return Post(
      id: json['id'],
      userId: json['userId'],
      userName: json['name'],
      title: json['title'],
      author: json['author'],
      review: json['review'],
      starsNumber: json['starsNumber'] is int
          ? json['starsNumber']
          : (json['starsNumber'] as double).toInt(),
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      likes: List<String>.from(json['likes'] ?? []),
      comments: comments,
    );
  }
}
