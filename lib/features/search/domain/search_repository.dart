import 'package:litlens_v1/features/profile/domain/entities/profile_user.dart';

abstract class SearchRepository {
  Future<List<ProfileUser?>> searchUsers(String query);
}
