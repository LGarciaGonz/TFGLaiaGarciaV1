import 'package:litlens_v1/features/authentication/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;

  final List<String> followers;
  final List<String> following;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
  });

  // MÉTODO PARA ACTUALZAR EL PERFIL DE USUARIO
  ProfileUser copyWith({
    String? newBio,
    String? newProfileImageUrl,
    List<String>? newFollowers,
    List<String>? newFollowing,
  }) {
    return ProfileUser(
      uid: uid,
      email: email,
      name: name,
      bio: newBio ?? bio,
      profileImageUrl: newProfileImageUrl ?? profileImageUrl,
      followers: newFollowers ?? followers,
      following: newFollowing ?? following,
    );
  }

  // Convertir perfil a json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following,
    };
  }

  // Convertir json a perfil
  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',

      // followers: List<String>.from(json['followers' ?? []]),
      // following: List<String>.from(json['following' ?? []]),
      followers: json['followers'] is List
          ? List<String>.from(json['followers'])
          : [],

      following: json['following'] is List
          ? List<String>.from(json['following'])
          : [],
    );
  }
}
